define (require) ->

  $           = require 'jquery'
  _           = require 'underscore'
  Backbone    = require 'backbone'
  # require "http://maps.googleapis.com/maps/api/js?libraries=places&sensor=false"
  jhere       = require 'jhere'
  StationCollection = require 'collections/StationCollection'
  mapTemplate    = require 'hbs!templates/station/map'
  StationView = require 'views/StationView'
  SearchView = require 'views/SearchView'
  TableStationView = require 'views/TableStationView'
  stationTableTemplate = require 'hbs!templates/station/tableStation'
  ->

  class MapView extends Backbone.View

    el: 'body'

    initialize: (opts) ->
      @rowViews = []
      @SelectedStation = opts.SelectedStation
      @SelectedStation.on "change", @changeStation, @
      @collection = opts.collection
      @collectionDisplayed = opts.collectionDisplayed      
      @collection.once "reset", @syncDisplayed, @
      @collection.fetch()

      @tableStationView = new TableStationView(
        collection: @collectionDisplayed
        SelectedStation: @SelectedStation
      )
      @searchView = new SearchView(
        collectionDisplayed: @collectionDisplayed
        collection: @collection
      )
    changeStation: ->
      console.log "station Changed"
      $("#station").html(@SelectedStation.get("name"))
    syncDisplayed: ()->
      @collectionDisplayed.reset @collection.models
    # Returns the Router class
    MapView