# Filename: main.js
require.config
    paths:
        jquery: '../vendor/jquery/jquery'
        underscore: '../vendor/underscore-amd/underscore'
        backbone: '../vendor/backbone-amd/backbone'
    # for development
    urlArgs: (new Date()).getTime()

require ['app'], (App) ->
    App.initialize()
