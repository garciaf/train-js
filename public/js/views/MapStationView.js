(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define(function(require) {
    var Backbone, Dispatcher, MapStationView, MapView, SearchView, TableStationView, mainTemplate;
    Backbone = require('backbone');
    mainTemplate = require('hbs!template/station/main');
    SearchView = require('views/SearchView');
    MapView = require('views/MapView');
    TableStationView = require('views/TableStationView');
    Dispatcher = require('event');
    require('fx_methods');
    (function() {});
    return MapStationView = (function(_super) {

      __extends(MapStationView, _super);

      function MapStationView() {
        return MapStationView.__super__.constructor.apply(this, arguments);
      }

      MapStationView.prototype.el = '#mapView';

      MapStationView.prototype.events = {
        "click #fullscreen": "changeSize"
      };

      MapStationView.prototype.changeSize = function() {
        if (!this.fullScreen) {
          this.fullScreen = true;
          return this.turnMapFullScreen($(window).height());
        } else {
          this.fullScreen = false;
          return this.turnMapRegularSize();
        }
      };

      MapStationView.prototype.turnMapFullScreen = function(windowsHeight) {
        return $("#map").css("height", windowsHeight);
      };

      MapStationView.prototype.turnMapRegularSize = function() {
        return $("#map").css("height", this.mapHeight);
      };

      MapStationView.prototype.updateSizeMap = function(windowsHeight) {
        if (!this.fullScreen) {
          return this.turnMapRegularSize();
        } else {
          return this.turnMapFullScreen(windowsHeight);
        }
      };

      MapStationView.prototype.initialize = function(opts) {
        Dispatcher.on("station:selected", this.changeStation, this);
        Dispatcher.on("window:resized", this.updateSizeMap, this);
        this.render();
        this.fullScreen = false;
        return this.mapHeight = $("#map").css("height");
      };

      MapStationView.prototype.render = function() {
        this.$el.html(mainTemplate());
        this.tableStationView = new TableStationView().setElement($("#stations"));
        this.searchView = new SearchView;
        return this.mapView = new MapView().setElement($("#map")).render();
      };

      MapStationView.prototype.changeStation = function(station) {
        return $("#station").html(station.getNameToDisplay());
      };

      MapStationView.prototype.hide = function() {
        return this.$el.hide();
      };

      MapStationView.prototype.show = function() {
        $("ul.nav li").removeClass("active");
        $($("ul.nav li")[0]).addClass("active");
        return this.$el.fadeIn();
      };

      return MapStationView;

    })(Backbone.View);
  });

}).call(this);
