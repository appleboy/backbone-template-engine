# Filename: app.js
define [
  'jquery'
  'underscore'
  'backbone'
  'hbs!templates/index'
  'libs/format_money'
  'modernizr'
  'libs/console'
  ], ($, _, Backbone, template, format_money) ->
  initialize = ->
    data =
      title: 'Welcome to Backbone Template Engine'
      money: 556688
    $('h1#head').html(template(data))
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
