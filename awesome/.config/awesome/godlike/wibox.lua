-- define the wibox
local awful     = require("awful")
local beautiful = require("beautiful")
local sharetags = require("sharetags")
local wibox     = require("wibox")
local widgets   = require("godlike.widgets")

godlike.taglistbuttons = godlike.taglistbuttons or
    awful.util.table.join(
       awful.button({ }, 1, awful.tag.viewonly),
       awful.button({ modkey }, 1, awful.client.movetotag),
       awful.button({ }, 3, awful.tag.viewtoggle),
       awful.button({ modkey }, 3, awful.client.toggletag),
       awful.button({ }, 4, function(t) awful.tag.viewnext(awful.tag.getscreen(t)) end),
       awful.button({ }, 5, function(t) awful.tag.viewprev(awful.tag.getscreen(t)) end)
    )

godlike.tasklistbuttons = godlike.tasklistbuttons or
awful.util.table.join(
    awful.button({ }, 1, function(t)
        local swap_t = awful.tag.selected()
        local swap_s = t.screen
        local sel = t.selected
        if t.screen ~= mouse.screen then
            sharetags.tag_move(t, mouse.screen)
        end
        if sel == true then
            sharetags.tag_move(swap_t, swap_s)
            awful.tag.viewonly(swap_t)
        end
        awful.tag.viewonly(t)
    end),
    awful.button({ modkey }, 1, awful.client.movetotag),
    awful.button({ }, 3, function(t)
        if t.screen ~= mouse.screen then
            sharetags.tag_move(t, mouse.screen)
        end
        awful.tag.viewtoggle(t)
    end),
    awful.button({ modkey }, 3, awful.client.toggletag),
    awful.button({ }, 4, function(t) awful.tag.viewnext(awful.tag.getscreen(t)) end),
    awful.button({ }, 5, function(t) awful.tag.viewprev(awful.tag.getscreen(t)) end)
)

godlike.layoutboxbuttons = godlike.layoutboxbuttons or
    awful.util.table.join(
        awful.button({}, 1, function() awful.layout.inc(godlike.layouts,  1) end ),
        awful.button({}, 3, function() awful.layout.inc(godlike.layouts, -1) end ),
        awful.button({}, 4, function() awful.layout.inc(godlike.layouts,  1) end ),
        awful.button({}, 5, function() awful.layout.inc(godlike.layouts, -1) end )
    )

godlike.launcher = godlike.launcher or
           awful.widget.launcher({ image = beautiful.awesome_icon, menu = godlike.mainmenu })

godlike.textclock = godlike.textclock or widgets.clock

for si = 1, screen.count() do
    local s = godlike.screens[si]

    s.promptbox = s.promptbox or awful.widget.prompt()

    if not s.layoutbox then
        s.layoutbox = awful.widget.layoutbox(si)
        s.layoutbox:buttons(godlike.layoutboxbuttons)
    end

    s.taglist = s.taglist or
        awful.widget.taglist(
            si,
            awful.widget.taglist.filter.noempty,
            godlike.taglistbuttons
        )

    s.tasklist = s.tasklist or
        awful.widget.tasklist(
            si,
            awful.widget.tasklist.filter.currenttags,
            godlike.tasklistbuttons
        )

    local layout_left = wibox.layout.fixed.horizontal()
      -- layout_left:add(godlike.launcher)
    layout_left:add(s.layoutbox)
    layout_left:add(s.taglist)
    layout_left:add(s.promptbox)

    local layout_right = wibox.layout.fixed.horizontal()
    layout_right:add(widgets.mail_markus)
    layout_right:add(widgets.mail_tutor)
    layout_right:add(widgets.mail_kth)
    layout_right:add(widgets.mail_intum)
    layout_right:add(widgets.mail_tum)
    -- layout_right:add(widgets.separator)
    -- layout_right:add(widgets.nowplaying)
    layout_right:add(widgets.separator)
    layout_right:add(widgets.traffic)
    layout_right:add(widgets.separator)
    layout_right:add(widgets.wifi)
    layout_right:add(widgets.separator)
    layout_right:add(widgets.volume)
    layout_right:add(widgets.separator)
    layout_right:add(widgets.battery0)
    layout_right:add(widgets.separator)
    layout_right:add(widgets.battery1)
    layout_right:add(widgets.separator)
    layout_right:add(widgets.thermal)
    layout_right:add(widgets.separator)
    layout_right:add(widgets.brightness)
    layout_right:add(widgets.separator)
    layout_right:add(godlike.textclock)
    layout_right:add(widgets.space)
    if si==1 then layout_right:add(wibox.widget.systray()) end

    local layout_top = wibox.layout.align.horizontal()
    layout_top:set_left(layout_left)
    layout_top:set_middle(s.tasklist)
    layout_top:set_right(layout_right)

    if s.wibox == "bottom" then
        s.wibox = awful.wibox({ position = "bottom", screen = si, height = beautiful.wibox_height })
    end
    if s.wibox == "top" or not s.wibox then
        s.wibox = awful.wibox({ position = "top", screen = si, height = beautiful.wibox_height })
    end
    s.wibox:set_widget(layout_top)
end

return godlike