// Generated by CoffeeScript 1.4.0
var __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

define(function(require) {
  var $, Backbone, Dispatcher, MapStationView, MapView, SearchView, TableStationView, mainTemplate, _;
  $ = require('jquery');
  _ = require('underscore');
  Backbone = require('backbone');
  mainTemplate = require('hbs!templates/station/main');
  SearchView = require('views/SearchView');
  MapView = require('views/MapView');
  TableStationView = require('views/TableStationView');
  Dispatcher = require('event');
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
        return this.turnMapFullScreen();
      } else {
        return this.turnMapRegularSize();
      }
    };

    MapStationView.prototype.turnMapFullScreen = function() {
      this.fullScreen = true;
      return $("#map").css("height", $(window).height());
    };

    MapStationView.prototype.turnMapRegularSize = function() {
      this.fullScreen = false;
      return $("#map").css("height", this.mapHeight);
    };

    MapStationView.prototype.initialize = function(opts) {
      Dispatcher.on("station:selected", this.changeStation, this);
      Dispatcher.on("search:complete", this.syncDisplayed, this);
      Dispatcher.on("search:complete", this.turnMapRegularSize, this);
      this.render();
      this.fullScreen = false;
      return this.mapHeight = $("#map").css("height");
    };

    MapStationView.prototype.render = function() {
      this.$el.html(mainTemplate());
      this.tableStationView = new TableStationView().setElement($("#stations"));
      this.searchView = new SearchView({
        collection: this.collection
      });
      return this.mapView = new MapView().setElement($("#map")).render();
    };

    MapStationView.prototype.changeStation = function(station) {
      return $("#station").html(station.get("name"));
    };

    MapStationView.prototype.hide = function() {
      return this.$el.hide();
    };

    MapStationView.prototype.show = function() {
      $("ul.nav li").removeClass("active");
      $($("ul.nav li")[0]).addClass("active");
      return this.$el.fadeIn();
    };

    MapStationView;


    return MapStationView;

  })(Backbone.View);
});
