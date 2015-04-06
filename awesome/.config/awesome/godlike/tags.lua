local awful     = require("awful")
local sharetags = require("sharetags")

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

godlike.tagnames = {
    'Stuff', 'Net', 'Term', 'IM', 'Mail', 'George', 'J', 'Soilent', 'MMXIII'
}

godlike.tags = sharetags.create_tags(godlike.tagnames, godlike.layouts)

return godlike
