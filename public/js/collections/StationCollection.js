// Generated by CoffeeScript 1.4.0
var __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

define(function(require) {
  var $, Backbone, StationCollection, _;
  $ = require('jquery');
  _ = require('underscore');
  Backbone = require('backbone');
  (function() {});
  return StationCollection = (function(_super) {

    __extends(StationCollection, _super);

    function StationCollection() {
      return StationCollection.__super__.constructor.apply(this, arguments);
    }

    StationCollection.prototype.url = "./stations";

    StationCollection.prototype.findPerName = function(value) {
      var lowValue, result,
        _this = this;
      lowValue = value.toLowerCase();
      return result = this.filter(function(station) {
        var lowStationName;
        lowStationName = station.get('name').toLowerCase();
        if (lowStationName.indexOf(lowValue) === -1) {
          return false;
        }
        return true;
      });
    };

    StationCollection;


    return StationCollection;

  })(Backbone.Collection);
});
