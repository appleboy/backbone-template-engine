# Filename: main.js
require.config
  paths:
    jquery: '../vendor/jquery/dist/jquery'
    underscore: '../vendor/underscore-amd/underscore'
    backbone: '../vendor/backbone-amd/backbone'
    modernizr: '../vendor/modernizr/modernizr'
    hbs: '../vendor/require-handlebars-plugin/hbs'

  pragmasOnSave:
    excludeHbsParser : true,
    excludeHbs: true,
    excludeAfterBuild: true

  hbs:
    helpers: true
    i18n: false
    templateExtension: 'hbs'
    partialsUrl: ''
    helperDirectory: 'helpers/'
    disableI18n: true

  # for development
  urlArgs: (new Date()).getTime()

require ['app'], (App) ->
  App.initialize()
