// Generated by CoffeeScript 1.4.0

require.config({
  paths: {
    jquery: '../vendor/jquery/jquery',
    underscore: '../vendor/underscore-amd/underscore',
    backbone: '../vendor/backbone-amd/backbone'
  },
  urlArgs: (new Date()).getTime()
});

require(['app'], function(App) {
  return App.initialize();
});
