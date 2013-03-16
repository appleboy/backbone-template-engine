module.exports = function(grunt) {
    grunt.loadNpmTasks('grunt-exec');

    grunt.initConfig({
        exec: {
            build: {
                command: 'node node_modules/requirejs/bin/r.js -o build/app.build.js'
            }
        }
    });

    grunt.registerTask('copy-output', function() {
        grunt.file.mkdir('output');
    });

    grunt.registerTask('default', ['exec', 'copy-output']);
};