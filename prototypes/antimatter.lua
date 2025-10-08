local misc = require("__pf-functions__/misc")
local item_sounds = require("__base__/prototypes/item_sounds")

if (misc.difficulty < 3) or not mods["space-age"] then
    return
end

--construct frame sequences for each layer of the animation.
--lower part of the machine has positions 1-8 (1 = due east, increasing counterclockwise, 45 degree interval)
--upper part of the machine has positions 1-5 (1 = leftmost, 5 = rightmost)
--for blasts: row 1 is blue blasts, row 2 is pink blasts, row 3 is a single empty frame. blasts correspond to a position of their respective machine part.
--for orb/main light: frame 1 is blank, frame 2 is blue, frame 3 is pink.
local lower_position = 8
local upper_position = 3

--these are our outputs
local lower_frames = {}
local upper_frames = {}
local lower_blast_frames = {}
local upper_blast_frames = {}
local orb_frames = {}

--represents frames left of blasting
local blasting = 0

--lower part, upper part
local keyframes = {
    {4, 3},
    {1, 1},
    {5, 5},
    {7, 4},
    {2, 1},
    {2, 5},
    {6, 2},
    {1, 1},
    {5, 4},
    {7, 2},
    {8, 3},
}

local next_keyframe = 1
local current_frame_index = 1

--used for machine sound accents. play a sound when blasting begins
local accents = {}

--effectively this block simulates the machine's state as if it was an animated crplcore or something, and records the state of each layer at each step.
--look, do you have a better referent?
--ixe was pretty bad btw. so disappointing. powder sim stuff looked to be the biggest innovation in a while for cellular-automata-as-rts.
--such a shame that aspect of the game was underdeveloped, only interactable with the clunkiest ship, and all the mechanics were streamlined to death.
--everyone saying the problem was it was like cw2 is wrong. cw2 is a great set of mechanics. i will defend cw2 to my grave. also farbor.
--maybe the timer on farbor is a little too tight and i think it's bad that it comes out of nowhere with new unique scripted units.
--also that the level doesn't tell you you can delay the timer with snipers, that's inexcusable.
--but like the conclusion everyone drew from farbor wasn't "this is a difficulty spike that's fine penultimate-level difficulty in a game that didn't ramp up enough before that"
--it was "timed missions are intrinsically illegitimate." which is fucking bonkers!
--the big problem with cw2 is there is a level design pattern that is easy to fall into, the threatless pressurized chamber.
--because LOS is harsher you can't snowball quite as much in cw2 so slog missions are sloggier.
--ixe did fall into this design pattern a lot but it was worsened by the fact you can continuously repair shields and have hard-limited firepower.
--so there's even less threat and you sometimes have to bombard for minutes at a time with no way to accelerate it.
--like sure you can say "get there before the pressure builds up" and this is a valid git gud from the perpective of leaderboard times
--but it doesn't change the fact that your punishment for being late is the game gets drawn out and slow with nothing to do.
--the other problem with ixe is there's no strategy at all. you have the unit limits from particle fleet but not the extremely limited energy budget.
--also your hq has guns and the relative cost of combat units and reactors means it's always max out your reactors first, like, mathematically.
--anyway where was i. right. factorio.
while next_keyframe <= #keyframes do
    if blasting > 0 then
        table.insert(lower_frames, lower_position)
        table.insert(upper_frames, upper_position)

        --blue on even frames, pink on odd frames
        --pink on all frames if the safety setting is on (it's on by default)
        if ((blasting % 2) == 0) and settings.startup["lasingaround-antiparticle-decelerator-flashing"].value then
            table.insert(upper_blast_frames, upper_position)
            table.insert(lower_blast_frames, lower_position)
            table.insert(orb_frames, 2)
        else
            table.insert(upper_blast_frames, upper_position + 5)
            table.insert(lower_blast_frames, lower_position + 8)
            table.insert(orb_frames, 3)
        end
        
        blasting = blasting - 1
        if blasting == 0 then
            next_keyframe = next_keyframe + 1
        end
    else
        local lower_target = keyframes[next_keyframe][1]
        local upper_target = keyframes[next_keyframe][2]

        --only move every other frame. we want the movement of the pointers to have half the apparent frame rate of the blast flashing.
        if (current_frame_index % 2) == 0 then
            --upper part moves linearly.
            if upper_position ~= upper_target then
                if upper_target > upper_position then
                    upper_position = upper_position + 1
                else
                    upper_position = upper_position - 1
                end
            end

            if lower_position ~= lower_target then
                --lower part can loop from 1 <-> 8.
                --lower_target_alt will be lower_target + 8
                --such that lower_target < lower_position < lower_target_alt
                local lower_target_alt = 0
                if lower_position < lower_target then
                    lower_target_alt = lower_target
                    lower_target = lower_target - 8
                else
                    lower_target_alt = lower_target + 8
                end

                --lower_position moves towards the closer lower_target, wrapping if needed.
                if (lower_position - lower_target) > (lower_target_alt - lower_position) then
                    lower_position = lower_position + 1
                    if lower_position == 9 then
                        lower_position = 1
                    end
                else
                    lower_position = lower_position - 1
                    if lower_position == 0 then
                        lower_position = 8
                    end
                end
            end
        else
            --this frame is already locked in as not blasting.
            --don't move and immediately blast on the next frame.
            if (lower_position == lower_target) and (upper_position == upper_target) then
                blasting = 6
                table.insert(accents,
                {
                    sound = {filename = "__LasingAround__/sound/zap.ogg", volume = 0.4},
                    frame = current_frame_index + 1, --the blasting begins next frame
                    audible_distance_modifier = 0.6
                }
            )
            end
        end
        table.insert(lower_frames, lower_position)
        table.insert(upper_frames, upper_position)
        --lights are off
        table.insert(lower_blast_frames, 17)
        table.insert(upper_blast_frames, 11)
        table.insert(orb_frames, 1)
    end
    current_frame_index = current_frame_index + 1
end

local antimatter = {
    type = "assembling-machine",
    name = "antiparticle-decelerator",
    icon = "__LasingAround__/graphics/icons/antiparticle-decelerator.png",
    flags = {"placeable-neutral","placeable-player", "player-creation"},
    minable = {mining_time = 0.2, result = "antiparticle-decelerator"},
    fast_replaceable_group = "antiparticle-decelerator",
    max_health = 300,
    corpse = "electromagnetic-plant-remnants",
    dying_explosion = "electromagnetic-plant-explosion",
    circuit_wire_max_distance = assembling_machine_circuit_wire_max_distance,
    circuit_connector = circuit_connector_definitions.create_vector(
        universal_connector_template,
        {
            { variation = 26, main_offset = util.by_pixel(40, 32), shadow_offset = util.by_pixel(35, 31), show_shadow = true },
            { variation = 26, main_offset = util.by_pixel(40, 32), shadow_offset = util.by_pixel(35, 31), show_shadow = true },
            { variation = 26, main_offset = util.by_pixel(40, 32), shadow_offset = util.by_pixel(35, 31), show_shadow = true },
            { variation = 26, main_offset = util.by_pixel(40, 32), shadow_offset = util.by_pixel(35, 31), show_shadow = true }
        }
    ),
    collision_box = {{-1.2, -1.2}, {1.2, 1.2}},
    selection_box = {{-1.5, -1.5}, {1.5, 1.5}},
    damaged_trigger_effect = data.raw["assembling-machine"]["electromagnetic-plant"].damaged_trigger_effect,
    module_slots = 2,
    allowed_effects = {"consumption", "speed", "productivity", "pollution", "quality"},
    graphics_set = {
      idle_animation = {
        layers = {
            {
                filename = "__LasingAround__/graphics/entity/antiparticle-decelerator/ad-lower.png",
                width = 192,
                height = 192,
                frame_count = 8,
                line_length = 8,
                frame_sequence = lower_frames,
                animation_speed = 0.5,
                max_advance = 1,
                scale = 0.5    
            },
            {
                filename = "__LasingAround__/graphics/entity/antiparticle-decelerator/ad-upper.png",
                width = 192,
                height = 192,
                frame_count = 5,
                line_length = 5,
                frame_sequence = upper_frames,
                animation_speed = 0.5,
                max_advance = 1,
                scale = 0.5    
            },
            {
                filename = "__LasingAround__/graphics/entity/antiparticle-decelerator/ad-shadow.png",
                width = 292,
                height = 192,
                draw_as_shadow = true,
                shift = {25/32, 0},
                frame_count = 1,
                line_length = 1,
                repeat_count = current_frame_index - 1,
                animation_speed = 0.5,
                max_advance = 1,
                scale = 0.5
            }
        }
      },
      animation = {
        layers = {
          {
            filename = "__LasingAround__/graphics/entity/antiparticle-decelerator/ad-lower.png",
            width = 192,
            height = 192,
            frame_count = 8,
            line_length = 8,
            frame_sequence = lower_frames,
            animation_speed = 0.5,
            max_advance = 1,
            scale = 0.5    
          },
          {
            filename = "__LasingAround__/graphics/entity/antiparticle-decelerator/ad-orb.png",
            width = 192,
            height = 192,
            frame_count = 3,
            line_length = 3,
            frame_sequence = orb_frames,
            animation_speed = 0.5,
            draw_as_glow = true,
            max_advance = 1,
            scale = 0.5    
          },
          {
            filename = "__LasingAround__/graphics/entity/antiparticle-decelerator/ad-lower-blast.png",
            width = 192,
            height = 192,
            frame_count = 17,
            line_length = 8,
            frame_sequence = lower_blast_frames,
            animation_speed = 0.5,
            draw_as_glow = true,
            max_advance = 1,
            scale = 0.5    
          },
          {
            filename = "__LasingAround__/graphics/entity/antiparticle-decelerator/ad-upper-blast.png",
            width = 192,
            height = 192,
            frame_count = 11,
            line_length = 5,
            frame_sequence = upper_blast_frames,
            animation_speed = 0.5,
            draw_as_glow = true,
            max_advance = 1,
            scale = 0.5    
          },
          {
            filename = "__LasingAround__/graphics/entity/antiparticle-decelerator/ad-upper.png",
            width = 192,
            height = 192,
            frame_count = 5,
            line_length = 5,
            frame_sequence = upper_frames,
            animation_speed = 0.5,
            max_advance = 1,
            scale = 0.5    
          },
          {
            filename = "__LasingAround__/graphics/entity/antiparticle-decelerator/ad-big-glow.png",
            width = 768,
            height = 768,
            frame_count = 3,
            line_length = 3,
            frame_sequence = orb_frames,
            animation_speed = 0.5,
            draw_as_light = true,
            max_advance = 1,
            scale = 0.5    
          },
          {
            filename = "__LasingAround__/graphics/entity/antiparticle-decelerator/ad-shadow.png",
            width = 292,
            height = 192,
            draw_as_shadow = true,
            shift = {25/32, 0},
            frame_count = 1,
            line_length = 1,
            repeat_count = current_frame_index - 1,
            animation_speed = 0.5,
            max_advance = 1,
            scale = 0.5
          }
        }
      },
      frozen_patch = {
          filename = "__LasingAround__/graphics/entity/antiparticle-decelerator/ad-frozen.png",
          width = 192,
          height = 192,
          scale = 0.5
      },
      reset_animation_when_frozen = true
    },
    impact_category = "metal-large",
    open_sound = {filename = "__base__/sound/open-close/reactor-open.ogg", volume = 0.5},
    close_sound = {filename = "__base__/sound/open-close/reactor-close.ogg", volume = 0.5},
    working_sound = {
      main_sounds = table.deepcopy(data.raw["reactor"]["nuclear-reactor"].working_sound),
      sound_accents = accents,
      max_sounds_per_prototype = 2
    },
    crafting_speed = 1,
    perceived_performance = {
        minimum = 0.5,
        maximum = 5
    },
    heating_energy = "150kW",
    energy_source =
    {
      type = "burner",
      fuel_categories = {"antimatter"},
      fuel_inventory_size = 1
    },
    energy_usage = "2MW",
    crafting_categories = {"conceptual-inversion"},
}

local car2 = table.deepcopy(data.raw.car.car)
car2.name = "reference-car"
car2.minable.result = "reference-car"
car2.animation.layers[2].apply_runtime_tint = false
car2.animation.layers[2].tint = {r=1, g=0.5, b=0.75, a=0.9}
car2.icon = "__LasingAround__/graphics/icons/reference-car.png"
car2.hidden_in_factoriopedia = true

data:extend({
    antimatter,
    car2,
    {
        type = "item",
        name = "antiparticle-decelerator",
        icon = "__LasingAround__/graphics/icons/antiparticle-decelerator.png",
        icon_size = 64,
        icon_mipmaps = 4,
        subgroup = "production-machine",
        place_result = "antiparticle-decelerator",
        order = "ca[antiparticle-decelerator]",
        inventory_move_sound = item_sounds.reactor_inventory_move,
        pick_sound = item_sounds.reactor_inventory_pickup,
        drop_sound = item_sounds.reactor_inventory_move,
        stack_size = 10,
        weight = 200*kg
    },
    {
        type = "item",
        name = "reference-car",
        icon = "__LasingAround__/graphics/icons/reference-car.png",
        icon_size = 64,
        icon_mipmaps = 4,
        subgroup = "inversion",
        place_result = "reference-car",
        order = "z",
        inventory_move_sound = item_sounds.vehicle_inventory_move,
        pick_sound = item_sounds.vehicle_inventory_pickup,
        drop_sound = item_sounds.vehicle_inventory_move,
        stack_size = 1,
        weight = 1000*kg,
        canonical_recipe = false,
        hidden_in_factoriopedia = true
    },
    {
        type = "recipe",
        name = "reference-car",
        localised_name = {"recipe-name.reference-car"},
        category = "conceptual-inversion",
        ingredients = {
            {type="item", name="ai-girlfriend", amount=1}
        },
        results = {
            {type="item", name="reference-car", amount=1}
        },
        energy_required = 110,
        enabled = false,
        hidden_in_factoriopedia = true,
        hide_from_player_crafting = true
    },
    {
        type = "build-entity-achievement",
        name = "the-fast-and-the-yurious",
        order = "g",
        to_build = "reference-car",
        icon = "__LasingAround__/graphics/achievement/the-fast-and-the-yurious.png",
        icon_size = 128
    },
    {
        type = "fuel-category",
        name = "antimatter",
    },
    {
        type = "recipe-category",
        name = "conceptual-inversion",
        can_recycle = false
    },
    {
        type = "sprite",
        name = "tooltip-category-antimatter",
        filename = "__space-age__/graphics/icons/tooltips/tooltip-category-fusion-plasma.png",
        priority = "extra-high-no-scale",
        width = 40,
        height = 40,
        flags = {"gui-icon"},
        mipmap_count = 2,
        scale = 0.5
    }
})