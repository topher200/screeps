WORKER_ATTRIBUTES = [Game.MOVE, Game.CARRY, Game.WORK]
WARRIOR_ATTRIBUTES = [Game.TOUGH, Game.TOUGH, Game.TOUGH, Game.ATTACK, Game.MOVE]
HEALER_ATTRIBUTES = [Game.TOUGH, Game.HEAL, Game.MOVE, Game.MOVE]


spawn_creep = (spawn) ->
  if spawn.spawning
    return

  creeps = spawn.room.find(Game.MY_CREEPS)
  if ((c for c in creeps when c.memory.role == 'harvester').length < 2)
    LOG("Spawning worker")
    spawn.createCreep(WORKER_ATTRIBUTES, null, {'role': 'harvester'})
    return
  if ((c for c in creeps when c.memory.role == 'warrior').length == 0)
    LOG("Spawning warrior")
    spawn.createCreep(WARRIOR_ATTRIBUTES, null, {'role': 'warrior'})
    return
  if ((c for c in creeps when c.memory.role == 'healer').length == 0)
    LOG("Spawning healer")
    spawn.createCreep(HEALER_ATTRIBUTES, null, {'role': 'healer'})
    return
  if (spawn.energy > (spawn.energyCapacity * .8))
    if ((c for c in creeps when c.memory.role == 'harvester').length > 5)
      return
    LOG("Spawn current energy: #{spawn.energy}. Spawning worker")
    spawn.createCreep(WORKER_ATTRIBUTES, null, {'role': 'harvester'})
    return
