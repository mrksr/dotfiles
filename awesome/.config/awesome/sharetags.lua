local ipairs = ipairs
local awful = require("awful")
local capi = {
  screen = screen
}

local sharetags = { }

function sharetags.create_tags(names, layout)
  local primary = capi.screen.primary

  awful.tag(names, primary, layout)
  sharetags.tags = primary.tags
  return sharetags.tags
end

function sharetags.reset_tags(tags)
  for _, tag in ipairs(tags) do
    sharetags.move(tag, capi.screen.primary)
  end
end

function sharetags.move(tag, to_screen)
  if not tag or not to_screen then return end

  if not tag.screen or to_screen ~= tag.screen then
    tag.screen = to_screen
    -- switch for all clients on tag
    for _ , client in ipairs(tag:clients()) do
      if not client.sticky then
        client.screen = to_screen
        client:tags({ tag })
      else
        awful.client.toggletag(tag, client)
      end
    end
  end
end

function sharetags.view_only(tag)
  local swap_tag = awful.tag.selected()
  local was_tag_selected = tag.selected == true
  local tag_original_screen = tag.screen
  local focused_screen = awful.screen.focused()

  if tag.screen ~= focused_screen then
    sharetags.move(tag, focused_screen)
  end

  if swap_tag and was_tag_selected then
    sharetags.move(swap_tag, tag_original_screen)
    awful.tag.viewonly(swap_tag)
  end

  awful.tag.viewonly(tag)
end

return sharetags
