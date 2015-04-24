-- functions to share tags on multiple screens

--{{{ Grab environment we need
local capi = { widget = widget,
               screen = screen,
               image = image,
               client = client,
               button = button }
local math = math
local type = type
local setmetatable = setmetatable
local pcall = pcall
local pairs = pairs
local ipairs = ipairs
local table = table
local common = require("awful.widget.common")
local util = require("awful.util")
local tag = require("awful.tag")
local beautiful = require("beautiful")
local fixed = require("wibox.layout.fixed")
local surface = require("gears.surface")

local naughty = require("naughty")

local awful = require("awful") 
local mouse = mouse
--}}}

module("sharetags")

--{{{ Functions

--{{{ create_tags: create a table of tags and bind them to screens
-- @param names : list to label the tags
-- @param layouts : list of layouts for the tags
-- @return table of tag objects
function create_tags(names, layouts)
    local tags = {}
    local count = #names
    if capi.screen.count() >= #names then
        count = capi.screen.count() + 1
    end
    for tagnumber = 1, count do
        tags[tagnumber] = awful.tag.add(names[tagnumber], {})
        tag.setproperty(tags[tagnumber], "number", tagnumber)
        -- Add tags to screen one by one
        tag.setproperty(tags[tagnumber], "screen", 1)
        awful.layout.set(layouts[tagnumber], tags[tagnumber])
    end

    tags[1].selected = true
    -- for s = 1, capi.screen.count() do
    --     -- I'm sure you want to see at least one tag.
    --     tag.setproperty(tags[s], "screen", s)
    --     tag.setproperty(tags[s], "selected", true)
    -- end
    return tags
end
--}}}

--{{{ tag_move: move a tag to a screen
-- @param t : the tag object to move
-- @param scr : the screen object to move to
function tag_move(t, scr)
    local ts = t or awful.tag.selected()
    if not scr then return end
    local target = scr
    local t_screen = tag.getproperty(t, "screen")

    if t_screen and target ~= t_screen then
        -- switch for tag
        tag.setproperty(t, "screen", target)
        -- switch for all clients on tag
        for _ , c in ipairs(ts:clients()) do
            if not c.sticky then
                c.screen = target
                c:tags( {ts} )
            else
                awful.client.toggletag(ts,c)
            end
        end
    end
end
--}}}

-- vim: fdm=marker:
