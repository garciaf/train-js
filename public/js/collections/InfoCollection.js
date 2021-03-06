(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define(function(require) {
    var Backbone, InfoCollection, InfoModel;
    Backbone = require('backbone');
    InfoModel = require("models/InfoModel");
    (function() {});
    return InfoCollection = (function(_super) {

      __extends(InfoCollection, _super);

      function InfoCollection() {
        return InfoCollection.__super__.constructor.apply(this, arguments);
      }

      InfoCollection.prototype.url = "./infos";

      InfoCollection.prototype.model = InfoModel;

      InfoCollection;


      return InfoCollection;

    })(Backbone.Collection);
  });

}).call(this);
