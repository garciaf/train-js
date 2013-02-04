define (require) ->

  $           = require 'jquery'
  _           = require 'underscore'
  Backbone    = require 'backbone'
  jhere       = require 'jhere'
  stationRowTemplate = require 'hbs!templates/station/rowStation'
  Dispatcher  = require 'event'
  ->

  class MapView extends Backbone.View
      
    initialize: (opts) ->
      @map = {}
      @displayMarker()
      @collection.once "reset", @displayMarker, @
      Dispatcher.on "station:selected",  @centerMap, @
      Dispatcher.on "station:hover",  @addBubbles, @

    addBubbles: (station) ->
      $("#map").jHERE 'center', station.getPosition()
      $("#map").jHERE 'bubble', station.getPosition(), content: station.get('name')
    centerMap: (station) ->
      $("#map").jHERE 'center', station.getPosition()
    displayMarker: ->
      @collection.forEach (station) =>
        @positionObject = [station.get('x'), station.get('y')]
        $("#map").jHERE 'marker', @positionObject, click: (e) => Dispatcher.trigger "station:selected", station
      return false

    popUpBubbles: ->

    render: ->
      @map = $("#map").jHERE(
        appId: "usgKT-xql56_vPTmD3Z5"
        authToken: "vR2pZ6q3EMnE3PX6fqt9uw"
      )
      return @
    # Returns the Router class
    MapView