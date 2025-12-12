rm = require("__pf-functions__/recipe-manipulation")

require("compat.vanilla")
if mods["space-age"] then
  require("compat.space-age")
end

require("compat/bz")
require("compat/mod-planets")
require("compat.small-mod")

if mods["quality"] then
    rm.FixStackingRecycling()
    require("__quality__/data-updates")

    if data.raw.item["dormant-newtronic-chip"] then
        local pulse_recycling = table.deepcopy(data.raw.recipe["dormant-newtronic-chip-recycling"])
        pulse_recycling.icons = data.raw.recipe["pulsing-newtronic-chip-recycling"].icons
        pulse_recycling.localised_name = data.raw.recipe["pulsing-newtronic-chip-recycling"].localised_name
        pulse_recycling.name = "pulsing-newtronic-chip-recycling"
        pulse_recycling.ingredients = {{type="item", name="pulsing-newtronic-chip", amount=1}}
        data:extend({pulse_recycling})
        data.raw.item["pulsing-newtronic-chip"].auto_recycle = false
    end

    local biggest_result_list = data.raw.furnace.recycler.result_inventory_size
    for k, v in pairs(data.raw.recipe) do
      if v.type == "recycling" or v.type == "recycling-or-hand-crafting" then
        if v.results and #v.results > biggest_result_list then
          biggest_result_list = #v.results
        end
      end
    end
    data.raw.furnace.recycler.result_inventory_size = biggest_result_list
    if mods["Age-of-Production"] then
        data.raw.furnace["aop-salvager"].result_inventory_size = biggest_result_list
    end
end

if mods["scrap-industry"] then
  if global_laser_mill_reserved then
      log("laser mill reserved by: " .. serpent.line(global_laser_mill_reserved))
  else
      require("lasermill-recipe-generator")
  end
end