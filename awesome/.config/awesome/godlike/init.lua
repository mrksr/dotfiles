-- this file ties everything together
-- begin here with your configuration

local gears = require("gears")
local awful = require("awful")
awful.rules = require("awful.rules")
require("awful.autofocus")
local wibox = require("wibox")
local beautiful = require("beautiful")
local naughty = require("naughty")
local menubar = require("menubar")

godlike = godlike or {}

godlike.terminal   = godlike.terminal   or "termite"
godlike.browser    = godlike.browser    or os.getenv("BROWSER") or "firefox"
godlike.home       = godlike.home       or os.getenv("HOME") or nil
godlike.editor     = godlike.editor     or os.getenv("EDITOR") or "vim"
godlike.editor_cmd = godlike.editor_cmd or "termite -e vim "
godlike.modkey     = godlike.modkey     or "Mod4"
godlike.altkey     = godlike.altkey     or "Mod1"
godlike.hostname   = godlike.hostname   or awful.util.pread('uname -n'):gsub('\n', '')
godlike.home       = os.getenv("HOME")
godlike.exec       = awful.util.spawn
godlike.sexec      = awful.util.spawn_with_shell
godlike.xexec      = godlike.spawn
godlike.screens    = { }
godlike.tags       = { }

for i = 1, screen.count() do
    godlike.screens[i] = { }
end

menubar.utils.terminal = godlike.terminal -- Set the terminal for applications that require it

require("godlike.errors")
require("godlike.appearance")
require("godlike.tags")
--require("godlike.widgets")
require("godlike.menu")
require("godlike.wibox")
require("godlike.clientkeys")
require("godlike.globalkeys")
require("godlike.audio")
require("godlike.rules")
require("godlike.signals")

return godlike
