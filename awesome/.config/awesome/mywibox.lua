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

mywibox.add_colorbar = function(widget, color)
  if beautiful.wibox_colorbar_height <= 0 then
    return widget
  else
    if beautiful.wibox_position == "top" then
      return {
        layout = wibox.container.margin,
        top = beautiful.wibox_colorbar_height,
        color = color,
        widget
      }
    else
      return {
        layout = wibox.container.margin,
        bottom = beautiful.wibox_colorbar_height,
        color = color,
        widget
      }
    end
  end
end

mywibox.construct_wibar = function(screen)
  if not screen.layoutbox then
    screen.layoutbox = awful.widget.layoutbox(screen)
    screen.layoutbox:buttons(mywibox.layoutboxbuttons)
  end

  screen.taglist = screen.taglist or awful.widget.taglist(
    screen,
    awful.widget.taglist.filter.noempty,
    mywibox.taglist_buttons,
    {
      spacing = 3,
      fg_focus = beautiful.blue,
      fg_urgent = beautiful.red,
      fg_volatile = beautiful.green,
      bg_occupied = "#00000000",
      bg_focus = "#00000000",
      bg_urgent = "#00000000",
    }
                                                         )

  screen.tasklist = screen.tasklist or awful.widget.tasklist(
    screen,
    awful.widget.tasklist.filter.currenttags,
    mywibox.tasklist_buttons,
    {
      spacing = 3,
      font_focus = "Aller Bold 12",
      font_urgent = "Aller Bold 12",
      bg_normal = "#00000000",
      bg_focus = "#00000000",
      bg_urgent = "#00000000",
      bg_minimize = "#00000000",
    }
                                                            )

  local wibox_position = "top"
  if screen.wibar then
    wibox_position = screen.wibar
  elseif beautiful.wibox_position then
    wibox_position = beautiful.wibox_position
  end

  screen.wibar = awful.wibar({
      position = wibox_position,
      screen = screen,
      height = beautiful.wibox_height
  })
  screen.wibar:setup({
      layout = wibox.layout.align.horizontal,
      {
        layout = wibox.layout.fixed.horizontal,
        mywidgets.small_space,
        mywibox.add_colorbar(screen.layoutbox, beautiful.green),
        mywidgets.space,
        mywibox.add_colorbar(screen.taglist, beautiful.blue),
        mywidgets.space,
      },
      -- mywibox.add_colorbar(screen.tasklist, beautiful.bg_focus),
      screen.tasklist,
      {
        layout = wibox.layout.fixed.horizontal,
        mywibox.add_colorbar(mywidgets.mail_markus, beautiful.green),
        mywibox.add_colorbar(mywidgets.mail_tutor, beautiful.green),
        mywibox.add_colorbar(mywidgets.mail_kth, beautiful.green),
        mywibox.add_colorbar(mywidgets.mail_intum, beautiful.green),
        mywibox.add_colorbar(mywidgets.mail_tum, beautiful.green),
        mywidgets.space,
        mywibox.add_colorbar(mywidgets.traffic, beautiful.blue),
        mywidgets.space,
        mywibox.add_colorbar(mywidgets.wifi, beautiful.red),
        mywidgets.space,
        mywibox.add_colorbar(mywidgets.volume, beautiful.yellow),
        mywidgets.space,
        mywibox.add_colorbar(mywidgets.battery0, beautiful.green),
        mywibox.add_colorbar(mywidgets.battery1, beautiful.green),
        mywidgets.space,
        mywibox.add_colorbar(mywidgets.thermal, beautiful.blue),
        mywidgets.space,
        mywibox.add_colorbar(mywidgets.brightness, beautiful.red),
        mywidgets.space,
        mywibox.add_colorbar(mywidgets.clock, beautiful.yellow),
        mywidgets.small_space,
        wibox.widget.systray(),
      },
  })
end

return mywibox
