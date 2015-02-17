-- theming and visual stuff

local gears = require("gears")
local awful = require("awful")
local beautiful = require("beautiful")
local naughty = require("naughty")

beautiful.init(awful.util.getdir("config") .. "/markus-theme/theme.lua")

if beautiful.wallpaper then
    for s = 1, screen.count() do
        gears.wallpaper.centered(beautiful.wallpaper, s, "#000000")
    end
end

naughty.config.presets = {
    normal = {},
    low = {
        timeout = 5
    },
    critical = {
        bg = "#cc5214",
        fg = "#000000",
        timeout = 0,
    }
}

naughty.config.defaults = {
    timeout = 5,
    text = "",
    screen = 1,
    ontop = true,
    margin = "5",
    border_width = "1",
    position = "top_right",
    icon_size = 64
}

naughty.config.spacing = 2
