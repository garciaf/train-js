define (require) ->

  $           = require 'jquery'
  _           = require 'underscore'
  Backbone    = require 'backbone'
  StationCollection = require 'collections/StationCollection'
  Dispatcher  = require 'event'
  require 'bootstrap'


  ->

  class SearchView extends Backbone.View
    el: 'body'
    events:
      "change #search": "searchStation"
      "blur #search": "searchStation"

    initialize: ->
      @search = $("#search")

      @collection = new StationCollection()

      @collection.on "reset", @searchStation, @
      @collection.once "reset", @initTypeahead, @
        
      @collection.fetch()

    initTypeahead: ->

      @search.typeahead
        source: @collection.getSearchValues()


    searchStation: ->
      collection = @collection.findPerName(@search.val())
      if collection[0]?
        @firstResult = collection[0]
      if collection.length is 1
        Dispatcher.trigger "station:selected", @firstResult
      Dispatcher.trigger "search:complete", @firstResult, @collection.findPerName(@search.val())