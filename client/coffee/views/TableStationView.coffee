define (require) ->

  Backbone    = require 'backbone'
  Dispatcher  = require 'event'
  StationView = require 'views/StationView'
  stationTableTemplate = require 'hbs!templates/station/tableStation'
  ->

  class TableStationView extends Backbone.View

    initialize: (opts) ->
      @rowViews = []
      Dispatcher.on "search:complete", @render, @

    render: (model, collection)->
      @$el.html(stationTableTemplate())

      collection.forEach (station, key) => 
        @rowViews[key] = new StationView(
          model: station
        )
        @$el.find('tbody').append(@rowViews[key].render().el)