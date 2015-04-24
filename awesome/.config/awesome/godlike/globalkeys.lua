-- global keybindings
-- you should use all of them with modkey
-- except for multimedia keys of course

local awful     = require("awful")
local menubar   = require("menubar")
local naughty   = require("naughty")
local beautiful = require("beautiful")
local lm        = require("godlike.layoutmode")
local sharetags = require("sharetags")

local modkey    = godlike.modkey
local altkey    = godlike.altkey
local exec      = godlike.exec
local sexec     = godlike.sexec
local format    = string.format

function view_non_empty(step, s)
    local s = s or 1

    local num_tags = #awful.tag.gettags(s)
    for i=1, num_tags do
        awful.tag.viewidx(step, s)
        if #awful.client.visible(s) > 0 then
            return
        end
    end
end

local function touchpadToggle()
    local toggle = "synclient TouchpadOff=$(synclient -l | grep -ce 'TouchpadOff.*0')"
    local palmrest = "pkill syndaemon; (sleep 0.5 ; syndaemon -k -i 0.8 -d ); (sleep 0.75 ; synclient PalmDetect=1)"
    sexec(toggle .. "; " .. palmrest)
end

local launcher = format(
    'yeganesh -x -- -i -fn "%s" -nb "%s" -nf "%s" -sb "%s" -sf "%s" | /bin/sh',
    beautiful.font,
    beautiful.bg_normal,
    beautiful.fg_normal,
    beautiful.bg_urgent,
    beautiful.fg_urgent
)

godlike.globalkeys = awful.util.table.join(
    -- Multimedia
    awful.key({}, "XF86AudioMute",        function() godlike.audio.mute()  end ),
    awful.key({}, "XF86AudioMicMute",     function() godlike.audio.micmute()end ),
    awful.key({}, "XF86AudioRaiseVolume", function() godlike.audio.raise() end ),
    awful.key({}, "XF86AudioLowerVolume", function() godlike.audio.lower() end ),
    ---
    awful.key({}, "XF86AudioNext",        function() godlike.audio.next()  end ),
    awful.key({}, "XF86AudioPrev",        function() godlike.audio.prev()  end ),
    awful.key({}, "XF86AudioPlay",        function() godlike.audio.play()  end ),
    awful.key({}, "XF86AudioStop",        function() godlike.audio.stop()  end ),
    ---
    awful.key({ modkey }, "Right",        function() godlike.audio.next()  end ),
    awful.key({ modkey }, "Left",         function() godlike.audio.prev()  end ),
    awful.key({ modkey }, "Down",         function() godlike.audio.play()  end ),
    awful.key({ modkey }, "Up",           function() godlike.audio.stop()  end ),

    -- Brightness
    awful.key({}, "XF86MonBrightnessUp",  function() sexec("xbacklight -inc 10 -time 100 -steps 10")  end ),
    awful.key({}, "XF86MonBrightnessDown",function() sexec("xbacklight -dec 10 -time 100 -steps 10")  end ),
    awful.key({}, "XF86Display",          function() sexec("xbacklight -set 1")  end ),
    -- Special Keys
    awful.key({}, "XF86Sleep",            function() sexec("systemctl suspend") end ),
    awful.key({}, "XF86ScreenSaver",      function() sexec("dm-tool lock") end ),
    awful.key({ modkey }, "p",            function() sexec("systemctl suspend") end ),
    awful.key({ modkey }, "o",            function() sexec("dm-tool lock") end),

    awful.key({}, "XF86TouchpadToggle",   touchpadToggle),
    awful.key({}, "XF86Tools",            touchpadToggle),
    awful.key({ modkey }, "u",            touchpadToggle),

    -- Navigation and Focus
    awful.key({ modkey,           }, "Tab",    function() view_non_empty(1, mouse.screen) end ),
    awful.key({ modkey, "Shift"   }, "Tab",    function() view_non_empty(-1, mouse.screen) end ),
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
    awful.key({ modkey,           }, "space",   function() awful.layout.inc(godlike.layouts,  1) end),
    awful.key({ modkey, "Shift"   }, "space",   function() awful.layout.inc(godlike.layouts, -1) end),

    awful.key({ modkey,           }, "j",       function() awful.client.swap.byidx(  1)    end),
    awful.key({ modkey,           }, "k",       function() awful.client.swap.byidx( -1)    end),
    awful.key({ modkey, "Shift"   }, "l",       function() awful.screen.focus_relative( 1) end),
    awful.key({ modkey, "Shift"   }, "h",       function() awful.screen.focus_relative(-1) end),
    awful.key({ modkey,           }, "q",       function() awful.screen.focus(1) end),
    awful.key({ modkey,           }, "w",       function() awful.screen.focus(2) end),

    awful.key({ modkey,           }, "l",       function() awful.tag.incmwfact( 0.05)    end),
    awful.key({ modkey,           }, "h",       function() awful.tag.incmwfact(-0.05)    end),
    awful.key({ modkey, "Shift"   }, "h",       function() awful.tag.incnmaster( 1)      end),
    awful.key({ modkey, "Shift"   }, "l",       function() awful.tag.incnmaster(-1)      end),
    awful.key({ modkey, "Control" }, "h",       function() awful.tag.incncol( 1)         end),
    awful.key({ modkey, "Control" }, "l",       function() awful.tag.incncol(-1)         end),

    awful.key({ modkey, "Control" }, "n",       awful.client.restore),
    awful.key({ modkey,           }, "b",       function() lm.activate() end),

    -- Awesome control
    awful.key({ modkey, "Shift"   }, "r",       awesome.restart),
    awful.key({ modkey, "Control" }, "r",       awesome.quit),

    -- The actual cool stuff
    awful.key({ modkey,           }, "c",       function() exec(godlike.terminal) end),
    awful.key({ modkey,           }, "x",       function() godlike.screens[mouse.screen].promptbox:run() end),
    awful.key({ modkey            }, "s",       function ()
                                                    local wibox = godlike.screens[mouse.screen].wibox
                                                    wibox.visible = not wibox.visible
                                                end),
    awful.key({ modkey,           }, "v",       function() exec("pavucontrol") end),
    awful.key({ modkey,           }, "f",       function() exec("gvim") end),
    awful.key({                   }, "F12",     function() sexec(launcher) end)
)

-- Tag manipulation
-- This loop uses keycodes to map
for i = 1, 9 do
    godlike.globalkeys = awful.util.table.join(godlike.globalkeys,
        awful.key({ modkey }, "#" .. i + 9,
            function ()
                sharetags.tag_viewonly(godlike.tags[i])
            end),
        awful.key({ modkey, "Control" }, "#" .. i + 9,
            function ()
                if godlike.tags[i] then
                    awful.tag.viewtoggle(godlike.tags[i])
                end
            end),
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
            function ()
                if client.focus and godlike.tags[i] then
                    awful.client.movetotag(godlike.tags[i])
                end
            end),
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
            function ()
                if client.focus and godlike.tags[i] then
                    awful.client.toggletag(godlike.tags[i])
                end
            end))
end
-- Do the same for F-keys
for i = 6, 9 do
    godlike.globalkeys = awful.util.table.join(godlike.globalkeys,
        awful.key({ modkey }, "F" .. i - 5,
            function ()
                sharetags.tag_viewonly(godlike.tags[i])
            end),
        awful.key({ modkey, "Control" }, "F" .. i - 5,
            function ()
                if godlike.tags[i] then
                    awful.tag.viewtoggle(godlike.tags[i])
                end
            end),
        awful.key({ modkey, "Shift" }, "F" .. i - 5,
            function ()
                if client.focus and godlike.tags[i] then
                    awful.client.movetotag(godlike.tags[i])
                end
            end),
        awful.key({ modkey, "Control", "Shift" }, "F" .. i - 5,
            function ()
                if client.focus and godlike.tags[i] then
                    awful.client.toggletag(godlike.tags[i])
                end
            end))
end

root.keys(godlike.globalkeys)

-- Mouse
root.buttons(awful.util.table.join(
    awful.button({ }, 3, function() godlike.menu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))

return godlike
