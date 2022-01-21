function Div(el)
    if el.attr.attributes["color"] then
      -- insert element in front
      table.insert(
        el.content, 1,
        pandoc.RawBlock("latex", "{\\color{" .. el.attr.attributes["color"] .. "}"))
      -- insert element at the back
      table.insert(
        el.content,
        pandoc.RawBlock("latex", "}"))
    end
    return el
  end