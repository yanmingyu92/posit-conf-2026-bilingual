-- Open external links in a new browser tab
function Link(el)
  if el.target:match("^https?://") then
    el.attributes.target = "_blank"
    return el
  end
end
