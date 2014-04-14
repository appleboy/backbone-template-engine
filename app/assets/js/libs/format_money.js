define(function(require, exports, module) {
  var format_money;
  format_money = function(money, ho, dot, delimiter) {
    var integer, j, minus;
    ho = (isNaN(ho = Math.abs(ho)) ? 0 : ho);
    dot = (dot === undefined ? "." : dot);
    delimiter = (delimiter === undefined ? "," : delimiter);
    minus = (money < 0 ? "-" : "");
    money = Math.abs(+money || 0).toFixed(ho);
    integer = parseInt(money) + "";
    j = ((j = integer.length) > 3 ? j % 3 : 0);
    return minus + (j ? integer.substr(0, j) + delimiter : "") + integer.substr(j).replace(/(\d{3})(?=\d)/g, "$1" + delimiter) + (ho ? dot + Math.abs(money - integer).toFixed(ho).slice(2) : "");
  };
  return format_money;
});
