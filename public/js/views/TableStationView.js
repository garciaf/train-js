(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define(function(require) {
    var Backbone, Dispatcher, StationView, TableStationView, stationTableTemplate;
    Backbone = require('backbone');
    Dispatcher = require('event');
    StationView = require('views/StationView');
    stationTableTemplate = require('hbs!template/station/tableStation');
    (function() {});
    return TableStationView = (function(_super) {

      __extends(TableStationView, _super);

      function TableStationView() {
        return TableStationView.__super__.constructor.apply(this, arguments);
      }

      TableStationView.prototype.initialize = function(opts) {
        this.rowViews = [];
        return Dispatcher.on("search:complete", this.render, this);
      };

      TableStationView.prototype.render = function(model, collection) {
        var _this = this;
        this.$el.html(stationTableTemplate());
        return collection.forEach(function(station, key) {
          _this.rowViews[key] = new StationView({
            model: station
          });
          return _this.$el.find('tbody').append(_this.rowViews[key].render().el);
        });
      };

      return TableStationView;

    })(Backbone.View);
  });

}).call(this);
