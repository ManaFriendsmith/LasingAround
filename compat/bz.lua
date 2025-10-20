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

if mods["bzsilicon"] then
    if data.raw.item["silicon-wafer"] then
        rm.ReplaceIngredientProportional("scanner", "electronic-circuit", "silicon-wafer")

        rm.AddLaserMillData("optical-fiber", {helium=-1}, {helium=-1})
    else
        rm.ReplaceIngredientProportional("scanner", "electronic-circuit", "silicon")
    end

    if data.raw.item["optical-fiber"] then
        rm.AddIngredient("laser", "optical-fiber", 3)
        rm.AddIngredient("lavaser", "optical-fiber", 3)
        rm.AddIngredient("bioluminaser", "optical-fiber", 3)

        rm.AddLaserMillData("optical-fiber", {helium=-1}, {helium=-1})
    elseif not data.raw.item["diamond"] then
        rm.AddIngredient("laser", "silica", 3)
        rm.AddIngredient("lavaser", "silica", 3)
        rm.AddIngredient("bioluminaser", "silica", 3)
    end
end

if mods["bzcarbon"] then
    SetItemCost("flake-graphite", 1)
    SetItemCost("graphite", 1)
    SetItemCost("carbon-black", 0.5)
    SetItemCost("diamond", 6)

    rm.AddIngredient("laser", "diamond")
    rm.AddIngredient("lavaser", "diamond")
    rm.AddIngredient("bioluminaser", "diamond")
    rm.RemoveIngredient("laser-turret", "diamond", 99999)
    rm.RemoveIngredient("distractor-capsule", "diamond", 99999)
end

if mods["bzlead"] then
    SetItemCost("lead-ore", 1)
    SetItemCost("lead-plate", 1)

    rm.AddLaserMillData("lead-expansion-bolt", {helium=-1}, {helium=-1})
end

if mods["bztin"] then
    SetItemCost("tin-ore", 1)
    SetItemCost("tin-plate", 1)

    rm.AddLaserMillData("solder", false, {helium=-1})

    if not data.raw.item["electroplating-machine"] then
        rm.AddLaserMillData("tinned-cable", {helium=-1}, {helium=-1})
    end
end

if mods["bztitanium"] then
    SetItemCost("titanium-ore", 1)
    SetItemCost("titanium-plate", 5)
end