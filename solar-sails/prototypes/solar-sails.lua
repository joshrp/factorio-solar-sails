-- Copyright (c) 2023 Paystey

ingredients = {
    deployer = {
      {'nuclear-fuel', 10},
      {'rocket-control-unit', 10},
      {'pay:solar-sail', 1000},
      {'effectivity-module-3', 10},
      {'accumulator', 50},
      {type='fluid', name = 'lubricant', amount=200}},
    solar_sail = {
      {'plastic-bar', 50},
      {'advanced-circuit', 10},
      {'low-density-structure', 20},
      {type='fluid', name = 'sulfuric-acid', amount=50}}
}

data:extend({{
  type = 'item',
  name = 'pay:solar-sail-receiver',
  place_result = 'pay:solar-sail-receiver-entity',
  icon = '__solar-sails__/graphics/icon/solar-power-receiver-icon.png',
  icon_size = 64,
  subgroup = 'energy',
  order = 'z',

  stack_size = 10
}})

data:extend({{
    type = 'item',
    name = 'pay:solar-sail',
    icon = '__solar-sails__/graphics/icon/solar-sail-icon.png',
    icon_size = 64,
    subgroup = 'intermediate-product',
    order = 'z',
    stack_size = 100
}, {
    type = 'item',
    name = 'pay:solar-sail-deployer',
    icon = '__solar-sails__/graphics/icon/solar-sail-array-icon.png',
    icon_size = 64,
    subgroup = "space-related",
    order = 'z',
    rocket_launch_product = {"pay:solar-sail-receiver", 1},
    stack_size = 5
}, {
    type = 'recipe',
    name = 'pay:solar-sail-recipe',
    category = 'crafting-with-fluid',
    normal = {
        enabled = true,
        ingredients = ingredients['solar_sail'],
        result = 'pay:solar-sail',
        energy_required = 30
    }
}})

data:extend({{
    type = 'recipe',
    name = 'pay:solar-sail-deployer-recipe',
    category = 'crafting-with-fluid',
    normal = {
        enabled = true,
        ingredients = ingredients['deployer'],
        result = 'pay:solar-sail-deployer',
        energy_required = 600
    }
}})

local solarReceiver = table.deepcopy(data.raw['solar-panel']['solar-panel'])

solarReceiver['name'] = "pay:solar-sail-receiver-entity"

solarReceiver.type = 'electric-energy-interface'
solarReceiver.energy_production = settings.startup['pay:receiver-power'].value
solarReceiver.gui_mode = 'none'
solarReceiver.minable = {mining_time = 1, result = "pay:solar-sail-receiver"}

solarReceiver.energy_source = {
  type = "electric",
  usage_priority = 'primary-output',
  output_flow_limit = settings.startup['pay:receiver-power'].value,
  buffer_capacity = settings.startup['pay:receiver-power'].value,
  render_no_power_icon = false,
}
solarReceiver.icon = '__solar-sails__/graphics/icon/solar-power-receiver-icon.png'

solarReceiver.collision_box[1][1] = solarReceiver.collision_box[1][1] * 0.9
solarReceiver.collision_box[2][1] = solarReceiver.collision_box[2][1] * 0.9
solarReceiver.collision_box[1][2] = solarReceiver.collision_box[1][2] * 0.9
solarReceiver.collision_box[2][2] = solarReceiver.collision_box[2][2] * 0.9

solarReceiver.picture = {
  layers = {
  {
    filename = "__solar-sails__/graphics/entity/receiver/solar-power-receiver.png",
    priority = "high",
    width = 116,
    height = 112,
    shift = util.by_pixel(-3, 3),
    hr_version =
    {
      filename = "__solar-sails__/graphics/entity/receiver/hr-solar-power-receiver.png",
      priority = "high",
      width = 230,
      height = 224,
      shift = util.by_pixel(-3, 3.5),
      scale = 0.5
    }
  },
  {
    filename = "__solar-sails__/graphics/entity/receiver/solar-panel-shadow.png",
    priority = "high",
    width = 112,
    height = 90,
    shift = util.by_pixel(10, 6),
    draw_as_shadow = true,
    hr_version =
    {
      filename = "__solar-sails__/graphics/entity/receiver/hr-solar-panel-shadow.png",
      priority = "high",
      width = 214,
      height = 180,
      shift = util.by_pixel(9.5, 6),
      draw_as_shadow = true,
      scale = 0.5
    }
  }}
}

data:extend({solarReceiver})

data:extend{{
  type = 'technology',
  name = 'pay:solar-sail-technology',
  icon = '__solar-sails__/graphics/technology/solar-sail-array.png',
  icon_size = 400,
  effects = {
    {
      type = 'unlock-recipe',
      recipe = 'pay:solar-sail-recipe'
    },
    {
      type = 'unlock-recipe',
      recipe = 'pay:solar-sail-deployer-recipe'
    },
  },
  prerequisites = {'rocket-silo'},
  unit = {
    count = 1000,
    ingredients = {
      {'automation-science-pack', 1},
      {'logistic-science-pack', 1},
      {'chemical-science-pack', 1},
      {'production-science-pack', 1},
      {'utility-science-pack', 1},
    },
    time = 30
  },
}}

