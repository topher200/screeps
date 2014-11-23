LOG = console.log

# Version is added by our build script, so we can get console output of changes
VERSION = "insert_version_here"
if Memory.version != VERSION
  LOG("New script version (#{VERSION})!")
  Memory.version = VERSION


