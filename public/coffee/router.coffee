define (require) ->

  $           = require 'jquery'
  _           = require 'underscore'
  Backbone    = require 'backbone'
  AppView     = require 'views/misc/app'
  MapStationView = require 'views/MapStationView'
  InfoView    = require 'views/InfoView'

  ->

  # The main router for the whole app
  class Router extends Backbone.Router
    
    # All of your Backbone Routes (add more)
    routes:

      # When there is no url, the home method is called
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

      # Enable pushState for compatible browsers
      enablePushState = false

      # Disable for older browsers
      pushState = !!(enablePushState && window.history && window.history.pushState)

      # Tells Backbone to start watching for hashchange events
      Backbone.history.start({pushState: pushState})        


    # Returns the Router class
    Router