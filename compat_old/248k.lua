local parts = require("variable-parts")
local tf = require("techfuncs")
local rm = require("recipe-modify")

if mods["248k"] then
  rm.ReplaceProportional("el_kerosene_recipe", "crude-oil", "filtered-oil", 1)
  rm.ReplaceProportional("el_kerosene_basic_recipe", "crude-oil", "filtered-oil", 1)

  tf.addPrereq("fi_refinery_tech", "spectroscopy")
  rm.AddIngredient("fi_refinery_recipe", "spectroscope", 10, 10)

  tf.addPrereq("fi_ki_tech", "helium-laser")
  rm.AddIngredient("fi_ki_beacon_recipe", "helium-laser", 5, 5)
  rm.ReplaceIngredient("fi_ki_core_recipe", "electronic-circuit", "helium-laser", 100, 100)
  rm.AddIngredient("fu_ki_beacon_recipe", "helium-laser", 15, 15)
  rm.ReplaceIngredient("fu_ki_core_recipe", "electronic-circuit", "helium-laser", 250, 250)

  rm.AddIngredient("fu_laser_recipe", "spectroscope", 20, 20)
  rm.AddIngredient("fu_laser_card_recipe", "carbon-dioxide-laser", 1, 1)
  rm.AddProductRaw("fu_laser_card_recipe", {type="item", name="carbon-dioxide-laser", amount=1, probability=0.75, catalyst_amount=1})

  if data.raw["assembling-machine"]["fu_laser_entity"] then
    data.raw["assembling-machine"]["fu_laser_entity"].ingredient_count = nil
  end

  rm.AddIngredient("fu_plasma_recipe", "carbon-dioxide-laser", 10, 10)

  rm.AddIngredient("fu_stelar_reactor_recipe", "carbon-dioxide-laser", 100, 100)
  rm.AddIngredient("fu_tokamak_reactor_recipe", "carbon-dioxide-laser", 100, 100)

  rm.AddIngredient("fu_fusor_recipe", "scanner", 50, 50)
  rm.AddIngredient("gr_lab_recipe", "scanner", 50, 50)

  if data.raw.item["micron-tolerance-components"] then
    rm.AddIngredient("fu_tech_sign_recipe", "micron-tolerance-components", 1, 1)
  end

  if not data.raw.item["advanced-machining-tool"] then
    rm.AddIngredient("gr_crafter_recipe", "scanner", 10, 10)
  end

  if data.raw.item["tracker"] then
    rm.AddIngredient("fu_robo_logistic_recipe", "tracker", 5, 5)
    rm.AddIngredient("fu_robo_construction_recipe", "tracker", 5, 5)
  end
end
