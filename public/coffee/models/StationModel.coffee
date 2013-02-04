define (require) ->

  $           = require 'jquery'
  _           = require 'underscore'
  Backbone    = require 'backbone'
  moment      = require 'moment'
  ->

  class StationModel extends Backbone.Model
    defaults:
      x: 0
      y: 0
    # Returns the Router class
    StationModel