function Div(el)
    -- Only handle note divs that should appear on specific slides.
    -- We rely on pandoc to handle other notes.
    if el.classes[1] ~= "notes" or not el.attr.attributes.only then
      return el
    end
  
    return
      {pandoc.RawBlock("tex", "\\note<" .. el.attr.attributes.only .. ">{")} ..
      el.content ..
      {pandoc.RawBlock("tex", "}")}
  end