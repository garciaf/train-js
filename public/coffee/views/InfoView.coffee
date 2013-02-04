define (require) ->

  $           = require 'jquery'
  _           = require 'underscore'
  Backbone    = require 'backbone'
  # require "http://maps.googleapis.com/maps/api/js?libraries=places&sensor=false"
  InfoCollection = require 'collections/InfoCollection'
  tableTemplate    = require 'hbs!templates/info/tableInfo'
  InfoRowView = require 'views/InfoRowView'
  TableStationView = require 'views/TableStationView'
  stationTableTemplate = require 'hbs!templates/station/tableStation'
  ->

  class InfoView extends Backbone.View

    el: '#content'

    initialize: (opts) ->
      @rowViews = []
      @type = opts.type
      @model = opts.model
      @collection = new InfoCollection()
      @collection.on "reset", @render, @
      @collection.fetch(
        data:
          code: @model.get('code_ddg')
      )

    render: ->
      @infos = new InfoCollection(@collection.toJSON()[0][@type])
      @$el.html(tableTemplate())
      @infos.forEach (info, key) => 
        @rowViews[key] = new InfoRowView(
          model: info
        )
        @$el.find('tbody').append(@rowViews[key].render().el)

    InfoView