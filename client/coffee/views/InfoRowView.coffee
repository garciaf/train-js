define (require) ->

  Backbone    = require 'backbone'
  rowTemplate    = require 'hbs!template/info/rowInfo'
  Dispatcher  = require 'event'

  ->

  class InfoRowView extends Backbone.View

    tagName:  "tr"
    events:
      "click": "selectInfo"
    
    selectInfo: ->
      Dispatcher.trigger "info:selected", @model
    render: ->
      @$el.html(rowTemplate(@model.toJSON()))
      if !!@model.get("retard")
        @$el.addClass("warning")
      return @