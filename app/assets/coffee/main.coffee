# Filename: main.js
require.config
  paths:
    jquery: '../vendor/jquery/dist/jquery'
    underscore: '../vendor/underscore-amd/underscore'
    backbone: '../vendor/backbone-amd/backbone'
    handlebars: '../vendor/require-handlebars-plugin/Handlebars'
    modernizr: '../vendor/modernizr/modernizr'
    hbs: '../vendor/require-handlebars-plugin/hbs'
    i18nprecompile: '../vendor/require-handlebars-plugin/hbs/i18nprecompile'
    json2: '../vendor/require-handlebars-plugin/hbs/json2'

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
