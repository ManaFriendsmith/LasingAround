local misc = require("__pf-functions__/misc")
local tm = require("__pf-functions__/technology-manipulation")

data:extend({
    {
        type = "technology",
        name = "laser-mill",
        icon = "__LasingAround__/graphics/technology/laser-mill.png",
        icon_size = 256,
        effects = {
            {
                type = "unlock-recipe",
                recipe = "laser-mill"
            }
        },
        prerequisites = mods["space-age"] and {"electromagnetic-science-pack", "carbon-fiber", "production-science-pack", "utility-science-pack"} or {"laser"},
        unit = mods["space-age"] and {
            count = 1000,
            time = 60,
            ingredients = {
                {"automation-science-pack", 1},
                {"logistic-science-pack", 1},
                {"chemical-science-pack", 1},
                {"space-science-pack", 1},
                {"production-science-pack", 1},
                {"utility-science-pack", 1},
                {"electromagnetic-science-pack", 1},
                {"agricultural-science-pack", 1}
            }
        } or {
            count = 500,
            time = 30,
            ingredients = {
                {"automation-science-pack", 1},
                {"logistic-science-pack", 1},
                {"chemical-science-pack", 1}
            }
        }
    },
    {
        type = "technology",
        name = "spectroscopy",
        icon = "__LasingAround__/graphics/technology/spectroscopy.png",
        icon_size = 256,
        effects = {
            {
                type = "unlock-recipe",
                recipe = "spectroscope"
            }
        },
        prerequisites = mods["space-age"] and {"electromagnetic-science-pack", "production-science-pack"} or {"production-science-pack", "laser"},
        unit = mods["space-age"] and {
            count = 500,
            time = 60,
            ingredients = {
                {"automation-science-pack", 1},
                {"logistic-science-pack", 1},
                {"chemical-science-pack", 1},
                {"production-science-pack", 1},
                {"space-science-pack", 1},
                {"electromagnetic-science-pack", 1}
            }
        } or {
            count = 200,
            time = 30,
            ingredients = {
                {"automation-science-pack", 1},
                {"logistic-science-pack", 1},
                {"chemical-science-pack", 1},
                {"production-science-pack", 1}
            }
        }
    }
})

if mods["LunarLandings"] then
  data:extend({
    {
          type = "technology",
          name = "polariton-laser",
          icons = {
            {
              icon = "__base__/graphics/technology/laser.png",
              icon_size = 256
            },
            {
              icon = "__LunarLandings__/graphics/icons/polariton/polariton.png",
              icon_size = 64,
              shift = {-64, -64},
              scale = 1
            }
           },
          effects =
          {
            {
              type = "unlock-recipe",
              recipe = "polariton-laser"
            }
          },
          prerequisites = {"ll-quantum-resonation"},
          unit = {
            count = 500,
            ingredients = {
              { "automation-science-pack", 1 },
              { "logistic-science-pack", 1 },
              { "chemical-science-pack", 1 },
              { "production-science-pack", 1 },
              { "utility-science-pack", 1 },
              { "ll-space-science-pack", 1 }
            },
            time = 60,
          }
    }
  })
end

if not mods["space-age"] then
    tm.AddUnlock("spectroscopy", "spectroscopic-oil-filtration")
else
    data:extend({
        {
            type = "technology",
            name = "spectroscopic-petrochemistry",
            icons = {
              {
                icon = "__LasingAround__/graphics/technology/helium-extraction.png",
                icon_size = 256
              },
              {
                icon = "__LasingAround__/graphics/technology/spectroscopy.png",
                icon_size = 256,
                scale = 0.25,
                shift = {-32, -32}
              }
            },
            effects = {
                {
                    type = "unlock-recipe",
                    recipe = "spectroscopic-oil-filtration"
                }
            },
            prerequisites = {"spectroscopy", "coal-liquefaction"},
            unit = {
                count = 1000,
                time = 60,
                ingredients = {
                    {"automation-science-pack", 1},
                    {"logistic-science-pack", 1},
                    {"chemical-science-pack", 1},
                    {"production-science-pack", 1},
                    {"space-science-pack", 1},
                    {"electromagnetic-science-pack", 1},
                    {"metallurgic-science-pack", 1}
                }
            }
        },
        {
            type = "technology",
            name = "spectroscopic-electrochemistry",
            icons = {
              {
                icon = "__space-age__/graphics/technology/holmium-processing.png",
                icon_size = 256
              },
              {
                icon = "__LasingAround__/graphics/technology/spectroscopy.png",
                icon_size = 256,
                scale = 0.25,
                shift = {-32, -32}
              }
            },
            effects = {
                {
                    type = "unlock-recipe",
                    recipe = "spectroscopic-holmium-processing"
                }
            },
            prerequisites = {"spectroscopy"},
            unit = {
                count = 1500,
                time = 60,
                ingredients = {
                    {"automation-science-pack", 1},
                    {"logistic-science-pack", 1},
                    {"chemical-science-pack", 1},
                    {"production-science-pack", 1},
                    {"space-science-pack", 1},
                    {"electromagnetic-science-pack", 1}
                }
            }
        },
        {
            type = "technology",
            name = "spectroscopic-biochemistry",
            icons = {
              {
                icon = "__space-age__/graphics/technology/bioflux.png",
                icon_size = 256
              },
              {
                icon = "__LasingAround__/graphics/technology/spectroscopy.png",
                icon_size = 256,
                scale = 0.25,
                shift = {-32, -32}
              }
            },
            effects = {
                {
                    type = "unlock-recipe",
                    recipe = "spectroscopic-bioflux-processing"
                }
            },
            prerequisites = {"spectroscopy", "agricultural-science-pack"},
            unit = {
                count = 1000,
                time = 60,
                ingredients = {
                    {"automation-science-pack", 1},
                    {"logistic-science-pack", 1},
                    {"chemical-science-pack", 1},
                    {"production-science-pack", 1},
                    {"space-science-pack", 1},
                    {"electromagnetic-science-pack", 1},
                    {"agricultural-science-pack", 1}
                }
            }
        }
    })
end


if data.raw.item["tracker"] then
    data:extend({
        {
            type = "technology",
            name = "tracking-systems",
            icon = "__LasingAround__/graphics/technology/tracking-systems.png",
            icon_size = 256,
            effects = {
                {
                    type = "unlock-recipe",
                    recipe = "tracker"
                }
            },
            prerequisites = mods["space-age"] and {"laser", "electric-engine"} or {"utility-science-pack"},
            unit = {
                count = 50,
                time = 15,
                ingredients = {
                    {"automation-science-pack", 1},
                    {"logistic-science-pack", 1},
                    {"chemical-science-pack", 1}
                }
            }
        }
    })

    if mods["LunarLandings"] then
        data:extend({
        {
                type = "technology",
                name = "advanced-rocket-navigation",
                icons = {
                {
                    icon = mods["space-age"] and "__pf-sa-compat__/graphics/technology/lunar-navigation-unit.png" or "__LunarLandings__/graphics/technology/rocket-control-unit.png",
                    icon_size = 256
                },
                {
                    icon = "__LasingAround__/graphics/icons/tracker.png",
                    icon_size = 64,
                    shift = {-64, -64},
                    scale = 1
                }
                },
                effects =
                {
                {
                    type = "unlock-recipe",
                    recipe = "rocket-control-unit-tracker"
                }
                },
                prerequisites = {"ll-quantum-science-pack"},
                unit = {
                count = 200,
                ingredients = {
                    { "automation-science-pack", 1 },
                    { "logistic-science-pack", 1 },
                    { "chemical-science-pack", 1 },
                    { "production-science-pack", 1 },
                    { "utility-science-pack", 1 },
                    { "ll-space-science-pack", 1 },
                    { "ll-quantum-science-pack", 1 }
                },
                time = 60,
                }
        }
        })
    end

    if not mods["space-age"] then
        tm.AddSciencePack("tracking-systems", "utility-science-pack")
    end
end

if mods["IfNickel"] and not mods["space-age"] then
    data:extend({
        {
            type = "technology",
            name = "micron-tolerance-manufacturing",
            icon = "__LasingAround__/graphics/technology/micron-tolerance-manufacturing.png",
            icon_size = 256,
            effects = {
                {
                    type = "unlock-recipe",
                    recipe = "micron-tolerance-components"
                }
            },
            prerequisites = {"laser-mill"},
            unit = {
                count = 150,
                time = 15,
                ingredients = {
                    {"automation-science-pack", 1},
                    {"logistic-science-pack", 1},
                    {"chemical-science-pack", 1}
                }
            }
        }
    })
end

if data.raw.item["mutagenic-sludge"] and not mods["BrimStuff"] then
    data:extend({
        {
            type = "technology",
            name = "advanced-ethics",
            icon = "__LasingAround__/graphics/technology/advanced-ethics.png",
            icon_size = 256,
            effects = {
                {
                    type = "unlock-recipe",
                    recipe = "mutagenic-sludge-obliteration"
                },
                {
                    type = "unlock-recipe",
                    recipe = "catastrophe-aversion"
                }
            },
            prerequisites = {"tissue-cultivation", "electromagnetic-science-pack", "utility-science-pack"},
            unit = {
                count = 500,
                time = 60,
                ingredients = {
                    {"automation-science-pack", 1},
                    {"logistic-science-pack", 1},
                    {"chemical-science-pack", 1},
                    {"space-science-pack", 1},
                    {"utility-science-pack", 1},
                    {"agricultural-science-pack", 1},
                    {"electromagnetic-science-pack", 1}
                }
            }
        }
    })
end

if mods["space-age"] and misc.difficulty == 3 then
    data:extend({
        {
            type = "technology",
            name = "antiparticle-decelerator",
            icon = "__LasingAround__/graphics/technology/antiparticle-decelerator.png",
            icon_size = 256,
            effects = {
                {
                    type = "unlock-recipe",
                    recipe = "antimatter-power-cell"
                },
                {
                    type = "unlock-recipe",
                    recipe = "antiparticle-decelerator"
                }
            },
            prerequisites = {"electromagnetic-science-pack"},
            unit = {
                count = 500,
                time = 60,
                ingredients = {
                    {"automation-science-pack", 1},
                    {"logistic-science-pack", 1},
                    {"chemical-science-pack", 1},
                    {"space-science-pack", 1},
                    {"electromagnetic-science-pack", 1}
                }
            }
        },
        {
            type = "technology",
            name = "probability-manipulation",
            icon = "__LasingAround__/graphics/technology/probability-manipulation.png",
            icon_size = 256,
            effects = {
                {
                    type = "unlock-recipe",
                    recipe = "high-density-chaos"
                },
                {
                    type = "unlock-recipe",
                    recipe = "high-density-chaos-inversion"
                },
                {
                    type = "unlock-recipe",
                    recipe = "random-number-nullifier"
                }
            },
            prerequisites = {"antiparticle-decelerator", "metallurgic-science-pack"},
            unit = {
                count = 1000,
                time = 60,
                ingredients = {
                    {"automation-science-pack", 1},
                    {"logistic-science-pack", 1},
                    {"chemical-science-pack", 1},
                    {"space-science-pack", 1},
                    {"electromagnetic-science-pack", 1},
                    {"metallurgic-science-pack", 1}
                }
            }
        },
        {
            type = "technology",
            name = mods["IfNickel"] and "geometry-abolition" or "laissez-faire-mathematics",
            icon = mods["IfNickel"] and "__LasingAround__/graphics/technology/geometry-abolition.png" or "__LasingAround__/graphics/technology/laissez-faire-mathematics.png",
            icon_size = 256,
            effects = {
                {
                    type = "unlock-recipe",
                    recipe = mods["IfNickel"] and "art-rotators" or "pentapod-gatekeeper"
                },
                {
                    type = "unlock-recipe",
                    recipe = mods["IfNickel"] and "art-rotator-inversion" or "pentapod-gatekeeper-inversion"
                },
                {
                    type = "unlock-recipe",
                    recipe = mods["IfNickel"] and "perpendicular-processor" or "logic-deregulator"
                }
            },
            prerequisites = {"antiparticle-decelerator", "agricultural-science-pack"},
            unit = {
                count = 1000,
                time = 60,
                ingredients = {
                    {"automation-science-pack", 1},
                    {"logistic-science-pack", 1},
                    {"chemical-science-pack", 1},
                    {"space-science-pack", 1},
                    {"electromagnetic-science-pack", 1},
                    {"agricultural-science-pack", 1}
                }
            }
        },
        {
            type = "technology",
            name = "waifugenesis",
            icon = "__LasingAround__/graphics/technology/waifugenesis.png",
            icon_size = 256,
            effects = {
                {
                    type = "unlock-recipe",
                    recipe = "weighted-blanket"
                },
                {
                    type = "unlock-recipe",
                    recipe = "weighted-blanket-inversion"
                },
                {
                    type = "unlock-recipe",
                    recipe = "ordinary-human-brain"
                },
                {
                    type = "unlock-recipe",
                    recipe = "ordinary-human-brain-inversion"
                },
                {
                    type = "unlock-recipe",
                    recipe = "ai-girlfriend"
                }
            },
            prerequisites = {"antiparticle-decelerator"},
            unit = {
                count = 1500,
                time = 60,
                ingredients = {
                    {"automation-science-pack", 1},
                    {"logistic-science-pack", 1},
                    {"chemical-science-pack", 1},
                    {"space-science-pack", 1},
                    {"electromagnetic-science-pack", 1}
                }
            }
        },
        {
            type = "technology",
            name = "lasingaround-easter-egg",
            icon = "__base__/graphics/technology/automobilism.png",
            icon_size = 256,
            effects = {
                {
                    type = "unlock-recipe",
                    recipe = "reference-car"
                }
            },
            hidden = true,
            hidden_in_factoriopedia = true,
            prerequisites = {"promethium-science-pack"},
            unit = {
                count = 420,
                time = 69,
                ingredients = {
                    {"promethium-science-pack", 1},
                }
            }
        }
    })

    if mods["BrassTacks"] then
        tm.AddUnlock("waifugenesis", "clumsy-piston", "-ai-girlfriend")
        tm.AddUnlock("waifugenesis", "clumsy-piston-inversion", "-ai-girlfriend")
    end

    if mods["BrimStuff"] and (mods["BrassTacks"] or mods["IfNickel"]) then
        data:extend({
            {
                type = "technology",
                name = "robot-estrogen",
                icon = "__LasingAround__/graphics/technology/robot-estrogen.png",
                icon_size = 256,
                effects = {
                    {
                        type = "unlock-recipe",
                        recipe = "robot-estrogen"
                    }
                },
                prerequisites = {"promethium-science-pack"},
                unit = {
                    count = 20000,
                    time = 60,
                    ingredients = {
                        {"automation-science-pack", 1},
                        {"logistic-science-pack", 1},
                        {"military-science-pack", 1},
                        {"chemical-science-pack", 1},
                        {"production-science-pack", 1},
                        {"utility-science-pack", 1},
                        {"space-science-pack", 1},
                        {"metallurgic-science-pack", 1},
                        {"electromagnetic-science-pack", 1},
                        {"agricultural-science-pack", 1},
                        {"cryogenic-science-pack", 1},
                        {"promethium-science-pack", 1}
                    }
                }
            }
        })
    end
end

if mods["space-age"] and misc.starting_planet ~= "vulcanus" then
    data:extend({
        {
            type = "technology",
            name = "lava-containment",
            icons = {
                {
                    icon = "__base__/graphics/technology/laser.png",
                    icon_size = 256,
                    icon_mipmaps = 4
                },
                {
                    icon = "__space-age__/graphics/icons/fluid/lava.png",
                    icon_size = 64,
                    icon_mipmaps = 4,
                    scale = 0.5,
                    shift = {32, 32}
                }
            },
            effects = {
                {
                    type = "unlock-recipe",
                    recipe = "lavaser"
                }
            },
            prerequisites = {"promethium-science-pack"},
            unit = {
                count = 20000,
                time = 60,
                ingredients = {
                    {"automation-science-pack", 1},
                    {"logistic-science-pack", 1},
                    {"military-science-pack", 1},
                    {"chemical-science-pack", 1},
                    {"production-science-pack", 1},
                    {"utility-science-pack", 1},
                    {"space-science-pack", 1},
                    {"metallurgic-science-pack", 1},
                    {"electromagnetic-science-pack", 1},
                    {"agricultural-science-pack", 1},
                    {"cryogenic-science-pack", 1},
                    {"promethium-science-pack", 1}
                }
            }
        }
    })
end

if mods["space-age"] and misc.starting_planet ~= "fulgora" then
    data:extend({
        {
            type = "technology",
            name = "holmium-excitation",
            icons = {
                {
                    icon = "__base__/graphics/technology/laser.png",
                    icon_size = 256,
                    icon_mipmaps = 4
                },
                {
                    icon = "__space-age__/graphics/icons/supercapacitor.png",
                    icon_size = 64,
                    icon_mipmaps = 4,
                    scale = 0.5,
                    shift = {32, 32}
                }
            },
            effects = {
                {
                    type = "unlock-recipe",
                    recipe = "electrolaser"
                }
            },
            prerequisites = {"promethium-science-pack"},
            unit = {
                count = 20000,
                time = 60,
                ingredients = {
                    {"automation-science-pack", 1},
                    {"logistic-science-pack", 1},
                    {"military-science-pack", 1},
                    {"chemical-science-pack", 1},
                    {"production-science-pack", 1},
                    {"utility-science-pack", 1},
                    {"space-science-pack", 1},
                    {"metallurgic-science-pack", 1},
                    {"electromagnetic-science-pack", 1},
                    {"agricultural-science-pack", 1},
                    {"cryogenic-science-pack", 1},
                    {"promethium-science-pack", 1}
                }
            }
        }
    })
end

if mods["space-age"] and misc.starting_planet ~= "gleba" then
    data:extend({
        {
            type = "technology",
            name = "controlled-bioluminescence",
            icons = {
                {
                    icon = "__base__/graphics/technology/laser.png",
                    icon_size = 256,
                    icon_mipmaps = 4
                },
                {
                    icon = "__space-age__/graphics/icons/bioflux.png",
                    icon_size = 64,
                    icon_mipmaps = 4,
                    scale = 0.5,
                    shift = {32, 32}
                }
            },
            effects = {
                {
                    type = "unlock-recipe",
                    recipe = "bioluminaser"
                }
            },
            prerequisites = {"promethium-science-pack"},
            unit = {
                count = 20000,
                time = 60,
                ingredients = {
                    {"automation-science-pack", 1},
                    {"logistic-science-pack", 1},
                    {"military-science-pack", 1},
                    {"chemical-science-pack", 1},
                    {"production-science-pack", 1},
                    {"utility-science-pack", 1},
                    {"space-science-pack", 1},
                    {"metallurgic-science-pack", 1},
                    {"electromagnetic-science-pack", 1},
                    {"agricultural-science-pack", 1},
                    {"cryogenic-science-pack", 1},
                    {"promethium-science-pack", 1}
                }
            }
        }
    })
end

if mods["Paracelsin"] and misc.starting_planet ~= "paracelsin" then
    data:extend({
        {
            type = "technology",
            name = "a-world-with-substantially-less-zinc",
            icons = {
                {
                    icon = "__base__/graphics/technology/laser.png",
                    icon_size = 256,
                    icon_mipmaps = 4
                },
                {
                    icon = "__Paracelsin-Graphics__/graphics/icons/zinc-plate.png",
                    icon_size = 64,
                    icon_mipmaps = 4,
                    scale = 0.5,
                    shift = {32, 32}
                }
            },
            effects = {
                {
                    type = "unlock-recipe",
                    recipe = "galvaser"
                }
            },
            prerequisites = {"promethium-science-pack"},
            unit = {
                count = 20000,
                time = 60,
                ingredients = {
                    {"automation-science-pack", 1},
                    {"logistic-science-pack", 1},
                    {"military-science-pack", 1},
                    {"chemical-science-pack", 1},
                    {"production-science-pack", 1},
                    {"utility-science-pack", 1},
                    {"space-science-pack", 1},
                    {"metallurgic-science-pack", 1},
                    {"electromagnetic-science-pack", 1},
                    {"agricultural-science-pack", 1},
                    {"cryogenic-science-pack", 1},
                    {"promethium-science-pack", 1}
                }
            }
        }
    })
end

if mods["maraxsis"] and misc.starting_planet ~= "maraxsis" then
    data:extend({
        {
            type = "technology",
            name = "coherent-salt-lamps",
            icons = {
                {
                    icon = "__base__/graphics/technology/laser.png",
                    icon_size = 256,
                    icon_mipmaps = 4
                },
                {
                    icon = "__maraxsis__/graphics/icons/salt-1.png",
                    icon_size = 64,
                    icon_mipmaps = 4,
                    scale = 0.5,
                    shift = {32, 32}
                }
            },
            effects = {
                {
                    type = "unlock-recipe",
                    recipe = "halaser"
                }
            },
            prerequisites = {"promethium-science-pack"},
            unit = {
                count = 20000,
                time = 60,
                ingredients = {
                    {"automation-science-pack", 1},
                    {"logistic-science-pack", 1},
                    {"military-science-pack", 1},
                    {"chemical-science-pack", 1},
                    {"production-science-pack", 1},
                    {"utility-science-pack", 1},
                    {"space-science-pack", 1},
                    {"metallurgic-science-pack", 1},
                    {"electromagnetic-science-pack", 1},
                    {"agricultural-science-pack", 1},
                    {"cryogenic-science-pack", 1},
                    {"promethium-science-pack", 1}
                }
            }
        }
    })
end

if mods["castra"] and misc.starting_planet ~= "castra" then
    data:extend({
        {
            type = "technology",
            name = "propaganda",
            icons = {
                {
                    icon = "__base__/graphics/technology/laser.png",
                    icon_size = 256,
                    icon_mipmaps = 4
                },
                {
                    icon = "__castra__/graphics/icons/castra-data.png",
                    icon_size = 64,
                    icon_mipmaps = 4,
                    scale = 0.5,
                    shift = {32, 32}
                }
            },
            effects = {
                {
                    type = "unlock-recipe",
                    recipe = "milaser"
                }
            },
            prerequisites = {"promethium-science-pack"},
            unit = {
                count = 20000,
                time = 60,
                ingredients = {
                    {"automation-science-pack", 1},
                    {"logistic-science-pack", 1},
                    {"military-science-pack", 1},
                    {"chemical-science-pack", 1},
                    {"production-science-pack", 1},
                    {"utility-science-pack", 1},
                    {"space-science-pack", 1},
                    {"metallurgic-science-pack", 1},
                    {"electromagnetic-science-pack", 1},
                    {"agricultural-science-pack", 1},
                    {"cryogenic-science-pack", 1},
                    {"promethium-science-pack", 1}
                }
            }
        }
    })
end

if mods["castra"] then
    data:extend({
        {
            type = "technology",
            name = "hydrogen-sulfide-spectroscopy",
            icons = {
                {
                    icon = "__castra__/graphics/technology/hydrogen-sulfide-vent.png",
                    icon_size = 256
                },
                {
                    icon = "__LasingAround__/graphics/technology/spectroscopy.png",
                    icon_size = 256,
                    scale = 0.25,
                    shift = {-32, -32}
                }
            },
            effects = {
                {
                    type = "unlock-recipe",
                    recipe = "spectroscopic-hydrogen-sulfide-electrolysis"
                }
            },
            prerequisites = {"battlefield-science-pack", "spectroscopic-petrochemistry"},
            unit = {
                count = 2000,
                time = 60,
                ingredients = {
                    {"automation-science-pack", 1},
                    {"logistic-science-pack", 1},
                    {"military-science-pack", 1},
                    {"chemical-science-pack", 1},
                    {"production-science-pack", 1},
                    {"utility-science-pack", 1},
                    {"space-science-pack", 1},
                    {"metallurgic-science-pack", 1},
                    {"electromagnetic-science-pack", 1},
                    {"battlefield-science-pack", 1}
                }
            }
        }
    })
end