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
  stationTableTemplate = require 'hbs!templates/station/tableStation'
  ->

  class TableStationView extends Backbone.View

    el: '#content'

    initialize: (opts) ->
      @rowViews = []
      @collection.on "reset", @render, @
      @SelectedStation = opts.SelectedStation
      @SelectedStation.on "change", @centerMap, @
    centerMap: ->
      @positionCenter = [@SelectedStation.get('x'), @SelectedStation.get('y')]
      @map.jHERE("center", @positionCenter)
      @map.jHERE('zoom', 9)
    render: ->
      @$el.html(mapTemplate())
      @$el.append(stationTableTemplate())
      
      @map = $("#map").jHERE("center", @positionCenter)

      @collection.forEach (station, key) => 
        @rowViews[key] = new StationView(
          map: @map
          model: station
          SelectedStation: @SelectedStation
        )
        @$el.find('tbody').append(@rowViews[key].render().el)
      
    # Returns the Router class
    TableStationView