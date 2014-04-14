define(["hbs/handlebars", "libs/format_money"], (Handlebars, format_money) ->
  Handlebars.registerHelper("format_money", (money, ho, dot, delimiter) ->
    format_money(money, ho, dot, delimiter)
  )
)
