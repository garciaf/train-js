define (require) ->

  $           = require 'jquery'
  _           = require 'underscore'
  Backbone    = require 'backbone'
  InfoModel   = require "models/InfoModel"
  ->

  class InfoCollection extends Backbone.Collection
    url: "./infos"
    model: InfoModel
    # Returns the Router class

    InfoCollection