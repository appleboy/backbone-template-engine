'use strict'

uuid = require 'uuid'
gulp = require 'gulp'
gutil = require 'gulp-util'
coffee = require 'gulp-coffee'
coffeelint = require 'gulp-coffeelint'
compass = require 'gulp-compass'
w3cjs = require 'gulp-w3cjs'
clean = require 'gulp-clean'
imagemin = require 'gulp-imagemin'
cache = require 'gulp-cache'
changed = require 'gulp-changed'
connect = require 'gulp-connect'
size = require 'gulp-size'
rjs = require 'requirejs'
gulpif = require 'gulp-if'
rename = require 'gulp-rename'
uglify = require 'gulp-uglify'
minifyCSS = require 'gulp-minify-css'
htmlmin = require 'gulp-htmlmin'
replace = require 'gulp-replace'
production = true if gutil.env.env is 'production'
filename = uuid.v4()

path =
  app: 'app/'
  js: 'app/assets/js/'
  coffee: 'app/assets/coffee/'
  sass: 'app/assets/sass/'
  css: 'app/assets/css/'

gulp.task 'coffee', ->
  gulp.src 'app/assets/coffee/**/*.coffee'
    .pipe changed 'app/assets/js/',
      extension: '.js'
    .pipe coffeelint()
    .pipe coffeelint.reporter()
    .pipe coffee bare: true
    .pipe gulp.dest 'app/assets/js/'
    .pipe size()
    .pipe connect.reload()

gulp.task 'test_coffee', ->
  gulp.src 'test/**/*.coffee'
    .pipe changed 'test/',
      extension: '.js'
    .pipe coffeelint()
    .pipe coffeelint.reporter()
    .pipe coffee bare: true
    .pipe gulp.dest 'test/'
    .pipe size()

gulp.task 'w3cjs', ->
  gulp.src 'app/*.html'
    .pipe changed 'dist'
    .pipe w3cjs()
    .pipe gulpif production, htmlmin(
      removeComments: true
      collapseWhitespace: true
    )
    .pipe gulpif production, replace 'js/main', 'js/' + filename
    .pipe gulpif production, replace 'vendor/requirejs/require.js', 'js/require.js'
    .pipe gulp.dest 'dist'
    .pipe size()
    .pipe connect.reload()

gulp.task 'compass', ->
  gulp.src 'app/assets/sass/**/*.scss'
    .pipe changed 'app/assets/css/',
      extension: '.css'
    .pipe compass
      css: 'app/assets/css'
      sass: 'app/assets/sass'
      image: 'app/assets/images'
    .on('error', ->)
    .pipe gulpif production, minifyCSS()
    .pipe gulp.dest 'dist/assets/css/'
    .pipe size()
    .pipe connect.reload()

gulp.task 'copy', ->
  gulp.src ['app/.htaccess', 'app/favicon.ico', 'app/robots.txt']
    .pipe gulp.dest 'dist/'

# Clean
gulp.task 'clean', ->
  gulp.src([
    'dist'
    '.sass-cache'
    'app/assets/js'
    'app/assets/css'
  ],
    read: false
  ).pipe clean()


# Images
gulp.task 'images', ->
  gulp.src 'app/assets/images/**/*'
    .pipe changed 'dist/assets/images'
    .pipe cache imagemin
      optimizationLevel: 3
      progressive: true
      interlaced: true
    .pipe gulp.dest 'dist/assets/images'
    .pipe connect.reload()

# Connect
gulp.task 'connect', ->
  connect.server
    root: ['app']
    port: 1337
    livereload: true

gulp.task 'watch', ['connect'], ->
  # Watch files and run tasks if they change
  gulp.watch 'app/assets/coffee/**/*.coffee', ['coffee']
  gulp.watch 'test/**/*.coffee', ['test_coffee']
  gulp.watch 'app/*.html', ['w3cjs']
  gulp.watch 'app/assets/sass/**/*.scss', ['compass']
  gulp.watch 'app/assets/images/**/*', ['images']
  true

# The default task (called when you run `gulp`)
gulp.task 'default', [
  'clean'
  'watch'
]

# Build
gulp.task 'build', [
  'coffee'
  'images'
  'compass'
  'w3cjs'
  'copy'
]

gulp.task 'rjs', ['build'], (cb) ->
  rjs.optimize
    baseUrl: "app/assets/js/"
    name: "main"
    out: "app/assets/js/main-built.js"
    mainConfigFile: "app/assets/js/main.js"
    preserveLicenseComments: false
    , (buildResponse) ->
      cb()

gulp.task 'rename', ['rjs'], ->
  gulp.src 'app/assets/js/main-built.js'
    .pipe rename 'assets/js/' + filename + '.js'
    .pipe gulp.dest 'dist'
  gulp.src 'app/assets/vendor/requirejs/require.js'
      .pipe uglify()
      .pipe gulp.dest 'dist/assets/js/'

gulp.task 'release', [
  'build'
  'rjs'
  'rename'
]
