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

    if misc.difficulty == 3 then
        tm.AddUnlock("cryovolcanic-power", "heat-pipe-vaterite")
        
        rm.AddIngredient("dormant-newtronic-chip", "electric-coil", 1)
    end

    if misc.starting_planet == "paracelsin" then
        tm.AddUnlock("mechanical-plant", "galvaser")
    end
end