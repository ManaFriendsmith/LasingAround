local rm = require("__pf-functions__/recipe-manipulation")
local tm = require("__pf-functions__/technology-manipulation")
local misc = require("__pf-functions__/misc")

--INTERMEDIATE PRODUCTS

tm.AddUnlock("oil-processing", "oil-filtration")
tm.AddUnlock("advanced-oil-processing", "advanced-oil-filtration", "-advanced-oil-processing")
tm.AddUnlock("advanced-oil-processing", "helium-venting", "-advanced-oil-processing")

rm.ReplaceIngredientProportional("basic-oil-processing", "crude-oil", "filtered-oil")
rm.ReplaceIngredientProportional("advanced-oil-processing", "crude-oil", "filtered-oil")

tm.AddPrerequisite("laser", "advanced-oil-processing")
tm.RemovePrerequisite("laser", "chemical-science-pack")
tm.AddUnlock("laser", "laser")

if misc.difficulty > 1 then
    tm.AddPrerequisite("utility-science-pack", "laser")
    rm.ReplaceIngredientProportional("utility-science-pack", "processing-unit", "scanner", 1)
    if mods["maraxsis"] then
        rm.ReplaceIngredientProportional("maraxsis-deepsea-research-utility-science-pack", "processing-unit", "scanner", 1)
    end
end

if mods["space-age"] then
    if data.raw.item["rocket-control-unit"] then
        if data.raw.item["tracker"] then
            rm.ReplaceIngredientProportional("rocket-control-unit", "battery", "tracker", 0.33)
            rm.RemoveIngredient("rocket-control-unit", "gyro", 99999)
            rm.RemoveIngredient("rocket-control-unit", "transceiver", 99999)
        else
            rm.ReplaceIngredientProportional("rocket-control-unit", "battery", "laser", 0.33)
        end
    else
        rm.AddIngredient("rocket-part", "laser", mods["planet-muluna"] and 2 or 1)
        rm.AddIngredient("maraxsis-rocket-part", "laser", mods["planet-muluna"] and 2 or 1)
    end
else
    if not mods["LunarLandings"] then
        if data.raw.item["rocket-control-unit"] then
            if data.raw.item["tracker"] then
                rm.AddIngredient("rocket-control-unit", "tracker", 1)
                rm.RemoveIngredient("rocket-control-unit", "gyro", 99999)
                rm.RemoveIngredient("rocket-control-unit", "transceiver", 99999)
            else
                rm.AddIngredient("rocket-control-unit", "laser", 1)
            end
        elseif data.raw.item["tracker"] then
            rm.AddIngredient("rocket-part", "laser", 5)
        else
            rm.AddIngredient("rocket-part", "laser", 5)
        end

        rm.AddIngredient("satellite", "spectroscope", 100)
        tm.AddPrerequisite("space-science-pack", "spectroscopy")
    end
end

if misc.difficulty > 1 then
    tm.AddUnlock("processing-unit", "scanner")
end

rm.AddLaserMillData("iron-gear-wheel", {helium=-1}, {helium=-1})
rm.AddLaserMillData("iron-stick", {helium=-1}, {helium=-1})
rm.AddLaserMillData("copper-cable", {helium=-1}, {helium=-1})
rm.AddLaserMillData("barrel", {helium=-1}, {helium=-1})
rm.AddLaserMillData("electronic-circuit", {helium=-1}, {helium=-1})
rm.AddLaserMillData("advanced-circuit", {helium=-1}, {helium=-1})
rm.AddLaserMillData("processing-unit", false, {helium=-1, prod_research={"processing-unit-productivity", 0.1}, icon_offset=mods["LunarLandings"] and {8, -8} or {-8, -8}})
rm.AddLaserMillData("battery", {helium=-1}, {helium=-1})

rm.AddLaserMillData("low-density-structure", {helium=-1.4, convert=not mods["LunarLandings"]}, {helium=-1, prod_research={"low-density-structure-productivity", 0.1}})
rm.AddLaserMillData("engine-unit", false, {helium=-1})
rm.AddLaserMillData("electric-engine-unit", false, {helium=-1})
rm.AddLaserMillData("flying-robot-frame", false, {helium=-1})

if not mods["space-age"] and not mods["LunarLandings"] then
    tm.RemovePrerequisite("low-density-structure", "chemical-science-pack")
    tm.AddPrerequisite("low-density-structure", "laser-mill")
end

if data.raw.item["tracker"] and (mods["space-age"] or not mods["LunarLandings"]) then
    tm.AddPrerequisite("rocket-silo", "tracking-systems")
end

if data.raw.item["tracker"] and data.raw.item["skyseeker-armature"] then
    tm.RemoveUnlock("electric-engine", "skyseeker-armature")
    tm.AddUnlock("tracking-systems", "skyseeker-armature")
    rm.AddIngredient("skyseeker-armature", "tracker")
end

if data.raw.item["micron-tolerance-components"] and not mods["LunarLandings"] then
    if mods["BrassTacksMk2"] then
        rm.ReplaceIngredientProportional("express-gearbox", "iron-gear-wheel", "micron-tolerance-components")
        tm.AddPrerequisite("production-science-pack", "micron-tolerance-manufacturing")
    end

    rm.ReplaceIngredientProportional("gimbaled-rocket-engine", "invar-plate", "micron-tolerance-components", 5)
end

--LOGISTICS

rm.AddLaserMillData("iron-chest", {helium=-1}, false)
rm.AddLaserMillData("steel-chest", {helium=-1}, false)

rm.AddLaserMillData("pipe", {helium=-1}, {helium=-1})
rm.AddLaserMillData("pipe-to-ground", {helium=-1}, false)
rm.AddLaserMillData("storage-tank", {helium=-1}, false)

if misc.difficulty > 1 then
    tm.AddPrerequisite("logistics-3", "processing-unit")
    rm.ReplaceIngredientProportional("express-splitter", "advanced-circuit", "scanner", 0.2)

    tm.AddPrerequisite("logistic-robotics", "processing-unit")
    rm.AddIngredient("logistic-robot", "scanner")

    rm.ReplaceIngredientProportional("stack-inserter", "processing-unit", "scanner")
end

if data.raw.item["micron-tolerance-components"] then
    if not mods["BrassTacksMk2"] and not mods["LunarLandings"] then
        rm.AddIngredient("express-belt", "micron-tolerance-components", 1)
        rm.AddIngredient("express-underground-belt", "micron-tolerance-components", 8)
        rm.AddIngredient("express-splitter", "micron-tolerance-components", 10)
        tm.AddPrerequisite("logistics-3", "micron-tolerance-manufacturing")
    end
    if not (mods["BrassTacksMk2"] or mods["IfNickelMk2"]) then
        rm.AddIngredient("stack-inserter", "micron-tolerance-components", 10)
    end
end


rm.AddLaserMillData("medium-electric-pole", {helium=-1, unlock="electric-energy-distribution-1"}, false)
rm.AddLaserMillData("big-electric-pole", {helium=-1, unlock="electric-energy-distribution-1"}, false)

rm.AddLaserMillData("rail-ramp", {helium=-1, unlock="elevated-rail"}, false)
rm.AddLaserMillData("rail-support", {helium=-1, unlock="elevated-rail"}, false)


if data.raw.item["tracker"] then
    if not mods["space-age"] then
        tm.AddPrerequisite("logistic-system", "tracking-systems")
    end
    rm.ReplaceIngredientProportional("requester-chest", "transceiver", "tracker")
    rm.ReplaceIngredientProportional("buffer-chest", "transceiver", "tracker")
    rm.ReplaceIngredientProportional("active-provider-chest", "transceiver", "tracker")
else
    rm.ReplaceIngredientProportional("requester-chest", "advanced-circuit", "laser")
    rm.ReplaceIngredientProportional("buffer-chest", "advanced-circuit", "laser")
    rm.ReplaceIngredientProportional("active-provider-chest", "advanced-circuit", "laser")
end

data.raw.recipe["basic-oil-processing"].subgroup = "helium"
data.raw.recipe["basic-oil-processing"].order = "e"
data.raw.recipe["advanced-oil-processing"].subgroup = "helium"
data.raw.recipe["advanced-oil-processing"].order = "f"
data.raw.recipe["coal-liquefaction"].subgroup = "helium"
data.raw.recipe["coal-liquefaction"].order = "h"
if mods["space-age"] then
    data.raw.recipe["simple-coal-liquefaction"].subgroup = "helium"
    data.raw.recipe["simple-coal-liquefaction"].order = "g"
end

--PRODUCTION

if misc.difficulty > 1 then
    tm.AddPrerequisite("automation-3", "processing-unit")
    rm.ReplaceIngredientProportional("assembling-machine-3", "speed-module", "scanner")
end

if misc.difficulty == 3 then
    data.raw.recipe["heat-pipe"].category = "crafting-with-fluid"
    rm.AddIngredient("heat-pipe", "helium", 30)
end

rm.AddLaserMillData("heat-pipe", {helium=-1, unlock="nuclear-power"}, false)
rm.AddLaserMillData("uranium-fuel-cell", {helium=120, unlock="nuclear-power"}, false)

rm.AddIngredient("beacon", "laser", 10)
rm.RemoveIngredient("beacon", "advanced-circuit", 10)
rm.RemoveIngredient("beacon", "integrated-circuit", 20)

if data.raw.item["micron-tolerance-components"] and not mods["LunarLandings"] then
    if not mods["BrassTacksMk2"] then
        rm.AddIngredient("assembling-machine-3", "micron-tolerance-components", 10)
        tm.AddPrerequisite("logistics-3", "micron-tolerance-manufacturing")
    end
end

--MILITARY

rm.ReplaceIngredientProportional("laser-turret", "battery", "laser", 0.33)
rm.ReplaceIngredientProportional("distractor-capsule", "advanced-circuit", "laser")

rm.ReplaceIngredientProportional("flamethrower-ammo", "crude-oil", "filtered-oil")

table.insert(data.raw["fluid-turret"]["flamethrower-turret"].attack_parameters.fluids, {type="filtered-oil"})

if data.raw.item["tracker"] then
    if not mods["space-age"] then
        if not data.raw.item["skyseeker-armature"] then
            rm.ReplaceIngredientProportional("artillery-turret", "advanced-circuit", "tracker")
            rm.ReplaceIngredientProportional("artillery-wagon", "advanced-circuit", "tracker")
        end
        tm.AddPrerequisite("artillery", "tracking-systems")
        tm.AddPrerequisite("personal-roboport-mk2-equipment", "tracking-systems")
    end
    rm.ReplaceIngredientProportional("artillery-shell", "radar", "tracker")
    rm.RemoveIngredient("artillery-shell", "gyro")

    rm.AddIngredient("personal-roboport-mk2-equipment", "tracker", 20)
end

if misc.difficulty == 3 and mods["space-age"] then
    --lol
    rm.AddIngredient("rocket-launcher", "laser")
    tm.AddPrerequisite("rocketry", "laser")
    tm.AddSciencePack("rocketry", "chemical-science-pack")
end

if data.raw.item["tracker"] and rm.GetIngredientCount("atomic-bomb", "rocket-control-unit") == 0 then
    rm.AddIngredient("atomic-bomb", "tracker", 10)
    tm.AddPrerequisite("atomic-bomb", "tracking-systems")
end