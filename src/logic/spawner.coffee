HARVESTER_ATTRIBUTES = [Game.MOVE, Game.CARRY, Game.WORK]
WARRIOR_ATTRIBUTES = [Game.TOUGH, Game.TOUGH, Game.ATTACK, Game.MOVE]
HEALER_ATTRIBUTES = [Game.TOUGH, Game.HEAL, Game.MOVE, Game.MOVE]


spawn_creep = (spawn) ->
  if spawn.spawning
    return

  creeps = spawn.room.find(Game.MY_CREEPS)
  if ((c for c in creeps when c.memory.role == HARVESTER).length < 2)
    LOG("Spawning harvester")
    spawn.createCreep(HARVESTER_ATTRIBUTES, null, {'role': HARVESTER})
    return
  if ((c for c in creeps when c.memory.role == WARRIOR).length == 0)
    LOG("Spawning warrior")
    spawn.createCreep(WARRIOR_ATTRIBUTES, null, {'role': WARRIOR})
    return
  if ((c for c in creeps when c.memory.role == HEALER).length == 0)
    LOG("Spawning healer")
    spawn.createCreep(HEALER_ATTRIBUTES, null, {'role': HEALER})
    return
  if (spawn.energy > (spawn.energyCapacity * .8))
    if ((c for c in creeps when c.memory.role == HARVESTER).length > 5)
      return
    LOG("Spawn current energy: #{spawn.energy}. Spawning harvester")
    spawn.createCreep(HARVESTER_ATTRIBUTES, null, {'role': HARVESTER})
    return
