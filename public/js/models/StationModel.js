(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define(function(require) {
    var Backbone, StationModel;
    Backbone = require('backbone');
    (function() {});
    return StationModel = (function(_super) {

      __extends(StationModel, _super);

      function StationModel() {
        return StationModel.__super__.constructor.apply(this, arguments);
      }

      StationModel.prototype.defaults = {
        x: 0,
        y: 0
      };

      StationModel.prototype.getPosition = function() {
        return [this.get('x'), this.get('y')];
      };

      StationModel.prototype.getNameToDisplay = function() {
        return "" + (this.get('name'));
      };

      return StationModel;

    })(Backbone.Model);
  });

}).call(this);
