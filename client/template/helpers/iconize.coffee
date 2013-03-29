define ["handlebars"], (Handlebars) ->
  
  iconize = (type, options) ->
    icon = switch type
      when "TER" then "ter"
      when "TGV" then "tgv"
      when "INTERCITES" then "intercités"
      when "BUS" then "bus"
      else type
    return icon
  Handlebars.registerHelper "iconize", iconize
  iconize
