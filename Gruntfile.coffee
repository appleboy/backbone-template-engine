module.exports = (grunt) ->

    # Project configuration
    grunt.initConfig
        shell:
            bower:
                command: 'node node_modules/.bin/bower install'
                options:
                    stdout: true
                    callback: (err, stdout, stderr, cb) ->
                        console.log('Install bower package compeletely.')
                        cb()
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
        uglify:
            template:
                files:
                    'assets/templates/template.js': ['assets/templates/template.js']
        connect:
            livereload:
                options:
                    hostname: '0.0.0.0'
                    port: 9001
                    base: '.'
        regarde:
            js:
                files: '**/*.js',
                tasks: ['livereload']
            handlebars:
                files: '**/*.handlebars',
                tasks: ['handlebars', 'livereload']

    grunt.event.on 'watch', (action, filepath) ->
        grunt.log.writeln filepath + ' has ' + action

    grunt.registerTask 'init', () ->
        grunt.log.writeln('Initial project');
        grunt.file.exists('assets/vendor') || grunt.task.run('shell:bower')

    # Dependencies
    grunt.loadNpmTasks 'grunt-regarde'
    grunt.loadNpmTasks 'grunt-shell'
    grunt.loadNpmTasks 'grunt-contrib-connect'
    grunt.loadNpmTasks 'grunt-contrib-handlebars'
    grunt.loadNpmTasks 'grunt-contrib-uglify'
    grunt.loadNpmTasks 'grunt-contrib-livereload'

    grunt.registerTask 'default', ['init', 'handlebars', 'uglify', 'shell:build', 'livereload-start', 'connect', 'regarde']