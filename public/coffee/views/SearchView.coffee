define (require) ->

  Backbone    = require 'backbone'
  StationCollection = require 'collections/StationCollection'
  Dispatcher  = require 'event'
  require 'bootstrap'
  UserModel   = require 'models/UserModel'


  ->

  class SearchView extends Backbone.View
    el: 'body'
    events:
      "change #search": "searchStation"
      "blur #search": "searchStation"

    initialize: ->
      @search = $("#search")

      @collection = new StationCollection()

      @collection.on "reset", @searchStation, @
      @collection.once "reset", @initTypeahead, @
      @collection.once "reset", @applyUserSettings, @
        
      @collection.fetch()

    applyUserSettings: ->
      @user = new UserModel(
        id:1
      )
      Dispatcher.on "search:complete",  @saveUserSearch, @
      Dispatcher.on "station:selected", @saveUserSearch, @
      @user.once "change", @displayUserStation, @
      @user.fetch()

    displayUserStation:(user) ->
      @search.val(@user.get('station'))
      @search.blur()

    saveUserSearch: (model, collection) ->
      station = if collection?.length is 1 or collection? is false then model.get('name') else "" 
      @user.set(
        id: 1
        station: station
      )
      @user.save()

    initTypeahead: ->
      @search.typeahead
        source: @collection.getSearchValues()

    searchStation: ->
      collection = @collection.findPerName(@search.val())
      if collection[0]?
        @firstResult = collection[0]
      if collection.length is 1
        Dispatcher.trigger "station:selected", @firstResult
      Dispatcher.trigger "search:complete", @firstResult, @collection.findPerName(@search.val())