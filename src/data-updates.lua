-- arg.from  (string)  Item name to set to spoil
-- arg.to    (string)  Item name to spoil into
-- arg.time  (int)     Spoilage time in ticks
function make_item_spoil_into_item(arg)
  local item = data.raw.item[arg.from]
  item.spoil_ticks = arg.time
  item.spoil_result = arg.to
end


-- arg.from             (string)  Item name to set to spoil
-- arg.to               (string)  Entity name that will be spawned nearby
-- arg.time             (int)     Spoilage time in ticks
-- [arg.per=5]          (int)     Number of items needed to spoil per spawn
-- [arg.as_enemy=true]  (bool)    Whether to spawn the entity as hostile
function make_item_spoil_into_entity(arg)
  local item = data.raw.item[arg.from]
  item.spoil_ticks = arg.time
  item.spoil_to_trigger_result = {
    items_per_trigger = arg.per or 5,
    trigger = {
      action_delivery = {
        source_effects = {
          {
            affects_target = true,
            as_enemy = arg.as_enemy == nil or arg.as_enemy,
            entity_name = arg.to,
            find_non_colliding_position = true,
            offset_deviation = {{ -1, -1 }, { 1, 1 }},
            show_in_tooltip = true,
            type = "create-entity"
          }
        },
        type = "instant"
      },
      type = "direct"
    }
  }
end


-- arg.from          (string)  Item name to set to spoil
-- arg.time          (int)     Spoilage time in ticks
-- [arg.per=5]       (int)     Number of items needed to spoil per explosion
-- [arg.damage=100]  (int)     Area of effect damage
-- [arg.radius=3]    (float)   Area of effect radius
function make_item_spoil_into_explosion(arg)
  local item = data.raw.item[arg.from]
  item.spoil_ticks = arg.time
  item.spoil_to_trigger_result = {
    items_per_trigger = arg.per or 5,
    trigger = {
      {
        action_delivery = {
          target_effects = {
            {
              damage = {
                amount = arg.damage or 100,
                type = "explosion"
              },
              type = "damage"
            },
            {
              entity_name = "explosion",
              type = "create-entity"
            }
          },
          type = "instant"
        },
        radius = arg.radius or 3,
        type = "area"
      }
    }
  }
end


local seconds = 60  -- in ticks at 60 ups
local minutes = 60 * seconds
local hours   = 60 * minutes

make_item_spoil_into_entity{from="iron-ore",           to="small-demolisher",         time= 60 * minutes, per=100,        }
make_item_spoil_into_entity{from="iron-plate",         to="medium-demolisher",        time=120 * minutes, per=100,        }
make_item_spoil_into_entity{from="steel-plate",        to="big-demolisher",           time=180 * minutes, per=100,        }
make_item_spoil_into_entity{from="copper-ore",         to="big-strafer-pentapod",     time= 60 * minutes, per=50,         }
make_item_spoil_into_entity{from="copper-plate",       to="big-stomper-pentapod",     time=120 * minutes, per=50,         }
make_item_spoil_into_entity{from="copper-wire",        to="small-wriggler-pentapod",  time= 30 * minutes,                 }
make_item_spoil_into_entity{from="electronic-circuit", to="small-wriggler-pentapod",  time= 60 * minutes,                 }
make_item_spoil_into_entity{from="advanced-circuit",   to="medium-wriggler-pentapod", time= 60 * minutes,                 }
make_item_spoil_into_entity{from="processing-unit",    to="big-wriggler-pentapod",    time= 60 * minutes,                 }
make_item_spoil_into_entity{from="coal",               to="big-spitter",              time= 60 * minutes,                 }
make_item_spoil_into_entity{from="scrap",              to="construction-robot",       time= 12 * minutes, as_enemy=false, }

make_item_spoil_into_explosion{from="calcite", time=30 * seconds, per=16, damage=46, }

-- make_item_spoil_into_tile("stone",              60 * minutes, "hazard-concrete-left")

make_item_spoil_into_item{from="spoilage",                to="copper-bacteria",             time=10 * minutes, }
make_item_spoil_into_item{from="uranium-238",             to="fluoroketone-hot-barrel",     time=12 * hours,   }
make_item_spoil_into_item{from="uranium-235",             to="fluoroketone-hot-barrel",     time=15 * minutes, }
make_item_spoil_into_item{from="fluoroketone-hot-barrel", to="fluoroketone-cold-barrel",    time=60 * minutes, }
make_item_spoil_into_item{from="uranium-fuel-cell",       to="depleted-uranium-fuel-cell",  time= 3 * hours,   }
make_item_spoil_into_item{from="construction-robot",      to="logistic-robot",              time= 5 * minutes, }
make_item_spoil_into_item{from="logistic-robot",          to="construction-robot",          time= 2 * minutes, }
make_item_spoil_into_item{from="assembling-machine-1",    to="scrap",                       time=10 * minutes, }
make_item_spoil_into_item{from="assembling-machine-2",    to="scrap",                       time=20 * minutes, }
make_item_spoil_into_item{from="assembling-machine-3",    to="scrap",                       time=30 * minutes, }
make_item_spoil_into_item{from="chemical-plant",          to="scrap",                       time=20 * minutes, }
make_item_spoil_into_item{from="lab",                     to="personal-roboport-equipment", time=20 * minutes, }
