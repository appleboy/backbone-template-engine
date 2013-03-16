module.exports = function(grunt) {
    grunt.initConfig({
    exec: {
        build: {
            command: 'node node_modules/requirejs/bin/r.js -o build/app.build.js'
        }
    }
    });

    grunt.loadNpmTasks('grunt-exec');

    grunt.registerTask('copy-output', function() {
        grunt.file.mkdir('output');
    });

    grunt.registerTask('default', ['copy-output']);
};