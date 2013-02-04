define (require) ->

  $           = require 'jquery'
  _           = require 'underscore'
  Backbone    = require 'backbone'
  AppView     = require 'views/misc/app'
  MapStationView = require 'views/MapStationView'
  InfoView    = require 'views/InfoView'
  StationModel = require 'models/StationModel'
  StationCollection = require 'collections/StationCollection'

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
      @infoView = new InfoView(
        model: @SelectedStation
        type: "A"
      )
    departure: ->
      @infoView = new InfoView(
        model: @SelectedStation
        type: "D"
      )
    map: ->
      unless @mapView?
        @mapView = new MapStationView(
          collection: @collection
          collectionDisplayed: @collectionDisplayed
          SelectedStation: @SelectedStation
        )
      else @mapView.render()        

    initialize: ->
      @SelectedStation = new StationModel()
      @collection = new StationCollection()
      @collectionDisplayed = new StationCollection()      

      @appView = new AppView

      # Enable pushState for compatible browsers
      enablePushState = false

      # Disable for older browsers
      pushState = !!(enablePushState && window.history && window.history.pushState)

      # Tells Backbone to start watching for hashchange events
      Backbone.history.start({pushState: pushState})        


    # Returns the Router class
    Router