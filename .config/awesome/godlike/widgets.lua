-- define widgets to show in wibox

local awful = require("awful")
local wibox = require("wibox")
local vicious = require("vicious")
local brightness = require("godlike.brightness")
local formatters = require("godlike.formatters")

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
vicious.register(widgets.clock, vicious.widgets.date, "%a %d. %b - %H:%M", 5)
vicious.register(widgets.brightness, brightness, "$3%", 0.5, "acpi_video0")
vicious.register(widgets.thermal, vicious.widgets.thermal, "$1°C", 1, "thermal_zone0")
vicious.register(widgets.battery, vicious.widgets.bat, formatters.battery, 0.5, "BAT0")
vicious.register(widgets.traffic, vicious.widgets.net, formatters.net, 1)
vicious.register(widgets.wifi, vicious.widgets.wifi, "${ssid} ${linp}%", 5, "wlp3s0")
widgets.wifi:buttons(awful.util.table.join(awful.button({}, 1, function() godlike.lanmenu:toggle() end)))
vicious.register(widgets.volume, vicious.widgets.volume, "$1%", 0.5, "Master")

local home = godlike.home
vicious.register(widgets.mail_markus, vicious.widgets.mdir, formatters.mail("markus"), 2, {home .. "/Mail/zfix-markus/INBOX"})
vicious.register(widgets.mail_tutor, vicious.widgets.mdir, formatters.mail("tutor"), 2, {home .. "/Mail/zfix-tutor/INBOX"})
vicious.register(widgets.mail_kth, vicious.widgets.mdir, formatters.mail("kth"), 2, {home .. "/Mail/kth/INBOX"})
vicious.register(widgets.mail_intum, vicious.widgets.mdir, formatters.mail("intum"), 2, {home .. "/Mail/intum/INBOX"})
vicious.register(widgets.mail_tum, vicious.widgets.mdir, formatters.mail("tum"), 2, {home .. "/Mail/tum/INBOX"})

return widgets
