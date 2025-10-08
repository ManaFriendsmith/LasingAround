require("lasermill-recipe-generator")

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