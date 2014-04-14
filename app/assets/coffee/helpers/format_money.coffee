define (require, exports, module) ->
  _selfPrefix = module.id
  Handlebars = require 'handlebars'
  format_money = require 'libs/format_money'
  Handlebars.registerHelper('format_money', (money, ho, dot, delimiter) ->
    format_money(money, ho, dot, delimiter)
  )
