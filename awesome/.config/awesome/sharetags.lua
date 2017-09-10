local ipairs = ipairs
local awful = require("awful")

local sharetags = { }

function sharetags.create_tags(names, layout)
  awful.tag(names, 1, layout)
  sharetags.tags = screen[1].tags
  return sharetags.tags
end

function sharetags.move(tag, to_screen)
  if not tag or not to_screen then return end

  if tag.screen and to_screen ~= tag.screen then
    tag.screen = to_screen
    -- switch for all clients on tag
    for _ , client in ipairs(t:clients()) do
      if not c.sticky then
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
  local tag_original_screen = tag.screen
  local focused_screen = awful.screen.focused()

  if tag.screen ~= focused_screen then
    sharetags.move(tag, focused_screen)
  end

  if swap_tag and tag.selected == true then
    sharetags.move(swap_tag, tag_original_screen)
    awful.tag.viewonly(swap_tag)
  end

  awful.tag.viewonly(tag)
end

return sharetags
