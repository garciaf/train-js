require.config

  paths:
    "modernizr": "vendors/modernizr"
    "jquery": "vendors/jquery"
    "underscore": "vendors/underscore-min"
    "backbone": "vendors/backbone-min"
    "localstorage": "vendors/backbone.localStorage"
    "i18nprecompile" : "vendors/require-handlebars-plugin/hbs/i18nprecompile"
    "json2" : "vendors/require-handlebars-plugin/hbs/json2"
    "hbs": "vendors/require-handlebars-plugin/hbs"    
    "handlebars": "vendors/Handlebars"
    "jhere": "vendors/jhere"
    "moment": "vendors/moment.min"
    "bootstrap": "vendors/bootstrap"
    "templates": "../templates"

  shim:
    "underscore":
      exports: "_"
    "localstorage":
      deps: ["backbone"]
      exports: "Backbone"
    "zepto":
      exports: "$"
    "bootstrap":
      deps: ["zepto"]
      exports: "$"      
    "jhere":
      exports: "$"
      deps: ["zepto"]
    "backbone":
        deps: ["underscore", "zepto"]
        exports: "Backbone"
  hbs:

    # # callback to determine path to look for helpers
    # helperPathCallback: (name) ->
    #     "helpers/all"
    templateExtension: "hbs"
    disableI18n: true
    "hbs/underscore": "underscore"

require ["modernizr", "jquery", "backbone", "router"], (Modernizr, $, Backbone, Router) ->
  @router = new Router()
