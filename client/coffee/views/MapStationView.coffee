define (require) ->

  Backbone    = require 'backbone'
  mainTemplate = require 'hbs!template/station/main'
  SearchView = require 'views/SearchView'
  MapView   = require 'views/MapView'
  TableStationView = require 'views/TableStationView'
  Dispatcher  = require 'event'
  require 'fx_methods'
  ->

  class MapStationView extends Backbone.View

    el: '#mapView'
    events:
      "click #fullscreen": "changeSize"

    changeSize: ->
      unless @fullScreen
        @fullScreen = true
        @turnMapFullScreen($(window).height())
      else
        @fullScreen = false
        @turnMapRegularSize()

    turnMapFullScreen: (windowsHeight) ->
      $("#map").css("height", windowsHeight) 

    turnMapRegularSize: ->
      $("#map").css("height", @mapHeight)
    
    updateSizeMap: (windowsHeight) ->
      unless @fullScreen
        @turnMapRegularSize()
      else
        @turnMapFullScreen(windowsHeight)
    
    initialize: (opts) ->
      Dispatcher.on "station:selected", @changeStation, @
      Dispatcher.on "window:resized", @updateSizeMap, @
      @render()
      @fullScreen = false
      @mapHeight = $("#map").css("height")

    render: ->
      @$el.html(mainTemplate())
      @tableStationView = new TableStationView(
      ).setElement($("#stations"))

      @searchView = new SearchView
      @mapView = new MapView(
      ).setElement($("#map")).render()

    changeStation: (station) ->
      $("#station").html(station.getNameToDisplay())
    
    
    hide: ->
      @$el.hide()
    
    show: ->
      $("ul.nav li").removeClass("active")
      $($("ul.nav li")[0]).addClass("active")
      @$el.fadeIn()