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
      "": "home"
      "arrivals": "arrival"
      "departure": "departure"
      "map": "map"


    home: ->

    arrival: ->
      @arrivalInfoView.$el.show()
      @departureInfoView.$el.hide()
      @mapView?.$el.hide()
    departure: ->
      @departureInfoView.$el.show()
      @arrivalInfoView.$el.hide()
      @mapView?.$el.hide()
    map: ->
      unless @mapView?
        @mapView = new MapStationView()
      else 
        @mapView.$el.show()
      @departureInfoView.$el.hide()
      @arrivalInfoView.$el.hide()

    initialize: ->
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