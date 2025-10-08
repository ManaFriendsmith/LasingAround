local rm = require("__pf-functions__/recipe-manipulation")
local tm = require("__pf-functions__/technology-manipulation")
local misc = require("__pf-functions__/misc")

if mods["Age-of-Production"] then
    require("compat.age-of-production")
end

--SPACE PLATFORM

data.raw.item["helium-barrel"].weight = 5 * kg
rm.AddIngredient("helium-barrel", "helium", 450)
rm.AddProduct("empty-helium-barrel", "helium", 450)

--VULCANUS

if misc.starting_planet == "vulcanus" then
    tm.AddUnlock("laser", "lavaser")
end

if misc.difficulty > 1 then
    rm.AddIngredient("turbo-splitter", "scanner", 4)
end

--GLEBA

if misc.starting_planet == "gleba" then
    tm.AddUnlock("laser", "bioluminaser")
end

if data.raw.item["mutagenic-sludge"] and mods["BrimStuff"] then
    tm.AddUnlock("advanced-sludge-handling", "mutagenic-sludge-obliteration")
    tm.AddUnlock("advanced-sludge-handling", "catastrophe-aversion")
end

--FULGORA

if misc.starting_planet == "fulgora" then
    tm.AddUnlock("laser", "electrolaser")
end

if misc.difficulty > 1 then
    rm.RemoveProduct("scrap-recycling", {type="item", name="holmium-ore", amount=1, probability=0.01})
    rm.AddProduct("scrap-recycling", {type="item", name="weird-alien-gizmo", amount=1, probability=0.05})    

    rm.ReplaceIngredientProportional("recycler", "processing-unit", "scanner")

    tm.AddUnlock("recycling", "weird-alien-gizmo-recycling")
    tm.AddUnlock("scrap-recycling-productivity", {type="change-recipe-productivity", recipe="weird-alien-gizmo-recycling", change=0.1})
    if misc.starting_planet == "fulgora" then
        tm.AddUnlock("scrap-recycling-productivity-1", {type="change-recipe-productivity", recipe="weird-alien-gizmo-recycling", change=0.1})
        tm.AddUnlock("scrap-recycling-productivity-2", {type="change-recipe-productivity", recipe="weird-alien-gizmo-recycling", change=0.1})
        tm.AddUnlock("scrap-recycling-productivity-3", {type="change-recipe-productivity", recipe="weird-alien-gizmo-recycling", change=0.1})
        tm.AddUnlock("scrap-recycling-productivity-4", {type="change-recipe-productivity", recipe="weird-alien-gizmo-recycling", change=0.1})
    end
else
    rm.AddProduct("scrap-recycling", {type="item", name="laser", amount=1, probability=0.01})
end

rm.ReplaceIngredientProportional("spectroscope", "copper-plate", "superconductor", 0.5)

if misc.difficulty == 3 then
    --data.raw.recipe["superconductor"].category = "electronics-with-fluid"
    tm.AddUnlock("electromagnetic-plant", "cardinal-grammeter")

    rm.ReplaceIngredientProportional("electromagnetic-plant", "holmium-plate", "cardinal-grammeter", 0.1)
    rm.ReplaceIngredientProportional("tesla-turret", "processing-unit", "cardinal-grammeter", 1)

    rm.AddIngredient("personal-roboport-mk2-equipment", "cardinal-grammeter", 10)
    rm.ReplaceIngredientProportional("mech-armor", "holmium-plate", "cardinal-grammeter", 0.1)
end

if data.raw.item["tracker"] then
    rm.AddIngredient("tesla-turret", "tracker", 10)
end

--AQUILO

rm.AddIngredient("fusion-reactor", "laser", 100)
rm.ReplaceIngredientProportional("fusion-power-cell", "ammonia", "helium", 0.25)
rm.ReplaceIngredientProportional("solid-fuel-from-ammonia", "crude-oil", "filtered-oil")

if misc.difficulty == 3 then
    tm.AddUnlock("quantum-processor", "dormant-newtronic-chip", "-quantum-processor")
    tm.AddPrerequisite("quantum-processor", "waifugenesis")
    tm.AddPrerequisite("quantum-processor", "probability-manipulation")
    tm.AddPrerequisite("quantum-processor", mods["IfNickel"] and "geometry-abolition" or "laissez-faire-mathematics")
    rm.ReplaceIngredientProportional("quantum-processor", "processing-unit", "pulsing-newtronic-chip")
end

--TUNER
if misc.difficulty == 3 and tune_up_data then
    if mods["IfNickel"] then
        tune_up_data.ReplaceIngredientProportional("efficiency-module", "quantum-processor", "perpendicular-processor", 1)
    else
        tune_up_data.ReplaceIngredientProportional("efficiency-module", "quantum-processor", "logic-deregulator", 1)
    end
    tune_up_data.ReplaceIngredientProportional("speed-module", "quantum-processor", "random-number-nullifier", 1)
    tune_up_data.ReplaceIngredientProportional("quality-module", "quantum-processor", "ai-girlfriend", 1)
end