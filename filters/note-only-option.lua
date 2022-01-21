-- notes-only-option.lua is preferred to this one.

function Div(el)
    if el.classes[1] == "note" then
      -- insert element in front
      if el.attr.attributes["only"] then
        table.insert(
            el.content, 1,
            pandoc.RawBlock("latex", "\\note<" .. el.attr.attributes["only"] .. ">{"))
      else
            table.insert(el.content, 1, pandoc.RawBlock("latex", "\\note{"))
      end
      -- insert element at the back
      table.insert(
        el.content,
        pandoc.RawBlock("latex", "}"))
    end
    return el
  end