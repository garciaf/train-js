define (require) ->

  $           = require 'jquery'
  _           = require 'underscore'
  Backbone    = require 'backbone'
  # require "http://maps.googleapis.com/maps/api/js?libraries=places&sensor=false"
  rowTemplate    = require 'hbs!templates/info/rowInfo'
  ->

  class InfoRowView extends Backbone.View

    tagName:  "tr"

    initialize: (opts) ->
            
    render: ->
      @$el.html(rowTemplate(@model.toJSON()))
      if !!@model.get("retard")
        @$el.addClass("warning")
      return @      
    
    InfoRowView