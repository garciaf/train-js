define (require) ->

  $           = require 'jquery'
  _           = require 'underscore'
  Backbone    = require 'backbone'
  Dispatcher  = require 'event'
  StationView = require 'views/StationView'
  stationTableTemplate = require 'hbs!templates/station/tableStation'
  ->

  class TableStationView extends Backbone.View

    initialize: (opts) ->
      @rowViews = []
      Dispatcher.on "search:complete", @render, @

    render: (collection)->
      @$el.html(stationTableTemplate())

      collection.forEach (station, key) => 
        @rowViews[key] = new StationView(
          model: station
        )
        @$el.find('tbody').append(@rowViews[key].render().el)
      
    # Returns the Router class
    TableStationView