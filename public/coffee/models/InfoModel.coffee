define (require) ->

  $           = require 'jquery'
  _           = require 'underscore'
  Backbone    = require 'backbone'
  moment      = require 'moment'
  ->

  class InfoModel extends Backbone.Model
    defaults:
      x: 0
      y: 0
    getWhen: ->
      to = moment(@get('heure'))
      return to.format("HH:mm")
      # return to.fromNow()
    getDelay: ->
      if @get('retard')
        delay = @get('retard')
        hours = "#{delay[0]}#{delay[1]}"
        min = "#{delay[2]}#{delay[3]}"
        delay = moment.duration(
          hours: parseInt(hours, 10)
          minutes: parseInt(min, 10)
        )
        to = moment(@get('heure'))
        return to.add(delay).format("HH:mm")
    toJSON: ->
      json = _(@attributes).clone()
      json.when = @getWhen()
      json.delay = @getDelay()
      return json
    # Returns the Router class
    InfoModel