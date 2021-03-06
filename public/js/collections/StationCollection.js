(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define(function(require) {
    var Backbone, StationCollection, StationModel;
    Backbone = require('backbone');
    StationModel = require('models/StationModel');
    (function() {});
    return StationCollection = (function(_super) {

      __extends(StationCollection, _super);

      function StationCollection() {
        return StationCollection.__super__.constructor.apply(this, arguments);
      }

      StationCollection.prototype.url = "./stations";

      StationCollection.prototype.model = StationModel;

      StationCollection.prototype.getSearchValues = function() {
        return this.map(function(station) {
          return station.get('name');
        });
      };

      StationCollection.prototype.findPerName = function(value) {
        var lowValue, result,
          _this = this;
        lowValue = value.toLowerCase();
        result = this.filter(function(station) {
          var lowCode, lowStationName;
          lowStationName = station.get('name').toLowerCase();
          lowCode = station.get('code_ddg').toLowerCase();
          if (lowStationName.indexOf(lowValue) === -1 && lowCode.indexOf(lowValue) === -1) {
            return false;
          }
          return true;
        });
        return result;
      };

      StationCollection;


      return StationCollection;

    })(Backbone.Collection);
  });

}).call(this);
