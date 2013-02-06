define (require) ->

  $           = require 'jquery'
  _           = require 'underscore'
  Backbone    = require 'backbone'
  Dispatcher  = require 'event'
  ->

  class AppView extends Backbone.View

    initialize: (opts) ->
      _.bindAll @
      $(window).resize ->
        Dispatcher.trigger "window:resized", $(@).height()
      Dispatcher.on "info:selected", @displayInfoInLoop, @
      Dispatcher.on "window:resized", @resizeContent, @
      @resizeContent($(window).height())

    resizeContent: (windowHeight) ->
      $("#content").css("height", windowHeight-80)


    displayInfoInLoop: (info) ->
      destination = info.get('origdest')
      if @intervalID? then clearInterval(@intervalID)
      @intervalID = setInterval( () =>
        $("#info").html("#{destination}:  #{info.getTimeremaining()}")  
      , 1000)
        

  AppView