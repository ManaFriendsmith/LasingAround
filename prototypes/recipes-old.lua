local parts = require("variable-parts")
local rm = require("recipe-modify")

local early_acid = data.raw.fluid["nitric-acid"] and (mods["ThemTharHills"] or mods["BrimStuff"])
local ic_in_scanner = mods["ThemTharHills"] and not mods["space-exploration"]

local gubbins_allowed = settings.startup["lasingaround-allow-gubbins-in-mill"].value
local circuits_allowed = settings.startup["lasingaround-allow-circuits-in-mill"].value
local entities_allowed = settings.startup["lasingaround-allow-entities-in-mill"].value


local helium_yield = 10
if settings.startup["lasingaround-allow-gubbins-in-mill"].value then
  helium_yield = helium_yield + 2
end
if settings.startup["lasingaround-allow-circuits-in-mill"].value then
  helium_yield = helium_yield + (mods["bzgold"] and 2 or 3)
end
if settings.startup["lasingaround-allow-gubbins-in-mill"].value then
  helium_yield = helium_yield + 1
end

if mods["LunarLandings"] then
  helium_yield = helium_yield / 2
end

data:extend({
  {
    type = "recipe",
    name = "oil-filtration",
    subgroup = "helium",
    order = "a",
    category = "chemistry",
    enabled = false,
    energy_required = 1,
    ingredients = {{type="fluid", name="crude-oil", amount=50, fluidbox_index=1}},
    results = {{type="fluid", name="filtered-oil", amount=50, fluidbox_index=1}},
    crafting_machine_tint = {
        primary = {0.1, 0.1, 0.1, 1},
        secondary = {0.9, 0.9, 0.9, 1},
        tertiary = {1, 1, 1, 0.5},
        quaternary = {1, 1, 1, 1}
    }
  },
  {
    type = "recipe",
    name = "advanced-oil-filtration",
    localised_description = {"recipe-description.helium-productivity-rules"},
    icon = "__LasingAround__/graphics/icons/advanced-oil-filtration.png",
    icon_size = 64,
    subgroup = "helium",
    order = "b",
    category = "chemistry",
    enabled = false,
    energy_required = 1,
    ingredients = {{type="fluid", name="crude-oil", amount=50}, {type="fluid", name="steam", amount=5}},
    results = {{type="fluid", name="filtered-oil", amount=50, catalyst_amount=50}, {type="fluid", name="helium", amount=helium_yield}},
    crafting_machine_tint = {
        primary = {0.1, 0.1, 0.1, 1},
        secondary = {0.75, 1, 0.9, 1},
        tertiary = {1, 1, 1, 0.5},
        quaternary = {0.75, 1, 0.9, 1}
    }
  },
  {
    type = "recipe",
    name = "spectroscopic-oil-filtration",
    localised_description = {"recipe-description.helium-productivity-rules"},
    icons = {
      {
        icon = "__LasingAround__/graphics/icons/advanced-oil-filtration.png",
        icon_size = 64,
      },
      {
        icon = "__LasingAround__/graphics/icons/spectroscope.png",
        icon_size = 64,
        scale=0.25,
        shift={-8, 8}
      }
    },
    subgroup = "helium",
    order = "c",
    category = "oil-processing",
    enabled = false,
    energy_required = 2,
    ingredients = {{type="fluid", name="crude-oil", amount=100}, {type="fluid", name="steam", amount=20}, {"spectroscope", 1}},
    results = {{type="fluid", name="filtered-oil", amount=100, catalyst_amount=100}, {type="fluid", name="helium", amount=helium_yield * 3}, {type="item", name="spectroscope", amount=1, probability=0.99, catalyst_amount=1}, {type="fluid", name="crude-oil", amount=5, catalyst_amount=5}},
    allow_decomposition = false
  },
  (mods["bzgold"] and not (mods["space-exploration"] or mods["ThemTharHills"])) and {
    type = "recipe",
    name = "empty-amplifier-tube",
    category = "advanced-crafting",
    enabled = false,
    energy_required = 50,
    ingredients = {{"gold-ingot", 1}, parts.preferred({"ll-silica", "bismuth-glass", "glass", "quartz", "silica", "tin-plate", "iron-plate"}, {40, 20, 20, 10, 50, 20, 10}), parts.preferred({"silver-plate", "copper-plate"}, {10, 10}), parts.optionalIngredient("tungsten-plate", 10)},
    result = "empty-amplifier-tube",
    result_count = 10,
    lasermill = {
      helium = 30,
      productivity = true
    }
  } or {
    type = "recipe",
    name = "empty-amplifier-tube",
    icon_size = 64,
    category = "advanced-crafting",
    enabled = false,
    energy_required = 5,
    ingredients = {parts.preferred({"gold-plate", "fi_materials_gold", "silver-wire", "tinned-cable", "copper-cable"}, {1, 1, 2, 2, 2}), parts.preferred({"ll-silica", "bismuth-glass", "glass", "quartz", "silica", "tin-plate", "iron-plate"}, {4, 2, 2, 1, 5, 2, 1}), parts.preferred({"silver-plate", "copper-plate"}, {1, 1}), parts.optionalIngredient("tungsten-plate", 1)},
    result = "empty-amplifier-tube",
    lasermill = {
      helium = 3,
      productivity = true
    }
  },
  {
    type = "recipe",
    name = "helium-laser",
    icon_size = 64,
    category = "crafting-with-fluid",
    enabled = false,
    energy_required = 2,
    ingredients = {{type="fluid", name="helium", amount=25}, {"empty-amplifier-tube", 1}, {"electronic-circuit", 1}, {"battery", 1}, parts.preferred({"optical-fiber", "quartz"}, {1, 1})},
    result = "helium-laser"
  },
  {
    type = "recipe",
    name = "carbon-dioxide-laser",
    icon_size = 64,
    category = "crafting-with-fluid",
    enabled = false,
    energy_required = 2,
    ingredients = {{type="fluid", name="petroleum-gas", amount=100}, {"empty-amplifier-tube", 1}, {"advanced-circuit", 1}, {"battery", 10}, parts.preferred({"ti-sapphire", "diamond", "el_energy_crystal_item"}, {1, 1, 1}), parts.optionalIngredient("advanced-cable", 1)},
    result = "carbon-dioxide-laser"
  },
  {
    type = "recipe",
    name = "scanner",
    icon_size = 64,
    category = "crafting",
    enabled = false,
    energy_required = 3,
    ingredients = {{"helium-laser", 1}, ic_in_scanner and {"integrated-circuit", 5} or {"electronic-circuit", 1}, {"advanced-circuit", ic_in_scanner and 1 or 3}, parts.preferred({"glass", "optical-fiber"}, {2, 3})},
    result = "scanner"
  },
  {
    type = "recipe",
    name = "spectroscope",
    icon_size = 64,
    category = "crafting",
    enabled = false,
    energy_required = 3,
    ingredients = {{"helium-laser", 1}, parts.preferred({"ll-silicon", "silver-plate", "copper-plate"}, {2, 3, 3}), parts.preferred({"silicon-wafer", "electronic-circuit"}, {1, 1}), parts.preferred({"glass", "ll-silica", "bismuth-glass"}, {1, 2, 1})},
    result = "spectroscope"
  },
  {
    type = "recipe",
    name = "laser-mill",
    category = "crafting",
    energy_required = 1,
    result = "laser-mill",
    enabled = false,
    ingredients = {{"assembling-machine-2", 1}, {"carbon-dioxide-laser", 2}, parts.preferred({"complex-joint", "steel-gear-wheel", "bearing", "iron-gear-wheel"}, {2, 4, 4, 10}), parts.preferred({"hv-power-regulator", "advanced-circuit"}, {5, 25}), parts.preferred({"se-heat-shielding", "tungsten-plate"}, {1, 10}), parts.optionalIngredient("cooling-fan", 10), parts.preferred({"bismuth-glass", "glass"}, {10, 10})}
  }
})

if mods["bzgas"] then
  data:extend({
    {
      type = "recipe",
      name = "advanced-gas-processing",
      localised_description = {"recipe-description.helium-productivity-rules"},
      icon = "__LasingAround__/graphics/icons/advanced-gas-processing.png",
      icon_size = 64,
      subgroup = "helium",
      order = "d",
      category = "chemistry",
      enabled = false,
      energy_required = 5,
      ingredients = {{type="fluid", name="gas", amount=50}, {type="fluid", name="steam", amount=5}},
      results = {{type="fluid", name="formaldehyde", amount=45, catalyst_amount=45}, {type="fluid", name="helium", amount=helium_yield}},
      crafting_machine_tint = {
          primary = {1, 0.85, 0.1, 1},
          secondary = {0.75, 1, 0.9, 1},
          tertiary = {1, 1, 1, 0.5},
          quaternary = {0.75, 1, 0.9, 1}
      }
    },
    {
      type = "recipe",
      name = "spectroscopic-gas-processing",
      localised_description = {"recipe-description.helium-productivity-rules"},
      icons = {
        {
          icon = "__LasingAround__/graphics/icons/advanced-gas-processing.png",
          icon_size = 64,
        },
        {
          icon = "__LasingAround__/graphics/icons/spectroscope.png",
          icon_size = 64,
          scale=0.25,
          shift={-8, 8}
        }
      },
      subgroup = "helium",
      order = "e",
      category = "oil-processing",
      enabled = false,
      energy_required = 10,
      ingredients = {{type="fluid", name="gas", amount=100}, {type="fluid", name="steam", amount=20}, {"spectroscope", 1}},
      results = {{type="fluid", name="formaldehyde", amount=90, catalyst_amount=90}, {type="fluid", name="helium", amount=helium_yield * 3}, {type="item", name="spectroscope", amount=1, probability=0.99, catalyst_amount=1}, {type="fluid", name="gas", amount=5, catalyst_amount=5}},
      allow_decomposition = false
    },
  })

  if mods["Krastorio2"] then
    data:extend({
      {
          type = "recipe",
          name = "advanced-gas-reforming",
          localised_description = {"recipe-description.helium-productivity-rules"},
          icons = {
            {
              icon = "__Krastorio2Assets__/icons/fluids/hydrogen.png",
              icon_mipmaps = 4,
              icon_size = 64,
            },
            {
              icon = "__bzgas__/graphics/icons/gas.png",
              icon_size = 128,
              scale=0.125,
              shift={-8, -8}
            },
            {
              icon = "__LasingAround__/graphics/icons/helium.png",
              icon_size = 64,
              scale=0.25,
              shift={8, 8}
            }
          },
          subgroup = "helium",
          order = "f",
          category = "chemistry",
          enabled = false,
          energy_required = 6,
          ingredients = {{type="fluid", name="gas", amount=50}, {type="fluid", name="steam", amount=10}},
          results = {{type="fluid", name="hydrogen", amount=200, catalyst_amount=200}, {type="fluid", name="helium", amount=helium_yield}},
          crafting_machine_tint = {
              primary = {1, 0.85, 0.1, 1},
              secondary = {0.75, 1, 0.9, 1},
              tertiary = {1, 1, 1, 0.5},
              quaternary = {0.75, 1, 0.9, 1}
          }
        },
        {
          type = "recipe",
          name = "spectroscopic-gas-reforming",
          localised_description = {"recipe-description.helium-productivity-rules"},
          icons = {
            {
              icon = "__Krastorio2Assets__/icons/fluids/hydrogen.png",
              icon_mipmaps = 4,
              icon_size = 64,
            },
            {
              icon = "__bzgas__/graphics/icons/gas.png",
              icon_size = 128,
              scale=0.125,
              shift={-8, -8}
            },
            {
              icon = "__LasingAround__/graphics/icons/helium.png",
              icon_size = 64,
              scale=0.25,
              shift={8, 8}
            },
            {
              icon = "__LasingAround__/graphics/icons/spectroscope.png",
              icon_size = 64,
              scale=0.25,
              shift={-8, 8}
            }
          },
          subgroup = "helium",
          order = "g",
          category = "oil-processing",
          enabled = false,
          energy_required = 12,
          ingredients = {{type="fluid", name="gas", amount=100}, {type="fluid", name="steam", amount=40}, {"spectroscope", 1}},
          results = {{type="fluid", name="hydrogen", amount=400, catalyst_amount=400}, {type="fluid", name="helium", amount=helium_yield * 3}, {type="item", name="spectroscope", amount=1, probability=0.99, catalyst_amount=1}, {type="fluid", name="gas", amount=5, catalyst_amount=5}},
          allow_decomposition = false
        }
    })
  end

  if mods["space-exploration"] then
    data:extend({
      {
          type = "recipe",
          name = "advanced-methane-distillation",
          localised_description = {"recipe-description.helium-productivity-rules"},
          icons = {
            {
              icon = "__space-exploration-graphics__/graphics/icons/fluid/methane-gas.png",
              icon_mipmaps = 4,
              icon_size = 64,
            },
            {
              icon = "__bzgas__/graphics/icons/gas.png",
              icon_size = 128,
              scale=0.125,
              shift={-8, -8}
            },
            {
              icon = "__LasingAround__/graphics/icons/helium.png",
              icon_size = 64,
              scale=0.25,
              shift={8, 8}
            }
          },
          subgroup = "helium",
          order = "h",
          category = "chemistry",
          enabled = false,
          energy_required = 2,
          ingredients = {{type="fluid", name="gas", amount=50}, {type="fluid", name="steam", amount=5}},
          results = {{type="fluid", name="se-methane-gas", amount=50, catalyst_amount=50}, {type="fluid", name="helium", amount=helium_yield}},
          crafting_machine_tint = {
              primary = {1, 0.85, 0.1, 1},
              secondary = {0.75, 1, 0.9, 1},
              tertiary = {1, 1, 1, 0.5},
              quaternary = {0.75, 1, 0.9, 1}
          }
        },
        {
          type = "recipe",
          name = "spectroscopic-methane-distillation",
          localised_description = {"recipe-description.helium-productivity-rules"},
          icons = {
            {
              icon = "__space-exploration-graphics__/graphics/icons/fluid/methane-gas.png",
              icon_mipmaps = 4,
              icon_size = 64,
            },
            {
              icon = "__bzgas__/graphics/icons/gas.png",
              icon_size = 128,
              scale=0.125,
              shift={-8, -8}
            },
            {
              icon = "__LasingAround__/graphics/icons/helium.png",
              icon_size = 64,
              scale=0.25,
              shift={8, 8}
            },
            {
              icon = "__LasingAround__/graphics/icons/spectroscope.png",
              icon_size = 64,
              scale=0.25,
              shift={-8, 8}
            }
          },
          subgroup = "helium",
          order = "i",
          category = "oil-processing",
          enabled = false,
          energy_required = 4,
          ingredients = {{type="fluid", name="gas", amount=100}, {type="fluid", name="steam", amount=20}, {"spectroscope", 1}},
          results = {{type="fluid", name="se-methane-gas", amount=100, catalyst_amount=100}, {type="fluid", name="helium", amount=helium_yield * 3}, {type="item", name="spectroscope", amount=1, probability=0.99, catalyst_amount=1}, {type="fluid", name="gas", amount=5, catalyst_amount=5}},
          allow_decomposition = false
        }
    })
  end
end

if data.raw.item["tracker"] then
  data:extend({
    {
      type = "recipe",
      name = "tracker",
      category = "crafting",
      enabled = false,
      energy_required = 10,
      ingredients = {{"transceiver", 1}, {"helium-laser", 1}, parts.preferred({"gyro", "gyroscope"}, {1, 1}), mods["space-exploration"] and parts.preferred({"graphene", "battery"}, {1, 1}) or {"battery", 1}},
      result = "tracker"
    }
  })
end

if data.raw.item["micron-tolerance-components"] then
  data:extend({
    {
      type = "recipe",
      name = "micron-tolerance-components",
      category = "meowing",
      enabled = false,
      energy_required = 4,
      ingredients = {{"invar-plate", 1}},
      result = "micron-tolerance-components",
      result_count = 4,
      lasermill = {
        helium = 2,
        convert = true,
        se_variant = "space-laser",
        se_tooltip_entity = "se-space-laser-laboratory",
        unlock = "se-space-laser-laboratory",
        icon_offset = {8, -8}
      }
    }
  })
  if mods["space-exploration"] then
    data:extend({
      {
        type = "recipe",
        name = "spectroscope-micron-tolerance",
        icons = {
          {
            icon = "__LasingAround__/graphics/icons/spectroscope.png",
            icon_size = 64
          },
          {
            icon = "__LasingAround__/graphics/icons/micron-tolerance-components.png",
            icon_size = 64,
            scale = 0.25,
            shift = {-8, -8}
          }
        },
        category = "crafting",
        enabled = false,
        energy_required = 3,
        ingredients = {{"helium-laser", 1}, parts.preferred({"silver-plate", "copper-plate"}, {1, 1}), parts.preferred({"silicon-wafer", "electronic-circuit"}, {1, 1}), parts.preferred({"glass", "bismuth-glass"}, {1, 1}), {"micron-tolerance-components", 1}},
        result = "spectroscope"
      },
      {
        type = "recipe",
        name = "laboratory-gear",
        category = "crafting",
        enabled = false,
        energy_required = 10,
        ingredients = {{"micron-tolerance-components", 5}, {"glass", 10}, {"spectroscope", 1}, {"scanner", 1}, parts.preferred({"gyroscope", "gyro"}, {1, 1}), parts.optionalIngredient("nitric-acid", 25)},
        result = "laboratory-gear",
        result_count = 5
      }
    })
  else
    if mods["LunarLandings"] then
      data:extend({
        {
          type = "recipe",
          name = "spectroscope-micron-tolerance",
          icons = {
            {
              icon = "__LasingAround__/graphics/icons/spectroscope.png",
              icon_size = 64
            },
            {
              icon = "__LasingAround__/graphics/icons/micron-tolerance-components.png",
              icon_size = 64,
              scale = 0.25,
              shift = {-8, -8}
            }
          },
          category = "crafting",
          enabled = false,
          energy_required = 3,
          ingredients = {{"helium-laser", 1}, {"ll-silicon", 2}, parts.preferred({"silicon-wafer", "electronic-circuit"}, {1, 1}), {"ll-silica", 2}, {"micron-tolerance-components", 2}},
          result = "spectroscope"
        }
      })
      rm.AddIngredient("spectroscope", "electronic-circuit", 2, 2)
    else
      rm.AddIngredient("spectroscope", "micron-tolerance-components", 1, 1)
      rm.RemoveIngredient("spectroscope", "copper-plate", 2, 2)
      rm.RemoveIngredient("spectroscope", "silver-plate", 2, 2)
    end
  end
end

if mods["space-exploration"] then
  se_delivery_cannon_recipes["helium-barrel"] = {name="helium-barrel"}
end

if not mods["Krastorio2"] then
  data:extend({
    {
      type = "recipe",
      name = "helium-venting",
      icon = "__LasingAround__/graphics/icons/helium-venting.png",
      icon_size = 64,
      subgroup = "helium",
      order = "z",
      category = "chemistry",
      enabled = false,
      energy_required = 0.5,
      ingredients = {{type="fluid", name="helium", amount=100}},
      emissions_multiplier = 0.01,
      results = {},
      allow_decomposition = false,
      crafting_machine_tint = {
          primary = {0, 0, 0, 0},
          secondary = {0, 0, 0, 0},
          tertiary = {0.75, 1, 0.9, 0.33},
          quaternary = {0.75, 1, 0.9, 1}
      }
    }
  })
end

if mods["LunarLandings"] then
  data:extend({
    {
      type = "recipe",
      name = "polariton-laser",
      category = "advanced-circuit-crafting",
      localised_name = { "recipe-name.polariton-laser" },
      icons = {
        {
          icon = "__LasingAround__/graphics/icons/helium-laser.png",
          icon_size = 64
        },
        {
          icon = "__LunarLandings__/graphics/icons/polariton/polariton.png",
          icon_size = 64,
          scale = 0.25,
          shift = {-8, -8}
        }
      },
      energy_required = 60,
      allow_decomposition = false,
      ingredients = {{"battery", 20}, {"empty-amplifier-tube", 20}, {type="fluid", name="ll-astroflux", amount=50}, {type="item", name="ll-superposed-polariton", amount=1, catalyst_amount=1}, {type="item", name="ll-up-polariton", amount=1, catalyst_amount=1}},
      results = {{type="item", name="helium-laser", amount=20}, {type="item", name="ll-up-polariton", amount=1, probability=0.2, catalyst_amount=1}, {type="item", name="ll-down-polariton", amount=1, probability=0.4, catalyst_amount=1}, {type="item", name="ll-left-polariton", amount=1, probability=0.6, catalyst_amount=1}, {type="item", name="ll-right-polariton", amount=1, probability=0.8, catalyst_amount=1}},
      main_product = "helium-laser",
      enabled = false
    }
  })
  if data.raw.item["tracker"] then
    data:extend({
      {
        type = "recipe",
        name = "advanced-rocket-control-unit",
        category = "advanced-circuit-crafting",
        icons = {
          {
            icon = "__base__/graphics/icons/rocket-control-unit.png",
            icon_size = 64
          },
          {
            icon = "__LasingAround__/graphics/icons/tracker.png",
            icon_size = 64,
            scale = 0.25,
            shift = {-8, -8}
          }
        },
        energy_required = 800,
        allow_decomposition = false,
        ingredients = {{"ll-quantum-processor", 1}, {"tracker", 20}, {"ll-data-card", 1}},
        results = {{type="item", name="rocket-control-unit", amount=20}, {type="item", name="ll-junk-data-card", amount=1, catalyst_amount=1}},
        main_product = "rocket-control-unit",
        enabled = false
      }
    })
  end
end
