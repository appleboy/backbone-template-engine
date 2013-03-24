module.exports = (grunt) ->
    # build time
    filetime = Date.now();

    project_config =
        app: 'app'
        output: 'output'

    # Project configuration
    grunt.initConfig
        backbone: project_config
        shell:
            bower:
                command: 'node node_modules/.bin/bower install'
                options:
                    stdout: true
                    stderr: true
                    callback: (err, stdout, stderr, cb) ->
                        console.log('Install bower package compeletely.')
                        cb()
            template:
                command: 'node node_modules/.bin/handlebars <%= backbone.app %>/assets/tmp/*.handlebars -m -f <%= backbone.app %>/assets/templates/template.js -k each -k if -k unless'
                options:
                    stdout: true
                    stderr: true
            build:
                command: 'node node_modules/requirejs/bin/r.js -o build/self.build.js'
                options:
                    stdout: true
                    stderr: true
            release:
                command: 'node node_modules/requirejs/bin/r.js -o build/app.build.js'
                options:
                    stdout: true
                    stderr: true
        handlebars:
            options:
                namespace: 'Handlebars.templates'
                processName: (filename) ->
                    return filename.replace(/<%= backbone.app %>\/assets\/templates\/(.*)\.handlebars$/i, '$1')
            compile:
                files:
                    '<%= backbone.app %>/assets/templates/template.js': ['<%= backbone.app %>/assets/templates/*.handlebars']
        connect:
            livereload:
                options:
                    port: 9001
                    base: '.'
        regarde:
            html:
                files: ['<%= backbone.app %>/**/*.html', '<%= backbone.app %>/**/*.htm']
                tasks: ['livereload']
                events: true
            scss:
                files: ['<%= backbone.app %>/**/*.scss'],
                tasks: ['compass:dev']
                events: true
            css:
                files: ['<%= backbone.app %>/**/*.css'],
                tasks: ['livereload']
                events: true
            js:
                files: '<%= backbone.app %>/**/*.js',
                tasks: ['livereload']
                events: true
            coffee:
                files: '**/*.coffee',
                tasks: ['coffee']
                events: true
            handlebars:
                files: '<%= backbone.app %>/**/*.handlebars',
                tasks: ['handlebars', 'livereload']
                events: true
        compass:
            dev:
                options:
                    basePath: '<%= backbone.app %>/assets'
                    config: '<%= backbone.app %>/assets/config.rb'
            release:
                options:
                    force: true
                    basePath: '<%= backbone.output %>/assets'
                    config: '<%= backbone.output %>/assets/config.rb'
                    outputStyle: 'compressed'
                    environment: 'production'
        coffee:
            app:
                expand: true,
                cwd: '<%= backbone.app %>/assets/coffeescript/',
                src: ['**/*.coffee'],
                dest: '<%= backbone.app %>/assets/js/',
                ext: '.js'
                options:
                    bare: true
            grunt:
                files:
                    'Gruntfile.js': 'Gruntfile.coffee'
                options:
                    bare: true
        clean:
            options:
                force: true
            js: '<%= backbone.output %>/assets/js'
            release: [
                '<%= backbone.output %>/build.txt'
                '<%= backbone.output %>/assets/coffeescript'
                '<%= backbone.output %>/assets/sass'
                '<%= backbone.output %>/assets/config.rb'
                '<%= backbone.output %>/assets/vendor'
                '<%= backbone.output %>/assets/templates'
                '<%= backbone.app %>/assets/tmp'
            ]
            cleanup: [
                '<%= backbone.output %>'
                '<%= backbone.app %>/assets/vendor'
                '<%= backbone.app %>/assets/templates/template.js'
                '<%= backbone.app %>/assets/js/main-built.js'
                '<%= backbone.app %>/assets/js/main-built.js.map'
                '<%= backbone.app %>/assets/js/main-built.js.src'
                'node_modules'
            ]
        copy:
            release:
                files: [
                    {src: '<%= backbone.app %>/.htaccess', dest: '<%= backbone.output %>/.htaccess'}
                    {src: '<%= backbone.output %>/assets/vendor/requirejs/require.js', dest: '<%= backbone.output %>/assets/js/require.js'}
                    {src: '<%= backbone.app %>/assets/js/main-built.js', dest: '<%= backbone.output %>/assets/js/' + filetime + '.js'}
                ]
        replace:
            release:
                src: '<%= backbone.output %>/index.html'
                dest: '<%= backbone.output %>/index.html'
                replacements: [
                    {
                        from: 'js/main'
                        to: 'js/' + filetime
                    },
                    {
                        from: 'vendor/requirejs/'
                        to: 'js/'
                    }
                ]
        htmlmin:
            options:
                removeComments: true
                collapseWhitespace: true
            dev:
                expand: true,
                cwd: '<%= backbone.app %>/assets/templates/',
                src: ['**/*.handlebars'],
                dest: '<%= backbone.app %>/assets/tmp',
                ext: '.handlebars'
            index:
                files:
                    '<%= backbone.output %>/index.html': '<%= backbone.app %>/index.html'

    grunt.event.on 'watch', (action, filepath) ->
        grunt.log.writeln filepath + ' has ' + action

    grunt.event.on 'regarde:file', (status, name, filepath, tasks, spawn) ->
        grunt.log.writeln 'File ' + filepath + ' ' + status + '. Tasks: ' + tasks

    grunt.registerTask 'init', () ->
        grunt.log.writeln 'Initial project'
        (grunt.file.exists project_config.app + '/assets/vendor') || grunt.task.run 'shell:bower'

    grunt.registerTask 'minify_template', () ->
        grunt.log.writeln 'minify handlebars templates.'
        grunt.task.run ['htmlmin:dev', 'shell:template']

    grunt.registerTask 'release', () ->
        grunt.log.writeln 'deploy project'
        (grunt.file.exists project_config.app + '/assets/vendor') || grunt.task.run 'shell:bower'
        # minify all handlebar template files.
        grunt.task.run 'minify_template'
        grunt.task.run ['shell:build', 'shell:release', 'compass:release', 'clean:js']
        grunt.file.mkdir project_config.output + '/assets/js'
        grunt.task.run 'copy:release'
        grunt.task.run 'htmlmin:index'
        grunt.task.run 'replace:release'
        grunt.task.run 'clean:release'

    # Dependencies
    grunt.loadNpmTasks 'grunt-regarde'
    grunt.loadNpmTasks 'grunt-shell'
    grunt.loadNpmTasks 'grunt-contrib-connect'
    grunt.loadNpmTasks 'grunt-contrib-handlebars'
    grunt.loadNpmTasks 'grunt-contrib-livereload'
    grunt.loadNpmTasks 'grunt-contrib-compass'
    grunt.loadNpmTasks 'grunt-contrib-coffee'
    grunt.loadNpmTasks 'grunt-contrib-copy'
    grunt.loadNpmTasks 'grunt-contrib-clean'
    grunt.loadNpmTasks 'grunt-text-replace'
    grunt.loadNpmTasks 'grunt-contrib-htmlmin'

    grunt.registerTask 'default', ['init', 'handlebars', 'livereload-start', 'connect', 'regarde']