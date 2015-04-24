-- keybindings for client windows

local awful = require("awful")
local modkey = godlike.modkey

godlike.clientkeys = awful.util.table.join(
    awful.key({ modkey,           }, "d",      function (c) c:kill()                         end),
    awful.key({ modkey,           }, "e",      function (c) c.fullscreen = not c.fullscreen  end),
    awful.key({ modkey,           }, "r",      function (c) c.ontop = not c.ontop            end),
    awful.key({ modkey,           }, "t",      awful.client.floating.toggle                     ),
    awful.key({ modkey,           }, "a",      function (c) c.sticky = not c.sticky          end),
    awful.key({ modkey,           }, "Return", function (c) c:swap(awful.client.getmaster()) end),
    awful.key({ modkey, "Shift"   }, "q",      function (c)
                                                    awful.client.movetoscreen(c, 1);
                                                    client.focus = c;
                                                    c:raise()
                                                end),
    awful.key({ modkey, "Shift"   }, "w",      function (c)
                                                    awful.client.movetoscreen(c, 2);
                                                    client.focus = c;
                                                    c:raise()
                                                end),
    awful.key({ modkey, "Shift"   }, "r",      function (c) c:redraw()                       end),
    awful.key({ modkey, "Shift"   }, "n",      function (c) c.minimized = not c.minimized    end),
    awful.key({ modkey, "Shift"   }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c.maximized_vertical   = not c.maximized_vertical
        end)
)

godlike.clientbuttons = awful.util.table.join(
    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
    awful.button({ modkey }, 1, awful.mouse.client.move),
    awful.button({ modkey }, 3, awful.mouse.client.resize)
)

return godlike
