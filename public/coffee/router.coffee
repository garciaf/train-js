define (require) ->

  $           = require 'jquery'
  _           = require 'underscore'
  Backbone    = require 'backbone'
  AppView     = require 'views/misc/app'
  MapStationView = require 'views/MapStationView'
  Dispatcher  = require 'event'
  InfoView    = require 'views/InfoView'

  ->

  class Router extends Backbone.Router
    
    routes:

      "arrivals": "arrival"
      "departure": "departure"
      "map": "map"
      "*actions": "map"


    home: ->

    arrival: ->
      @arrivalInfoView.show()
      @departureInfoView.hide()
      @mapView.hide()
    departure: ->
      @departureInfoView.show()
      @arrivalInfoView.hide()
      @mapView.hide()
    map: ->
      @mapView.show()
      @departureInfoView.hide()
      @arrivalInfoView.hide()

    initialize: ->
      @mapView = new MapStationView()

      @departureInfoView = new InfoView(
          type: "D"
        )
      @arrivalInfoView = new InfoView(
          type: "A"
        )
      @appView = new AppView

      enablePushState = false

      pushState = !!(enablePushState && window.history && window.history.pushState)
      Backbone.history.start({pushState: pushState})        