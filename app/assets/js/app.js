define(['jquery', 'underscore', 'backbone', 'hbs!../templates/index', 'modernizr', 'handlebars', 'libs/console'], function($, _, Backbone, template) {
  var initialize;
  initialize = function() {
    var data;
    data = {
      title: 'Welcome to Backbone Template Engine'
    };
    $('h1#head').html(template(data));
    if (Modernizr.canvas) {
      console.info('Your browser support canvas');
    } else {
      console.warn('Your browser don\'t support canvas');
    }
    if (Modernizr.touch) {
      console.info('Your device support touch event');
    } else {
      console.warn('Your browser don\'t support canvas');
    }
    return null;
  };
  return {
    initialize: initialize
  };
});
