define (require) ->

  $           = require 'jquery'
  _           = require 'underscore'
  Backbone    = require 'backbone'
  # require "http://maps.googleapis.com/maps/api/js?libraries=places&sensor=false"
  rowTemplate    = require 'hbs!templates/info/rowInfo'
  Dispatcher  = require 'event'

  ->

  class InfoRowView extends Backbone.View

    tagName:  "tr"
    events:
      "click": "selectInfo"

    initialize: (opts) ->
    
    selectInfo: ->
      Dispatcher.trigger "info:selected", @model
    render: ->
      @$el.html(rowTemplate(@model.toJSON()))
      if !!@model.get("retard")
        @$el.addClass("warning")
      return @      
    
    InfoRowView