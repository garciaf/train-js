(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define(function(require) {
    var Backbone, Dispatcher, InfoCollection, InfoRowView, InfoView, loadingTemplate, moment, notificationTemplate, tableTemplate;
    Backbone = require('backbone');
    Dispatcher = require('event');
    InfoCollection = require('collections/InfoCollection');
    tableTemplate = require('hbs!template/info/tableInfo');
    notificationTemplate = require('hbs!template/notification');
    loadingTemplate = require('hbs!template/loading');
    InfoRowView = require('views/InfoRowView');
    moment = require('moment');
    (function() {});
    return InfoView = (function(_super) {

      __extends(InfoView, _super);

      function InfoView() {
        return InfoView.__super__.constructor.apply(this, arguments);
      }

      InfoView.prototype.initialize = function(opts) {
        this.rowViews = [];
        this.type = opts.type;
        if (this.type === "A") {
          this.setElement($("#arrivalView"));
        } else {
          this.setElement($("#departView"));
        }
        this.model = opts.model;
        this.collection = new InfoCollection();
        this.listenTo(this.collection, "request", this.displayloading);
        this.listenTo(this.collection, "sync", this.render);
        this.listenTo(this.collection, "error", this.onError);
        return Dispatcher.on("station:selected", this.loopPopulateData, this);
      };

      InfoView.prototype.loopPopulateData = function(model) {
        var _this = this;
        this.populateData(model);
        if (this.intervalID != null) {
          clearInterval(this.intervalID);
        }
        return this.intervalID = setInterval(function() {
          return _this.populateData(model);
        }, 300000);
      };

      InfoView.prototype.populateData = function(model) {
        return this.collection.fetch({
          data: {
            code: model.get('code_ddg')
          }
        });
      };

      InfoView.prototype.render = function() {
        var now,
          _this = this;
        this.infos = new InfoCollection(this.collection.toJSON()[0][this.type]);
        this.$el.html(tableTemplate());
        this.infos.forEach(function(info, key) {
          _this.rowViews[key] = new InfoRowView({
            model: info
          });
          return _this.$el.find('tbody').append(_this.rowViews[key].render().el);
        });
        now = moment().format("LT");
        return $("#lastupdate").html(now);
      };

      InfoView.prototype.onError = function(model, resp, options) {
        return this.$el.html(notificationTemplate({
          type: "error",
          message: "error communication"
        }));
      };

      InfoView.prototype.displayloading = function() {
        return this.$el.html(loadingTemplate());
      };

      InfoView.prototype.hide = function() {
        return this.$el.hide();
      };

      InfoView.prototype.show = function() {
        $("ul.nav li").removeClass("active");
        if (this.type === "A") {
          $($("ul.nav li")[2]).addClass("active");
        } else {
          $($("ul.nav li")[1]).addClass("active");
        }
        return this.$el.fadeIn();
      };

      return InfoView;

    })(Backbone.View);
  });

}).call(this);
