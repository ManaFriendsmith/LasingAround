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

if mods["scrap-industry"] then
    ScrapIndustry.items["laser"] = {scrap={"circuit-scrap"}, scale=ScrapIndustry.RARE, failrate=0.02}
    ScrapIndustry.items["scanner"] = {scrap={"circuit-scrap"}, scale=ScrapIndustry.RARE, failrate=0.02}
    ScrapIndustry.items["tracker"] = {scrap={"circuit-scrap"}, scale=ScrapIndustry.RARE, failrate=0.05}
    ScrapIndustry.items["cardinal-grammeter"] = {scrap={"circuit-scrap", "holmium-scrap"}, scale=ScrapIndustry.RARE, failrate=0.05}
    ScrapIndustry.items["weird-alien-gizmo"] = {scrap={"circuit-scrap"}, scale=ScrapIndustry.COMMON, failrate=0.01}
    ScrapIndustry.items["micron-tolerance-components"] = {scrap={"invar-scrap"}, scale=ScrapIndustry.CHEAP, failrate=0.01}

    ScrapIndustry.items["ai-girlfriend"] = {scrap={"circuit-scrap", data.raw.item["mech-scrap"] and "mech-scrap" or "steel-scrap"}, scale=ScrapIndustry.EPIC, failrate=0.01}
    ScrapIndustry.items["random-number-nullifier"] = {scrap={"circuit-scrap", data.raw.item["mech-scrap"] and "mech-scrap" or "steel-scrap" }, scale=ScrapIndustry.RARE, failrate=0.01}
    ScrapIndustry.items["perpendicular-processor"] = {scrap={"circuit-scrap"}, scale=ScrapIndustry.RARE, failrate=0.01}
    ScrapIndustry.items["logic-deregulator"] = {scrap={"circuit-scrap"}, scale=ScrapIndustry.RARE, failrate=0.01}
    ScrapIndustry.items["pulsing-newtronic-chip"] = {scrap={"circuit-scrap"}, scale=ScrapIndustry.RARE, failrate=-1}

    ScrapIndustry.recipes["art-rotators"] = {ignore=true}
    ScrapIndustry.recipes["art-rotator-inversion"] = {ignore=true}
    ScrapIndustry.recipes["pentapod-gatekeeper"] = {ignore=true}
    ScrapIndustry.recipes["pentapod-gatekeeper-inversion"] = {ignore=true}
    ScrapIndustry.recipes["high-density-chaos"] = {ignore=true}
    ScrapIndustry.recipes["high-density-chaos-inversion"] = {ignore=true}
    ScrapIndustry.recipes["weighted-blanket"] = {ignore=true}
    ScrapIndustry.recipes["weighted-blanket-inversion"] = {ignore=true}
    ScrapIndustry.recipes["clumsy-piston"] = {ignore=true}
    ScrapIndustry.recipes["clumsy-piston-inversion"] = {ignore=true}
    ScrapIndustry.recipes["ordinary-human-brain"] = {ignore=true}
    ScrapIndustry.recipes["ordinary-human-brain-inversion"] = {ignore=true}

    ScrapIndustry.recipes["spectroscopic-oil-filtration"] = {ignore=true}
    rm.AddProduct("spectroscopic-oil-filtration", {type="item", name="circuit-scrap", amount=1, probability=0.01, ignored_by_productivity=1})
    if mods["space-age"] then
        rm.AddProduct("spectroscopic-oil-filtration", {type="item", name="holmium-scrap", amount=1, probability=0.01, ignored_by_productivity=1})
        ScrapIndustry.recipes["spectroscopic-holmium-processing"] = {ignore=true}
        rm.AddProduct("spectroscopic-holmium-processing", {type="item", name="circuit-scrap", amount=1, probability=0.01, ignored_by_productivity=1})
        rm.AddProduct("spectroscopic-holmium-processing", {type="item", name="holmium-scrap", amount=1, probability=0.01, ignored_by_productivity=1})

        ScrapIndustry.recipes["spectroscopic-bioflux-processing"] = {ignore=true}
        rm.AddProduct("spectroscopic-bioflux-processing", {type="item", name="circuit-scrap", amount=1, probability=0.01, ignored_by_productivity=1})
        rm.AddProduct("spectroscopic-bioflux-processing", {type="item", name="holmium-scrap", amount=1, probability=0.01, ignored_by_productivity=1})

        ScrapIndustry.recipes["spectroscopic-hydrogen-sulfide-electrolysis"] = {ignore=true}
        rm.AddProduct("spectroscopic-hydrogen-sulfide-electrolysis", {type="item", name="circuit-scrap", amount=1, probability=0.01, ignored_by_productivity=1})
        rm.AddProduct("spectroscopic-hydrogen-sulfide-electrolysis", {type="item", name="holmium-scrap", amount=1, probability=0.01, ignored_by_productivity=1})
    end

    if mods["BrassTacksMk2"] then
        table.insert(ScrapIndustry.items["tracker"].scrap, data.raw.item["mech-scrap"] and "mech-scrap" or "brass-scrap")
    end

    if data.raw.item["mech-scrap"] then
        table.insert(ScrapIndustry.items["cardinal-grammeter"].scrap, "mech-scrap")
    end

    if data.raw.item["plastic-bits"] then
        table.insert(ScrapIndustry.items["laser"].scrap, "plastic-bits")
        table.insert(ScrapIndustry.items["scanner"].scrap, "plastic-bits")
    end
    if mods["ThemTharHillsMk2"] then
        table.insert(ScrapIndustry.items["laser"].scrap, "gold-scrap")
        table.insert(ScrapIndustry.items["scanner"].scrap, "gold-scrap")
        ScrapIndustry.items["laser"].scale = ScrapIndustry.UNCOMMON
        ScrapIndustry.items["scanner"].scale = ScrapIndustry.UNCOMMON
    end

end