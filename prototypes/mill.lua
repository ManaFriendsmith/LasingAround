local util = require("util")
local item_sounds = require("__base__/prototypes/item_sounds")

local lasermill_pipes = assembler2pipepictures()
lasermill_pipes.south =
{
  filename = "__LasingAround__/graphics/entity/laser-mill/lm-pipe.png",
  priority = "extra-high",
  width = 88,
  height = 61,
  shift = util.by_pixel(0, -31.25),
  scale = 0.5
}

local lasermill = {
  type = "assembling-machine",
  name = "laser-mill",
  icon = "__LasingAround__/graphics/icons/laser-mill.png",
  icon_size = 64, icon_mipmaps = 4,
  flags = {"placeable-neutral", "placeable-player", "player-creation"},
  minable = {mining_time = 0.25, result = "laser-mill"},
  max_health = 450,
  collision_box = {{-1.2, -1.2}, {1.2, 1.2}},
  selection_box = {{-1.5, -1.5}, {1.5, 1.5}},
  crafting_categories = {"laser-assembling", "laser-milling", "laser-milling-exclusive"},
  crafting_speed = 2,
  heating_energy = mods["space-age"] and "150kW" or nil,
  energy_source =
  {
    type = "electric",
    usage_priority = "secondary-input",
    emissions_per_minute = {pollution=1}
  },
  energy_usage = mods["space-age"] and "1500kW" or "850kW",
  module_slots = 4,
  effect_receiver = { base_effect = mods["space-age"] and { productivity = 1 } or { productivity = 0.5 }},
  entity_info_icon_shift = {0, 0.5},
  allowed_effects = {"consumption", "speed", "productivity", "pollution", "quality"},
  fluid_boxes = {
    {
      production_type = "input",
      pipe_picture = lasermill_pipes,
      pipe_covers = pipecoverspictures(),
      volume = 100,
      pipe_connections = {{ flow_direction="input", position = {0, -1}, direction = defines.direction.north}},
      secondary_draw_orders = { north = -1, east = -1, west = -1 }
    },
    {
      production_type = "input",
      pipe_picture = lasermill_pipes,
      pipe_covers = pipecoverspictures(),
      volume = 100,
      pipe_connections = {{ flow_direction="input", position = {0, 1}, direction = defines.direction.south }},
      secondary_draw_orders = { north = -1, east = -1, west = -1 }
    },
    {
      production_type = "output",
      pipe_picture = lasermill_pipes,
      pipe_covers = pipecoverspictures(),
      volume = 100,
      pipe_connections = {{ flow_direction="output", position = {1, 0}, direction = defines.direction.east }},
      secondary_draw_orders = { north = -1, east = -1, west = -1 }
    },
    {
      production_type = "output",
      pipe_picture = lasermill_pipes,
      pipe_covers = pipecoverspictures(),
      volume = 100,
      pipe_connections = {{ flow_direction="output", position = {-1, 0}, direction = defines.direction.west }},
      secondary_draw_orders = { north = -1, east = -1, west = -1 }
    }
  },
  corpse = "laser-mill-remnants",
  dying_explosion = "assembling-machine-3-explosion",
  damaged_trigger_effect = data.raw["assembling-machine"]["assembling-machine-3"].damaged_trigger_effect,
  graphics_set = {
    working_visualisations = {{
      animation = {
        layers = {
          {
              filename = "__LasingAround__/graphics/entity/laser-mill/lm-table-hot.png",
              priority = "high",
              width = 192,
              height = 176,
              frame_count = 15,
              line_length = 15,
              scale = 0.5,
              shift = util.by_pixel(0, -28),
              animation_speed = 0.175,
          },
          {
              filename = "__LasingAround__/graphics/entity/laser-mill/lm-beams.png",
              priority = "high",
              draw_as_glow = true,
              width = 192,
              height = 240,
              frame_count = 15,
              line_length = 15,
              scale=0.5,
              shift = util.by_pixel(0, -12),
          },
          {
              filename = "__LasingAround__/graphics/entity/laser-mill/lm-box.png",
              priority = "high",
              width = 192,
              height = 240,
              frame_count = 15,
              line_length = 15,
              scale=0.5,
              shift = util.by_pixel(0, -12),
          },
          {
              filename = "__LasingAround__/graphics/entity/laser-mill/lm-glow.png",
              priority = "high",
              width = 240,
              height = 240,
              frame_count = 15,
              line_length = 15,
              scale=0.5,
              draw_as_light = true,
              shift = util.by_pixel(0, -12),
          }
        }
      }}
    },
    animation = {
      layers = {
        {
          filename = "__LasingAround__/graphics/entity/laser-mill/lm-shadow.png",
          priority = "high",
          width = 320,
          height = 192,
          frame_count = 1,
          line_length = 1,
          scale = 0.5,
          repeat_count = 15,
          shift = util.by_pixel(32, 0),
          animation_speed = 0.175,
          draw_as_shadow = true,
        },
        {
          filename = "__LasingAround__/graphics/entity/laser-mill/lm-table.png",
          priority = "high",
          width = 192,
          height = 240,
          frame_count = 15,
          line_length = 15,
          scale = 0.5,
          shift = util.by_pixel(0, -12),
          animation_speed = 0.175,
        },
        {
          filename = "__LasingAround__/graphics/entity/laser-mill/lm-box.png",
          priority = "high",
          width = 192,
          height = 240,
          frame_count = 15,
          line_length = 15,
          scale = 0.5,
          shift = util.by_pixel(0, -12),
          animation_speed = 0.175,
        }
      }
    },
    frozen_patch = mods["space-age"] and {
        filename = "__LasingAround__/graphics/entity/laser-mill/lm-frozen.png",
        width = 192,
        height = 240,
        shift = util.by_pixel(0, -12),
        scale = 0.5
    } or nil,
    reset_animation_when_frozen = false
  },
  working_sound = {
      sound =
      {
        {
          filename = "__LasingAround__/sound/lasermill.ogg",
          volume = 0.85
        }
      },
      audible_distance_modifier = 1,
      fade_in_ticks = 4,
      fade_out_ticks = 4
  },
  open_sound = util.table.deepcopy(data.raw["assembling-machine"]["assembling-machine-3"].open_sound),
  close_sound = util.table.deepcopy(data.raw["assembling-machine"]["assembling-machine-3"].close_sound),
  vehicle_impact_sound = util.table.deepcopy(data.raw["assembling-machine"]["assembling-machine-3"].vehicle_impact_sound),
  ll_surface_conditions = {nauvis=true, luna={plain=false, lowland=false, mountain=false, foundation=true}}
}

data:extend({
  lasermill,
  {
    type = "item",
    name = "laser-mill",
    icon = "__LasingAround__/graphics/icons/laser-mill.png",
    icon_size = 64,
    icon_mipmaps = 4,
    subgroup = "production-machine",
    place_result = "laser-mill",
    order = "c[laser-mill]",
    inventory_move_sound = item_sounds.mechanical_inventory_move,
    pick_sound = item_sounds.mechanical_inventory_pickup,
    drop_sound = item_sounds.mechanical_inventory_move,
    stack_size = 10,
    weight = 100 * kg
  },
  {
    type = "recipe-category",
    name = "laser-assembling"
  },
  {
    type = "recipe-category",
    name = "laser-milling"
  },
  {
    type = "recipe-category",
    name = "laser-milling-exclusive"
  },
  {
    type = "corpse",
    name = "laser-mill-remnants",
    icon = "__LasingAround__/graphics/icons/laser-mill.png",
    icon_size = 64,
    flags = {"placeable-neutral", "not-on-map"},
    subgroup = "production-machine-remnants",
    order = "c[laser-mill]",
    selection_box = {{-1.5, -1.5}, {1.5, 1.5}},
    tile_width = 3,
    tile_height = 3,
    selectable_in_game = false,
    time_before_removed = 60 * 60 * 15,
    animation = {
        direction_count = 1,
        filename = "__LasingAround__/graphics/entity/laser-mill/lm-remnant.png",
        priority = "high",
        width = 192,
        height = 192,
        frame_count = 1,
        line_length = 1,
        scale = 0.5
    }
  }
})
