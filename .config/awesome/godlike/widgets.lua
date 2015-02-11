-- define widgets to show in wibox

local awful = require("awful")
local wibox = require("wibox")
local vicious = require("vicious")
local brightness = require("godlike.brightness")
local format = string.format

local widgets = {}


-- Links:
-- ======
-- http://awesome.naquadah.org/wiki/Widgets_in_awesome
-- http://awesome.naquadah.org/wiki/Delightful
-- http://awesome.naquadah.org/wiki/Farhavens_volume_widget
-- http://awesome.naquadah.org/wiki/MPD_Widgets
-- http://awesome.naquadah.org/wiki/Raum_Mpd_Alarm_Clock
-- http://awesome.naquadah.org/wiki/Orglendar_widget
-- https://github.com/alexander-yakushev/Orglendar/blob/master/orglendar.lua
-- https://github.com/setkeh/Awesome-3.5/blob/master/wi.lua

-- Separators
widgets.separator = wibox.widget.textbox()
widgets.separator:set_text("  λ  ")
widgets.space = wibox.widget.textbox()
widgets.space:set_text(" ")

-- Boxes
widgets.mail_markus = wibox.widget.textbox()
widgets.mail_tutor = wibox.widget.textbox()
widgets.mail_kth = wibox.widget.textbox()
widgets.mail_intum = wibox.widget.textbox()
widgets.mail_tum = wibox.widget.textbox()
widgets.volume = wibox.widget.textbox()
widgets.traffic = wibox.widget.textbox()
widgets.wifi = wibox.widget.textbox()
widgets.battery = wibox.widget.textbox()
widgets.thermal = wibox.widget.textbox()
widgets.brightness = wibox.widget.textbox()
widgets.clock = wibox.widget.textbox()

-- Widgets
vicious.register(widgets.wifi, vicious.widgets.wifi, "${ssid} ${linp}%", 5, "wlp3s0")
widgets.wifi:buttons(awful.util.table.join(awful.button({}, 1, function() godlike.lanmenu:toggle() end)))

vicious.register(widgets.clock, vicious.widgets.date, "%a %d. %b - %H:%M", 5)
vicious.register(widgets.brightness, brightness, "$3%", 0.5, "acpi_video0")
vicious.register(widgets.thermal, vicious.widgets.thermal, "$1°C", 1, "thermal_zone0")
vicious.register(widgets.volume, vicious.widgets.volume, "$1%", 0.5, "Master")

local function netformatter(_, data)
    local function activeInterface()
        interfaces = {"wlp3s0", "enp0s25"}

        max = {0, -1}
        for ix, name in pairs(interfaces) do
            traffic = data["{" .. name .. " up_b}"] + data["{" .. name.. " down_b}"]
            if traffic > max[2] then
                max[1] = ix
                max[2] = traffic
            end
        end

        return interfaces[max[1]]
    end

    local function activeUnit(traffic)
        if traffic > 1024^3 then
            unit = "gb"
        elseif traffic > 1024^2 then
            unit = "mb"
        elseif traffic > 1024 then
            unit = "kb"
        else
            unit = "b"
        end

        return unit
    end

    local function colorize(str, unit)
        local thresholds = {
            0,
            64 * 1024,
            128 * 1024
        }
        local colors = {
            {"", ""},
            {"<span color='green'>", "</span>"},
            {"<span color='red'>", "</span>"}
        }

        c = 1
        for ix, th in ipairs(thresholds) do
            if unit > th then
                c = ix
            end
        end

        return format("%s%s%s", colors[c][1], str, colors[c][2])
    end

    local function direction(interface, dir)
        low = 64 * 1024 -- in kb

        -- for k, v in pairs(data) do
        --     return k
        -- end
        traffic = tonumber(data["{" .. interface .. " " .. dir .. "_b}"])
        if traffic < low then
            unit = "low"
            out = "low"
        else
            unit = activeUnit(traffic)
            out = format("%s%s", data["{" .. interface .. " " .. dir .. "_" .. unit .. "}"], unit)
        end

        return colorize(out, traffic)
    end


    active = activeInterface()
    up = direction(active, "up")
    down = direction(active, "down")

    return format("%s ⇅ %s", up, down)
end
vicious.register(widgets.traffic, vicious.widgets.net, netformatter, 1)

local function batteryformatter(_, data)
    local state = data[1]
    local percent = data[2]
    local time = data[3]

    local battery_state = {
        ["↯"] = '<span color="green">AC</span> - ',
        ["⌁"] = '<span color="green">AC</span> - ',
        ["+"] = '<span color="green">AC</span> - ',
        ["−"] = ""
    }

    return format("%s%s%% - %s", battery_state[state], percent, time)
end
vicious.register(widgets.battery, vicious.widgets.bat, batteryformatter, 0.5, "BAT0")

local function mailformatter(name)
    local function fmt(_, data)
        local news = data[1] + data[2]
        if news > 0 then
            return format(" %s%d", name, news)
        else
            return ""
        end
    end

    return fmt
end
local home = godlike.home
vicious.register(widgets.mail_markus, vicious.widgets.mdir, mailformatter("markus:"), 5, {home .. "/Mail/zfix-markus/INBOX"})
vicious.register(widgets.mail_tutor, vicious.widgets.mdir, mailformatter("tutor:"), 5, {home .. "/Mail/zfix-tutor/INBOX"})
vicious.register(widgets.mail_kth, vicious.widgets.mdir, mailformatter("kth:"), 5, {home .. "/Mail/kth/INBOX"})
vicious.register(widgets.mail_intum, vicious.widgets.mdir, mailformatter("intum:"), 5, {home .. "/Mail/intum/INBOX"})
vicious.register(widgets.mail_tum, vicious.widgets.mdir, mailformatter("tum:"), 5, {home .. "/Mail/tum/INBOX"})

return widgets
