// Generated by CoffeeScript 1.4.0
var __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

define(function(require) {
  var $, Backbone, InfoCollection, InfoRowView, InfoView, TableStationView, stationTableTemplate, tableTemplate, _;
  $ = require('jquery');
  _ = require('underscore');
  Backbone = require('backbone');
  InfoCollection = require('collections/InfoCollection');
  tableTemplate = require('hbs!templates/info/tableInfo');
  InfoRowView = require('views/InfoRowView');
  TableStationView = require('views/TableStationView');
  stationTableTemplate = require('hbs!templates/station/tableStation');
  (function() {});
  return InfoView = (function(_super) {

    __extends(InfoView, _super);

    function InfoView() {
      return InfoView.__super__.constructor.apply(this, arguments);
    }

    InfoView.prototype.el = '#content';

    InfoView.prototype.initialize = function(opts) {
      this.rowViews = [];
      this.type = opts.type;
      this.model = opts.model;
      this.collection = new InfoCollection();
      this.collection.on("reset", this.render, this);
      return this.collection.fetch({
        data: {
          code: this.model.get('code_ddg')
        }
      });
    };

    InfoView.prototype.render = function() {
      var _this = this;
      this.infos = new InfoCollection(this.collection.toJSON()[0][this.type]);
      this.$el.html(tableTemplate());
      return this.infos.forEach(function(info, key) {
        _this.rowViews[key] = new InfoRowView({
          model: info
        });
        return _this.$el.find('tbody').append(_this.rowViews[key].render().el);
      });
    };

    InfoView;


    return InfoView;

  })(Backbone.View);
});
