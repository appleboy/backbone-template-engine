module.exports = function(grunt) {
  var filetime, project_config;
  filetime = Date.now();
  project_config = {
    app: 'app',
    output: 'output'
  };
  grunt.initConfig({
    pkg: project_config,
    shell: {
      bower: {
        command: 'node node_modules/.bin/bower install',
        options: {
          stdout: true,
          stderr: true,
          callback: function(err, stdout, stderr, cb) {
            console.log('Install bower package compeletely.');
            return cb();
          }
        }
      },
      template: {
        command: 'node node_modules/.bin/handlebars <%= pkg.app %>/assets/tmp/*.handlebars -m -f <%= pkg.app %>/assets/templates/template.js -k each -k if -k unless',
        options: {
          stdout: true,
          stderr: true
        }
      },
      build: {
        command: 'node node_modules/requirejs/bin/r.js -o build/self.build.js',
        options: {
          stdout: true,
          stderr: true
        }
      },
      release: {
        command: 'node node_modules/requirejs/bin/r.js -o build/app.build.js',
        options: {
          stdout: true,
          stderr: true
        }
      }
    },
    bower: {
      install: {
        options: {
          cleanup: false,
          install: true,
          verbose: true,
          copy: false
        }
      },
      cleanup: {
        options: {
          cleanup: true,
          verbose: true,
          install: false,
          copy: false
        }
      }
    },
    requirejs: {
      build: {
        options: {
          baseUrl: '<%= pkg.app %>/assets/js/',
          name: 'main',
          out: '<%= pkg.app %>/assets/js/main-built.js',
          mainConfigFile: '<%= pkg.app %>/assets/js/main.js',
          preserveLicenseComments: false
        }
      },
      release: {
        options: {
          /*
          support generate Source Maps, make sure requirejs version in 2.1.2
          optimize: 'uglify2'
          generateSourceMaps: true
          */

          appDir: "<%= pkg.app %>/",
          baseUrl: "assets/js/",
          dir: "<%= pkg.output %>",
          name: "main",
          mainConfigFile: '<%= pkg.app %>/assets/js/main.js',
          preserveLicenseComments: false,
          fileExclusionRegExp: /^(\.|node_modules)/
        }
      }
    },
    handlebars: {
      options: {
        namespace: 'Handlebars.templates',
        processName: function(filename) {
          return filename.replace(/.*\/(.*)\.handlebars$/i, '$1');
        }
      },
      compile: {
        files: {
          '<%= pkg.app %>/assets/templates/template.js': ['<%= pkg.app %>/assets/templates/*.handlebars']
        }
      }
    },
    connect: {
      livereload: {
        options: {
          hostname: '0.0.0.0',
          port: 3000,
          base: '.'
        }
      }
    },
    regarde: {
      html: {
        files: ['<%= pkg.app %>/**/*.{html,htm}'],
        tasks: ['livereload'],
        events: true
      },
      scss: {
        files: ['<%= pkg.app %>/**/*.scss'],
        tasks: ['compass:dev'],
        events: true
      },
      css: {
        files: ['<%= pkg.app %>/**/*.css'],
        tasks: ['livereload'],
        events: true
      },
      js: {
        files: '<%= pkg.app %>/**/*.js',
        tasks: ['livereload'],
        events: true
      },
      coffee: {
        files: ['**/*.coffee', '!**/node_modules/**', '!**/vendor/**'],
        tasks: ['coffeelint', 'coffee'],
        events: true
      },
      handlebars: {
        files: '<%= pkg.app %>/**/*.handlebars',
        tasks: ['handlebars', 'livereload'],
        events: true
      }
    },
    coffeelint: {
      options: {
        'force': true,
        'no_trailing_whitespace': {
          'level': 'error'
        },
        'max_line_length': {
          'level': 'ignore'
        },
        'indentation': {
          'value': 4,
          'level': 'error'
        }
      },
      dev: ['**/*.coffee', '!**/node_modules/**', '!**/vendor/**']
    },
    compass: {
      dev: {
        options: {
          /*
          Load config from config.rb file
          basePath: '<%= pkg.app %>/assets'
          config: 'config.rb'
          */

          sassDir: '<%= pkg.app %>/assets/sass',
          cssDir: '<%= pkg.app %>/assets/css',
          imagesDir: '<%= pkg.app %>/assets/images',
          javascriptsDir: '<%= pkg.app %>/assets/js',
          outputStyle: 'nested',
          relativeAssets: true,
          noLineComments: true,
          environment: 'development'
        }
      },
      release: {
        options: {
          force: true,
          sassDir: '<%= pkg.output %>/assets/sass',
          cssDir: '<%= pkg.output %>/assets/css',
          imagesDir: '<%= pkg.output %>/assets/images',
          javascriptsDir: '<%= pkg.output %>/assets/js',
          outputStyle: 'compressed',
          relativeAssets: true,
          noLineComments: true,
          environment: 'production'
        }
      }
    },
    cssmin: {
      release: {
        report: 'gzip',
        expand: true,
        cwd: '<%= pkg.output %>/assets/css',
        src: ['*.css'],
        dest: '<%= pkg.output %>/assets/css'
      }
    },
    coffee: {
      app: {
        expand: true,
        cwd: '<%= pkg.app %>/assets/coffeescript/',
        src: ['**/*.coffee'],
        dest: '<%= pkg.app %>/assets/js/',
        ext: '.js',
        options: {
          bare: true
        }
      },
      grunt: {
        files: {
          'Gruntfile.js': 'Gruntfile.coffee'
        },
        options: {
          bare: true
        }
      },
      server: {
        files: {
          'build/server.js': 'build/server.coffee'
        }
      },
      test: {
        files: {
          'test/test.js': 'test/test.coffee'
        }
      }
    },
    clean: {
      options: {
        force: true
      },
      js: '<%= pkg.output %>/assets/js',
      release: ['<%= pkg.output %>/build.txt', '<%= pkg.output %>/assets/coffeescript', '<%= pkg.output %>/assets/sass', '<%= pkg.output %>/assets/config.rb', '<%= pkg.output %>/assets/vendor', '<%= pkg.output %>/assets/templates', '<%= pkg.output %>/assets/tmp'],
      cleanup: ['<%= pkg.output %>', '<%= pkg.app %>/assets/vendor', '<%= pkg.app %>/assets/templates/template.js', '<%= pkg.app %>/assets/js/main-built.js', '<%= pkg.app %>/assets/js/main-built.js.map', '<%= pkg.app %>/assets/js/main-built.js.src', 'node_modules']
    },
    copy: {
      release: {
        files: [
          {
            src: '<%= pkg.app %>/.htaccess',
            dest: '<%= pkg.output %>/.htaccess'
          }, {
            src: '<%= pkg.output %>/assets/vendor/requirejs/require.js',
            dest: '<%= pkg.output %>/assets/js/require.js'
          }, {
            src: '<%= pkg.app %>/assets/js/main-built.js',
            dest: '<%= pkg.output %>/assets/js/' + filetime + '.js'
          }
        ]
      }
    },
    replace: {
      release: {
        src: '<%= pkg.output %>/index.html',
        dest: '<%= pkg.output %>/index.html',
        replacements: [
          {
            from: 'js/main',
            to: 'js/' + filetime
          }, {
            from: 'vendor/requirejs/',
            to: 'js/'
          }
        ]
      }
    },
    htmlmin: {
      options: {
        removeComments: true,
        collapseWhitespace: true
      },
      dev: {
        expand: true,
        cwd: '<%= pkg.app %>/assets/templates/',
        src: ['**/*.handlebars'],
        dest: '<%= pkg.app %>/assets/tmp',
        ext: '.handlebars'
      },
      index: {
        files: {
          '<%= pkg.output %>/index.html': '<%= pkg.app %>/index.html'
        }
      }
    }
  });
  grunt.event.on('watch', function(action, filepath) {
    return grunt.log.writeln(filepath + ' has ' + action);
  });
  grunt.event.on('regarde:file', function(status, name, filepath, tasks, spawn) {
    return grunt.log.writeln('File ' + filepath + ' ' + status + '. Tasks: ' + tasks);
  });
  grunt.registerTask('init', function() {
    grunt.log.writeln('Initial project');
    return (grunt.file.exists(project_config.app + '/assets/vendor')) || grunt.task.run('bower:install');
  });
  grunt.registerTask('minify_template', function() {
    grunt.log.writeln('minify handlebars templates.');
    return grunt.task.run(['htmlmin:dev', 'shell:template']);
  });
  grunt.registerTask('release', function() {
    grunt.log.writeln('deploy project');
    (grunt.file.exists(project_config.app + '/assets/vendor')) || grunt.task.run('bower:install');
    grunt.task.run('minify_template');
    grunt.task.run(['requirejs:build', 'requirejs:release', 'cssmin:release', 'clean:js']);
    grunt.file.mkdir(project_config.output + '/assets/js');
    grunt.task.run('copy:release');
    grunt.task.run('htmlmin:index');
    grunt.task.run('replace:release');
    return grunt.task.run('clean:release');
  });
  grunt.loadNpmTasks('grunt-regarde');
  grunt.loadNpmTasks('grunt-shell');
  grunt.loadNpmTasks('grunt-contrib-connect');
  grunt.loadNpmTasks('grunt-contrib-handlebars');
  grunt.loadNpmTasks('grunt-contrib-livereload');
  grunt.loadNpmTasks('grunt-contrib-compass');
  grunt.loadNpmTasks('grunt-contrib-coffee');
  grunt.loadNpmTasks('grunt-contrib-copy');
  grunt.loadNpmTasks('grunt-contrib-clean');
  grunt.loadNpmTasks('grunt-text-replace');
  grunt.loadNpmTasks('grunt-contrib-htmlmin');
  grunt.loadNpmTasks('grunt-requirejs');
  grunt.loadNpmTasks('grunt-bower-task');
  grunt.loadNpmTasks('grunt-contrib-cssmin');
  grunt.loadNpmTasks('grunt-coffeelint');
  return grunt.registerTask('default', ['init', 'handlebars', 'livereload-start', 'connect', 'regarde']);
};
