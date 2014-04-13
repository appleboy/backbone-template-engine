# Filename: main.js
require.config
  paths:
    jquery: '../vendor/jquery/dist/jquery'
    underscore: '../vendor/underscore-amd/underscore'
    backbone: '../vendor/backbone-amd/backbone'
    handlebars: '../vendor/handlebars/handlebars.runtime'
    modernizr: '../vendor/modernizr/modernizr'
    hbs: '../vendor/require-handlebars-plugin/hbs'

  hbs:
    helpers: true
    i18n: false
    templateExtension: 'hbs'
    partialsUrl: ''

  # for development
  urlArgs: (new Date()).getTime()

require ['app'], (App) ->
  App.initialize()
