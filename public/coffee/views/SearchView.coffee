define (require) ->

  $           = require 'jquery'
  _           = require 'underscore'
  Backbone    = require 'backbone'
  StationCollection = require 'collections/StationCollection'
  Dispatcher  = require 'event'


  ->

  class SearchView extends Backbone.View
    el: 'body'
    events:
      "keyup #search": "searchStation"

    initialize: (opts) ->
      @search = $("#search")
      @collection = new StationCollection()
      @collection.on "reset", @searchStation, @
      @collection.fetch()


    searchStation: ->
      Dispatcher.trigger "search:complete", @collection.findPerName(@search.val())

    SearchView