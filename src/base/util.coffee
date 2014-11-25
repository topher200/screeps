LOG = console.log

# Version is added by our build script, so we can get console output of changes
VERSION = "insert_version_here"
if Memory.version != VERSION
  LOG("New script version (#{VERSION})!")
  Memory.version = VERSION


# Garbage collect any memory of entities that have expired
clear_named_entities = (entity_type) ->
  for entity of Memory[entity_type]
    if not Game[entity_type][entity]
      delete Memory[entity_type][entity]
(clear_named_entities(e) for e in ["creeps", "spawns"])


# Different modes describe different creep actions
default_mode = {
  warrior: smart_attack
}
pacifist = {
  warrior: no_attack
}
statue = {
  creeps: do_nothing
}
player_1 = default_mode
player_2 = pacifist
# sed replaced by build script
MODE = insert_mode_here
