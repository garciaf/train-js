(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define(function(require) {
    var AppView, Backbone, InfoView, MapStationView, Router;
    Backbone = require('backbone');
    AppView = require('views/misc/app');
    MapStationView = require('views/MapStationView');
    InfoView = require('views/InfoView');
    (function() {});
    return Router = (function(_super) {

      __extends(Router, _super);

      function Router() {
        return Router.__super__.constructor.apply(this, arguments);
      }

      Router.prototype.routes = {
        "arrivals": "arrival",
        "departure": "departure",
        "map": "map",
        "*actions": "map"
      };

      Router.prototype.home = function() {};

      Router.prototype.arrival = function() {
        this.arrivalInfoView.show();
        this.departureInfoView.hide();
        return this.mapView.hide();
      };

      Router.prototype.departure = function() {
        this.departureInfoView.show();
        this.arrivalInfoView.hide();
        return this.mapView.hide();
      };

      Router.prototype.map = function() {
        this.mapView.show();
        this.departureInfoView.hide();
        return this.arrivalInfoView.hide();
      };

      Router.prototype.initialize = function() {
        var enablePushState, pushState;
        this.mapView = new MapStationView();
        this.departureInfoView = new InfoView({
          type: "D"
        });
        this.arrivalInfoView = new InfoView({
          type: "A"
        });
        this.appView = new AppView;
        enablePushState = false;
        pushState = !!(enablePushState && window.history && window.history.pushState);
        return Backbone.history.start({
          pushState: pushState
        });
      };

      return Router;

    })(Backbone.Router);
  });

}).call(this);
