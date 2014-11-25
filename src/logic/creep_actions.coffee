set_job = (creep, job) ->
  if creep.memory.job != job
    LOG(" job: #{creep.name} '#{job}' at #{creep.pos}")
  creep.memory.job = job


closest_spawn = (creep) -> creep.pos.findNearest(Game.MY_SPAWNS)


return_to_closest_spawn = (creep) ->
  creep.moveTo(closest_spawn(creep))


harvest_closest_source = (creep) ->
  closest_source = creep.pos.findNearest(Game.SOURCES)
  creep.moveTo(closest_source)
  creep.harvest(closest_source)


attack_hostile = (creep, hostile, hostile_type) ->
  if hostile != null
    set_job(creep, "attack #{hostile_type} #{hostile.id} at #{hostile.pos}")
    creep.moveTo(hostile)
    creep.attack(hostile)
    return true


attack_enemy = (creep) ->
  hostile = creep.pos.findNearest(Game.HOSTILE_CREEPS)
  return attack_hostile(creep, hostile, "creep")


attack_buildings = (creep) ->
  hostile = creep.pos.findNearest(Game.HOSTILE_SPAWNS)
  return attack_hostile(creep, hostile, "spawn")


chill_at_base =  (creep) ->
  return_to_closest_spawn(creep)


run_from_battle = (creep) ->
  # Run from battle when all our armor is gone
  if creep.getActiveBodyparts(Game.TOUGH) > 0
    return false
  set_job(creep, 'run from battle')
  # TODO
  chill_at_base(creep)
  return true


### Creep meta actions ###

do_nothing = (creep) ->
  return

### Warrior meta actions ###

smart_attack = (creep) ->
  if run_from_battle(creep)
    delete creep.memory.attacking
    return
  if attack_enemy(creep)
    return
  if attack_buildings(creep)
    return
  delete creep.memory.attacking
  return_to_base(creep)

no_attack = (creep) ->
  if run_from_battle(creep)
    return
  chill_at_base(creep)

### ###


# Different modes describe different creep actions
default_mode = {
  WARRIOR: smart_attack
}
pacifist = {
  WARRIOR: no_attack
}
statue = {
  CREEP: do_nothing
}

player_1 = default_mode
player_2 = default_mode
# sed replaced by build script
MODE = insert_mode_here


run_creep_actions = () ->
  for _, creep of Game.creeps
    # Is there a mode set for all creeps?
    if MODE.CREEP?
      MODE.CREEP(creep)
      continue

    if creep.getActiveBodyparts(Game.HEAL) > 0
      hurt_creeps = (c for _, c of Game.creeps when c != creep and
        c.hits < c.hitsMax)
      if hurt_creeps.length == 0
        creep.moveTo(closest_spawn(creep))
        continue
      creep_to_heal = hurt_creeps[0]
      set_job(creep, "healing #{creep_to_heal.name}")
      creep.moveTo(creep_to_heal)
      creep.heal(creep_to_heal)
      continue
    if creep.memory.role == WARRIOR
      MODE.WARRIOR(creep)
      continue
    if creep.memory.role == HARVESTER
      if creep.energy >= creep.energyCapacity
        return_to_closest_spawn(creep)
        creep.transferEnergy(closest_spawn(creep))
      else
        harvest_closest_source(creep)
