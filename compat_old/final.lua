local cu = require("category-utils")
local rm = require("recipe-modify")

cu.moveItem("nickel-electromagnet", "effector-components", "g")
cu.moveItem("se-holmium-solenoid", "effector-components", "h")
cu.moveItem("se-dynamic-emitter", "effector-components", "i")

if mods["248k"] then
  rm.ReplaceProportional("fi_refinery_basic_recipe", "crude-oil", "filtered-oil", 1)
  rm.ReplaceProportional("fi_refinery_coal_recipe", "crude-oil", "filtered-oil", 1)
  rm.ReplaceProportional("fi_refinery_sulfur_recipe", "crude-oil", "filtered-oil", 1)
end
