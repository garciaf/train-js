require.config

  paths:
    "zepto": "vendors/zepto.min"
    "jherezepto": "vendors/zepto.adapter"
    "selector": "vendors/selector"
    "fx_methods": "vendors/fx_methods"
    "detect": "vendors/detect"
    "underscore": "vendors/underscore"
    "backbone": "vendors/backbone"
    "i18nprecompile" : "vendors/require-handlebars-plugin/hbs/i18nprecompile"
    "json2" : "vendors/require-handlebars-plugin/hbs/json2"
    "hbs": "vendors/require-handlebars-plugin/hbs"    
    "handlebars": "vendors/Handlebars"
    "jhere": "vendors/jhere"
    "moment": "vendors/moment.min"
    "text": "vendors/text"
    "json": "vendors/json"
    
    "templates": "../templates"

  shim:

    "underscore":
      exports: "_"
    "zepto":
      exports: "$"
    "fx_methods":
      exports: "$"
      deps: ["zepto"]
    "jherezepto":
      exports: "$"
      deps: ["zepto"]
    "selector":
      deps: ["zepto"]
      exports: "$"
    "detect":
      deps: ["zepto"]
      exports: "$"
    "jhere":
      exports: "$"
      deps: ["jherezepto"]
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

require ["router"], (Router) ->
  @router = new Router()
