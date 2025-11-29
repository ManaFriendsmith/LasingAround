local rm = require("__pf-functions__/recipe-manipulation")
local tm = require("__pf-functions__/technology-manipulation")
local misc = require("__pf-functions__/misc")

if mods["se-space-trains"] then
    if misc.difficulty == 3 and mods["space-age"] then
        rm.ReplaceIngredientProportional("space-locomotive", "processing-unit", "ai-girlfriend")
        tm.AddPrerequisite("tech-space-trains", "waifugenesis")
    end
end