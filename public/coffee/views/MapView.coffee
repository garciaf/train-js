define (require) ->

  $           = require 'jquery'
  _           = require 'underscore'
  Backbone    = require 'backbone'
  Dispatcher  = require 'event'
  jhere       = require 'jhere'
  Dispatcher  = require 'event'
  ->

  class MapView extends Backbone.View
    


    initialize: (opts) ->      
      Dispatcher.once "search:complete", @displayMarker, @
      Dispatcher.on "station:selected",  @centerMap, @
      Dispatcher.on "station:hover",  @addBubbles, @

    addBubbles: (station) ->
      $("#map").jHERE 'center', station.getPosition()
      $("#map").jHERE 'bubble', station.getPosition(), content: station.get('name')
    centerMap: (station) ->
      $("#map").jHERE 'center', station.getPosition()
    displayMarker: (stations) ->
      stations.forEach (station) =>
        $("#map").jHERE 'marker', station.getPosition(),  {icon: 'img/steamtrain.png', anchor: {x: 12, y: 30},  click: (e) => Dispatcher.trigger "station:selected", station }
      return false

    render: ->
      @map = $("#map").jHERE(
        appId: "usgKT-xql56_vPTmD3Z5"
        authToken: "vR2pZ6q3EMnE3PX6fqt9uw"
      )
      return @
    MapView