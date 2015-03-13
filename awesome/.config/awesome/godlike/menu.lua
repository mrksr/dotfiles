local awful = require("awful")
local beautiful = require("beautiful")


local awesomemenu = {
    { "&globalkeys", godlike.editor_cmd .. awful.util.getdir("config") .. "/godlike/globalkeys.lua" },
    { "&clientkeys", godlike.editor_cmd .. awful.util.getdir("config") .. "/godlike/clientkeys.lua" },
    { "&menu",       godlike.editor_cmd .. awful.util.getdir("config") .. "/godlike/menu.lua" },
    { "&rules",      godlike.editor_cmd .. awful.util.getdir("config") .. "/godlike/rules.lua" },
    { "&widgets",    godlike.editor_cmd .. awful.util.getdir("config") .. "/godlike/widgets.lua" },
    { "&tags",       godlike.editor_cmd .. awful.util.getdir("config") .. "/godlike/tags.lua" },
    { "godlike",     godlike.editor_cmd .. awful.util.getdir("config") .. "/godlike/init.lua" },
    { "rc.lua",      godlike.editor_cmd .. awesome.conffile },
    { "manual",      godlike.terminal .. " -e man awesome" },
    { "restart",     awesome.restart },
    { "&quit",       awesome.quit },
}

local quickstartmenu = {
    { "&Chromium",   "chromium" },
    { "&joindota",   "chromium --app=http://joindota.com" },
    { "Mario &Kart", 'mupen64plus "/srv/roms/Mario Kart 64 (USA).n64"' },
}

local keyboardmenu = {
    { "&de",    "setxkbmap de nodeadkeys" },
    { "&neo2",  "setxkbmap de neo" },
    { "&se",    "setxkbmap se nodeadkeys" },
}

local lanmenu = {
    { "&lan",          "netctl start eth" },
    { "&eduroam",      "netctl start eduroam" },
    { "&Setanglement", "netctl start se" },
}

local mainmenu = {
    -- { "Quick&start",    quickstartmenu },
    -- { "Debian",         debian.menu.Debian_menu.Debian },
    { "&awesome",       awesomemenu, beautiful.awesome_icon },
    -- { "&Lan",           lanmenu },
    { "&Keyboard",      keyboardmenu },
    { "open &terminal", godlike.terminal },
}


godlike.lanmenu = godlike.lanmenu or awful.menu({ items = lanmenu})
godlike.mainmenu = godlike.mainmenu or awful.menu({ items = mainmenu })
godlike.menu = godlike.menu or godlike.mainmenu

return godlike
