define (require) ->

  $           = require 'jquery'
  _           = require 'underscore'
  Backbone    = require 'backbone'
  moment      = require 'moment'
  require 'localstorage'
  ->

  class UserModel extends Backbone.Model
    
    localStorage: new Backbone.LocalStorage("user")

    initialize: ->
    
      