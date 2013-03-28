define ["handlebars"], (Handlebars) ->
  capitalize = (context, options) ->
    low = "#{context}".toLowerCase()
    low.charAt(0).toUpperCase() + low.slice(1)
  
  Handlebars.registerHelper "capitalize", capitalize
  capitalize
