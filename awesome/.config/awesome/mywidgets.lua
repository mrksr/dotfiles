-- define widgets to show in wibox
local wibox        = require("wibox")
local vicious      = require("vicious")
local beautiful    = require("beautiful")
local brightness   = require("brightness")
local nowplaying   = require("nowplaying")
local formatters   = require("formatters")
local format       = string.format

local widgets = {}

-- Separators
widgets.separator = wibox.widget {
  markup = formatters.colored(" λ ", beautiful.blue),
  widget = wibox.widget.textbox
}
widgets.space = wibox.widget {
  markup = "    ",
  widget = wibox.widget.textbox
}
widgets.small_space = wibox.widget {
  markup = " ",
  widget = wibox.widget.textbox
}

-- Boxes
widgets.mail_markus = wibox.widget.textbox()
widgets.mail_tutor = wibox.widget.textbox()
widgets.mail_kth = wibox.widget.textbox()
widgets.mail_intum = wibox.widget.textbox()
widgets.mail_tum = wibox.widget.textbox()
widgets.mail_pub = wibox.widget.textbox()
widgets.volume = wibox.widget.textbox()
widgets.nowplaying = wibox.widget.textbox()
widgets.traffic = wibox.widget.textbox()
widgets.wifi = wibox.widget.textbox()
widgets.battery0 = wibox.widget.textbox()
widgets.battery1 = wibox.widget.textbox()
widgets.thermal = wibox.widget.textbox()
widgets.brightness = wibox.widget.textbox()
widgets.clock = wibox.widget.textbox()

-- Widgets
vicious.register(
  widgets.clock,
  vicious.widgets.date,
  format("%s %s %s", formatters.colored("", beautiful.yellow), "%a %e. %b", formatters.colored("%H:%M", beautiful.yellow)),
  5
)
vicious.register(
  widgets.brightness,
  brightness,
  format("%s $3%%", formatters.colored("", beautiful.red)),
  1,
  "intel_backlight"
)
vicious.register(
  widgets.thermal,
  vicious.widgets.thermal,
  format("%s $1%s", formatters.colored("", beautiful.blue), formatters.colored("<b>°C</b>", beautiful.blue)),
  5,
  "thermal_zone0"
)
vicious.register(
  widgets.battery0,
  vicious.widgets.bat,
  formatters.battery(formatters.colored("", beautiful.green)),
  2,
  "BAT0"
)
vicious.register(
  widgets.battery1,
  vicious.widgets.bat,
  formatters.battery(" "),
  2,
  "BAT1"
)
vicious.register(
  widgets.traffic,
  vicious.widgets.net,
  formatters.net,
  2
)
vicious.register(
  widgets.volume,
  vicious.widgets.volume,
  formatters.volume,
  1,
  "Master"
)
vicious.register(
  widgets.wifi,
  vicious.widgets.wifi,
  format("%s ${ssid} - ${linp}%%", formatters.colored("", beautiful.red)),
  5,
  "wlp3s0"
)
-- vicious.register(widgets.nowplaying, nowplaying, "$1", 5)

local home = os.getenv("HOME")
vicious.register(widgets.mail_markus, vicious.widgets.mdir, formatters.mail("markus"), 2, {home .. "/Mail/zfix-markus/INBOX"})
vicious.register(widgets.mail_tutor, vicious.widgets.mdir, formatters.mail("tutor"), 2, {home .. "/Mail/zfix-tutor/INBOX"})
vicious.register(widgets.mail_kth, vicious.widgets.mdir, formatters.mail("kth"), 2, {home .. "/Mail/kth/INBOX"})
vicious.register(widgets.mail_intum, vicious.widgets.mdir, formatters.mail("intum"), 2, {home .. "/Mail/intum/INBOX"})
vicious.register(widgets.mail_tum, vicious.widgets.mdir, formatters.mail("tum"), 2, {home .. "/Mail/tum/INBOX"})
vicious.register(widgets.mail_pub, vicious.widgets.mdir, formatters.mail("pub"), 2, {home .. "/Mail/zfix-pub/INBOX"})

return widgets
