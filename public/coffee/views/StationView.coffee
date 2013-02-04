define (require) ->

  $           = require 'jquery'
  _           = require 'underscore'
  Backbone    = require 'backbone'
  stationRowTemplate = require 'hbs!templates/station/rowStation'
  ->

  class StationView extends Backbone.View

    tagName:  "tr"

    events:
      "mouseover" : "popUpBubbles"
      "click" : "chooseStation"

    chooseStation: ->
      @SelectedStation.set @model.toJSON()
      
    initialize: (opts) ->
      @SelectedStation = opts.SelectedStation
      @map = opts.map
      @positionObject = [@model.get('x'), @model.get('y')]
      @map.jHERE 'marker', @positionObject, {click: (e) => @chooseStation() }
    # 
    popUpBubbles: ->
      @map.jHERE("center", @positionObject)
      @map.jHERE('zoom', 9)
      @map.jHERE 'bubble', @positionObject, {content: @model.get('name')}

    render: ->
      @$el.html(stationRowTemplate(@model.toJSON()))
      return @
    # Returns the Router class
    StationView