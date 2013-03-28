define (require) ->

  Backbone    = require 'backbone'
  stationRowTemplate = require 'hbs!template/station/rowStation'
  Dispatcher  = require 'event'
  ->

  class StationView extends Backbone.View

    tagName:  "tr"

    events:
      "mouseover" : "onMouseOver"
      "click" : "chooseStation"

    chooseStation: ->
      Dispatcher.trigger "station:selected", @model
      
    onMouseOver: ->
      Dispatcher.trigger "station:hover", @model
      
    render: ->
      @$el.html(stationRowTemplate(@model.toJSON()))
      return @