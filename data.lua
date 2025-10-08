if mods["space-age"] and not mods["pf-sa-compat"] then
  error("Lasing Around requires PF Space Age compatibility (pf-sa-compat) to work with Space Age. Please download and enable that mod to continue.")
end

require("prototypes.mill")
require("prototypes.antimatter")
require("prototypes.items-fluids")
require("prototypes.recipe")
require("prototypes.technology")
require("item-costs")