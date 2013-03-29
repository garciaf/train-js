(function() {

  define(["handlebars"], function(Handlebars) {
    var iconize;
    iconize = function(type, options) {
      var icon;
      icon = (function() {
        switch (type) {
          case "TER":
            return "ter";
          case "TGV":
            return "tgv";
          case "INTERCITES":
            return "intercités";
          case "BUS":
            return "bus";
          default:
            return type;
        }
      })();
      return icon;
    };
    Handlebars.registerHelper("iconize", iconize);
    return iconize;
  });

}).call(this);
