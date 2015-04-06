-- create initial tags and define layouts

local awful = require("awful")

godlike.layouts = godlike.layouts or
{
    awful.layout.suit.max,
    awful.layout.suit.tile,
    -- awful.layout.suit.tile.left,
    awful.layout.suit.tile.bottom,
    -- awful.layout.suit.tile.top,
    -- awful.layout.suit.fair,
    -- awful.layout.suit.fair.horizontal,
    -- awful.layout.suit.spiral,
    -- awful.layout.suit.spiral.dwindle,
    -- awful.layout.suit.max.fullscreen,
    -- awful.layout.suit.magnifier,
    -- awful.layout.suit.floating,
}

for s = 1, screen.count() do
    godlike.screens[s].tags = awful.tag({
        'Stuff', 'Net', 'Term', 'IM', 'Mail', 'George', 'J', 'Soilent', 'MMXIII'
        }, s,  awful.layout.suit.max)
end

return godlike
