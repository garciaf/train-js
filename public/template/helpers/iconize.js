(function() {

  define(["handlebars"], function(Handlebars) {
    var iconize;
    iconize = function(type, options) {
      var icon;
      icon = (function() {
        switch (type) {
          case "TER":
            return "<i class='icons-ter'></i>";
          case "TGV":
            return "<i class='icons-tgv'></i>";
          case "INTERCITES":
            return "<i class='icons-intercite'></i>";
          case "BUS":
            return "<i class='icons-bus'></i>";
          case "IDTGV":
            return "<i class='icons-idtgv'></i>";
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
