(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define(function(require) {
    var Backbone, Dispatcher, SearchView, StationCollection, stations;
    Backbone = require('backbone');
    StationCollection = require('collections/StationCollection');
    Dispatcher = require('event');
    stations = require('json!data/station.json');
    (function() {});
    return SearchView = (function(_super) {

      __extends(SearchView, _super);

      function SearchView() {
        return SearchView.__super__.constructor.apply(this, arguments);
      }

      SearchView.prototype.el = 'body';

      SearchView.prototype.events = {
        "keyup #search": "searchStation"
      };

      SearchView.prototype.initialize = function() {
        this.search = $("#search");
        this.form = $("form.navbar-search");
        this.collection = new StationCollection();
        this.listenToOnce(this.collection, "reset", this.searchStation);
        return this.collection.reset(stations);
      };

      SearchView.prototype.searchStation = function() {
        var collection;
        collection = this.collection.findPerName(this.search.val());
        if (collection[0] != null) {
          this.firstResult = collection[0];
        }
        if (collection.length === 1) {
          Dispatcher.trigger("station:selected", this.firstResult);
        }
        return Dispatcher.trigger("search:complete", this.firstResult, this.collection.findPerName(this.search.val()));
      };

      return SearchView;

    })(Backbone.View);
  });

}).call(this);
