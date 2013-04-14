require.config({
  paths: {
    jquery: '../vendor/jquery/jquery',
    underscore: '../vendor/underscore-amd/underscore',
    backbone: '../vendor/backbone-amd/backbone',
    handlebars: '../vendor/handlebars/handlebars.runtime',
    modernizr: '../vendor/modernizr/modernizr',
    templates: '../templates/template'
  },
  shim: {
    'templates': {
      deps: ['handlebars']
    }
  },
  urlArgs: (new Date()).getTime()
});

require(['app'], function(App) {
  return App.initialize();
});
