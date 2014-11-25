module.exports = (grunt) ->
  # Project configuration.
  grunt.initConfig({
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
    'string-replace':
      dist:
        files:
          'generated_bundle.js': 'generated_bundle.js'
        options:
          replacements: [
            {
              pattern: "insert_version_here"
              replacement: Date.now()
            }, {
              pattern: "insert_mode_here"
              replacement: "<%= mode %>"
            }
          ],
  })

  # Load plugins
  grunt.loadNpmTasks('grunt-contrib-coffee')
  grunt.loadNpmTasks('grunt-string-replace')

  # Tasks runners
  grunt.registerTask('default', "Takes a --mode to set behavior", do () ->
    mode = grunt.option('mode') ? "player_1"
    grunt.config.set('mode', mode)
    ['coffee', 'string-replace']
  )
