define (require) ->

  $           = require 'jquery'
  _           = require 'underscore'
  Backbone    = require 'backbone'
  StationModel = require 'models/StationModel'
  ->

  class StationCollection extends Backbone.Collection
    url: "./stations"
    model: StationModel
    # Returns the Router class
    findPerName: (value) ->
      lowValue = value.toLowerCase()
      result = @filter (station) =>
        lowStationName = station.get('name').toLowerCase()
        if lowStationName.indexOf(lowValue) is -1
          return false
        return true
      return result

    StationCollection