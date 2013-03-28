(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define(function(require) {
    var Backbone, Dispatcher, MapView;
    Backbone = require('backbone');
    Dispatcher = require('event');
    require('jhere');
    (function() {});
    return MapView = (function(_super) {

      __extends(MapView, _super);

      function MapView() {
        return MapView.__super__.constructor.apply(this, arguments);
      }

      MapView.prototype.initialize = function(opts) {
        Dispatcher.once("search:complete", this.displayMarker, this);
        Dispatcher.on("search:complete", this.centerMap, this);
        Dispatcher.on("station:selected", this.centerMap, this);
        return Dispatcher.on("station:hover", this.addBubbles, this);
      };

      MapView.prototype.addBubbles = function(station) {
        $("#map").jHERE('center', station.getPosition());
        return $("#map").jHERE('bubble', station.getPosition(), {
          content: station.get('name')
        });
      };

      MapView.prototype.centerMap = function(station) {
        return $("#map").jHERE('center', station.getPosition());
      };

      MapView.prototype.displayMarker = function(firstStation, stations) {
        var _this = this;
        stations.forEach(function(station) {
          return $("#map").jHERE('marker', station.getPosition(), {
            icon: 'img/steamtrain.png',
            anchor: {
              x: 12,
              y: 30
            },
            click: function(e) {
              return Dispatcher.trigger("station:selected", station);
            }
          });
        });
        return false;
      };

      MapView.prototype.render = function() {
        this.map = $("#map").jHERE({
          appId: "usgKT-xql56_vPTmD3Z5",
          authToken: "vR2pZ6q3EMnE3PX6fqt9uw"
        });
        return this;
      };

      return MapView;

    })(Backbone.View);
  });

}).call(this);
