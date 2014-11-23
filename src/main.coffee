#include creep_actions.coffee
#include spawner.coffee
#include util.coffee

for _, spawn of Game.spawns
  spawn_creep(spawn)

run_creep_actions()
