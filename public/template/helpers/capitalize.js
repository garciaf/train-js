(function() {

  define(["handlebars"], function(Handlebars) {
    var capitalize;
    capitalize = function(context, options) {
      var low;
      low = ("" + context).toLowerCase();
      return low.charAt(0).toUpperCase() + low.slice(1);
    };
    Handlebars.registerHelper("capitalize", capitalize);
    return capitalize;
  });

}).call(this);
