-- theming and visual stuff

local gears     = require("gears")
local awful     = require("awful")
local beautiful = require("beautiful")

local _dbus = dbus; dbus = nil
local naughty = require("naughty")
dbus = _dbus

beautiful.init(awful.util.getdir("config") .. "/markus-theme/theme.lua")

if beautiful.wallpaper then
    for s = 1, screen.count() do
        gears.wallpaper.centered(beautiful.wallpaper, s, "#000000")
    end
end

naughty.config.presets = {
    normal = {},
    low = {
        bg = beautiful.bg_normal,
        fg = beautiful.fg_normal,
        timeout = 5
    },
    critical = {
        bg = beautiful.bg_urgent,
        fg = beautiful.fg_urgent,
        timeout = 0,
    }
}

naughty.config.defaults = {
    timeout = 5,
    text = "",
    screen = 1,
    ontop = true,
    margin = "5",
    border_width = "4",
    position = "top_right",
    icon_size = 96,
    width = 400,
}

naughty.config.spacing = 4
