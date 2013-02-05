define (require) ->

  $           = require 'jquery'
  _           = require 'underscore'
  Backbone    = require 'backbone'
  mainTemplate = require 'hbs!templates/station/main'
  SearchView = require 'views/SearchView'
  MapView   = require 'views/MapView'
  TableStationView = require 'views/TableStationView'
  Dispatcher  = require 'event'
  ->

  class MapStationView extends Backbone.View

    el: '#mapView'

    initialize: (opts) ->
      Dispatcher.on "station:selected", @changeStation, @
      Dispatcher.on "search:complete", @syncDisplayed, @
      @render()
    render: ->
      @$el.html(mainTemplate())
      @tableStationView = new TableStationView(
      ).setElement($("#stations"))

      @searchView = new SearchView(
        collection: @collection
      )
      @mapView = new MapView(
      ).setElement($("#map")).render()

    changeStation: (station) ->
      $("#station").html(station.get("name"))

    MapStationView