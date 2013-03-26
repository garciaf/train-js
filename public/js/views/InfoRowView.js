(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define(function(require) {
    var Backbone, Dispatcher, InfoRowView, rowTemplate;
    Backbone = require('backbone');
    rowTemplate = require('hbs!templates/info/rowInfo');
    Dispatcher = require('event');
    (function() {});
    return InfoRowView = (function(_super) {

      __extends(InfoRowView, _super);

      function InfoRowView() {
        return InfoRowView.__super__.constructor.apply(this, arguments);
      }

      InfoRowView.prototype.tagName = "tr";

      InfoRowView.prototype.events = {
        "click": "selectInfo"
      };

      InfoRowView.prototype.selectInfo = function() {
        return Dispatcher.trigger("info:selected", this.model);
      };

      InfoRowView.prototype.render = function() {
        this.$el.html(rowTemplate(this.model.toJSON()));
        if (!!this.model.get("retard")) {
          this.$el.addClass("warning");
        }
        return this;
      };

      return InfoRowView;

    })(Backbone.View);
  });

}).call(this);
