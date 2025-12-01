local misc = require("__pf-functions__/misc")
local rm = require("__pf-functions__/recipe-manipulation")
local item_sounds = require("__base__/prototypes/item_sounds")
local space_age_item_sounds = "foo"

data:extend({
    {
        type = "recipe",
        name = "oil-filtration",
        subgroup = "helium",
        order = "a",
        category = "chemistry",
        enabled = false,
        energy_required = 1,
        ingredients = {
            {type="fluid", name="crude-oil", amount=50, fluidbox_index=1}
        },
        results = {
            {type="fluid", name="filtered-oil", amount=50, fluidbox_index=1}
        },
        allow_quality = false,
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
        icon = "__LasingAroundMk2__/graphics/icons/advanced-oil-filtration.png",
        icon_size = 64,
        subgroup = "helium",
        order = "b",
        category = "chemistry",
        enabled = false,
        energy_required = 1,
        ingredients = {
            {type="fluid", name="crude-oil", amount=50},
            {type="fluid", name="steam", amount=5}
        },
        results = {
            {type="fluid", name="filtered-oil", amount=50, ignored_by_productivity=50},
            {type="fluid", name="helium", amount=mods["LunarLandings"] and 3 or 10}
        },
        allow_quality = false,
        allow_productivity = true,
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
            icon = "__LasingAroundMk2__/graphics/icons/advanced-oil-filtration.png",
            icon_size = 64,
          },
          {
            icon = "__LasingAroundMk2__/graphics/icons/spectroscope.png",
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
        ingredients = {
            {type="fluid", name="crude-oil", amount=100},
            {type="fluid", name="steam", amount=20},
            {type="item", name="spectroscope", amount=1, ignored_by_stats=1}
        },
        results = {
            {type="fluid", name="filtered-oil", amount=100, ignored_by_productivity=100},
            {type="fluid", name="helium", amount=mods["LunarLandings"] and 20 or 10},
            {type="item", name="spectroscope", amount=1, probability=0.99, ignored_by_stats=1, ignored_by_productivity=1},
            {type="fluid", name="heavy-oil", amount=5}
        },
        allow_quality = false,
        allow_productivity = true,
        allow_decomposition = false
      },
      {
        type = "recipe",
        name = "helium-venting",
        icon = "__LasingAroundMk2__/graphics/icons/helium-venting.png",
        icon_size = 64,
        subgroup = "helium",
        order = "d",
        category = "chemistry",
        enabled = false,
        energy_required = 0.5,
        ingredients = {{type="fluid", name="helium", amount=100}},
        emissions_multiplier = 0.01,
        results = {},
        allow_decomposition = false,
        allow_quality = false,
        crafting_machine_tint = {
            primary = {0, 0, 0, 0},
            secondary = {0, 0, 0, 0},
            tertiary = {0.75, 1, 0.9, 0.33},
            quaternary = {0.75, 1, 0.9, 1}
        }
      },
      {
        type = "recipe",
        name = "laser",
        category = mods["space-age"] and "electronics" or "crafting-with-fluid",
        ingredients = {
            {type="item", name="advanced-circuit", amount=1},
            {type="item", name="battery", amount=3},
            {type="fluid", name="helium", amount=25}
        },
        results = {
            {type="item", name="laser", amount=1}
        },
        energy_required = 8,
        lasermill_dlc = {helium=-1},
        allow_productivity = true,
        enabled = false
      },
      {
        type = "recipe",
        name = "spectroscope",
        category = mods["space-age"] and "electronics" or "crafting",
        ingredients = {
            {type="item", name="laser", amount=1},
            {type="item", name="electronic-circuit", amount=2},
            {type="item", name="copper-plate", amount=2}
        },
        results = {
            {type="item", name="spectroscope", amount=1}
        },
        energy_required = 8,
        lasermill_dlc = {helium=-1, unlock="spectroscopy"},
        allow_productivity = true,
        enabled = false
      },
      {
        type = "recipe",
        name = "laser-mill",
        category = "crafting",
        ingredients = mods["space-age"] and {
            {type="item", name="assembling-machine-3", amount=1},
            misc.difficulty == 3 and {type="item", name="cardinal-grammeter", amount=10} or {type="item", name="superconductor", amount=50},
            {type="item", name="carbon-fiber", amount=50},
            {type="item", name="laser", amount=20},
        } or {
            {type="item", name="assembling-machine-2", amount=1},
            {type="item", name="advanced-circuit", amount=20},
            {type="item", name="laser", amount=20},
        },
        results = {
            {type="item", name="laser-mill", amount=1}
        },
        energy_required = 5,
        enabled = false
    }
})

if mods["LunarLandings"] then
    data:extend({
        {
            type = "recipe",
            name = "ll-helium-extraction",
            category = "ll-electric-smelting",
            subgroup = "ll-raw-material-moon",
            order = "a[moon-rock]-c",
            icon = "__LasingAroundMk2__/graphics/icons/helium.png",
            icon_size = 64,
            ingredients = {
                {type="item", name="ll-moon-rock", amount=10},
                {type="fluid", name="steam", amount=20, fluidbox_index=1}
            },
            results = {
                {type="item", name="ll-moon-rock", amount_min=6, amount_max=9, ignored_by_productivity=9},
                {type="fluid", name="helium", amount=20, fluidbox_index=1}
            },
            energy_required = 10,
            enabled = false
        },
        {
            type = "recipe",
            name = "polariton-laser",
            category = "advanced-circuit-crafting",
            localised_name = { "recipe-name.polariton-laser" },
            icons = {
                {
                icon = "__LasingAroundMk2__/graphics/icons/laser.png",
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
            ingredients = {
                {type="item", name="battery", amount=20},
                {type="item", name="ll-silica", amount=100},
                {type="item", name="ll-superposed-polariton", amount=1},
                {type="item", name="ll-up-polariton", amount=1},
                {type="fluid", name="ll-astroflux", amount=50}
            },
            results = {
                {type="item", name="laser", amount=20},
                {type="item", name="ll-up-polariton", amount=1, probability=0.2, ignored_by_productivity=1},
                {type="item", name="ll-down-polariton", amount=1, probability=0.4, ignored_by_productivity=1},
                {type="item", name="ll-left-polariton", amount=1, probability=0.6, ignored_by_productivity=1},
                {type="item", name="ll-right-polariton", amount=1, probability=0.8, ignored_by_productivity=1}
            },
            main_product = "laser",
            allow_productivity = true,
            enabled = false
        }
    })
end

if mods["space-age"] then
    data:extend({
        {
            type = "recipe",
            name = "spectroscopic-holmium-processing",
            icons = {
                {
                    icon = "__space-age__/graphics/icons/fluid/holmium-solution.png",
                    icon_size = 64,
                    icon_mipmaps = 4
                },
                {
                    icon = "__LasingAroundMk2__/graphics/icons/spectroscope.png",
                    icon_size = 64,
                    scale = 0.25,
                    shift = {-8, -8}
                }
            },
            subgroup = "fulgora-processes",
            order = "c",
            category = "chemistry",
            ingredients = {
                {type="fluid", name="water", amount=10},
                {type="item", name="holmium-ore", amount=2},
                {type="item", name="stone", amount=2},
                {type="item", name="spectroscope", amount=1, ignored_by_stats=1}
            },
            results = {
                {type="fluid", name="holmium-solution", amount=110},
                {type="fluid", name="electrolyte", amount=5},
                {type="item", name="copper-ore", amount=1, probability=0.2},
                {type="item", name="spectroscope", amount=1, probability=0.99, ignored_by_stats=1, ignored_by_productivity=1}
            },
            energy_required = 20,
            allow_productivity = true,
            enabled = false
        },
        {
            type = "recipe",
            name = "spectroscopic-bioflux-processing",
            icons = {
                {
                    icon = "__space-age__/graphics/icons/bioflux.png",
                    icon_size = 64,
                    icon_mipmaps = 4
                },
                {
                    icon = "__LasingAroundMk2__/graphics/icons/spectroscope.png",
                    icon_size = 64,
                    scale = 0.25,
                    shift = {-8, -8}
                }
            },
            subgroup = "agriculture-products",
            order = "a[organic-products]-g[bioflux]-alt",
            category = "organic",
            ingredients = {
                {type="item", name="yumako-mash", amount=15},
                {type="item", name="jelly", amount=12},
                {type="item", name="spectroscope", amount=1, ignored_by_stats=1}
            },
            results = {
                {type="item", name="bioflux", amount=5},
                {type="item", name="spoilage", amount=5},
                {type="item", name="spectroscope", amount=1, probability=0.99, ignored_by_stats=1, ignored_by_productivity=1}
            },
            energy_required = 20,
            allow_productivity = true,
            enabled = false
        },
        {
            type = "recipe",
            name = "lavaser",
            category = "metallurgy",
            icons = {
                {
                    icon = "__LasingAroundMk2__/graphics/icons/laser.png",
                    icon_size = 64
                },
                {
                    icon = "__space-age__/graphics/icons/fluid/lava.png",
                    icon_size = 64,
                    icon_mipmaps = 4,
                    scale = 0.25,
                    shift = {8, 8}
                }
            },
            ingredients = {
                {type="item", name="advanced-circuit", amount=1},
                {type="item", name="battery", amount=3},
                {type="item", name="tungsten-plate", amount=(misc.starting_planet == "vulcanus") and 4 or 1},
                {type="fluid", name="lava", amount=2500}
            },
            results = {
                {type="item", name="laser", amount=1}
            },
            energy_required = 16,
            allow_productivity = true,
            enabled = false
        },
        {
            type = "recipe",
            name = "electrolaser",
            category = "electromagnetics",
            icons = {
                {
                    icon = "__LasingAroundMk2__/graphics/icons/laser.png",
                    icon_size = 64
                },
                {
                    icon = "__space-age__/graphics/icons/holmium-plate.png",
                    icon_size = 64,
                    icon_mipmaps = 4,
                    scale = 0.25,
                    shift = {8, 8}
                }
            },
            ingredients = {
                {type="item", name="processing-unit", amount=1},
                {type="item", name="supercapacitor", amount=3},
                {type="fluid", name="electrolyte", amount=50}
            },
            results = {
                {type="item", name="laser", amount=1}
            },
            energy_required = 16,
            allow_productivity = true,
            enabled = false
        },
        {
            type = "recipe",
            name = "bioluminaser",
            category = "organic",
            icons = {
                {
                    icon = "__LasingAroundMk2__/graphics/icons/laser.png",
                    icon_size = 64
                },
                {
                    icon = "__space-age__/graphics/icons/bioflux.png",
                    icon_size = 64,
                    icon_mipmaps = 4,
                    scale = 0.25,
                    shift = {8, 8}
                }
            },
            ingredients = {
                {type="item", name="advanced-circuit", amount=1},
                {type="item", name="battery", amount=3},
                {type="item", name="bioflux", amount=5}
            },
            results = {
                {type="item", name="laser", amount=1}
            },
            energy_required = 16,
            allow_productivity = true,
            enabled = false
        }
    })

    if data.raw.item["philosophers-hormone"] then
        rm.AddProduct("spectroscopic-bioflux-processing", {type="item", name="philosophers-hormone", amount=1, probability=0.5})
    end
end

if mods["maraxsis"] then
    data:extend({
        {
            type = "recipe",
            name = "halaser",
            category = "maraxsis-hydro-plant",
            icons = {
                {
                    icon = "__LasingAroundMk2__/graphics/icons/laser.png",
                    icon_size = 64
                },
                {
                    icon = "__maraxsis__/graphics/icons/salt-1.png",
                    icon_size = 64,
                    scale = 0.25,
                    shift = {8, 8}
                }
            },
            ingredients = {
                {type="item", name="advanced-circuit", amount=1},
                {type="item", name="battery", amount=3},
                {type="fluid", name="molten-salt", amount=25},
                {type="item", name="maraxsis-glass-panes", amount=5},
            },
            results = {
                {type="item", name="laser", amount=1}
            },
            energy_required = 16,
            allow_productivity = true,
            enabled = false
        }
    })
end

if mods["Paracelsin"] then
    data:extend({
        {
            type = "recipe",
            name = "galvaser",
            category = "mechanics",
            icons = {
                {
                    icon = "__LasingAroundMk2__/graphics/icons/laser.png",
                    icon_size = 64
                },
                {
                    icon = "__Paracelsin-Graphics__/graphics/icons/zinc-plate.png",
                    icon_size = 64,
                    scale = 0.25,
                    shift = {8, 8}
                }
            },
            ingredients = {
                {type="item", name="advanced-circuit", amount=1},
                {type="item", name="battery", amount=3},
                {type="fluid", name="nitric-acid", amount=25},
                {type="item", name="zinc-solder", amount=15},
                {type="item", name=mods["BrassTacksMk2"] and "pcl-zinc-plate" or "zinc-plate", amount=10},
            },
            results = {
                {type="item", name="laser", amount=1}
            },
            energy_required = 16,
            allow_productivity = true,
            enabled = false
        }
    })
end

if mods["castra"] then
    data:extend({
        {
            type = "recipe",
            name = "milaser",
            category = "castra-forge",
            icons = {
                {
                    icon = "__LasingAroundMk2__/graphics/icons/laser.png",
                    icon_size = 64
                },
                {
                    icon = "__castra__/graphics/icons/castra-data.png",
                    icon_size = 64,
                    scale = 0.25,
                    shift = {8, 8}
                }
            },
            ingredients = {
                {type="item", name="advanced-circuit", amount=1},
                {type="item", name="battery", amount=3},
                {type="item", name="castra-data", amount=1},
                {type="item", name=mods["IfNickelMk2"] and "cst-nickel-plate" or "nickel-plate", amount=5},
            },
            results = {
                {type="item", name="laser", amount=1}
            },
            energy_required = 16,
            allow_productivity = true,
            enabled = false
        }
    })

    local h2srecipe = table.deepcopy(data.raw.recipe["hydrogen-sulfide-electrolysis"])
    h2srecipe.name = "spectroscopic-hydrogen-sulfide-electrolysis"
    table.insert(h2srecipe.icons, {icon="__LasingAroundMk2__/graphics/icons/spectroscope.png", icon_size=64})
    rm.MultiplyRecipe(h2srecipe, 5)
    rm.AddIngredient(h2srecipe, "spectroscope", 1)
    rm.AddProduct(h2srecipe, {type="item", name="spectroscope", amount=1, probability=0.99})
    rm.AddProduct(h2srecipe, {type="fluid", name="helium", amount=10})
    data:extend({h2srecipe})
end

if tune_up_data then
  tune_up_data.recipes["laser"] = {
    category = "tuning-up",
    count = 1,
    energy_required = 3,
    ingredients = {{{"supercapacitor", 1}, {"holmium-plate", 1}}, {{"battery", 2}, {"integrated-circuit", 2}, {"helium", 5}}, {{"battery", 2}, {"electronic-circuit", 2}, {"helium", 5}}}
  }

  tune_up_data.recipes["spectroscope"] = {
    category = "tuning-up",
    count = 1,
    energy_required = 1,
    ingredients = {{{"superconductor", 1}, {"helium", 5}}}
  }

  tune_up_data.recipes["weird-alien-gizmo"] = {
    category = "tuning-up",
    count = 1,
    energy_required = 10,
    ingredients = {{{"superconductor", 5}, {"express-gearbox", 1}}, {{"superconductor", 5}, {"bearing", 5}}, {{"superconductor", 5}, {"iron-gear-wheel", 10}}}
  }

  tune_up_data.recipes["laser-mill"] = {
    category = "tuning-up",
    count = 1,
    energy_required = 5,
    ingredients = {{{"cardinal-grammeter", 10}, {"laser", 10}, {"supercapacitor", 10}}, {{"assembling-machine-3", 1}, {"laser", 10}, {"supercapacitor", 10}}, {{"assembling-machine-2", 1}, {"laser", 10}, {"productivity-module", 1}}}
  }

  tune_up_data.recipes["antiparticle-decelerator"] = {
    category = "tuning-up",
    count = 5,
    energy_required = 5,
    ingredients = {{{"quantum-processor", 20}, {"laser-mill", 1}, {"cardinal-grammeter", 20}}}
  }

  tune_up_data.recipes["antimatter-power-cell"] = {
    category = "tuning-up",
    count = 1,
    energy_required = 3,
    ingredients = {{{"helium", 10}}}
  }

  tune_up_data.recipes["tracker"] = {
    category = "tuning-up",
    count = 1,
    energy_required = 5,
    ingredients = {{{"advanced-circuit", 3}, {"battery", 3}}}
  }

  tune_up_data.recipes["micron-tolerance-components"] = {
    category = "tuning-up",
    count = 10,
    energy_required = 5,
    ingredients = {{{"invar-plate", 1}, {"helium", 3}}}
  }

  tune_up_data.recipes["scanner"] = {
    category = "tuning-up",
    count = 5,
    energy_required = 10,
    ingredients = {{{"laser", 5}, {"processing-unit", 1}}}
  }

  tune_up_data.recipes["cardinal-grammeter"] = {
    category = "tuning-up",
    count = 4,
    energy_required = 10,
    ingredients = {{{"hydrocoptic-marzelvane", 1}, {"quantum-processor", 1}}}
  }

  tune_up_data.recipes["high-density-chaos"] = {
    category = "tuning-up",
    count = 5,
    energy_required = 10,
    ingredients = {{{"cluster-grenade", 1}}}
  }

  tune_up_data.recipes["random-number-nullifier"] = {
    category = "tuning-up",
    count = 3,
    energy_required = 10,
    ingredients = {{{"weird-alien-gizmo", 1}}}
  }

  tune_up_data.recipes["art-rotators"] = {
    category = "tuning-up",
    count = 3,
    energy_required = 2,
    ingredients = {{{"electric-motor", 1}}}
  }

  tune_up_data.recipes["perpendicular-processor"] = {
    category = "tuning-up",
    count = 3,
    energy_required = 10,
    ingredients = {{{"advanced-circuit", 7}}}
  }

  tune_up_data.recipes["pentapod-gatekeeper"] = {
    category = "tuning-up",
    count = 2,
    energy_required = 4,
    ingredients = {{{"gate", 1}}}
  }

  tune_up_data.recipes["logic-deregulator"] = {
    category = "tuning-up",
    count = 1,
    energy_required = 10,
    ingredients = {{{"power-switch", 2}}}
  }

  tune_up_data.recipes["weighted-blanket"] = {
    category = "tuning-up",
    count = 3,
    energy_required = 2,
    ingredients = {{{"carbon-fiber", 2}}}
  }

  tune_up_data.recipes["clumsy-piston"] = {
    category = "tuning-up",
    count = 5,
    energy_required = 5,
    ingredients = {{{"uranium-238", 1}}}
  }

  tune_up_data.recipes["ordinary-human-brain"] = {
    category = "purification",
    count = 1,
    energy_required = 5,
    ingredients = {{{"neural-bioculture", 6}}, {{"bioflux", 1}}}
  }

  tune_up_data.recipes["ai-girlfriend"] = {
    category = "tuning-up",
    count = 10,
    energy_required = 20,
    ingredients = {{{"recycler", 1}}}
  }

  tune_up_data.recipes["dormant-newtronic-chip"] = {
    category = "tuning-up",
    count = 2,
    energy_required = 10,
    ingredients = {{{"cardinal-grammeter", 1}}}
  }

  tune_up_data.recipes["pulsing-newtronic-chip"] = {
    category = "tuning-up",
    count = 2,
    energy_required = 10,
    ingredients = {{{"cardinal-grammeter", 1}}}
  }
end

if misc.difficulty == 1 then
    return
end

if mods["space-age"] then
    data:extend({
        {
            type = "recipe",
            name = "custom-weird-alien-gizmo-recycling",
            category = "recycling-or-hand-crafting",
            localised_name = {"recipe-name.recycling", {"item-name.weird-alien-gizmo"}},
            subgroup = "fulgora-processes",
            order = "a[trash]-ba",
            icons = {
                {
                    icon = "__quality__/graphics/icons/recycling.png",
                    icon_size = 64
                  },
                  {
                    icon = "__LasingAroundMk2__/graphics/icons/weird-alien-gizmo.png",
                    icon_size = 64
                  },
                  {
                    icon = "__quality__/graphics/icons/recycling-top.png",
                    icon_size = 64
                  }
            },
            ingredients = {
                {type="item", name="weird-alien-gizmo", amount=1}            },
            results = {
                {type="item", name="holmium-ore", amount=1, probability=0.2},
                {type="item", name="battery", amount=1, probability=0.2},
                {type="item", name=mods["ThemTharHillsMk2"] and "gold-wire" or "copper-cable", amount=1, probability=mods["ThemTharHillsMk2"] and 0.8 or 0.7},
                {type="item", name="processing-unit", amount=1, probability=0.1},
                {type="item", name="laser", amount=1, probability=0.1},
                {type="item", name="depleted-uranium-fuel-cell", amount=1, probability=0.01}
            },
            bespoke = "weird-alien-gizmo",
            allow_decomposition = false,
            allow_as_intermediate = false,
            allow_productivity = true,
            energy_required = 2,
            enabled = false
        }
    })
end

data:extend({
    {
        type = "recipe",
        name = "scanner",
        category = mods["space-age"] and "electronics" or "crafting",
        ingredients = {
            {type="item", name="laser", amount=1},
            {type="item", name="advanced-circuit", amount=5},
            {type="item", name="electronic-circuit", amount=5}
        },
        results = {
            {type="item", name="scanner", amount=1}
        },
        energy_required = 5,
        lasermill_dlc = {helium=-1},
        allow_productivity = true,
        enabled = false
    }
})

if mods["IfNickelMk2"] and not mods["space-age"] then
    data:extend({
        {
            type = "recipe",
            name = "micron-tolerance-components",
            category = "irrelevant",
            ingredients = {
                {type="item", name="invar-plate", amount=1}
            },
            results = {
                {type="item", name="micron-tolerance-components", amount=4}
            },
            energy_required = 5,
            lasermill_vanilla = {helium=-2.5, convert=true},
            allow_productivity = true,
            enabled = false
        }
    })
end

if data.raw.item["tracker"] then
    data:extend({
        {
            type = "recipe",
            name = "tracker",
            category = mods["space-age"] and "electronics" or "crafting",
            ingredients = {
                {type="item", name="laser", amount=1},
                {type="item", name="gyro", amount=1},
                {type="item", name="transceiver", amount=1},
                {type="item", name="battery", amount=1}
            },
            results = {
                {type="item", name="tracker", amount=1}
            },
            energy_required = 5,
            lasermill_dlc = {helium=-1},
            enabled = false
        }
    })

    if mods["LunarLandings"] then
        data:extend({
        {
            type = "recipe",
            name = "rocket-control-unit-tracker",
            category = "advanced-circuit-crafting",
            icons = {
            {
                icon = mods["space-age"] and "__pf-sa-compat__/graphics/icons/lunar-navigation-unit.png" or "__LunarLandings__/graphics/icons/rocket-control-unit.png",
                icon_size = 64
            },
            {
                icon = "__LasingAroundMk2__/graphics/icons/tracker.png",
                icon_size = 64,
                scale = 0.25,
                shift = {-8, -8}
            }
            },
            energy_required = 800,
            allow_decomposition = false,
            ingredients = {
                {type="item", name="ll-quantum-processor", amount=1},
                {type="item", name="tracker", amount=20},
                {type="item", name="ll-data-card", amount=1}
            },
            results = {
                {type="item", name=mods["space-age"] and "ll-rocket-control-unit" or "rocket-control-unit", amount=20},
                {type="item", name="ll-junk-data-card", amount=1, ignored_by_productivity=1}
            },
            main_product = mods["space-age"] and "ll-rocket-control-unit" or "rocket-control-unit",
            allow_productivity = true,
            enabled = false
        }
        })
    end
end

if misc.difficulty == 2 then
    return
end

if mods["Paracelsin"] then
    --helium required for normal heat pipe recipe. fine for aquilo but paracelsin has at least the theoretical possibility for self sufficiency
    data:extend({
        {
            type = "recipe",
            name = "heat-pipe-vaterite",
            category = "crafting",
            icons = {
                {
                    icon = "__base__/graphics/icons/heat-pipe.png",
                    icon_size = 64
                },
                {
                    icon = "__Paracelsin-Graphics__/graphics/icons/vaterite-1.png",
                    icon_size = 64,
                    scale = 0.25,
                    shift = {-8, -8}
                }
            },
            ingredients = {
                {type="item", name="copper-plate", amount=30},
                {type="item", name=mods["IfNickelMk2"] and "invar-plate" or "steel-plate", amount=15},
                {type="item", name="vaterite", amount=20}
            },
            results = {
                {type="item", name="heat-pipe", amount=1}
            },
            energy_required = 2,
            auto_recycle = false,
            enabled = false
        }
    })
end

if mods["space-age"] then
    --rm.AddProduct("custom-weird-alien-gizmo-recycling", {type="item", name="tungsten-plate", amount=1, probability=0.01})
    data:extend({
        {
            type = "recipe",
            name = "cardinal-grammeter",
            category = "electronics",
            surface_conditions = {
                {
                    property = "magnetic-field",
                    min = 99
                }
            },
            ingredients = {
                {type="item", name="laser", amount=1},
                {type="item", name="processing-unit", amount=1},
                {type="item", name="holmium-plate", amount=10},
                {type="item", name="iron-gear-wheel", amount=10}
            },
            results = {
                {type="item", name="cardinal-grammeter", amount=1}
            },
            lasermill_dlc = {helium=-1.5}, --prod mods can't be used, so we can extort the player a bit for some extra prod on these.
            energy_required = 3,
            enabled = false
        },
        {
            type = "recipe",
            name = "antiparticle-decelerator",
            category = "crafting-with-fluid",
            surface_conditions = {
                {
                    property = "magnetic-field",
                    min = 99
                }
            },
            ingredients = {
                {type="item", name="electromagnetic-plant", amount=1},
                {type="item", name="supercapacitor", amount=100},
                {type="item", name="laser", amount=100},
                {type="item", name="cardinal-grammeter", amount=50},
                {type="fluid", name="helium", amount=250}
            },
            results = {
                {type="item", name="antiparticle-decelerator", amount=1}
            },
            energy_required = 10,
            enabled = false
        },
        {
            type = "recipe",
            name = "antimatter-power-cell",
            category = "electromagnetics",
            ingredients = {
                {type="item", name="battery", amount=1},
                {type="fluid", name="helium", amount=25}
            },
            results = {
                {type="item", name="antimatter-power-cell", amount=1}
            },
            energy_required = 5,
            enabled = false
        },
        {
            type = "recipe",
            name = "high-density-chaos",
            category = "conceptual-inversion",
            ingredients = {
                {type="item", name="low-density-structure", amount=1}
            },
            results = {
                {type="item", name="high-density-chaos", amount=1}
            },
            energy_required = 2,
            enabled = false
        },
        {
            type = "recipe",
            name = "high-density-chaos-inversion",
            localised_name = {"item-name.low-density-structure"},
            subgroup = "inversion",
            order = "ca",
            category = "conceptual-inversion",
            hide_from_player_crafting = true,
            ingredients = {
                {type="item", name="high-density-chaos", amount=1}
            },
            results = {
                {type="item", name="low-density-structure", amount=1}
            },
            energy_required = 2,
            enabled = false
        },
        {
            type = "recipe",
            name = "random-number-nullifier",
            category = "conceptual-inversion",
            ingredients = {
                {type="item", name="high-density-chaos", amount=1},
                {type="item", name="uranium-235", amount=1},
                {type="item", name="advanced-circuit", amount=1}
            },
            results = {
                {type="item", name="random-number-nullifier", amount=1}
            },
            force_auto_recycle = true,
            energy_required = 20,
            enabled = false
        },
        {
            type = "recipe",
            name = "weighted-blanket",
            category = "conceptual-inversion",
            ingredients = {
                {type="item", name="lightning-rod", amount=1}
            },
            results = {
                {type="item", name="weighted-blanket", amount=1}
            },
            energy_required = 2,
            enabled = false
        },
        {
            type = "recipe",
            name = "weighted-blanket-inversion",
            localised_name = {"entity-name.lightning-rod"},
            subgroup = "inversion",
            order = "ea",
            category = "conceptual-inversion",
            hide_from_player_crafting = true,
            ingredients = {
                {type="item", name="weighted-blanket", amount=1}
            },
            results = {
                {type="item", name="lightning-rod", amount=1}
            },
            energy_required = 2,
            enabled = false
        },
        {
            type = "recipe",
            name = "ordinary-human-brain",
            category = "conceptual-inversion",
            ingredients = {
                {type="item", name="weird-alien-gizmo", amount=1}
            },
            results = {
                {type="item", name="ordinary-human-brain", amount=1}
            },
            energy_required = 2,
            enabled = false
        },
        {
            type = "recipe",
            name = "ordinary-human-brain-inversion",
            localised_name = {"item-name.weird-alien-gizmo"},
            subgroup = "inversion",
            order = "fa",
            category = "conceptual-inversion",
            hide_from_player_crafting = true,
            ingredients = {
                {type="item", name="ordinary-human-brain", amount=1}
            },
            results = {
                {type="item", name="weird-alien-gizmo", amount=1}
            },
            energy_required = 2,
            enabled = false
        },
        {
            type = "recipe",
            name = "ai-girlfriend",
            category = "electromagnetics",
            ingredients = {
                {type="item", name="weighted-blanket", amount=1},
                {type="item", name="flying-robot-frame", amount=1},
                {type="item", name="ordinary-human-brain", amount=1},
                {type="item", name="rocket-control-unit", amount=1}
            },
            results = {
                {type="item", name="ai-girlfriend", amount=1}
            },
            energy_required = 20,
            enabled = false
        },
        {
            type = "recipe",
            name = "dormant-newtronic-chip",
            category = "electromagnetics",
            ingredients = {
                {type="item", name="ai-girlfriend", amount=1},
                {type="item", name="random-number-nullifier", amount=1},
                {type="item", name=mods["IfNickelMk2"] and "perpendicular-processor" or "logic-deregulator", amount=1}
            },
            results = {
                {type="item", name="dormant-newtronic-chip", amount=1},
            },
            energy_required = 20,
            enabled = false
        },
    })

    if mods["IfNickelMk2"] then
        data:extend({
            {
                type = "recipe",
                name = "mutagenic-sludge-obliteration",
                category = "organic",
                icon = "__LasingAroundMk2__/graphics/icons/mutagenic-sludge-obliteration.png",
                icon_size = 64,
                subgroup = "original-dint",
                order = "za", --planning!
                ingredients = {
                    {type="item", name="mutagenic-sludge", amount=1},
                    {type="item", name="weird-alien-gizmo", amount=1, ignored_by_stats=1}
                },
                results = {
                    {type="item", name="weird-alien-gizmo", amount=1, probability=0.8, ignored_by_stats=1}
                },
                show_amount_in_title = false,
                maximum_productivity = 0,
                energy_required = 3,
                enabled = false
            },
            {
                type = "recipe",
                name = "catastrophe-aversion",
                category = "organic",
                icon = "__LasingAroundMk2__/graphics/icons/catastrophe-aversion.png",
                icon_size = 64,
                subgroup = "original-dint",
                order = "zb",
                ingredients = {
                    {type="item", name="bubbling-mutagenic-sludge", amount=1},
                    {type="item", name="weird-alien-gizmo", amount=1}
                },
                results = {
                },
                maximum_productivity = 0,
                energy_required = 5,
                enabled = false
            },
            {
                type = "recipe",
                name = "art-rotators",
                category = "conceptual-inversion",
                ingredients = {
                    {type="item", name="stem-cells", amount=1}
                },
                results = {
                    {type="item", name="art-rotators", amount=1}
                },
                energy_required = 2,
                enabled = false
            },
            {
                type = "recipe",
                name = "art-rotator-inversion",
                localised_name = {"item-name.stem-cells"},
                subgroup = "inversion",
                order = "aa",
                category = "conceptual-inversion",
                hide_from_player_crafting = true,
                ingredients = {
                    {type="item", name="art-rotators", amount=1}
                },
                results = {
                    {type="item", name="stem-cells", amount=1}
                },
                energy_required = 2,
                enabled = false
            },
            {
                type = "recipe",
                name = "perpendicular-processor",
                category = "conceptual-inversion",
                ingredients = {
                    {type="item", name="art-rotators", amount=5},
                    {type="item", name="iron-stick", amount=7},
                    {type="item", name="processing-unit", amount=1}
                },
                results = {
                    {type="item", name="perpendicular-processor", amount=1}
                },
                force_auto_recycle = true,
                energy_required = 20,
                enabled = false
            }
        })
    else
        data:extend({
            {
                type = "recipe",
                name = "pentapod-gatekeeper",
                category = "conceptual-inversion",
                ingredients = {
                    {type="item", name="pentapod-egg", amount=1}
                },
                results = {
                    {type="item", name="pentapod-gatekeeper", amount=1}
                },
                energy_required = 2,
                enabled = false
            },
            {
                type = "recipe",
                name = "pentapod-gatekeeper-inversion",
                localised_name = {"item-name.pentapod-egg"},
                subgroup = "inversion",
                order = "aa",
                hide_from_player_crafting = true,
                category = "conceptual-inversion",
                ingredients = {
                    {type="item", name="pentapod-gatekeeper", amount=1}
                },
                results = {
                    {type="item", name="pentapod-egg", amount=1}
                },
                energy_required = 2,
                enabled = false
            },
            {
                type = "recipe",
                name = "logic-deregulator",
                category = "conceptual-inversion",
                ingredients = {
                    {type="item", name="pentapod-gatekeeper", amount=1},
                    {type="item", name="hazard-concrete", amount=10},
                    {type="item", name="processing-unit", amount=1}
                },
                results = {
                    {type="item", name="logic-deregulator", amount=1}
                },
                force_auto_recycle = true,
                energy_required = 20,
                enabled = false
            }
        })
    end

    if mods["BrassTacksMk2"] then
        data:extend({
            {
                type = "recipe",
                name = "clumsy-piston",
                category = "conceptual-inversion",
                ingredients = {
                    {type="item", name="flywheel", amount=1}
                },
                results = {
                    {type="item", name="clumsy-piston", amount=1}
                },
                energy_required = 2,
                enabled = false
            },
            {
                type = "recipe",
                name = "clumsy-piston-inversion",
                localised_name = {"item-name.flywheel"},
                subgroup = "inversion",
                order = "ga",
                category = "conceptual-inversion",
                hide_from_player_crafting = true,
                ingredients = {
                    {type="item", name="clumsy-piston", amount=1}
                },
                results = {
                    {type="item", name="flywheel", amount=1}
                },
                energy_required = 2,
                enabled = false
            }
        })

        rm.AddIngredient("ai-girlfriend", "clumsy-piston", 2)
    end

    if mods["BrimStuffMk2"] and (mods["BrassTacksMk2"] or mods["IfNickelMk2"]) then
        data:extend({
            {
                type = "recipe",
                name = "robot-estrogen",
                icon = "__LasingAroundMk2__/graphics/icons/robot-estrogen.png",
                icon_size = 64,
                subgroup = "inversion",
                order = "z",
                category = "organic",
                ingredients = {
                    {type="item", name="ai-girlfriend", amount=1}
                },
                results = {
                    {type="item", name="philosophers-hormone", amount=100}
                },
                energy_required = 20,
                preserve_products_in_machine_output = true,
                allow_productivity = true,
                enabled = false
            }
        })
    end
end