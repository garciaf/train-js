define (require) ->

  Backbone    = require 'backbone'
  ->

  class StationModel extends Backbone.Model
    defaults:
      x: 0
      y: 0

    getPosition: () ->
      return [@get('x'), @get('y')]
    getNameToDisplay: ()->
      return "#{@get('name')}"
