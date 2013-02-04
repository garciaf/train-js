define (require) ->

  $           = require 'jquery'
  _           = require 'underscore'
  Backbone    = require 'backbone'
  # require "http://maps.googleapis.com/maps/api/js?libraries=places&sensor=false"
  jhere       = require 'jhere'
  StationCollection = require 'collections/StationCollection'
  mapTemplate    = require 'hbs!templates/station/map'
  mainTemplate = require 'hbs!templates/station/main'
  StationView = require 'views/StationView'
  SearchView = require 'views/SearchView'
  MapView   = require 'views/MapView'
  TableStationView = require 'views/TableStationView'
  stationTableTemplate = require 'hbs!templates/station/tableStation'
  Dispatcher  = require 'event'
  ->

  class MapStationView extends Backbone.View

    el: 'section'

    initialize: (opts) ->
      @SelectedStation = opts.SelectedStation
      @SelectedStation.on "change", @changeStation, @
      @collection = opts.collection
      @collectionDisplayed = opts.collectionDisplayed      
      @collection.once "reset", @copyCollection, @
      Dispatcher.on "station:selected", @changeStation, @
      Dispatcher.on "search:complete", @syncDisplayed, @
      @render()
    render: ->
      @$el.html(mainTemplate())
      @tableStationView = new TableStationView(
        collection: @collectionDisplayed
      ).setElement(@$el.find("#stations")).render()

      @searchView = new SearchView(
        collectionDisplayed: @collectionDisplayed
        collection: @collection
      )
      @mapView = new MapView(
        collection: @collection
      ).setElement(@$el.find("#graph")).render()

      @collection.fetch()

    changeStation: (station) ->
      $("#station").html(station.get("name"))
      @SelectedStation.set station.toJSON()

    copyCollection: ->
      @collectionDisplayed.reset @collection.models
    
    syncDisplayed: (searchResult) ->
      @collectionDisplayed.reset searchResult

    MapStationView