module.exports = function(grunt) {
    grunt.loadNpmTasks('grunt-exec');
    grunt.loadNpmTasks('grunt-shell');

    grunt.initConfig({
        exec: {
            build: {
                command: 'node node_modules/requirejs/bin/r.js -o build/self.build.js'
            }
        },
        shell: {
            init: {
                command: 'test -d "assets/vendor" || bower install',
                options: {
                    stdout: true,
                    callback: function (err, stdout, stderr, cb) {
                        console.log('Install bower package compeletely.');
                        cb();
                    }
                }
            },
            template: {
                command: 'handlebars assets/templates/*.handlebars -m -f assets/templates/template.js -k each -k if -k unless'
            }
        }
    });

    grunt.registerTask('default', ['shell', 'exec']);
};