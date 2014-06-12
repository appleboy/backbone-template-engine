define (require, exports, module) ->

  format_money = (number) ->
    Math.abs(number).toString().replace(/(\d)(?=(\d\d\d)+(?!\d))/g, "$1,")

  format_money
