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
    getTimeremaining: ->
      to = if !!@get('retard') then @getDelayTime() else @getWhenTime()
      return moment.duration(to.diff(new Date()))
      # return to.from(moment(new Date()))
    
    getWhenTime: ->
      return moment(@get('heure'))

    getWhen: ->
      return @getWhenTime().format("HH:mm")
      
    getDelayTime: ->
      if @get('retard')
        delay = @get('retard')
        hours = "#{delay[0]}#{delay[1]}"
        min = "#{delay[2]}#{delay[3]}"
        delay = moment.duration(
          hours: parseInt(hours, 10)
          minutes: parseInt(min, 10)
        )
        to = moment(@get('heure'))
        return to.add(delay)
      return false

    getDelay: ->
      time = @getDelayTime()
      if time
        return time.format("HH:mm")
      return null
    toJSON: ->
      json = _(@attributes).clone()
      json.when = @getWhen()
      json.delay = @getDelay()
      return json
    # Returns the Router class
    InfoModel