define (require) ->

  $           = require 'jquery'
  _           = require 'underscore'
  Backbone    = require 'backbone'
  ->

  class StationCollection extends Backbone.Collection
    url: "./stations"
    # Returns the Router class
    findPerName: (value) ->
      lowValue = value.toLowerCase()
      result = @filter (station) =>
        lowStationName = station.get('name').toLowerCase()
        if lowStationName.indexOf(lowValue) is -1
          return false
        return true

    StationCollection