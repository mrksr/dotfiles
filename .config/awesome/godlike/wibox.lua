-- define the wibox
local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local widgets = require("godlike.widgets")

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
               awful.button({ }, 1, function (c)
                                       if c == client.focus then -- c.minimized = true
                                       else c.minimized = false
                                            if not c:isvisible() then awful.tag.viewonly(c:tags()[1]) end
                                            client.focus = c; c:raise()
                                       end end),
               awful.button({ }, 3, function ()
                                       if instance then instance:hide(); instance = nil
                                       else instance = awful.menu.clients({ theme = { width = 250 } })
                                       end end),
               awful.button({ }, 4, function ()
                                       awful.client.focus.byidx(1)
                                       if client.focus then client.focus:raise() end end),
               awful.button({ }, 5, function ()
                                       awful.client.focus.byidx(-1)
                                       if client.focus then client.focus:raise() end end)
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
    layout_right:add(widgets.volume)
    layout_right:add(widgets.separator)
    layout_right:add(widgets.wifi)
    layout_right:add(widgets.separator)
    layout_right:add(widgets.traffic)
    layout_right:add(widgets.separator)
    layout_right:add(widgets.battery)
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
        s.wibox = awful.wibox({ position = "bottom", screen = si, height = 16 })
    end
    if s.wibox == "top" or not s.wibox then
        s.wibox = awful.wibox({ position = "top", screen = si, height = 16 })
    end
    s.wibox:set_widget(layout_top)
end

return godlike