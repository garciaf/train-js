define (require) ->

  Backbone    = require 'backbone'
  moment      = require 'moment'
  require 'localstorage'
  ->

  class UserModel extends Backbone.Model
    
    localStorage: new Backbone.LocalStorage("user")

    initialize: ->
    
      