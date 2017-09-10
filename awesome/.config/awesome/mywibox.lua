-- define the wibox
local awful     = require("awful")
local beautiful = require("beautiful")
local gears     = require("gears")
local wibox     = require("wibox")
local mywidgets = require("mywidgets")

local mywibox = {}

mywibox.taglist_buttons = gears.table.join(
  awful.button({ }, 1, function(t) t:view_only() end),
  awful.button({ modkey }, 1, function(t)
      if client.focus then
        client.focus:move_to_tag(t)
      end
  end),
  awful.button({ }, 3, awful.tag.viewtoggle),
  awful.button({ modkey }, 3, function(t)
      if client.focus then
        client.focus:toggle_tag(t)
      end
  end),
  awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
  awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
)

mywibox.tasklist_buttons = gears.table.join(
  awful.button({ }, 1, function (c)
      if c == client.focus then
        c.minimized = true
      else
        -- Without this, the following
        -- :isvisible() makes no sense
        c.minimized = false
        if not c:isvisible() and c.first_tag then
          c.first_tag:view_only()
        end
        -- This will also un-minimize
        -- the client, if needed
        client.focus = c
        c:raise()
      end
  end),
  -- awful.button({ }, 3, client_menu_toggle_fn()),
  awful.button({ }, 4, function ()
      awful.client.focus.byidx(1)
  end),
  awful.button({ }, 5, function ()
      awful.client.focus.byidx(-1)
end))

mywibox.layoutboxbuttons = gears.table.join(
        awful.button({}, 1, function() awful.layout.inc( 1) end ),
        awful.button({}, 3, function() awful.layout.inc(-1) end ),
        awful.button({}, 4, function() awful.layout.inc( 1) end ),
        awful.button({}, 5, function() awful.layout.inc(-1) end )
    )

mywibox.construct_wibar = function(s)
    if not s.layoutbox then
        s.layoutbox = awful.widget.layoutbox(s)
        s.layoutbox:buttons(mywibox.layoutboxbuttons)
    end

    s.taglist = s.taglist or awful.widget.taglist(
      s,
      awful.widget.taglist.filter.noempty,
      mywibox.taglist_buttons
    )

    s.tasklist = s.tasklist or awful.widget.tasklist(
      s,
      awful.widget.tasklist.filter.currenttags,
      mywibox.tasklist_buttons
    )

    local wibox_position = "top"
    if s.wibox then
      wibox_position = s.wibox
    elseif beautiful.wibox_position then
      wibox_position = beautiful.wibox_position
    end

    s.wibox = awful.wibox({
        position = wibox_position,
        screen = s,
        height = beautiful.wibox_height
    })
    s.wibox:setup {
      layout = wibox.layout.align.horizontal,
      {
        layout = wibox.layout.fixed.horizontal,
        -- s.layoutbox,
        s.taglist,
        mywidgets.space,
        -- mywidgets.separator,
      },
      s.tasklist,
      {
        layout = wibox.layout.fixed.horizontal,
        mywidgets.mail_markus,
        mywidgets.mail_tutor,
        mywidgets.mail_kth,
        mywidgets.mail_intum,
        mywidgets.mail_tum,
        -- mywidgets.separator,
        -- mywidgets.nowplaying,
        mywidgets.separator,
        mywidgets.traffic,
        mywidgets.separator,
        mywidgets.wifi,
        mywidgets.separator,
        mywidgets.volume,
        mywidgets.separator,
        mywidgets.battery0,
        mywidgets.separator,
        mywidgets.battery1,
        mywidgets.separator,
        mywidgets.thermal,
        mywidgets.separator,
        mywidgets.brightness,
        mywidgets.separator,
        mywidgets.clock,
        mywidgets.space,
        wibox.widget.systray(),
      },
    }
end

return mywibox
