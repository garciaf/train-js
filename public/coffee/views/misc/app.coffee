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
      Dispatcher.on "station:selected",  @removeInfo, @
      @setElement($("#info"))
      @resizeContent($(window).height())

    resizeContent: (windowHeight) ->
      $("#content").css("height", windowHeight-80)

    removeInfo: ->
      if @intervalID? then clearInterval(@intervalID)      
      @$el.html('')
    displayInfoInLoop: (info) ->
      destination = info.get('origdest')
      if @intervalID? then clearInterval(@intervalID)
      @intervalID = setInterval( () =>
        duration = info.getTimeremaining()
        console.log duration.minutes()
        console.log duration.seconds()
        @$el.html("<i class='icon-resize-horizontal'></i> #{destination} #{duration.minutes()}: #{duration.seconds()}")  
      , 1000)
        

  AppView