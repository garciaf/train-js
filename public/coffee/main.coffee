# Sets the require.js configuration for your application.
require.config

  # 3rd party script alias names (Easier to type "jquery" than "vendors/jquery-1.7.2.min")
  paths:
    
    # Core Libraries
    "modernizr": "vendors/modernizr"
    "jquery": "vendors/jquery"
    "underscore": "vendors/underscore-min"
    "backbone": "vendors/backbone-min"
    "i18nprecompile" : "vendors/require-handlebars-plugin/hbs/i18nprecompile"
    "json2" : "vendors/require-handlebars-plugin/hbs/json2"
    "hbs": "vendors/require-handlebars-plugin/hbs"    
    "handlebars": "vendors/Handlebars"
    "jhere": "vendors/jhere"
    "moment": "vendors/moment.min"
    "templates": "../templates"

  # Sets the configuration for your third party scripts that are not AMD compatible
  shim:
    "underscore":
      exports: "_"
    # Twitter Bootstrap jQuery plugins
    "jhere":
      exports: "$"
      deps: ["jquery"]
    "backbone":
        deps: ["underscore", "jquery"]
        exports: "Backbone" #attaches "Backbone" to the window object

  # Settings for the handlebars implementation
  hbs:

    # # callback to determine path to look for helpers
    # helperPathCallback: (name) ->
    #     "helpers/all"
    templateExtension: "hbs"
    # if disableI18n is `true` it won't load locales and the i18n helper
    # won't work as well.
    disableI18n: true
    "hbs/underscore": "underscore"


# Include Desktop Specific JavaScript files here (or inside of your Desktop router)
require ["modernizr", "jquery", "backbone", "router"], (Modernizr, $, Backbone, Router) ->

  # Instantiates a new Router
  @router = new Router()
