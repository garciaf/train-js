define (require) ->

  $           = require 'jquery'
  _           = require 'underscore'
  Backbone    = require 'backbone'
  # require "http://maps.googleapis.com/maps/api/js?libraries=places&sensor=false"
  jhere       = require 'jhere'
  StationCollection = require 'collections/StationCollection'
  mapTemplate    = require 'hbs!templates/station/map'
  StationView = require 'views/StationView'
  SearchView = require 'views/SearchView'
  MapView   = require 'views/MapView'

  stationTableTemplate = require 'hbs!templates/station/tableStation'
  ->

  class TableStationView extends Backbone.View

    initialize: (opts) ->
      @rowViews = []
      @fullCollection = opts.fullCollection
      @collection.on "reset", @render, @

    render: ->
      @$el.html(stationTableTemplate())

      @collection.forEach (station, key) => 
        @rowViews[key] = new StationView(
          model: station
        )
        @$el.find('tbody').append(@rowViews[key].render().el)
      
    # Returns the Router class
    TableStationView