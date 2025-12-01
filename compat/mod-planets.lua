local rm = require("__pf-functions__/recipe-manipulation")
local tm = require("__pf-functions__/technology-manipulation")
local misc = require("__pf-functions__/misc")

local function SetItemCost(item, cost)
    local prot = misc.GetPrototype(item)
    if prot then
        prot.canonical_cost = cost
    else
        prot = misc.GetPrototype(item, "fluid")
        if prot then
            prot.canonical_cost = cost
        end
    end
end

if mods["LunarLandings"] then
    tm.AddPrerequisite("laser", "ll-moon-rock-processing")
    tm.AddPrerequisite("laser", "ll-luna-automation")
    rm.AddIngredient("laser", "ll-silica", 5)
    rm.RemoveRecipeCategory("laser", "electronics")
    rm.RemoveRecipeCategory("laser", "crafting-with-fluid")
    rm.AddRecipeCategory("laser", "advanced-circuit-crafting")
    if mods["space-age"] then
        rm.AddRecipeCategory("laser", "electromagnetics")
    end

    rm.AddRecipeCategory("spectroscope", "circuit-crafting")
    rm.AddRecipeCategory("tracker", "circuit-crafting")
    if misc.difficulty == 3 then
        rm.RemoveRecipeCategory("scanner", "electronics")
        rm.RemoveRecipeCategory("scanner", "crafting")
        rm.AddRecipeCategory("scanner", "advanced-circuit-crafting")
    else
        rm.AddRecipeCategory("scanner", "circuit-crafting")
    end

    tm.AddUnlock("ll-moon-rock-processing", "ll-oxygen-extraction", "ll-helium-extraction")

    SetItemCost("ll-astroflux", 0.5)
    SetItemCost("ll-oxygen", 0)
    SetItemCost("ll-silica", 1)
    SetItemCost("ll-silicon", 0.75)
    SetItemCost("ll-aluminium-ore", 2)
    SetItemCost("ll-alumina", 3)
    SetItemCost("ll-aluminium-plate", 3)

    --not sure if LL/SA compat is ever actually coming
    if not mods["space-age"] then
        --laser mill is locked behind fulgora + gleba
        tm.AddPrerequisite("laser-mill", "ll-space-science-pack")
        tm.AddPrerequisite("laser-mill", "production-science-pack")
        tm.AddSciencePack("laser-mill", "ll-space-science-pack")
        tm.AddSciencePack("laser-mill", "production-science-pack")

        tm.AddPrerequisite("ll-low-density-structure-aluminium", "laser-mill")
        tm.RemovePrerequisite("ll-low-density-structure-aluminium", "ll-space-science-pack")

        rm.ReplaceIngredientProportional("laser-mill", "advanced-circuit", "processing-unit")
        rm.ReplaceIngredientProportional("laser-mill", "assembling-machine-2", "ll-low-grav-assembling-machine")

        --space age already makes these changes
        data.raw.item["helium-barrel"].weight = 5 * kg
        rm.AddIngredient("helium-barrel", "helium", 450)
        rm.AddProduct("empty-helium-barrel", "helium", 450)

        --spectroscopy is locked behind fulgora
        tm.AddPrerequisite("ll-space-data-collection", "spectroscopy")
        tm.RemoveSciencePack("spectroscopy", "production-science-pack")
        tm.RemovePrerequisite("spectroscopy", "production-science-pack")
        rm.AddIngredient("ll-telescope", "spectroscope", 10)
    else
        tm.AddPrerequisite("ll-quantum-data-collection", "spectroscopy")
        tm.AddSciencePack("ll-quantum-data-collection", "electromagnetic-science-pack")
        tm.AddSciencePack("ll-quantum-science-pack", "electromagnetic-science-pack")
        tm.AddSciencePack("advanced-rocket-navigation", "electromagnetic-science-pack")
    end
    rm.AddIngredient("ll-quantum-data-card", "spectroscope")
    rm.AddLaserMillData("ll-low-density-structure-aluminium", {helium=-1, convert=not mods["space-age"], unlock="ll-low-density-structure-aluminium", icon_offset={8, -8}}, {helium=-1, unlock="ll-low-density-structure-aluminium", icon_offset={8, -8}})
    rm.AddLaserMillData("ll-heat-shielding", {helium=-1}, {helium=-1})
    rm.AddLaserMillData("ll-rocket-control-unit", false, {helium=-1})
    rm.AddIngredient("ll-quantum-resonator", "laser", 10)

    if misc.difficulty == 3 or (misc.difficulty == 2 and not mods["space-age"]) then
        rm.AddIngredient("ll-superposition-right-left", {type="item", name="laser", amount=1, ignored_by_stats=1})
        rm.AddIngredient("ll-superposition-up-down", {type="item", name="laser", amount=1, ignored_by_stats=1})
        rm.AddProduct("ll-superposition-right-left", {type="item", name="laser", amount=1, probability=0.85, ignored_by_stats=1})
        rm.AddProduct("ll-superposition-up-down", {type="item", name="laser", amount=1, probability=0.85, ignored_by_stats=1})
    end

    if data.raw.item["tracker"] then
        tm.RemoveSciencePack("tracking-systems", "utility-science-pack")
        tm.RemovePrerequisite("tracking-systems", "utility-science-pack")
        tm.AddPrerequisite("tracking-systems", "laser")
        tm.AddPrerequisite("ll-space-data-collection", "tracking-systems")
        if not data.raw.item["skyseeker-armature"] then
            rm.AddIngredient("ll-telescope", "tracker", 10)
            rm.AddIngredient("ll-mass-driver", "tracker", 20)
            rm.AddIngredient("ll-mass-driver-capsule", "tracker", 1)
        end

        rm.AddIngredient("ll-ion-roboport", "tracker", 30)
        tm.AddPrerequisite("ll-ion-robotics", "tracking-systems")
    end

    if data.raw.item["micron-tolerance-components"] then
        tm.AddSciencePack("micron-tolerance-manufacturing", "production-science-pack")

        local function make_mt_recipe(recipe)
            if data.raw.recipe[recipe] then
                local new_recipe = table.deepcopy(data.raw.recipe[recipe])
                new_recipe.name = recipe .. "-micron-tolerance"
                new_recipe.localised_name = {"recipe-name.micron-tolerance-recipe", {"item-name." .. recipe}}
                if not new_recipe.icons then
                    if new_recipe.icon then
                        new_recipe.icons = {{
                            icon=new_recipe.icon,
                            icon_size=new_recipe.icon_size,
                            icon_mipmaps=new_recipe.icon_mipmaps
                        }}
                        new_recipe.icon = nil
                    else
                        if data.raw.item[recipe].icons then
                            new_recipe.icons = table.deepcopy(data.raw.item[recipe].icons)
                        else
                            local source_item = data.raw.item[recipe]
                            new_recipe.icons = {{
                                icon=source_item.icon,
                                icon_size=source_item.icon_size,
                                icon_mipmaps=source_item.icon_mipmaps
                            }}
                        end
                    end
                end
                table.insert(new_recipe.icons, {
                    icon = "__LasingAroundMk2__/graphics/icons/micron-tolerance-components.png",
                    icon_size = 64,
                    scale = 0.25,
                    shift = {-8, -8}
                })
                data:extend({new_recipe})
                tm.AddUnlock("micron-tolerance-manufacturing", new_recipe.name)
            end
        end

        data.raw.technology["micron-tolerance-manufacturing"].unit.count = 1000
        
        make_mt_recipe("high-pressure-valve")
        rm.ReplaceIngredientProportional("high-pressure-valve-micron-tolerance", "invar-plate", "micron-tolerance-components", 3)

        make_mt_recipe("complex-joint")
        rm.MultiplyRecipe("complex-joint-micron-tolerance", {input=2, output=3, time=3})
        rm.ReplaceIngredientProportional("complex-joint-micron-tolerance", "linkages", "micron-tolerance-components", 3, 8)

        make_mt_recipe("gyro")
        rm.MultiplyRecipe("gyro-micron-tolerance", {input=2, output=3, time=3})
        rm.ReplaceIngredientProportional("gyro-micron-tolerance", "bearing", "micron-tolerance-components", 6, 1)

        make_mt_recipe("motorized-arm")
        rm.MultiplyRecipe("motorized-arm-micron-tolerance", {input=2, output=3, time=3})
        if rm.GetIngredientCount("motorized-arm", "electronic-circuit") > 0 then
            rm.ReplaceIngredientProportional("motorized-arm-micron-tolerance", "electronic-circuit", "micron-tolerance-components", 6, 1)
        else
            rm.ReplaceIngredientProportional("motorized-arm-micron-tolerance", "linkages", "micron-tolerance-components", 5, 2)
            rm.ReplaceIngredientProportional("motorized-arm-micron-tolerance", "iron-stick", "micron-tolerance-components", 1, 6)
        end

        make_mt_recipe("express-gearbox")
        rm.MultiplyRecipe("express-gearbox-micron-tolerance", {input=2, output=3, time=3})
        rm.ReplaceIngredientProportional("express-gearbox-micron-tolerance", "iron-gear-wheel", "micron-tolerance-components", 3, 5)

        make_mt_recipe("stepper-motor")
        rm.MultiplyRecipe("stepper-motor-micron-tolerance", {input=2, output=3, time=3})
        rm.ReplaceIngredientProportional("stepper-motor-micron-tolerance", "iron-gear-wheel", "micron-tolerance-components", 5, 1)

        make_mt_recipe("drive-belt")
        rm.MultiplyRecipe("drive-belt-micron-tolerance", {input=2, output=3, time=3})
        rm.ReplaceIngredientProportional("drive-belt-micron-tolerance", "spring", "micron-tolerance-components", 3, 1)
        rm.ReplaceIngredientProportional("drive-belt-micron-tolerance", "iron-stick", "micron-tolerance-components", 3, 1)

        make_mt_recipe("gimbaled-rocket-engine")
        rm.MultiplyRecipe("gimbaled-rocket-engine-micron-tolerance", {input=3, output=4, time=4})
        rm.ReplaceIngredientProportional("gimbaled-rocket-engine-micron-tolerance", "invar-plate", "micron-tolerance-components", 6)
        rm.AddIngredient("gimbaled-rocket-engine-micron-tolerance", "ll-heat-shielding")

        make_mt_recipe("skyseeker-armature")
        rm.MultiplyRecipe("skyseeker-armature-micron-tolerance", {input=3, output=4, time=4})
        rm.ReplaceIngredientProportional("skyseeker-armature-micron-tolerance", "bearing", "micron-tolerance-components", 12, 6)
    end

    if data.raw.item["dormant-newtronic-chip"] then
        rm.AddIngredient("dormant-newtronic-chip", "ll-quantum-data-card")
        rm.AddIngredient("dormant-newtronic-chip", "ll-quantum-processor")
        rm.RemoveIngredient("quantum-processor", "ll-quantum-processor")

        rm.AddIngredient("antiparticle-decelerator", "ll-quantum-processor", 50)
        rm.ReplaceIngredientProportional("perpendicular-processor", "processing-unit", "ll-quantum-processor")
        rm.ReplaceIngredientProportional("logic-deregulator", "processing-unit", "ll-quantum-processor")
        rm.AddIngredient("ai-girlfriend", "ll-junk-data-card")
        rm.AddIngredient("random-number-nullifier", "ll-aluminium-plate", 5)

        tm.AddPrerequisite("antiparticle-decelerator", "ll-quantum-computing")

        tm.AddSciencePack("antiparticle-decelerator", "ll-space-science-pack")
        tm.AddSciencePack("laissez-faire-mathematics", "ll-space-science-pack")
        tm.AddSciencePack("geometry-abolition", "ll-space-science-pack")
        tm.AddSciencePack("waifugenesis", "ll-space-science-pack")
        tm.AddSciencePack("probability-manipulation", "ll-space-science-pack")
    end

    if mods["space-age"] then
        if data.raw.item["tracker"] then
            data.raw.recipe["rocket-control-unit-tracker"].localised_name = {"recipe-name.ll-rocket-control-unit-tracker"}
        end
        rm.AddLaserMillData("ll-processing-unit-without-silicon", false, {helium=-1})
        data.raw.item["processing-unit"].cost_canonical_recipe = "ll-processing-unit-without-silicon"
        data.raw.recipe["processing-unit"].surface_conditions = {
            {
                property = "ll-radiation",
                min = 10
            }
        }

        tm.AddSciencePack("robot-estrogen", "ll-space-science-pack")
        tm.AddSciencePack("a-world-with-substantially-less-zinc", "ll-space-science-pack")
        tm.AddSciencePack("lava-containment", "ll-space-science-pack")
        tm.AddSciencePack("holmium-excitation", "ll-space-science-pack")
        tm.AddSciencePack("controlled-bioluminescence", "ll-space-science-pack")
        tm.AddSciencePack("propaganda", "ll-space-science-pack")
        tm.AddSciencePack("coherent-salt-lamps", "ll-space-science-pack")

        tm.AddSciencePack("robot-estrogen", "ll-quantum-science-pack")
        tm.AddSciencePack("a-world-with-substantially-less-zinc", "ll-quantum-science-pack")
        tm.AddSciencePack("lava-containment", "ll-quantum-science-pack")
        tm.AddSciencePack("holmium-excitation", "ll-quantum-science-pack")
        tm.AddSciencePack("controlled-bioluminescence", "ll-quantum-science-pack")
        tm.AddSciencePack("propaganda", "ll-quantum-science-pack")
        tm.AddSciencePack("coherent-salt-lamps", "ll-quantum-science-pack")

    end
end

if mods["maraxsis"] then
    tm.AddSciencePack("robot-estrogen", "hydraulic-science-pack")
    tm.AddSciencePack("a-world-with-substantially-less-zinc", "hydraulic-science-pack")
    tm.AddSciencePack("lava-containment", "hydraulic-science-pack")
    tm.AddSciencePack("holmium-excitation", "hydraulic-science-pack")
    tm.AddSciencePack("controlled-bioluminescence", "hydraulic-science-pack")
    tm.AddSciencePack("propaganda", "hydraulic-science-pack")
    tm.AddSciencePack("coherent-salt-lamps", "hydraulic-science-pack")

    if misc.difficulty == 3 then
        rm.AddIngredient("maraxsis-conduit", "cardinal-grammeter", 10)
        rm.AddIngredient("maraxsis-sonar", "cardinal-grammeter", 10)
    end
end

if mods["Paracelsin"] then
    if mods["BrassTacksMk2"] then
        data.raw.technology["a-world-with-substantially-less-zinc"].localised_name = {"technology-name.glacite-resonance"}
        data.raw.recipe["galvaser"].localised_name = {"recipe-name.glaser"}
        SetItemCost("pcl-zinc-plate", 2)
    else
        SetItemCost("zinc-plate", 2)
    end

    rm.AddLaserMillData("zinc-solder", false, {helium=-1, unlock="zinc-extraction"})
    rm.AddLaserMillData("zinc-rivets", false, {helium=-1, unlock="zinc-extraction"})
    rm.AddLaserMillData("electric-coil", false, {helium=-1, unlock="mechanical-plant"})
    rm.AddLaserMillData("paracelsin-processing-units-from-nitric-acid", false, {helium=-1, unlock="electrochemical-plant", icon_offset={8, -8}})
    rm.AddLaserMillData("batteries-from-nitric-acid", false, {helium=-1, unlock="mechanical-plant", icon_offset={8, -8}})

    tm.AddSciencePack("robot-estrogen", "galvanization-science-pack")
    tm.AddSciencePack("a-world-with-substantially-less-zinc", "galvanization-science-pack")
    tm.AddSciencePack("lava-containment", "galvanization-science-pack")
    tm.AddSciencePack("holmium-excitation", "galvanization-science-pack")
    tm.AddSciencePack("controlled-bioluminescence", "galvanization-science-pack")
    tm.AddSciencePack("propaganda", "galvanization-science-pack")
    tm.AddSciencePack("coherent-salt-lamps", "galvanization-science-pack")

    if misc.difficulty == 3 then
        tm.AddUnlock("cryovolcanic-power", "heat-pipe-vaterite")
        
        rm.AddIngredient("dormant-newtronic-chip", "electric-coil", 1)
    end

    if misc.starting_planet == "paracelsin" then
        tm.AddUnlock("mechanical-plant", "galvaser")
    end
end

if mods["castra"] then
    if misc.difficulty == 3 then
        rm.AddIngredient("dormant-newtronic-chip", "lithium-battery", 1)
        tm.AddSciencePack("quantum-processor", "battlefield-science-pack")
        tm.AddPrerequisite("quantum-processor", "lithium-battery")
        tm.AddSciencePack("productivity-module-3", "battlefield-science-pack")
        tm.AddSciencePack("fusion-reactor", "battlefield-science-pack")
        tm.AddSciencePack("portable-fusion-reactor", "battlefield-science-pack")
    end

    if mods["BrassTacksMk2"] then
        rm.AddProduct("custom-ancient-military-wreckage-recycling", {type="item", name="laser", amount=1, probability=0.005})
    end

    SetItemCost("millerite", 1)
    if mods["IfNickelMk2"] then
        SetItemCost("cst-nickel-plate", 1)
    else
        SetItemCost("nickel-plate", 1)
    end

    if data.raw.item["tracker"] then
        rm.AddIngredient("jammed-data-collector", "tracker", 100)
    end

    if misc.difficulty == 3 then
        rm.ReplaceIngredientProportional("jammer-radar", "processing-unit", "cardinal-grammeter", 1)
    end

    tm.AddSciencePack("robot-estrogen", "battlefield-science-pack")
    tm.AddSciencePack("a-world-with-substantially-less-zinc", "battlefield-science-pack")
    tm.AddSciencePack("lava-containment", "battlefield-science-pack")
    tm.AddSciencePack("holmium-excitation", "battlefield-science-pack")
    tm.AddSciencePack("controlled-bioluminescence", "battlefield-science-pack")
    tm.AddSciencePack("propaganda", "battlefield-science-pack")
    tm.AddSciencePack("coherent-salt-lamps", "battlefield-science-pack")

    if misc.starting_planet == "castra" then
        tm.AddUnlock("forge", "milaser")
    end

    if misc.difficulty > 1 then
        rm.ReplaceIngredientProportional("military-splitter", "electronic-circuit", "scanner", 0.2)
    end

    rm.RemoveProduct("reverse-cracking", "crude-oil", 5)
    rm.AddProduct("reverse-cracking", "filtered-oil", 5)
    rm.AddLaserMillData("nickel-battery", false, {helium=-1, unlock="millerite-processing"})
end

if data.raw.recipe["dormant-newtronic-chip"] then
    local yield = math.floor((#data.raw.recipe["dormant-newtronic-chip"].ingredients - 1) / 2)
    rm.MultiplyRecipe("dormant-newtronic-chip", {input=1, time=yield, output=yield})
end