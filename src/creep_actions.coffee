#include util.coffee

closest_spawn = (creep) -> creep.pos.findNearest(Game.MY_SPAWNS)


return_to_closest_spawn = (creep) ->
  creep.moveTo(closest_spawn(creep))


harvest_closest_source = (creep) ->
  closest_source = creep.pos.findNearest(Game.SOURCES)
  creep.moveTo(closest_source)
  creep.harvest(closest_source)


attack_hostile = (creep, hostile, hostile_type) ->
  if hostile != null
    creep.memory.attacking = "#{hostile_type} at #{hostile.pos} of " +
      "#{hostile.owner.username}"
    creep.moveTo(hostile)
    creep.attack(hostile)
    return true


run_creep_actions = () ->
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
      hostile = creep.pos.findNearest(Game.HOSTILE_CREEPS)
      if attack_hostile(creep, hostile, "creep")
        continue
      hostile = creep.pos.findNearest(Game.HOSTILE_SPAWNS)
      if attack_hostile(creep, hostile, "spawn")
        continue
      delete creep.memory.attacking
    if creep.memory.role == 'harvester'
      if creep.energy >= creep.energyCapacity
        return_to_closest_spawn(creep)
        creep.transferEnergy(closest_spawn(creep))
      else
        harvest_closest_source(creep)
