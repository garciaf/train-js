define (require) ->

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
      Dispatcher.once "stations:fetched", @applyUserSettings, @
      
      @setElement($("#info"))
      @resizeContent($(window).height())

    applyUserSettings: ->
      @user = new UserModel(
        id:1
      )
      Dispatcher.on "search:complete",  @saveUserSearch, @
      @user.on "change", @displayUser, @
      @user.fetch()

    displayUser:(user) ->
      $('#search').val(@user.get('station'))
      $('#search').blur()
      console.log @user

    saveUserSearch: (model, collection) ->
      console.log collection
      station = if collection.length is 1 then model.get('name') else "" 
      @user.set(
        id: 1
        station: station
      )
      @user.save()
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
        hours = if duration.hours() isnt 0 then "#{duration.hours()}:" else ""
        @$el.html("<i class='icon-resize-horizontal'></i> #{destination} #{hours}#{duration.minutes()}: #{duration.seconds()}")  
      , 1000)