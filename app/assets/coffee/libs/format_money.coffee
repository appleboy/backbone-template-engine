define (require, exports, module) ->
  # http://stackoverflow.com/questions/149055/how-can-i-format-numbers-as-money-in-javascript/149099#149099

  format_money = (money, ho, dot, delimiter) ->
    ho        = (if isNaN(ho = Math.abs(ho)) then 0 else ho)
    dot       = (if dot is undefined then "." else dot)
    delimiter = (if delimiter is undefined then "," else delimiter)
    minus     = (if money < 0 then "-" else "")
    money     = Math.abs(+money or 0).toFixed(ho)
    integer   = parseInt(money) + ""
    j         = (if (j = integer.length) > 3 then j % 3 else 0)

    return minus + ((if j then integer.substr(0, j) + delimiter else "")) +
      integer.substr(j).replace(/(\d{3})(?=\d)/g, "$1" + delimiter) +
      ((if ho then dot + Math.abs(money - integer).toFixed(ho).slice(2) else ""))

  format_money
