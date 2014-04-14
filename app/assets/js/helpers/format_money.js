define(function(require, exports, module) {
  var Handlebars, format_money, _selfPrefix;
  _selfPrefix = module.id;
  Handlebars = require('handlebars');
  format_money = require('libs/format_money');
  return Handlebars.registerHelper('format_money', function(money, ho, dot, delimiter) {
    return format_money(money, ho, dot, delimiter);
  });
});
