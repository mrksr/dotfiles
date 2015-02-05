-- global keybindings
-- you should use all of them with modkey
-- except for multimedia keys of course

local awful   = require("awful")
local menubar = require("menubar")
local quake   = require("godlike.quake")
local naughty = require("naughty")
--require("revelation")

local modkey  = godlike.modkey
local altkey  = godlike.altkey
local exec    = godlike.exec
local sexec   = godlike.sexec

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

godlike.globalkeys = awful.util.table.join(
    -- Multimedia
    awful.key({}, "XF86AudioMute",        function() godlike.audio.mute()  end ),
    awful.key({}, "XF86AudioRaiseVolume", function() godlike.audio.raise() end ),
    awful.key({}, "XF86AudioLowerVolume", function() godlike.audio.lower() end ),
    awful.key({}, "XF86AudioNext",        function() godlike.audio.next()  end ),
    awful.key({}, "XF86AudioPrev",        function() godlike.audio.prev()  end ),
    awful.key({}, "XF86AudioPlay",        function() godlike.audio.play()  end ),
    awful.key({}, "XF86AudioStop",        function() godlike.audio.stop()  end ),

    -- Special Keys
    awful.key({}, "XF86Sleep",            function() sexec("systemctl suspend") end ),
    awful.key({}, "XF86ScreenSaver",      function() sexec("slimlock") end ),
    awful.key({}, "XF86TouchpadToggle",   function()
                                                local toggle = "synclient TouchpadOff=$(synclient -l | grep -ce TouchpadOff.*0)"
                                                local palmrest = "pkill syndaemon && (sleep 0.5 ; syndaemon -k -i 0.8 -d ) && (sleep 0.75 ; synclient PalmDetect=1)"
                                                sexec(toggle .. " && " .. palmrest)
                                          end ),

    -- Navigation and Focus
    awful.key({ modkey,           }, "Tab",    function() view_non_empty(1, mouse.screen) end ),
    awful.key({ modkey, "Shift"   }, "Tab",    function() view_non_empty(-1, mouse.screen) end ),
    awful.key({ modkey,           }, "^",      awful.tag.history.restore),
    awful.key({ modkey,           }, "u",      awful.client.urgent.jumpto),

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

    awful.key({ modkey,           }, "l",       function() awful.tag.incmwfact( 0.05)    end),
    awful.key({ modkey,           }, "h",       function() awful.tag.incmwfact(-0.05)    end),
    awful.key({ modkey, "Shift"   }, "h",       function() awful.tag.incnmaster( 1)      end),
    awful.key({ modkey, "Shift"   }, "l",       function() awful.tag.incnmaster(-1)      end),
    awful.key({ modkey, "Control" }, "h",       function() awful.tag.incncol( 1)         end),
    awful.key({ modkey, "Control" }, "l",       function() awful.tag.incncol(-1)         end),

    awful.key({ modkey, "Control" }, "n",       awful.client.restore),

    -- Awesome control
    awful.key({ modkey,           }, "q",       awesome.restart),
    awful.key({ modkey, "Shift"   }, "q",       awesome.quit),

    -- The actual cool stuff
    awful.key({ modkey,           }, "p",       function() menubar.show() end),
    awful.key({ modkey,           }, "c",       function() exec(godlike.terminal) end),
    awful.key({ modkey,           }, "m",       function() godlike.menu:show({keygrabber=true}) end),
    awful.key({ modkey,           }, "x",       function() godlike.screens[mouse.screen].promptbox:run() end),
    -- awful.key({ modkey,           }, "s",       quake.toggle),
    -- awful.key({ modkey },      "e",   function () revelation.expose({class=""}, mouse.screen) end),
    awful.key({ modkey,           }, "v",       function() exec("pavucontrol") end),
    awful.key({ modkey,           }, "o",       function() exec("gvim") end)
)

-- Tag manipulation
-- This loop uses keycodes to map
for i = 1, 9 do
    godlike.globalkeys = awful.util.table.join(godlike.globalkeys,
        -- View tag only.
        awful.key({ modkey }, "#" .. i + 9,
                  function()
                        local tag = awful.tag.gettags(mouse.screen)[i]
                        if tag then awful.tag.viewonly(tag) end
                  end),
        -- Toggle tag.
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function()
                      local tag = awful.tag.gettags(mouse.screen)[i]
                      if tag then awful.tag.viewtoggle(tag) end
                  end),
        -- Move client to tag.
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function()
                      if client.focus then
                          local tag = awful.tag.gettags(client.focus.screen)[i]
                          if tag then awful.client.movetotag(tag) end
                      end
                  end),
        -- Toggle tag.
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function()
                      if client.focus then
                          local tag = awful.tag.gettags(client.focus.screen)[i]
                          if tag then awful.client.toggletag(tag) end
                      end
                  end))
end
-- Do the same for F-keys
for i = 6, 9 do
    godlike.globalkeys = awful.util.table.join(godlike.globalkeys,
        -- View tag only.
        awful.key({ modkey }, "F" .. i - 5,
                  function()
                        local tag = awful.tag.gettags(mouse.screen)[i]
                        if tag then awful.tag.viewonly(tag) end
                  end),
        -- Toggle tag.
        awful.key({ modkey, "Control" }, "F" .. i - 5,
                  function()
                      local tag = awful.tag.gettags(mouse.screen)[i]
                      if tag then awful.tag.viewtoggle(tag) end
                  end),
        -- Move client to tag.
        awful.key({ modkey, "Shift" }, "F" .. i - 5,
                  function()
                      if client.focus then
                          local tag = awful.tag.gettags(client.focus.screen)[i]
                          if tag then awful.client.movetotag(tag) end
                      end
                  end),
        -- Toggle tag.
        awful.key({ modkey, "Control", "Shift" }, "F" .. i - 5,
                  function()
                      if client.focus then
                          local tag = awful.tag.gettags(client.focus.screen)[i]
                          if tag then awful.client.toggletag(tag) end
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
