local parts = {}

parts.heavyGyro = false
if mods["BrassTacks"] and settings.startup["brasstacks-experimental-intermediates"].value and (settings.startup["brasstacks-gyro-override"].value or not mods["bzsilicon"]) then
  parts.heavyGyro = true
end

parts.brassExperiment = mods["BrassTacks"] and settings.startup["brasstacks-experimental-intermediates"].value
parts.nickelExperiment = mods["IfNickel"] and settings.startup["ifnickel-experimental-intermediates"].value

function parts.qualityIconPath(mod, icon)
  local prefix = ""
  --I intend to reuse this function between mods, hence checking for itself and specifying which mod to look in.
  --Other mods may add an alternate recipe and need to look up an icon, etc.
  --Possible that I am over-engineering this system.
  if mod == "brasstacks" and mods["BrassTacks"] then
    if settings.startup["brasstacks-classic-icons"].value then
      prefix = "__BrassTacks__/graphics/classic/"
    else
      prefix = "__BrassTacks__/graphics/galdoc/"
    end
  end
  if prefix ~= "" then
    return prefix .. icon
  end
end

function parts.preferred(ingredients, quantities)
  for k, v in ipairs(ingredients) do
    if data.raw.item[v] then
      return {v, quantities[k]}
    end
  end
end

function parts.optionalIngredient(item, amount)
  if data.raw.item[item] then
    return {item, amount}
  end
end

if mods["bzfoundry"] and not settings.startup["bzfoundry-minimal"].value then
  parts.foundryEnabled = true
else
  parts.foundryEnabled = false
end

return parts
