define ["handlebars"], (Handlebars) ->
  
  iconize = (type, options) ->
    icon = switch type
      when "TER" then "<i class='icons-ter'></i>"
      when "TGV" then "<i class='icons-tgv'></i>"
      when "INTERCITES" then "<i class='icons-intercite'></i>"
      when "BUS" then "<i class='icons-bus'></i>"
      when "IDTGV" then "<i class='icons-idtgv'></i>"
      else type
    return icon
  Handlebars.registerHelper "iconize", iconize
  iconize
