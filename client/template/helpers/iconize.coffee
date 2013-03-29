define ["handlebars"], (Handlebars) ->
  
  iconize = (type, options) ->
    icon = switch type
      when "TER" then "<img src='/img/ter.png'>"
      when "TGV" then "<img src='/img/tgv.jpg'>"
      when "INTERCITES" then "<img src='/img/intercite.png'>"
      when "BUS" then "<img src='/img/bus.png'>"
      else type
    return icon
  Handlebars.registerHelper "iconize", iconize
  iconize
