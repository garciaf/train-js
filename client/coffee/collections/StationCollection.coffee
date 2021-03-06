define (require) ->

  Backbone    = require 'backbone'
  StationModel = require 'models/StationModel'
  ->

  class StationCollection extends Backbone.Collection
    url: "./stations"
    model: StationModel
    # Returns the Router class
    getSearchValues: ->
      @map (station)->
        return station.get('name')
      
    findPerName: (value) ->
      lowValue = value.toLowerCase()
      result = @filter (station) =>
        lowStationName = station.get('name').toLowerCase()
        lowCode = station.get('code_ddg').toLowerCase()
        if lowStationName.indexOf(lowValue) is -1 and lowCode.indexOf(lowValue) is -1
          return false
        return true
      return result

    StationCollection