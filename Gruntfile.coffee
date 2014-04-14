uuid = require 'uuid'

module.exports = (grunt) ->
  newFilename = uuid.v4()

  project_config =
    app: 'app'
    dist: 'dist'

  # Project configuration
  grunt.initConfig
    pkg: project_config
    shell:
      bower:
        command: 'node node_modules/.bin/bower install'
        options:
          stdout: true
          stderr: true
          callback: (err, stdout, stderr, cb) ->
            console.log('Install bower package compeletely.')
            cb()
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
    bower:
      install:
        options:
          cleanup: false
          install: true
          verbose: true
          copy: false
      cleanup:
        options:
          cleanup: true
          verbose: true
          install: false
          copy: false
    requirejs:
      build:
        options:
          baseUrl: '<%= pkg.app %>/assets/js/'
          name: 'main'
          out: '<%= pkg.app %>/assets/js/main-built.js'
          mainConfigFile: '<%= pkg.app %>/assets/js/main.js'
          preserveLicenseComments: false
      release:
        options:
          ###
          support generate Source Maps, make sure requirejs version in 2.1.2
          optimize: 'uglify2'
          generateSourceMaps: true
          ###
          appDir: "<%= pkg.app %>/"
          baseUrl: "assets/js/"
          dir: "<%= pkg.dist %>"
          name: "main"
          mainConfigFile: '<%= pkg.app %>/assets/js/main.js'
          preserveLicenseComments: false
          fileExclusionRegExp: /^(\.|node_modules)/
    connect:
      server:
        options:
          base: '<%= pkg.app %>'
          hostname: '0.0.0.0'
          port: 4500
    watch:
      html:
        files: ['<%= pkg.app %>/*.{html,htm}']
        tasks: ['validation']
        options:
          livereload: true
      scss:
        files: ['<%= pkg.app %>/**/*.scss'],
        tasks: ['compass:dev']
      css:
        files: ['<%= pkg.app %>/**/*.css'],
        options:
          livereload: true
      js:
        files: '<%= pkg.app %>/**/*.js',
        options:
          livereload: true
      coffee:
        files: ['**/*.coffee', '!**/node_modules/**', '!**/vendor/**'],
        tasks: ['coffee']
      handlebars:
        files: '<%= pkg.app %>/**/*.handlebars',
        tasks: ['handlebars']
        options:
          livereload: true

    coffeelint:
      options:
        'force': true
        'no_trailing_whitespace':
          'level': 'error'
        'max_line_length':
          'level': 'ignore'
        'indentation':
          'value': 2
          'level': 'error'
      dev: ['**/*.coffee', '!**/node_modules/**', '!**/vendor/**']

    compass:
      dev:
        options:
          ###
          Load config from config.rb file
          basePath: '<%= pkg.app %>/assets'
          config: 'config.rb'
          ###
          sassDir: '<%= pkg.app %>/assets/sass'
          cssDir: '<%= pkg.app %>/assets/css'
          imagesDir: '<%= pkg.app %>/assets/images'
          javascriptsDir: '<%= pkg.app %>/assets/js'
          outputStyle: 'nested'
          relativeAssets: true
          noLineComments: true
          debugInfo: false
          environment: 'development'
      release:
        options:
          force: true
          sassDir: '<%= pkg.dist %>/assets/sass'
          cssDir: '<%= pkg.dist %>/assets/css'
          imagesDir: '<%= pkg.dist %>/assets/images'
          javascriptsDir: '<%= pkg.dist %>/assets/js'
          outputStyle: 'compressed'
          relativeAssets: true
          noLineComments: true
          environment: 'production'
    cssmin:
      release:
        report: 'gzip'
        expand: true
        cwd: '<%= pkg.dist %>/assets/css'
        src: ['*.css']
        dest: '<%= pkg.dist %>/assets/css'
    coffee:
      app:
        expand: true,
        cwd: '<%= pkg.app %>/assets/coffee/',
        src: ['**/*.coffee'],
        dest: '<%= pkg.app %>/assets/js/',
        ext: '.js'
        options:
          bare: true
      server:
        files:
          'build/server.js': 'build/server.coffee'
      test:
        files:
          'test/test.js': 'test/test.coffee'
    clean:
      options:
        force: true
      js: '<%= pkg.dist %>/assets/js'
      release: [
        '<%= pkg.dist %>/build.txt'
        '<%= pkg.dist %>/assets/coffee'
        '<%= pkg.dist %>/assets/sass'
        '<%= pkg.dist %>/assets/vendor'
        '<%= pkg.dist %>/assets/templates'
      ]
      cleanup: [
        '<%= pkg.dist %>'
        '<%= pkg.app %>/assets/vendor'
        '<%= pkg.app %>/assets/js/main-built.js'
        '<%= pkg.app %>/assets/js/main-built.js.map'
        '<%= pkg.app %>/assets/js/main-built.js.src'
      ]
    copy:
      release:
        files: [
          {src: '<%= pkg.app %>/.htaccess', dest: '<%= pkg.dist %>/.htaccess'}
          {src: '<%= pkg.dist %>/assets/vendor/requirejs/require.js', dest: '<%= pkg.dist %>/assets/js/require.js'}
          {src: '<%= pkg.app %>/assets/js/main-built.js', dest: '<%= pkg.dist %>/assets/js/' + newFilename + '.js'}
        ]
    replace:
      release:
        src: '<%= pkg.dist %>/index.html'
        dest: '<%= pkg.dist %>/index.html'
        replacements: [
          {
            from: 'js/main'
            to: 'js/' + newFilename
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
      index:
        files:
          '<%= pkg.dist %>/index.html': '<%= pkg.app %>/index.html'

    validation:
      files:
        src: ['<%= pkg.app %>/*.html']

  grunt.event.on 'watch', (action, filepath) ->
    grunt.log.writeln filepath + ' has ' + action

  grunt.registerTask 'init', () ->
    grunt.log.writeln 'Initial project'
    (grunt.file.exists project_config.app + '/assets/vendor') || grunt.task.run 'bower:install'

  grunt.registerTask 'release', () ->
    grunt.log.writeln 'deploy project'
    (grunt.file.exists project_config.app + '/assets/vendor') || grunt.task.run 'bower:install'
    grunt.task.run ['compass:dev', 'coffee:app', 'requirejs:build', 'requirejs:release', 'cssmin:release', 'clean:js']
    grunt.file.mkdir project_config.dist + '/assets/js'
    grunt.task.run 'copy:release'
    grunt.task.run 'htmlmin:index'
    grunt.task.run 'replace:release'
    grunt.task.run 'clean:release'

  # Dependencies
  grunt.loadNpmTasks 'grunt-shell'
  grunt.loadNpmTasks 'grunt-contrib-connect'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-contrib-compass'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-copy'
  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-text-replace'
  grunt.loadNpmTasks 'grunt-contrib-htmlmin'
  grunt.loadNpmTasks 'grunt-requirejs'
  grunt.loadNpmTasks 'grunt-bower-task'
  grunt.loadNpmTasks 'grunt-contrib-cssmin'
  grunt.loadNpmTasks 'grunt-coffeelint'
  grunt.loadNpmTasks 'grunt-html-validation'

  grunt.registerTask 'default', ['init', 'connect', 'compass:dev', 'watch']
