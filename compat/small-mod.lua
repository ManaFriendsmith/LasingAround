local rm = require("__pf-functions__/recipe-manipulation")
local tm = require("__pf-functions__/technology-manipulation")
local misc = require("__pf-functions__/misc")

if mods["se-space-trains"] and not mods["LunarLandings"] then
    if misc.difficulty == 3 and mods["space-age"] then
        rm.ReplaceIngredientProportional("space-locomotive", "processing-unit", "ai-girlfriend")
        tm.AddPrerequisite("tech-space-trains", "waifugenesis")
    end
end

if mods["deadlock-beltboxes-loaders"] then
    if misc.difficulty > 1 then
        if mods["space-age"] then
            rm.AddIngredient("turbo-transport-belt-beltbox", "scanner", 5)
        else
            rm.AddIngredient("express-transport-belt-beltbox", "scanner", 2)
        end
    end
end