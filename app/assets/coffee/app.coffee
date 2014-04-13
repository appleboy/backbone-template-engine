# Filename: app.js
define [
  'jquery',
  'underscore',
  'backbone',
  'modernizr',
  'handlebars',
  'libs/console',
  'templates'], ($, _, Backbone) ->
  initialize = ->
    data = {
      title: 'Welcome to Backbone Template Engine'
    }
    $('h1#head').html(Handlebars.templates.index(data))
    console.info data.title
    if (Modernizr.canvas)
      console.info 'Your browser support canvas'
    else
      console.warn 'Your browser don\'t support canvas'
    if (Modernizr.touch)
      console.info 'Your device support touch event'
    else
      console.warn 'Your browser don\'t support canvas'
    null

  initialize: initialize
