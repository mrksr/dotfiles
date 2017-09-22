pcall(require, "luarocks.loader")

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local _dbus = dbus; dbus = nil
local naughty = require("naughty")
dbus = _dbus
-- local menubar = require("menubar")
-- local hotkeys_popup = require("awful.hotkeys_popup").widget
-- -- Enable hotkeys help widget for VIM and other apps
-- -- when client with a matching name is opened:
-- require("awful.hotkeys_popup.keys")

-- Themes define colours, icons, font and wallpapers.
beautiful.init(gears.filesystem.get_configuration_dir() .. "markus-theme/theme.lua")

-- Own stuff
local mywibox = require("mywibox")
local sharetags = require("sharetags")

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = tostring(err) })
        in_error = false
    end)
end
-- }}}

-- {{{ Variable definitions
-- This is used later as the default terminal and editor to run.
terminal = "termite"
editor = os.getenv("EDITOR") or "vim"
editor_cmd = terminal .. " -e " .. editor

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"
altkey = "Mod1"

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
  awful.layout.suit.max,
    -- awful.layout.suit.floating,
    awful.layout.suit.tile,
    -- awful.layout.suit.tile.left,
    -- awful.layout.suit.tile.bottom,
    -- awful.layout.suit.tile.top,
    -- awful.layout.suit.fair,
    -- awful.layout.suit.fair.horizontal,
    -- awful.layout.suit.spiral,
    awful.layout.suit.spiral.dwindle,
    -- awful.layout.suit.max.fullscreen,
    -- awful.layout.suit.magnifier,
    -- awful.layout.suit.corner.nw,
    -- awful.layout.suit.corner.ne,
    -- awful.layout.suit.corner.sw,
    -- awful.layout.suit.corner.se,
}
local tag_names = {
  '',
  '',
  '',
  '',
  '',
  '',
  '',
  '',
  ''
}
sharetags.create_tags(tag_names, awful.layout.layouts[1])
awful.screen.connect_for_each_screen(function(s)
    s:connect_signal("removed", function() sharetags.reset_tags(s.tags) end)
end)
-- }}}

-- {{{ Wibar
local function set_wallpaper(s)
    -- Wallpaper
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        -- If wallpaper is a function, call it with the screen
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        gears.wallpaper.maximized(wallpaper, s, true)
    end
end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

awful.screen.connect_for_each_screen(function(s)
    -- Wallpaper
    set_wallpaper(s)

    -- Wibox
    mywibox.construct_wibar(s)
end)
-- }}}

-- {{{ Key bindings
function view_non_empty(step, s)
  local num_tags = #awful.tag.gettags(s)
  for i=1, num_tags do
    awful.tag.viewidx(step, s)
    if #awful.client.visible(s) > 0 then
      return
    end
  end
end

local function touchpadToggle()
  local device ='"$(xinput --list --name-only | grep -i Synaptics | head -n 1)"'
  local check = 'xinput list-props ' .. device .. ' | grep -ce "Device Enabled.*0$"'
  local toggle = 'xinput set-prop ' .. device .. ' "Device Enabled" $(' .. check .. ')'
  awful.spawn.with_shell(toggle)
end

local function lockSession()
  -- awful.spawn.with_shell("light-locker-command -l || dm-tool lock")
  -- awful.spawn.with_shell("i3lock-fancy -p -f Aller -- scrot -z || i3lock || slimlock")
  awful.spawn.with_shell("i3lock-fancy -g -p -f Aller -- maim -u -m 1")
end

local launcher = 'rofi -show drun'

local audio = {
  play = function() awful.spawn("playerctl play-pause") end,
  stop = function() awful.spawn("playerctl stop") end,
  next = function() awful.spawn("playerctl next") end,
  prev = function() awful.spawn("playerctl previous") end,
  mute = function() awful.spawn("amixer set Master toggle") end,
  micmute = function() awful.spawn("amixer set Capture toggle") end,
  raise = function() awful.spawn("amixer sset Master 8%+") end,
  lower = function() awful.spawn("amixer sset Master 8%-") end,
}

globalkeys = gears.table.join(
    -- Multimedia
    awful.key({}, "XF86AudioMute",        audio.mute),
    awful.key({}, "XF86AudioMicMute",     audio.micmute),
    awful.key({}, "XF86AudioRaiseVolume", audio.raise),
    awful.key({}, "XF86AudioLowerVolume", audio.lower),
    ---
    awful.key({}, "XF86AudioNext",        audio.next),
    awful.key({}, "XF86AudioPrev",        audio.prev),
    awful.key({}, "XF86AudioPlay",        audio.play),
    awful.key({}, "XF86AudioStop",        audio.stop),
    ---
    awful.key({ modkey }, "Right",        audio.next),
    awful.key({ modkey }, "Left",         audio.prev),
    awful.key({ modkey }, "Down",         audio.play),
    awful.key({ modkey }, "Up",           audio.stop),
    awful.key({ altkey }, "Right",        audio.next),
    awful.key({ altkey }, "Left",         audio.prev),
    awful.key({ altkey }, "Down",         audio.play),
    awful.key({ altkey }, "Up",           audio.stop),
    awful.key({ "Mod5" }, "Right",        audio.next),
    awful.key({ "Mod5" }, "Left",         audio.prev),
    awful.key({ "Mod5" }, "Down",         audio.play),
    awful.key({ "Mod5" }, "Up",           audio.stop),

    -- Brightness
    awful.key({}, "XF86MonBrightnessUp",  function() awful.spawn("xbacklight -inc 10 -time 100 -steps 10") end),
    awful.key({}, "XF86MonBrightnessDown",function() awful.spawn("xbacklight -dec 10 -time 100 -steps 10") end),
    awful.key({}, "XF86Display",          function() awful.spawn("xbacklight -set 5") end),
    -- Special Keys
    awful.key({}, "XF86Sleep",            function() awful.spawn("systemctl suspend") end),
    awful.key({}, "XF86ScreenSaver",      lockSession ),
    awful.key({ modkey }, "p",            function() awful.spawn("systemctl suspend") end),
    awful.key({ modkey }, "o",            lockSession ),

    awful.key({}, "XF86TouchpadToggle",   touchpadToggle),
    awful.key({}, "XF86Tools",            touchpadToggle),
    awful.key({ modkey }, "u",            touchpadToggle),
    ---
    awful.key({}, "Print",                function() awful.spawn.with_shell("maim -u /tmp/$(date +%y-%m-%d-%H%M%S)_screen.png") end),

    -- Navigation and Focus
    awful.key({ modkey,           }, "Tab",    function() view_non_empty(1, awful.screen.focused()) end),
    awful.key({ modkey, "Shift"   }, "Tab",    function() view_non_empty(-1, awful.screen.focused()) end),
    awful.key({ modkey,           }, "^",      awful.tag.history.restore),
    awful.key({ modkey,           }, "g",      awful.client.urgent.jumpto),

    awful.key({ altkey,           }, "^",      function()
                                                    awful.client.focus.history.previous()
                                                    if client.focus then client.focus:raise() end
                                               end),
    awful.key({ altkey,           }, "Tab",    function()
                                                    awful.client.focus.byidx( 1)
                                                    if client.focus then client.focus:raise() end
                                                end),
    awful.key({ altkey, "Shift"   }, "Tab",    function()
                                                    awful.client.focus.byidx(-1)
                                                    if client.focus then client.focus:raise() end
                                                end),

    -- Layout manipulation
    awful.key({ modkey,           }, "space",   function() awful.layout.inc(1) end),
    awful.key({ modkey, "Shift"   }, "space",   function() awful.layout.inc(-1) end),

    awful.key({ modkey,           }, "j",       function() awful.client.swap.byidx(  1) end),
    awful.key({ modkey,           }, "k",       function() awful.client.swap.byidx( -1) end),
    awful.key({ modkey, "Shift"   }, "l",       function() awful.screen.focus_relative( 1) end),
    awful.key({ modkey, "Shift"   }, "h",       function() awful.screen.focus_relative(-1) end),
    awful.key({ modkey,           }, "q",       function() awful.screen.focus(1) end),
    awful.key({ modkey,           }, "w",       function() awful.screen.focus(2) end),
    awful.key({ modkey, "Shift"   }, "^",       function() awful.screen.focus_relative(1) end),

    awful.key({ modkey,           }, "l",       function() awful.tag.incmwfact( 0.05) end),
    awful.key({ modkey,           }, "h",       function() awful.tag.incmwfact(-0.05) end),
    awful.key({ modkey, "Shift"   }, "h",       function() awful.tag.incnmaster( 1) end),
    awful.key({ modkey, "Shift"   }, "l",       function() awful.tag.incnmaster(-1) end),
    awful.key({ modkey, "Control" }, "h",       function() awful.tag.incncol( 1) end),
    awful.key({ modkey, "Control" }, "l",       function() awful.tag.incncol(-1) end),

    awful.key({ modkey, "Control" }, "n",       awful.client.restore),

    -- Awesome control
    awful.key({ modkey, "Shift"   }, "r",       awesome.restart),
    awful.key({ modkey, "Control" }, "r",       awesome.quit),

    -- The actual cool stuff
    awful.key({ modkey,           }, "c",       function() awful.spawn(terminal) end),
    awful.key({ modkey,           }, "x",       function() awful.spawn(terminal) end),
    awful.key({ modkey            }, "s",       function ()
                                                    local wibox = awful.screen.focused().wibox
                                                    wibox.visible = not wibox.visible
                                                end),
    awful.key({ modkey,           }, "v",       function() awful.spawn("pavucontrol") end),
    awful.key({ modkey,           }, "f",       function() awful.spawn("gvim") end),
    awful.key({ modkey, "Shift"   }, "f",       function() awful.spawn("emacsclient -nca ''") end),
    awful.key({                   }, "F11",     function() awful.spawn("rofi -show window") end),
    awful.key({                   }, "F12",     function() awful.spawn(launcher) end)
)

clientkeys = gears.table.join(
    awful.key({ modkey,           }, "d",      function (c) c:kill()                         end),
    awful.key({ modkey,           }, "e",      function (c)
                                                    c.fullscreen = not c.fullscreen
                                                    c:raise()
                                                end),
    awful.key({ modkey, "Shift"   }, "e",      function (c)
                                                    c.maximized = not c.maximized
                                                    if not c.maximized then
                                                      c.maximized_horizontal = false
                                                      c.maximized_vertical   = false
                                                    end
                                                end),
    awful.key({ modkey,           }, "r",      function (c) c.ontop = not c.ontop            end),
    awful.key({ modkey,           }, "t",      awful.client.floating.toggle                     ),
    awful.key({ modkey, "Shift"   }, "t", function (c)
                                                    local maximized = c.maximized_horizontal
                                                    c.maximized_horizontal = not maximized
                                                    c.maximized_vertical   = not maximized
                                                end),
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
    awful.key({ modkey, "Shift"   }, "n",      function (c) c.minimized = not c.minimized    end)
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    globalkeys = gears.table.join(globalkeys,
        -- View tag only.
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = awful.screen.focused()
                        local tag = sharetags.tags[i]
                        if tag then
                          sharetags.view_only(tag)
                        end
                  end,
                  {description = "view tag #"..i, group = "tag"}),
        -- Toggle tag display.
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local tag = sharetags.tags[i]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end,
                  {description = "toggle tag #" .. i, group = "tag"}),
        -- Move client to tag.
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = sharetags.tags[i]
                          if tag then
                              client.focus:move_to_tag(tag)
                          end
                     end
                  end,
                  {description = "move focused client to tag #"..i, group = "tag"}),
        -- Toggle tag on focused client.
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = sharetags.tags[i]
                          if tag then
                              client.focus:toggle_tag(tag)
                          end
                      end
                  end,
                  {description = "toggle focused client on tag #" .. i, group = "tag"})
    )
end
-- Do the same for F-Keys
for i = 6, 9 do
    globalkeys = gears.table.join(globalkeys,
        -- View tag only.
        awful.key({ modkey }, "F" .. i - 5,
                  function ()
                        local screen = awful.screen.focused()
                        local tag = sharetags.tags[i]
                        if tag then
                          sharetags.view_only(tag)
                        end
                  end,
                  {description = "view tag #"..i, group = "tag"}),
        -- Toggle tag display.
        awful.key({ modkey, "Control" }, "F" .. i - 5,
                  function ()
                      local tag = sharetags.tags[i]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end,
                  {description = "toggle tag #" .. i, group = "tag"}),
        -- Move client to tag.
        awful.key({ modkey, "Shift" }, "F" .. i - 5,
                  function ()
                      if client.focus then
                          local tag = sharetags.tags[i]
                          if tag then
                              client.focus:move_to_tag(tag)
                          end
                     end
                  end,
                  {description = "move focused client to tag #"..i, group = "tag"}),
        -- Toggle tag on focused client.
        awful.key({ modkey, "Control", "Shift" }, "F" .. i - 5,
                  function ()
                      if client.focus then
                          local tag = sharetags.tags[i]
                          if tag then
                              client.focus:toggle_tag(tag)
                          end
                      end
                  end,
                  {description = "toggle focused client on tag #" .. i, group = "tag"})
    )
end

clientbuttons = gears.table.join(
    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
    awful.button({ modkey }, 1, awful.mouse.client.move),
    awful.button({ modkey }, 3, awful.mouse.client.resize))

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = awful.client.focus.filter,
                     raise = true,
                     keys = clientkeys,
                     buttons = clientbuttons,
                     screen = awful.screen.preferred,
                     placement = awful.placement.no_overlap+awful.placement.no_offscreen
     }
    },

    -- Floating clients.
    { rule_any = {
        class = {
          "pinentry",
          "Gcr-prompter",
        },

        name = {
          "Event Tester", -- xev.
        },
        role = {
          "pop-up", -- e.g. Google Chrome's (detached) Developer Tools.
        }
      }, properties = { floating = true }},
    { rule = { class = "Gcr-prompter" },
      callback = function (c)
        awful.placement.centered(c, nil)
    end },

    { rule = { class = "Pidgin" },
      properties = { tag = tag_names[4] } },
    { rule = { class = "Gajim" },
      properties = { tag = tag_names[4] } },
    { rule = { name = "Gitter" },
      properties = { tag = tag_names[4] } },
    { rule = { class = "Skype" },
      properties = { tag = tag_names[4] },
      callback = awful.client.setslave },

    { rule = { class = "Thunderbird" },
      properties = { tag = tag_names[5] } },
    { rule = { class = "Astroid" },
      properties = { tag = tag_names[5] } },

    { rule = { class = "Firefox" },
      properties = { tag = tag_names[2] } },
    { rule = { class = "Opera" },
      properties = { tag = tag_names[2] } },
    { rule = { class = "Chromium" },
      properties = { tag = tag_names[2] } },
    { rule = { class = "Google-chrome-stable" },
      properties = { tag = tag_names[2] } },
    { rule = { class = "Google-chrome" },
      properties = { tag = tag_names[2] } },

    { rule = { class = "Spotify" },
      properties = { tag = tag_names[9] } },
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    -- if not awesome.startup then awful.client.setslave(c) end

    if awesome.startup and
      not c.size_hints.user_position
      and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end
end)

client.connect_signal("property::sticky", function(c)
                        if c.sticky then
                          awful.client.setslave(c)
                        end
end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
    if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
        and awful.client.focus.filter(c) then
        client.focus = c
    end
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)

awful.screen.connect_for_each_screen(function(s)
    -- No borders for single windows
    s:connect_signal("arrange", function ()
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

    -- Hide invisible clients in max
    s:connect_signal("arrange", function ()
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

    -- No gaps for max layout
    s:connect_signal("arrange", function ()
                       local layout = awful.layout.getname(awful.layout.get(s))
                       for _, tag in pairs(screen[s].selected_tags) do
                         if layout == "max" then
                           tag.gap = 0
                         else
                           tag.gap = beautiful.useless_gap or 0
                         end
                       end
    end)

    -- Don't get (so) confused by sticky windows
    for _, tag in pairs(s.tags) do
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
end)
-- }}}
