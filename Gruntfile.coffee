module.exports = (grunt) ->

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
        handlebars:
            options:
                namespace: 'Handlebars.templates'
                processName: (filename) ->
                    return filename.replace(/assets\/templates\/(.*)\.handlebars$/i, '$1')
            compile:
                files:
                    'assets/templates/template.js': ['assets/templates/*.handlebars']
        connect:
            server:
                options:
                    port: 9001
                    base: '.'

    # Dependencies
    grunt.loadNpmTasks 'grunt-shell'
    grunt.loadNpmTasks 'grunt-contrib-connect'
    grunt.loadNpmTasks 'grunt-contrib-handlebars'

    grunt.registerTask 'default', ['shell', 'handlebars', 'connect:server']