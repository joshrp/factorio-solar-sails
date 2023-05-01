
if mods['SeaBlock'] then
  log('SeaBlock detected, adjusting solar sail deployer recipe')
  ingredients = {
    deployer = {
      {'deuterium-fuel-cell-2', 1},
      {'rocket-control-unit', 1},
      {'pay:solar-sail', 1000},
      {'effectivity-module-8', 10},
      {'silver-zinc-battery', 100},
      {'gas-hydrazine-barrel', 100}},
    solar_sail = {
      {'glass', 50},
      {'cp-advanced-circuit-board', 10},
      {'silicon-wafer', 50},
      {'low-density-structure', 20},
      {type = "fluid", name = "liquid-hydrochloric-acid", amount = 50}
    }
  }

  data.raw.recipe['pay:solar-sail-deployer-recipe'].normal.ingredients = ingredients.deployer
  data.raw.recipe['pay:solar-sail-deployer-recipe'].category = 'crafting'
  data.raw.recipe['pay:solar-sail-recipe'].normal.ingredients = ingredients.solar_sail

  data.raw.technology['pay:solar-sail-technology'].prerequisites = {'rocket-silo', 'deuterium-fuel-cell-2', 'bob-solar-energy-3'}
end
