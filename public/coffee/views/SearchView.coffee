define (require) ->

  $           = require 'jquery'
  _           = require 'underscore'
  Backbone    = require 'backbone'
  StationCollection = require 'collections/StationCollection'


  ->

  class SearchView extends Backbone.View
    el: 'body'
    events:
      "keyup #search": "searchStation"

    initialize: (opts) ->
      @search = $("#search")
      @collectionDisplayed = opts.collectionDisplayed
      @collection = opts.collection

    searchStation: ->
      @collectionDisplayed.reset(@collection.findPerName @search.val())
      console.log @collection
      return @collection.findPerName @search.val()

    # Returns the Router class
    SearchView