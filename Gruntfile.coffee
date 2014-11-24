module.exports = (grunt) ->
  # Project configuration.
  grunt.initConfig
    coffee:
      compile:
        options:
          join: true
        files:
          'generated_bundle.js': [
            'src/base/*.coffee',
            'src/*/*.coffee',
            'src/main.coffee'
          ]

  # Load plugins
  grunt.loadNpmTasks 'grunt-contrib-coffee'

  # Tasks runners
  grunt.registerTask 'default', ['coffee']
