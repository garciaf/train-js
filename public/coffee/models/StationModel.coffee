define (require) ->

  $           = require 'jquery'
  _           = require 'underscore'
  Backbone    = require 'backbone'
  ->

  class StationModel extends Backbone.Model
    defaults:
      x: 0
      y: 0
    # Returns the Router class
    getPosition: () ->
      return [@get('x'), @get('y')]
    getNameToDisplay: ()->
      return "#{@get('name')}"
    StationModel