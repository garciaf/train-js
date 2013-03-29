(function() {

  define(["handlebars"], function(Handlebars) {
    var iconize;
    iconize = function(type, options) {
      var icon;
      icon = (function() {
        switch (type) {
          case "TER":
            return "<img src='/img/ter.png'>";
          case "TGV":
            return "<img src='/img/tgv.jpg'>";
          case "INTERCITES":
            return "<img src='/img/intercite.png'>";
          case "BUS":
            return "<img src='/img/bus.png'>";
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
