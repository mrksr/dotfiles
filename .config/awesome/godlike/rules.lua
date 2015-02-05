-- rules for special applications

-- Standard awesome library
local awful = require("awful")
require("awful.rules")
local beautiful = require("beautiful")

-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = awful.client.focus.filter,
                     raise = true,
                     keys = godlike.clientkeys,
                     buttons = godlike.clientbuttons } },
    { rule = { class = "pinentry" },
      properties = { floating = true } },

    { rule = { class = "Pidgin" },
      properties = { tag = godlike.screens[1].tags[4] } },
    { rule = { class = "Gajim" },
      properties = { tag = godlike.screens[1].tags[4] } },
    { rule = { class = "Skype" },
      properties = { tag = godlike.screens[1].tags[4] } },

    { rule = { class = "Firefox" },
      properties = { tag = godlike.screens[1].tags[2] } },
    { rule = { class = "Opera" },
      properties = { tag = godlike.screens[1].tags[2] } },
    { rule = { class = "Chromium" },
      properties = { tag = godlike.screens[1].tags[2] } },
    { rule = { class = "Google-chrome-stable" },
      properties = { tag = godlike.screens[1].tags[2] } },
}

return godlike
