define (require) ->

  $           = require 'jquery'
  _           = require 'underscore'
  Backbone    = require 'backbone'
  Dispatcher  = require 'event'
  ->

  class AppView extends Backbone.View

    initialize: (opts) ->
      _.bindAll @

      Dispatcher.on "info:selected", @displayInfo

    displayInfo: (info) ->
      date = if info.get('retard') then info.getDelay() else info.getWhen()
      destination = info.get('origdest')
      if @intervalID? then clearInterval(@intervalID)
      @intervalID = setInterval( () =>
        $("#info").html("#{destination}:  #{info.getTimeremaining()}")  
      , 1000)
        
    showView: (view) ->

      # if a currentView exists, close it before rendering the new view
      if @currentView?
          @currentView.close()

      # render the new view
      @currentView = view
      @currentView.render()

      # insert the view into the htmlz
      $('#page').html(@currentView.el)

  AppView