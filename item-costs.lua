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

SetItemCost("water", 0)
SetItemCost("helium", 0)

SetItemCost("stone", 0.8)
SetItemCost("stone-brick", 1.6)

SetItemCost("iron-ore", 1)
SetItemCost("iron-plate", 1)
SetItemCost("copper-ore", 1)
SetItemCost("copper-plate", 1)

SetItemCost("plastic-bar", 1)
SetItemCost("sulfur", mods["BrimStuffMk2"] and 1 or 1.5)
SetItemCost("solid-fuel", 1)

SetItemCost("sulfuric-acid", 0.15)
SetItemCost("lubricant", 0.1)

SetItemCost("uranium-ore", 1)
SetItemCost("uranium-238", 10)
SetItemCost("uranium-235", 10)

if mods["space-age"] then
    SetItemCost("metallic-asteroid-chunk", 10)
    SetItemCost("oxide-asteroid-chunk", 10)
    SetItemCost("carbonic-asteroid-chunk", 10)

    SetItemCost("ice", 0)
    SetItemCost("carbon", 1)

    SetItemCost("holmium-solution", 0.1)
    SetItemCost("electrolyte", 0.1)
    SetItemCost("holmium-plate", 2)
    SetItemCost("holmium-ore", 10)

    SetItemCost("calcite", 2)
    SetItemCost("tungsten-ore", 2)
    SetItemCost("tungsten-carbide", 5)
    SetItemCost("tungsten-plate", 8)
    
    SetItemCost("yumako", 0.25)
    SetItemCost("jellynut", 0.25)
    SetItemCost("nutrients", 0.1)
    SetItemCost("spoilage", 0.1)
    SetItemCost("iron-bacteria", 1)
    SetItemCost("copper-bacteria", 1)

    SetItemCost("ammoniacal-solution", 0)
    SetItemCost("ammonia", 0)
    SetItemCost("fluorine", 0.2)
    SetItemCost("lithium", 3)
    SetItemCost("lithium-plate", 3)
end
