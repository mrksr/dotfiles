-- theming and visual stuff

local gears = require("gears")
local awful = require("awful")
local beautiful = require("beautiful")

beautiful.init("/usr/share/awesome/themes/zenburn/theme.lua")

-- http://awesome.naquadah.org/wiki/Raum_Mpd_Alarm_Clock

if beautiful.wallpaper then
    for s = 1, screen.count() do
        gears.wallpaper.maximized(beautiful.wallpaper, s, true)
    end
end
