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

if mods["maraxsis"] then
    tm.AddSciencePack("robot-estrogen", "hydraulic-science-pack")
    tm.AddSciencePack("a-world-with-substantially-less-zinc", "hydraulic-science-pack")
    tm.AddSciencePack("lava-containment", "hydraulic-science-pack")
    tm.AddSciencePack("holmium-excitation", "hydraulic-science-pack")
    tm.AddSciencePack("controlled-bioluminescence", "hydraulic-science-pack")
    tm.AddSciencePack("propaganda", "hydraulic-science-pack")
end

if mods["Paracelsin"] then
    if mods["BrassTacks"] then
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

    if mods["BrassTacks"] then
        rm.AddProduct("custom-ancient-military-wreckage-recycling", {type="item", name="laser", amount=1, probability=0.005})
    end

    SetItemCost("millerite", 1)
    if mods["IfNickel"] then
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

local yield = math.floor((#data.raw.recipe["dormant-newtronic-chip"].ingredients - 1) / 2)
rm.MultiplyRecipe("dormant-newtronic-chip", {input=1, time=yield, output=yield})