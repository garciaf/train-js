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
    events:
      "click #fullscreen": "changeSize"

    changeSize: ->
      unless @fullScreen
        @fullScreen = true
        @turnMapFullScreen()
      else
        @fullScreen = false
        @turnMapRegularSize()

    turnMapFullScreen: ->
      $("#map").css("height", $(window).height()) 

    turnMapRegularSize: ->
      $("#map").css("height", @mapHeight)
    updateSizeMap: ->
      unless @fullScreen
        @turnMapRegularSize()
      else
        @turnMapFullScreen()
    initialize: (opts) ->
      Dispatcher.on "station:selected", @changeStation, @
      Dispatcher.on "search:complete", @syncDisplayed, @
      Dispatcher.on "search:complete", @turnMapRegularSize, @
      Dispatcher.on "window:resized", @updateSizeMap, @
      @render()
      @fullScreen = false
      @mapHeight = $("#map").css("height")

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
    
    
    hide: ->
      @$el.hide()
    
    show: ->
      $("ul.nav li").removeClass("active")
      $($("ul.nav li")[0]).addClass("active")
      @$el.fadeIn()

    MapStationView