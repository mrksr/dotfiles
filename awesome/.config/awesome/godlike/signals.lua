local awful = require("awful")
local beautiful = require("beautiful")

-------------------
--  Positioning  --
-------------------
client.connect_signal("manage", function (c, startup)
    -- Enable sloppy focus
    c:connect_signal("mouse::enter", function(c)
        if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
            and awful.client.focus.filter(c) then
            client.focus = c
        end
    end)

    if not startup then
        -- Set the windows at the slave,
        -- i.e. put it at the end of others instead of setting it master.
        -- awful.client.setslave(c)

        -- Put windows in a smart way, only if they does not set an initial position.
        if not c.size_hints.user_position and not c.size_hints.program_position then
            awful.placement.no_overlap(c)
            awful.placement.no_offscreen(c)
        end
    end
end)

----------------------------
--  Above while floating  --
----------------------------
client.connect_signal("property::floating", function(c)
    if awful.client.floating.get(c) then
        c.above = true
    else
        c.above = false
    end
end)

client.connect_signal("property::sticky", function(c)
    if c.sticky then
        awful.client.setslave(c)
    end
end)

---------------------
--  Border Colors  --
---------------------
client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)

-------------------------------------
--  No Borders for single windows  --
-------------------------------------
for s = 1, screen.count() do screen[s]:connect_signal("arrange", function ()
    local clients = awful.client.visible(s)
    local layout = awful.layout.getname(awful.layout.get(s))

    for _, c in pairs(clients) do
        if awful.client.floating.get(c) then
            c.border_width = beautiful.border_width
        elseif #clients == 1 or layout == "max" then
            c.border_width = 0
        else
            c.border_width = beautiful.border_width
        end
    end
    end)
end

-------------------------------------
--  Hide invisible clients in max  --
-------------------------------------
for s = 1, screen.count() do screen[s]:connect_signal("arrange", function ()
    local clients = awful.client.visible(s)
    local layout = awful.layout.getname(awful.layout.get(s))

    local focused = client.focus
    local top_of_stack = awful.client.visible(s, true)[1]

    local focused_is_not_tiled = focused and (
        focused.maximized or
        focused.floating or
        focused.above
        )
    local top_of_stack_is_not_tiled = top_of_stack and (
        top_of_stack.maximized or
        top_of_stack.floating or
        top_of_stack.above
        )

    for _, c in pairs(clients) do
        local is_of_interest = (c == focused) or (c == top_of_stack)
        local is_not_tiled = (c.maximized or c.floating or c.above)
        if layout == "max" and (
                not focused_is_not_tiled and
                not top_of_stack_is_not_tiled and
                not is_of_interest and
                not is_not_tiled
                ) then
            c.opacity = 0
        else
            c.opacity = 1
        end
    end
end)
end

------------------------------
--  No gaps for max layout  --
------------------------------
for s = 1, screen.count() do screen[s]:connect_signal("arrange", function ()
    local layout = awful.layout.getname(awful.layout.get(s))
    for _, tag in pairs(screen[s].selected_tags) do
        if layout == "max" then
            tag.gap = 0
        else
            tag.gap = beautiful.useless_gap or 0
        end
    end
    end)
end

-------------------------------------------------
--  Don't get (so) confused by sticky windows  --
-------------------------------------------------
for s = 1, screen.count() do
    for _, tag in pairs(awful.tag.gettags(s)) do
        tag:connect_signal("property::selected", function(tag)
            local focus = client.focus
            if focus and focus.sticky then
                local first = awful.client.visible(s, true)[1]
                for _, c in pairs(awful.client.visible(s)) do
                    if not c.sticky and awful.client.focus.filter(c) then
                        client.focus = c
                        c:raise()
                        return
                    end
                end

                if first and awful.client.focus.filter(first) then
                    client.focus = first
                    first:raise()
                end
            end
        end)
    end
end

return godlike
