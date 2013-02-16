define (require) ->

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
      @form = $("form.navbar-search")
      console.log @form
      @collection = new StationCollection()
      @collection.on "reset", @searchStation, @
      @collection.once "reset", @initTypeahead, @        
      @collection.fetch()

    searchStation: ->
      collection = @collection.findPerName(@search.val())
      if collection[0]?
        @firstResult = collection[0]
      if collection.length is 1
        Dispatcher.trigger "station:selected", @firstResult
      Dispatcher.trigger "search:complete", @firstResult, @collection.findPerName(@search.val())