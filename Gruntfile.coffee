module.exports = (grunt) ->
    grunt.loadNpmTasks('grunt-shell')

    # Project configuration
    grunt.initConfig
        shell:
            init:
                command: 'test -d "assets/vendor" || bower install'
                options:
                    stdout: true
                    callback: (err, stdout, stderr, cb) ->
                        console.log('Install bower package compeletely.')
                        cb()
            template:
                command: 'handlebars assets/templates/*.handlebars -m -f assets/templates/template.js -k each -k if -k unless'
            build:
                command: 'node node_modules/requirejs/bin/r.js -o build/self.build.js'
                options:
                    stdout: true

    grunt.registerTask('default', ['shell'])