local rm = require("__pf-functions__/recipe-manipulation")
local tm = require("__pf-functions__/technology-manipulation")
local misc = require("__pf-functions__/misc")

local canonical_item_costs = {}

local function get_canonical_recipe(item)
  --if a canonical recipe is specified, use that. no questions asked.
  if item.cost_canonical_recipe ~= nil then return item.cost_canonical_recipe end
  if item.canonical_recipe ~= nil then return item.canonical_recipe end

  --if a recipe exists with the exact same name that produces the item, use that.
  if data.raw.recipe[item.name] and data.raw.recipe[item.name].results then
      for k, product in pairs(data.raw.recipe[item.name].results) do
          if product.name == item.name and product.type == "item" then
              return item.name
          end
      end
  end

  --if exactly one valid recipe produces the item with no byproducts, use that.
  local candidate = nil
  for k, recipe in pairs(data.raw.recipe) do
      if recipe.results and #recipe.results == 1 and recipe.category ~= "recycling" and recipe.category ~= "recycling-or-hand-crafting" then
          local ok = false
          local solids = 0
          for k2, product in pairs(recipe.results) do --not taking risks if someone uses weird keys for their tables.
              if product.type == "item" then
                  solids = solids + 1
                  if product.name == item.name then
                      ok = true
                  end
              end
          end
          if (solids == 1) and ok then
              if candidate then
                  candidate = nil
              else
                  candidate = recipe.name
              end
          end
      end
  end
  if candidate then return candidate end
  return true
end

local time_paradox = {}

local function GetItemCost(item)
  if canonical_item_costs[item] then
    return canonical_item_costs[item]
  end

  local prot = misc.GetPrototype(item)
  if not prot then
    prot = misc.GetPrototype(item, "fluid")
  end

  if prot then
    if prot.canonical_cost then
      canonical_item_costs[item] = prot.canonical_cost
      return prot.canonical_cost
    end

    local rec = get_canonical_recipe(prot)
    if type(rec) == "string" then
      local possible_cost = time_paradox[1](data.raw.recipe[rec])
      --this can be set by the recipe.
      if not canonical_item_costs[item] then
        canonical_item_costs[item] = possible_cost
      end
      return canonical_item_costs[item]
    end
    log("No canonical recipe found for ".. item)
    
    if prot.type == "fluid" then
      canonical_item_costs[item] = 0.1
      return 0.1
    else
      canonical_item_costs[item] = 1
      return 1
    end

  end

  return 0
end

local recipes_examined = {}

local function GetRecipeCost(recipe)
  if recipes_examined[recipe.name] then
    log("Loop detected while determining cost of " .. recipe.name .. " , defaulting to 1.")
    return 1
  end
  recipes_examined[recipe.name] = true
  --log("Getting recipe cost of " .. recipe.name)
  local cumulative_cost = 0
  if recipe.ingredients then
    for k, v in pairs(recipe.ingredients) do
      cumulative_cost = cumulative_cost + (GetItemCost(v.name) * v.amount)
    end
  end

  local solid_products = {}
  if recipe.results then
    for k, v in pairs(recipe.results) do
      if v.type == "item" then
        table.insert(solid_products, table.deepcopy(v))
      end
    end

    if #solid_products == 1 then
      local a = 1
      if solid_products[1].amount then
        a = solid_products[1].amount
      elseif solid_products[1].amount_min and solid_products[1].amount_max then
        a = (solid_products[1].amount_min + solid_products[1].amount_max) / 2
      end

      if solid_products[1].probability then
        a = a * solid_products[1].probability
      end

      --remove catalysts
      a = a - rm.GetIngredientCount(recipe, solid_products[1].name)

      if a > 0 and not canonical_item_costs[solid_products[1].name] then
        local prot = misc.GetPrototype(solid_products[1].name)
        if prot and get_canonical_recipe(prot) == recipe.name then
          canonical_item_costs[solid_products[1].name] = cumulative_cost / a
        end
      end
    end
  end
  recipes_examined[recipe.name] = false
  return cumulative_cost
end

time_paradox[1] = GetRecipeCost

if mods["Krastorio2"] and data.raw.recipe["iron-gear-wheel"] then
  --I don't know why Krastorio is only sometimes bulkifying this recipe.
  if (data.raw.recipe["iron-gear-wheel"].normal and data.raw.recipe["iron-gear-wheel"].normal.energy_required == 2) or data.raw.recipe["iron-gear-wheel"].energy_required == 2 then
    -- recipe has been bulkified to cost of 4 plates
    data.raw.recipe["iron-gear-wheel"].lasermill.helium = 2
  else
    -- recipe remains at K2 default cost of 1 plate
    data.raw.recipe["iron-gear-wheel"].lasermill.multiply = 2
  end
end

local new_recipes = {}
local new_recipes_helium = {}
local new_recipes_multipliers = {}
local new_recipes_tech_unlocks = {}

--local gubbins_allowed = settings.startup["lasingaround-allow-gubbins-in-mill"].value
--local circuits_allowed = settings.startup["lasingaround-allow-circuits-in-mill"].value
--local entities_allowed = settings.startup["lasingaround-allow-entities-in-mill"].value
local hide_duplicates = settings.startup["lasingaround-hide-duplicate-recipes"].value

local function get_main_product(recipe)
  if recipe.main_product then
    return recipe.main_product
  end
  if recipe.results and #recipe.results == 1 then
    local product = recipe.results[1]
    return product["name"] or product[1] or "???"
  end
  return "???"
end

local function get_prototype(name)
  local possibilities = {"item", "fluid", "ammo", "capsule", "gun", "item-with-entity-data", "item-with-label", "module", "rail-planner", "spidertron-remote", "tool", "armor", "repair-tool"}
  for k, v in pairs(possibilities) do
    if data.raw[v] then
      local prototype = data.raw[v][name]
      if prototype then return prototype end
    end
  end
  log("tried to get prototype for nonexistent item/fluid: " .. name)
  return false
end

local function get_icon(name)
  local p = get_prototype(name)
  if p then
    if p.icons then return p.icons end
    if p.icon then
      return {
        {
          icon = p.icon,
          icon_size = p.icon_size,
          icon_mipmaps = p.icon_mipmaps
        }
      }
    end
    log("missing or malformed icon for item/fluid: " .. name)
    return {
      {
        icon = "__core__/graphics/icons/alerts/destroyed-icon.png",
        icon_size = 64
      }
    }
  else
    return {
      {
        icon = "__core__/graphics/icons/alerts/destroyed-icon.png",
        icon_size = 64
      }
    }
  end
end

local function make_laser_recipe_icon(recipe, position, is_space)
  local starting_icon = {}
  if recipe.icons then
    starting_icon = table.deepcopy(recipe.icons)
    if not position then
      if mods["icon-badges"] and recipe.ib_badge and (recipe.ib_corner == "left-top" or not recipe.ib_corner) then
        position = {8, -8}
      else
        position = {-8, -8}
      end
    end
  else if recipe.icon then
    starting_icon = {
      {
        icon = recipe.icon,
        icon_size = recipe.icon_size,
        icon_mipmaps = recipe.icon_mipmaps
      }
    }
    if not position then
      if mods["icon-badges"] and recipe.ib_badge and (recipe.ib_corner == "left-top" or not recipe.ib_corner) then
        position = {8, -8}
      else
        position = {-8, -8}
      end
    end
  else
    local product = get_main_product(recipe)
    starting_icon = table.deepcopy(get_icon(product))
    if not position then
      local product_prototype = get_prototype(product)
      if product_prototype and mods["icon-badges"] and product_prototype.ib_badge then
        position = {8, -8}
      else
        position = {-8, -8}
      end
    end
  end end
  table.insert(starting_icon, {
    icon = is_space and "__space-exploration-graphics__/graphics/icons/astronomic/planet-orbit.png" or "__LasingAround__/graphics/icons/laser-modifier.png",
    icon_size = 64,
    scale = 0.25,
    shift = table.deepcopy(position)
  })
  return starting_icon
end

local function remove_extraneous_fluids(recipe, exclusion)
  if recipe.ingredients then
    local incomplete = true
    while incomplete do
      incomplete = false
      for k, ing in pairs(recipe.ingredients) do
        if ing.type == "fluid" and ing.name ~= "helium" and ing.name ~= exclusion then
          recipe.ingredients[k] = nil
          incomplete = true
          break
        end
      end
    end
  end
end

--[[
lasermill = {
  helium = 5,
  type = "welding",
  convert = false,
  productivity = false,
  unlock = "laser-mill",
  icon_offset={-8, -8},
  remove_fluids=false,
  se_variant=false,
  multiply=1
}
]]--

local lasermill_property = mods["space-age"] and "lasermill_dlc" or "lasermill_vanilla"

for name, recipe in pairs(data.raw.recipe) do
  if recipe[lasermill_property] then
    local lasdata = recipe[lasermill_property]
    if true then
      if lasdata.helium < 0 then
          local estimated_cost = GetRecipeCost(recipe) * lasdata.helium * -1
          if mods["space-age"] then
            estimated_cost = estimated_cost / 2
          end
          if estimated_cost < 0.6 and estimated_cost ~= 0 then
            local mult = math.ceil(1 / estimated_cost)
            lasdata.multiply = mult * (lasdata.multiply or 1)
            estimated_cost = estimated_cost * mult
          end
          lasdata.helium = math.ceil(estimated_cost - (mods["space-age"] and 0.1 or 0.2))
      end

      if lasdata.convert then
        if lasdata.remove_fluids then
          remove_extraneous_fluids(recipe)
        end
        if lasdata.remove_fluids_except then
          remove_extraneous_fluids(recipe, lasdata.remove_fluids_except)
        end
        new_recipes_helium[name] = lasdata.helium or 1
        recipe.category = "laser-milling-exclusive"
        if lasdata.multiply then
          new_recipes_multipliers[recipe_copy.name] = lasdata.multiply
        end
      end
      if (not lasdata.convert) or (mods["space-exploration"] and lasdata.se_variant and lasdata.convert) then
        local recipe_copy = table.deepcopy(recipe)
        if lasdata.remove_fluids then
          remove_extraneous_fluids(recipe_copy)
        end
        if lasdata.remove_fluids_except then
          remove_extraneous_fluids(recipe, lasdata.remove_fluids_except)
        end
        if lasdata.convert then
          recipe_copy.name = name .. "-in-orbit"
          recipe_copy.category = lasdata.se_variant
          recipe_copy.additional_categories = nil
          recipe.additional_categories = nil
        else
          recipe_copy.name = name .. "-in-laser-mill"
          recipe_copy.category = "laser-milling"
          recipe_copy.additional_categories = nil
          new_recipes_helium[recipe_copy.name] = lasdata.helium or 1
          if lasdata.multiply then
            new_recipes_multipliers[recipe_copy.name] = lasdata.multiply
          end
        end

        if lasdata.prod_research then
          if type(lasdata.prod_research) == "string" then
            tm.AddUnlock(lasdata.prod_research, {type="change-recipe-productivity", recipe=recipe_copy.name, change=0.1})
          else
            tm.AddUnlock(lasdata.prod_research[1], {type="change-recipe-productivity", recipe=recipe_copy.name, change=lasdata.prod_research[2]})
          end
        end

        if lasdata.icon_offset ~= false then
          recipe_copy.icons = make_laser_recipe_icon(recipe, lasdata.icon_offset, lasdata.convert)
          recipe_copy.icon = nil
          recipe_copy.icon_mipmaps = nil
        end

        if lasdata.convert then
          if recipe.localised_description then
            recipe.localised_description = {"", recipe.localised_description, "\n\n", {"recipe-description.also-made-without-helium", lasdata.se_tooltip_entity, {"entity-name." .. lasdata.se_tooltip_entity}}}
          else
            recipe.localised_description = {"?", {"", {"recipe-description." .. recipe.name}, "\n\n", {"recipe-description.also-made-without-helium", lasdata.se_tooltip_entity, {"entity-name." .. lasdata.se_tooltip_entity}}}, {"recipe-description.also-made-without-helium", lasdata.se_tooltip_entity, {"entity-name." .. lasdata.se_tooltip_entity}}}
            recipe_copy.localised_description = {"?", {"recipe-description." .. recipe_copy.name}, {"recipe-description." .. recipe.name}, ""}
          end
        else
          if recipe.localised_description then
            recipe.localised_description = {"", recipe.localised_description, "\n\n", {"recipe-description.also-made-with-helium", "laser-mill", {"entity-name.laser mill"}}}
          else
            recipe.localised_description = {"?", {"", {"recipe-description." .. recipe.name}, "\n\n", {"recipe-description.also-made-with-helium", "laser-mill", {"entity-name.laser-mill"}}}, {"recipe-description.also-made-with-helium", "laser-mill", {"entity-name.laser-mill"}}}
            recipe_copy.localised_description = {"?", {"recipe-description." .. recipe_copy.name}, {"recipe-description." .. recipe.name}, ""}
          end
        end

        if recipe.localised_name then
          recipe_copy.localised_name = {"recipe-name.laser-mill-recipe", recipe.localised_name}
        else
          recipe_copy.localised_name = {"recipe-name.laser-mill-recipe", {"?", {"recipe-name." .. recipe.name}, {"item-name." .. get_main_product(recipe)}, {"entity-name." .. get_main_product(recipe)}}}
        end

        if hide_duplicates then
          recipe_copy.hide_from_player_crafting = true
          if recipe_copy.normal then recipe_copy.normal.hide_from_player_crafting = true end
          if recipe_copy.expensive then recipe_copy.expensive.hide_from_player_crafting = true end
        end

        recipe_copy.always_show_made_in = true
        if recipe_copy.normal then recipe_copy.normal.always_show_made_in = true end
        if recipe_copy.expensive then recipe_copy.expensive.always_show_made_in = true end

        --allow more convenience for specifying this
        if lasdata.unlock == true then
          recipe_copy.enabled = true
          if recipe_copy.normal then recipe_copy.normal.enabled = true end
          if recipe_copy.expensive then recipe_copy.expensive.enabled = true end
        else
          recipe_copy.enabled = false
          if recipe_copy.normal then recipe_copy.normal.enabled = false end
          if recipe_copy.expensive then recipe_copy.expensive.enabled = false end
          if lasdata.unlock ~= false then
            if lasdata.unlock == nil then lasdata.unlock = {"laser-mill"} end
            if type(lasdata.unlock) == "string" then lasdata.unlock = {lasdata.unlock} end
            new_recipes_tech_unlocks[recipe_copy.name] = lasdata.unlock
          end
        end
        --techfuncs unlock-adding function requires the recipe to first exist in data.raw, but we are iterating over data.raw as we speak so we cannot add it here

        if lasdata.productivity ~= nil then
          recipe_copy.allow_productivity = true
        end

        --log("generating laser mill recipe: " .. recipe_copy.name)

        table.insert(new_recipes, recipe_copy)
      end
    end
  end
end

if #new_recipes > 0 then
  data:extend(new_recipes)
end

for name, techs in pairs(new_recipes_tech_unlocks) do
  for _, technology in pairs(techs) do
    tm.AddUnlock(technology, name)
  end
end

for name, multiplier in pairs(new_recipes_multipliers) do
  rm.MultiplyRecipe(name, multiplier)
end

for name, helium in pairs(new_recipes_helium) do
  rm.AddIngredient(name, "helium", helium)
end

log(serpent.block(canonical_item_costs))