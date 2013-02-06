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

    initialize: ->
      @search = $("#search")
      @collection = new StationCollection()
      @collection.on "reset", @searchStation, @
      @collection.fetch()


    searchStation: ->
      collection = @collection.findPerName(@search.val())
      if collection[0]?
        @firstResult = collection[0]
      Dispatcher.trigger "search:complete", @firstResult, @collection.findPerName(@search.val())

    SearchView