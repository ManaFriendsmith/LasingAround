local misc = require("__pf-functions__/misc")
local rm = require("__pf-functions__/recipe-manipulation")
local item_sounds = require("__base__/prototypes/item_sounds")
local space_age_item_sounds = "foo"

data:extend({
    {
        type = "item-subgroup",
        name = "helium",
        group = "intermediate-products",
        order = "a",
    },
    {
      type = "fluid",
      name = "helium",
      icon = "__LasingAroundMk2__/graphics/icons/helium.png",
      icon_size = 64,
      subgroup = "fluid",
      order = "a[fluid]-f",
      default_temperature = 25,
      max_temperature = 25,
      base_color = {r=0.75, g=1, b=0.9, a=1},
      flow_color = {r=1, g=1, b=1, a=1}
    },
    {
      type = "fluid",
      name = "filtered-oil",
      icon = "__base__/graphics/icons/fluid/crude-oil.png",
      icon_size = 64,
      subgroup = "fluid",
      order = "a[fluid]-bc",
      default_temperature = 25,
      max_temperature = 25,
      base_color = data.raw.fluid["crude-oil"].base_color,
      flow_color = data.raw.fluid["crude-oil"].flow_color
    },
    {
        type = "item",
        name = "laser",
        icon = "__LasingAroundMk2__/graphics/icons/laser.png",
        icon_size = 64,
        pictures = {
          layers = {
            {
              size = 64,
              filename = "__LasingAroundMk2__/graphics/icons/laser.png",
              scale = 0.5
            },
            {
              filename = "__LasingAroundMk2__/graphics/icons/laser-glow.png",
              size = 64,
              scale = 0.5,
              draw_as_light = true
            }
          }
        },
        subgroup = "intermediate-product",
        order = "c[advanced-intermediates]-d1",
        inventory_move_sound = item_sounds.rocket_control_inventory_move,
        pick_sound = item_sounds.rocket_control_inventory_pickup,
        drop_sound = item_sounds.rocket_control_inventory_move,
        stack_size = 50,
        default_import_location = "nauvis",
        weight = 2 * kg
    },
    {
        type = "item",
        name = "spectroscope",
        icon = "__LasingAroundMk2__/graphics/icons/spectroscope.png",
        icon_size = 64,
        subgroup = mods["space-age"] and "fulgora-processes" or "intermediate-product",
        order = mods["space-age"] and "b[holmium]-ga" or "c[advanced-intermediates]-d3",
        inventory_move_sound = item_sounds.rocket_control_inventory_move,
        pick_sound = item_sounds.rocket_control_inventory_pickup,
        drop_sound = item_sounds.rocket_control_inventory_move,
        stack_size = 50,
        default_import_location = "nauvis",
        weight = 2 * kg
    }
})

--It's not generally kosher to do this before data-updates but we need to get there before barrel recipes get generated.
data.raw.fluid["crude-oil"].icon = "__LasingAroundMk2__/graphics/icons/crude-oil.png"
data.raw.fluid["crude-oil"].flow_color = {r=0.5, g=0.35, b=0.2}
data.raw.fluid["crude-oil"].base_color = {r=0.25, g=0.15, b=0.0}

if mods["space-age"] then
  space_age_item_sounds = require("__space-age__.prototypes.item_sounds")
end

if misc.difficulty == 1 then
    return
end

data:extend({
    {
        type = "item",
        name = "scanner",
        icon = "__LasingAroundMk2__/graphics/icons/scanner.png",
        icon_size = 64,
        subgroup = "intermediate-product",
        order = "c[advanced-intermediates]-d2",
        inventory_move_sound = item_sounds.rocket_control_inventory_move,
        pick_sound = item_sounds.rocket_control_inventory_pickup,
        drop_sound = item_sounds.rocket_control_inventory_move,
        stack_size = 50,
        default_import_location = "nauvis",
        weight = misc.difficulty == 1 and 2*kg or 4*kg
    }
})

if mods["IfNickelMk2"] and not mods["space-age"] then
  data:extend({
    {
      type = "item",
      name = "micron-tolerance-components",
      icon = "__LasingAroundMk2__/graphics/icons/micron-tolerance-components.png",
      pictures =
      {
        { size = 64, filename = "__LasingAroundMk2__/graphics/icons/micron-tolerance-components-1.png", scale = 0.25},
        { size = 64, filename = "__LasingAroundMk2__/graphics/icons/micron-tolerance-components-2.png", scale = 0.25},
        { size = 64, filename = "__LasingAroundMk2__/graphics/icons/micron-tolerance-components-3.png", scale = 0.25},
        { size = 64, filename = "__LasingAroundMk2__/graphics/icons/micron-tolerance-components-4.png", scale = 0.25}
      },
      icon_size = 64,
      subgroup = "intermediate-product",
      order = "a[basic-intermediates]-e",
      inventory_move_sound = item_sounds.metal_small_inventory_move,
      pick_sound = item_sounds.metal_small_inventory_pickup,
      drop_sound = item_sounds.metal_small_inventory_move,
      stack_size = 100,
      default_import_location = "nauvis",
      weight = 1*kg
    }
  })
end

if data.raw.item["transceiver"] and data.raw.item["gyro"] then
  data:extend({
    {
      type = "item",
      name = "tracker",
      icon = "__LasingAroundMk2__/graphics/icons/tracker.png",
      icon_size = 64,
      pictures = {
        layers = {
          {
            size = 64,
            filename = "__LasingAroundMk2__/graphics/icons/tracker.png",
            scale = 0.5
          },
          {
            filename = "__LasingAroundMk2__/graphics/icons/tracker-glow.png",
            size = 64,
            scale = 0.5,
            draw_as_light = true
          }
        }
      },
      subgroup = "intermediate-product",
      order = "c[advanced-intermediates]-d4",
      inventory_move_sound = item_sounds.rocket_control_inventory_move,
      pick_sound = item_sounds.rocket_control_inventory_pickup,
      drop_sound = item_sounds.rocket_control_inventory_move,
      stack_size = 50,
      default_import_location = "nauvis",
      weight = 5 * kg
  }
  })
end

if mods["space-age"] then
    data:extend({
        {
            type = "item",
            name = "weird-alien-gizmo",
            icon = "__LasingAroundMk2__/graphics/icons/weird-alien-gizmo.png",
            icon_size = 64,
            pictures = {
                layers = {
                  {
                    size = 64,
                    filename = "__LasingAroundMk2__/graphics/icons/weird-alien-gizmo.png",
                    scale = 0.5
                  },
                  {
                    filename = "__LasingAroundMk2__/graphics/icons/weird-alien-gizmo-glow.png",
                    size = 128,
                    scale = 0.5,
                    draw_as_light = true
                  }
                }
              },
            subgroup = "fulgora-processes",
            order = "a[scrap]-b",
            auto_recycle = false,
            inventory_move_sound = item_sounds.rocket_control_inventory_move,
            pick_sound = item_sounds.rocket_control_inventory_pickup,
            drop_sound = item_sounds.rocket_control_inventory_move,
            stack_size = 50,
            default_import_location = "fulgora",
            weight = 5*kg
        }
    })
end

if misc.difficulty == 2 then
    return
end

if mods["space-age"] then
    data:extend({
        {
            type = "item-subgroup",
            name = "inversion",
            group = "intermediate-products",
            order = "l"
        },
        {
            type = "item",
            name = "cardinal-grammeter",
            icon = "__LasingAroundMk2__/graphics/icons/cardinal-grammeter.png",
            icon_size = 64,
            subgroup = "fulgora-processes",
            order = "b[holmium]-g",
            inventory_move_sound = item_sounds.rocket_control_inventory_move,
            pick_sound = item_sounds.rocket_control_inventory_pickup,
            drop_sound = item_sounds.rocket_control_inventory_move,
            stack_size = 50,
            default_import_location = "fulgora",
            weight = 5*kg
        },
        {
          type = "item",
          name = "antimatter-power-cell",
          icon = "__LasingAroundMk2__/graphics/icons/antimatter-power-cell.png",
          icon_size = 64,
          subgroup = "inversion",
          pictures = {
            layers = {
              {
                size = 64,
                filename = "__LasingAroundMk2__/graphics/icons/antimatter-power-cell.png",
                scale = 0.5
              },
              {
                filename = "__LasingAroundMk2__/graphics/icons/antimatter-power-cell-glow.png",
                size = 128,
                scale = 0.5,
                draw_as_light = true
              }
            }
          },
          order = "0",
          inventory_move_sound = item_sounds.atomic_bomb_inventory_move,
          pick_sound = item_sounds.atomic_bomb_inventory_pickup,
          drop_sound = item_sounds.atomic_bomb_inventory_move,
          stack_size = 10,
          default_import_location = "nauvis",
          weight = 10*kg,
          spoil_ticks = 1 * hour,
          spoil_to_trigger_result =
            {
              items_per_trigger = 1,
              trigger = data.raw.projectile["grenade"].action
            },
          fuel_category = "antimatter",
          fuel_value = "500MJ",
          fuel_acceleration_multiplier = 4,
          fuel_top_speed_multiplier = 1.5
        },
        {
          type = "item",
          name = "high-density-chaos",
          icon = "__LasingAroundMk2__/graphics/icons/high-density-chaos.png",
          icon_size = 64,
          subgroup = "inversion",
          order = "c",
          inventory_move_sound = item_sounds.wood_inventory_move,
          pick_sound = item_sounds.wood_inventory_pickup,
          drop_sound = item_sounds.wood_inventory_move,
          stack_size = 50,
          default_import_location = "nauvis",
          weight = 1*kg
        },
        {
          type = "item",
          name = "random-number-nullifier",
          icon = "__LasingAroundMk2__/graphics/icons/random-number-nullifier.png",
          icon_size = 64,
          subgroup = "inversion",
          order = "d",
          inventory_move_sound = item_sounds.mechanical_inventory_move,
          pick_sound = item_sounds.mechanical_inventory_pickup,
          drop_sound = item_sounds.mechanical_inventory_move,
          stack_size = 50,
          default_import_location = "nauvis",
          weight = 5*kg
        },
        {
          type = "item",
          name = "weighted-blanket",
          icon = "__LasingAroundMk2__/graphics/icons/weighted-blanket.png",
          icon_size = 64,
          subgroup = "inversion",
          order = "e",
          inventory_move_sound = item_sounds.plastic_inventory_move,
          pick_sound = item_sounds.plastic_inventory_pickup,
          drop_sound = item_sounds.plastic_inventory_move,
          stack_size = 50,
          default_import_location = "fulgora",
          weight = 5*kg
        },
        {
          type = "item",
          name = "ordinary-human-brain",
          icon = "__LasingAroundMk2__/graphics/icons/ordinary-human-brain.png",
          icon_size = 64,
          subgroup = "inversion",
          order = "f",
          inventory_move_sound = space_age_item_sounds.agriculture_inventory_move,
          pick_sound = space_age_item_sounds.agriculture_inventory_pickup,
          drop_sound = space_age_item_sounds.agriculture_inventory_move,
          stack_size = 50,
          default_import_location = "fulgora",
          weight = 2*kg,
          spoil_ticks = 2 * minute,
          spoil_result = "advanced-circuit"
        },
        {
          type = "item",
          name = "ai-girlfriend",
          icon = "__LasingAroundMk2__/graphics/icons/ai-girlfriend.png",
          icon_size = 64,
          pictures = {
            layers = {
              {
                size = 64,
                filename = "__LasingAroundMk2__/graphics/icons/ai-girlfriend.png",
                scale = 0.5
              },
              {
                filename = "__LasingAroundMk2__/graphics/icons/ai-girlfriend-glow.png",
                size = 64,
                scale = 0.5,
                draw_as_light = true
              }
            }
          },
          subgroup = "inversion",
          order = "h",
          inventory_move_sound = item_sounds.module_inventory_move,
          pick_sound = item_sounds.module_inventory_pickup,
          drop_sound = item_sounds.module_inventory_move,
          stack_size = 50,
          default_import_location = "gleba",
          weight = 5*kg
        },
        {
          type = "item",
          name = "dormant-newtronic-chip",
          icon = "__LasingAroundMk2__/graphics/icons/dormant-newtronic-chip.png",
          icon_size = 64,
          subgroup = "inversion",
          order = "i",
          inventory_move_sound = item_sounds.module_inventory_move,
          pick_sound = item_sounds.module_inventory_pickup,
          drop_sound = item_sounds.module_inventory_move,
          stack_size = 10,
          default_import_location = "nauvis",
          weight = 10*kg,
          spoil_ticks = 4.5 * minute,
          spoil_result = "pulsing-newtronic-chip"
        },
        {
          type = "item",
          name = "pulsing-newtronic-chip",
          icon = "__LasingAroundMk2__/graphics/icons/pulsing-newtronic-chip.png",
          icon_size = 64,
          pictures = {
            layers = {
              {
                size = 64,
                filename = "__LasingAroundMk2__/graphics/icons/pulsing-newtronic-chip.png",
                scale = 0.5
              },
              {
                filename = "__LasingAroundMk2__/graphics/icons/pulsing-newtronic-chip-glow.png",
                size = 64,
                scale = 0.5,
                draw_as_light = true
              }
            }
          },
          subgroup = "inversion",
          order = "i2",
          inventory_move_sound = item_sounds.module_inventory_move,
          pick_sound = item_sounds.module_inventory_pickup,
          drop_sound = item_sounds.module_inventory_move,
          stack_size = 10,
          default_import_location = "nauvis",
          weight = 10*kg,
          spoil_ticks = 0.5 * minute,
          spoil_result = "dormant-newtronic-chip"
        }
    })

    if mods["IfNickelMk2"] then
      data:extend({
        {
          type = "item",
          name = "art-rotators",
          icon = "__LasingAroundMk2__/graphics/icons/art-rotators.png",
          icon_size = 64,
          subgroup = "inversion",
          order = "a",
          inventory_move_sound = space_age_item_sounds.agriculture_inventory_move,
          pick_sound = space_age_item_sounds.agriculture_inventory_pickup,
          drop_sound = space_age_item_sounds.agriculture_inventory_move,
          stack_size = 50,
          default_import_location = "gleba",
          weight = 1*kg
        },
        {
          type = "item",
          name = "perpendicular-processor",
          icon = "__LasingAroundMk2__/graphics/icons/perpendicular-processor.png",
          icon_size = 64,
          pictures = {
            layers = {
              {
                size = 64,
                filename = "__LasingAroundMk2__/graphics/icons/perpendicular-processor.png",
                scale = 0.5
              },
              {
                filename = "__LasingAroundMk2__/graphics/icons/perpendicular-processor-glow.png",
                size = 64,
                scale = 0.5,
                draw_as_light = true
              }
            }
          },
          subgroup = "inversion",
          order = "b",
          inventory_move_sound = item_sounds.electric_small_inventory_move,
          pick_sound = item_sounds.electric_small_inventory_pickup,
          drop_sound = item_sounds.electric_small_inventory_move,
          stack_size = 50,
          default_import_location = "gleba",
          weight = 5*kg
        }
      })
    else
      data:extend({
        {
          type = "item",
          name = "pentapod-gatekeeper",
          icon = "__LasingAroundMk2__/graphics/icons/pentapod-gatekeeper.png",
          icon_size = 64,
          subgroup = "inversion",
          order = "a",
          inventory_move_sound = space_age_item_sounds.agriculture_inventory_move,
          pick_sound = space_age_item_sounds.agriculture_inventory_pickup,
          drop_sound = space_age_item_sounds.agriculture_inventory_move,
          stack_size = 50,
          default_import_location = "gleba",
          weight = 5*kg
        },
        {
          type = "item",
          name = "logic-deregulator",
          icon = "__LasingAroundMk2__/graphics/icons/logic-deregulator.png",
          icon_size = 64,
          subgroup = "inversion",
          order = "b",
          inventory_move_sound = item_sounds.electric_small_inventory_move,
          pick_sound = item_sounds.electric_small_inventory_pickup,
          drop_sound = item_sounds.electric_small_inventory_move,
          stack_size = 50,
          default_import_location = "gleba",
          weight = 5*kg
        }
      })
    end

    if mods["BrassTacksMk2"] then
      data:extend({
        {
          type = "item",
          name = "clumsy-piston",
          icon = "__LasingAroundMk2__/graphics/icons/clumsy-piston.png",
          icon_size = 64,
          subgroup = "inversion",
          order = "g",
          inventory_move_sound = item_sounds.metal_large_inventory_move,
          pick_sound = item_sounds.metal_large_inventory_pickup,
          drop_sound = item_sounds.metal_large_inventory_move,
          stack_size = 50,
          default_import_location = "nauvis",
          weight = 5*kg
        }
      })
    end
end