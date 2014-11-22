LOG = console.log

WORKER_ATTRIBUTES = [Game.MOVE, Game.CARRY, Game.WORK]
WARRIOR_ATTRIBUTES = [Game.TOUGH, Game.TOUGH, Game.TOUGH, Game.ATTACK, Game.MOVE]
HEALER_ATTRIBUTES = [Game.TOUGH, Game.HEAL, Game.MOVE, Game.MOVE]


for _, spawn of Game.spawns
  if spawn.spawning
    continue

  creeps = spawn.room.find(Game.MY_CREEPS)
  if ((c for c in creeps when c.memory.role == 'harvester').length < 2)
    LOG("Spawning worker")
    spawn.createCreep(WORKER_ATTRIBUTES, null, {'role': 'harvester'})
    continue
  if ((c for c in creeps when c.memory.role == 'warrior').length == 0)
    LOG("Spawning warrior")
    spawn.createCreep(WARRIOR_ATTRIBUTES, null, {'role': 'warrior'})
    continue
  if ((c for c in creeps when c.memory.role == 'healer').length == 0)
    LOG("Spawning healer")
    spawn.createCreep(HEALER_ATTRIBUTES, null, {'role': 'healer'})
    continue
  if (spawn.energy > (spawn.energyCapacity * .8))
    if ((c for c in creeps when c.memory.role == 'harvester').length > 5)
      continue
    LOG("Spawn current energy: #{spawn.energy}. Spawning worker")
    spawn.createCreep(WORKER_ATTRIBUTES, null, {'role': 'harvester'})
    continue

closest_spawn = (creep) -> creep.pos.findNearest(Game.MY_SPAWNS)


return_to_closest_spawn = (creep) ->
  creep.moveTo(closest_spawn(creep))


harvest_closest_source = (creep) ->
  closest_source = creep.pos.findNearest(Game.SOURCES)
  creep.moveTo(closest_source)
  creep.harvest(closest_source)


for _, creep of Game.creeps
  if creep.getActiveBodyparts(Game.HEAL) > 0
    hurt_creeps = (c for _, c of Game.creeps when c.hits < c.hitsMax)
    if hurt_creeps.length == 0
      creep.moveTo(closest_spawn(creep))
      continue
    creep_to_heal = hurt_creeps[0]
    LOG("#{creep.name} healing #{creep_to_heal.name}")
    creep.moveTo(creep_to_heal)
    creep.heal(creep_to_heal)
    continue
  if creep.getActiveBodyparts(Game.ATTACK) > 0
    closest_hostile = creep.pos.findNearest(Game.HOSTILE_CREEPS)
    if closest_hostile != null
      LOG("#{creep.name} attacking creep of " +
          "'#{closest_hostile.owner.username}' at #{closest_hostile.pos}")
      creep.moveTo(closest_hostile)
      creep.attack(closest_hostile)
      continue
  if creep.memory.role == 'harvester'
    if creep.energy >= creep.energyCapacity
      return_to_closest_spawn(creep)
      creep.transferEnergy(closest_spawn(creep))
    else
      harvest_closest_source(creep)
