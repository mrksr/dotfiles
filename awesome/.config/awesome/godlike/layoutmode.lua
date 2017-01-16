local awful = require("awful")

local _dbus = dbus; dbus = nil
local naughty = require("naughty")
dbus = _dbus

local layoutmode = {}

layoutmode.keys = {
    name  = "Layout",
    space = function() awful.layout.inc(godlike.layouts,  1) end,
    a     = function() awful.tag.incmwfact(-0.05) end,
    d     = function() awful.tag.incmwfact( 0.05) end,
    s     = function() awful.tag.incwfact(-0.05) end,
    w     = function() awful.tag.incwfact( 0.05) end,
    -- w     = function() awful.client.swap.byidx( 1) end,
    -- s     = function() awful.client.swap.byidx(-1) end,

    k     = function() awful.client.moveresize(0, 0,  0, -5) end,
    j     = function() awful.client.moveresize(0, 0,  0,  5) end,
    h     = function() awful.client.moveresize(0, 0, -5,  0) end,
    l     = function() awful.client.moveresize(0, 0,  5,  0) end,

    Left  = function() awful.tag.incncol(-1) end,
    Right = function() awful.tag.incncol( 1) end,
    Up    = function() awful.tag.incnmaster( 1) end,
    Down  = function() awful.tag.incnmaster(-1) end,

    m     = function() awful.tag.incnmaster( 1) end,
    comma = function() awful.tag.incnmaster(-1) end,
}

function layoutmode.activate(keys)
    keys = keys or layoutmode.keys
    local function grabber(mod, key, event)
        if key == "Escape" then
            naughty.notify({ text = "Mode: Normal" })
            awful.keygrabber.stop(grabber)
        end
        if event == "press" and keys[key] then
            pcall(keys[key])
        end
    end

    naughty.notify({ text = "Mode: " .. keys.name })
    awful.keygrabber.run(grabber)
end

return layoutmode
