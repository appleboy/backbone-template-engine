# Filename: app.js
define [
    'jquery',
    'underscore',
    'backbone',
    'handlebars',
    'libs/console',
    '../templates/template'], ($, _, Backbone) ->
    initialize = ->
        data = {
            title: 'Welcome to Backbone Template Engine'
        }
        $('body').html(Handlebars.templates.index(data))
        console.info data.title

    initialize: initialize
