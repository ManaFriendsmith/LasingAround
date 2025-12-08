require("lasermill-recipe-generator")
rm = require("__pf-functions__/recipe-manipulation")

if data.raw.item["antimatter-power-cell"] then
    local function AllowAntimatterFuel(energy_source)
        if energy_source.type == "burner" then
            if energy_source.fuel_categories then
                table.insert(energy_source.fuel_categories, "antimatter")
            elseif energy_source.fuel_category then
                energy_source.fuel_categories = {energy_source.fuel_category, "antimatter"}
                energy_source.fuel_category = nil
            else
                energy_source.fuel_categories = {"antimatter"}
            end
        end
    end

    for k, v in pairs(data.raw.car) do
        if v.energy_source then
            AllowAntimatterFuel(v.energy_source)
        end
    end
    for k, v in pairs(data.raw.locomotive) do
        if v.energy_source then
            AllowAntimatterFuel(v.energy_source)
        end
    end
    for k, v in pairs(data.raw["spider-vehicle"]) do
        if v.energy_source then
            AllowAntimatterFuel(v.energy_source)
        end
    end
end

if mods["quality"] then
    rm.FixStackingRecycling()
    require("__quality__/data-updates.lua")

    if data.raw.item["dormant-newtronic-chip"] then
        local pulse_recycling = table.deepcopy(data.raw.recipe["dormant-newtronic-chip-recycling"])
        pulse_recycling.icons = data.raw.recipe["pulsing-newtronic-chip-recycling"].icons
        pulse_recycling.localised_name = data.raw.recipe["pulsing-newtronic-chip-recycling"].localised_name
        pulse_recycling.name = "pulsing-newtronic-chip-recycling"
        pulse_recycling.ingredients = {{type="item", name="pulsing-newtronic-chip", amount=1}}
        data:extend({pulse_recycling})
        data.raw.item["pulsing-newtronic-chip"].auto_recycle = false
    end
end