define (require) ->

  Backbone    = require 'backbone'
  Dispatcher  = require 'event'
  InfoCollection = require 'collections/InfoCollection'
  tableTemplate    = require 'hbs!templates/info/tableInfo'
  InfoRowView = require 'views/InfoRowView'
  moment      = require 'moment'

  ->

  class InfoView extends Backbone.View

    initialize: (opts) ->
      @rowViews = []
      @type = opts.type
      if @type is "A"
        @setElement $("#arrivalView")
      else
        @setElement $("#departView")
      @model = opts.model
      @collection = new InfoCollection()
      @collection.on "sync", @render, @
      Dispatcher.on "station:selected", @loopPopulateData, @
    
    loopPopulateData: (model) ->
      @populateData(model)
      if @intervalID? then clearInterval(@intervalID)
      @intervalID = setInterval( () =>
        @populateData(model)
      , 60000)

    populateData: (model) ->
      @collection.fetch(
        data:
          code: model.get('code_ddg')
      )
    
    render: ->

      @infos = new InfoCollection(@collection.toJSON()[0][@type])
      @$el.html(tableTemplate())
      @infos.forEach (info, key) => 
        @rowViews[key] = new InfoRowView(
          model: info
        )
        @$el.find('tbody').append(@rowViews[key].render().el)

      now = moment().format("LT")
      $("#lastupdate").html(now)
    
    hide: ->
      @$el.hide()

    show: ->
      $("ul.nav li").removeClass("active")
      if @type is "A"
        $($("ul.nav li")[2]).addClass("active")
      else
        $($("ul.nav li")[1]).addClass("active")

      @$el.fadeIn()