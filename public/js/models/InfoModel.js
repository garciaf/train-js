(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define(function(require) {
    var Backbone, InfoModel, moment;
    Backbone = require('backbone');
    moment = require('moment');
    (function() {});
    return InfoModel = (function(_super) {

      __extends(InfoModel, _super);

      function InfoModel() {
        return InfoModel.__super__.constructor.apply(this, arguments);
      }

      InfoModel.prototype.defaults = {
        x: 0,
        y: 0
      };

      InfoModel.prototype.getTimeremaining = function() {
        var to;
        to = !!this.get('retard') ? this.getDelayTime() : this.getWhenTime();
        return moment.duration(to.diff(new Date()));
      };

      InfoModel.prototype.getWhenTime = function() {
        return moment(this.get('heure'));
      };

      InfoModel.prototype.getWhen = function() {
        return this.getWhenTime().format("HH:mm");
      };

      InfoModel.prototype.getDelayTime = function() {
        var delay, hours, min, to;
        if (this.get('retard')) {
          delay = this.get('retard');
          hours = "" + delay[0] + delay[1];
          min = "" + delay[2] + delay[3];
          delay = moment.duration({
            hours: parseInt(hours, 10),
            minutes: parseInt(min, 10)
          });
          to = moment(this.get('heure'));
          return to.add(delay);
        }
        return false;
      };

      InfoModel.prototype.getDelay = function() {
        var time;
        time = this.getDelayTime();
        if (time) {
          return time.format("HH:mm");
        }
        return null;
      };

      InfoModel.prototype.toJSON = function() {
        var json;
        json = _(this.attributes).clone();
        json.when = this.getWhen();
        json.delay = this.getDelay();
        return json;
      };

      return InfoModel;

    })(Backbone.Model);
  });

}).call(this);
