local rm = require("__pf-functions__/recipe-manipulation")
local tm = require("__pf-functions__/technology-manipulation")
local misc = require("__pf-functions__/misc")

if misc.difficulty == 3 then
    rm.ReplaceIngredientProportional("aop-mineral-synthesizer", "copper-plate", "random-number-nullifier", 0.25)
    tm.AddPrerequisite("aop-mineral-synthesis", "probability-manipulation")

    rm.AddIngredient("aop-salvager", "random-number-nullifier", 10)
    tm.AddPrerequisite("aop-advanced-recycling", "probability-manipulation")

    rm.AddIngredient("aop-greenhouse", "ai-girlfriend", 10)
    tm.AddPrerequisite("aop-greenhouse", "waifugenesis")

    rm.AddIngredient("aop-hydraulic-facility", mods["IfNickel"] and "perpendicular-processor" or "logic-deregulator", 20)
    tm.AddPrerequisite("aop-hydraulics", mods["IfNickel"] and "geometry-abolition" or "laissez-faire-mathematics")
end