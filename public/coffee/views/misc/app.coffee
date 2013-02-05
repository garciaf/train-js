define (require) ->

  $           = require 'jquery'
  _           = require 'underscore'
  Backbone    = require 'backbone'
  Dispatcher  = require 'event'
  ->

  class AppView extends Backbone.View

    initialize: (opts) ->
      _.bindAll @

      Dispatcher.on "info:selected", @displayInfoInLoop

    displayInfoInLoop: (info) ->
      destination = info.get('origdest')
      if @intervalID? then clearInterval(@intervalID)
      @intervalID = setInterval( () =>
        $("#info").html("#{destination}:  #{info.getTimeremaining()}")  
      , 1000)
        

  AppView