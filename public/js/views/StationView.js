(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define(function(require) {
    var Backbone, Dispatcher, StationView, stationRowTemplate;
    Backbone = require('backbone');
    stationRowTemplate = require('hbs!template/station/rowStation');
    Dispatcher = require('event');
    (function() {});
    return StationView = (function(_super) {

      __extends(StationView, _super);

      function StationView() {
        return StationView.__super__.constructor.apply(this, arguments);
      }

      StationView.prototype.tagName = "tr";

      StationView.prototype.events = {
        "mouseover": "onMouseOver",
        "click": "chooseStation"
      };

      StationView.prototype.chooseStation = function() {
        return Dispatcher.trigger("station:selected", this.model);
      };

      StationView.prototype.onMouseOver = function() {
        return Dispatcher.trigger("station:hover", this.model);
      };

      StationView.prototype.render = function() {
        this.$el.html(stationRowTemplate(this.model.toJSON()));
        return this;
      };

      return StationView;

    })(Backbone.View);
  });

}).call(this);
