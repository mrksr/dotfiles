-- functions to share tags on multiple screens
local capi = { screen = screen }
local math = math
local setmetatable = setmetatable
local ipairs = ipairs
local tag = require("awful.tag")

local awful = require("awful")

module("sharetags")

-- create_tags: create a table of tags and bind them to screens
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
        tags[tagnumber] = awful.tag.add(names[tagnumber], { screen = 1 })
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

-- tag_move: move a tag to a screen
-- @param t : the tag object to move
-- @param scr : the screen object to move to
function tag_move(t, scr)
    if not t or not scr then return end
    local t_screen = tag.getproperty(t, "screen")

    if t_screen and scr ~= t_screen then
        -- switch for tag
        tag.setproperty(t, "screen", scr)
        -- switch for all clients on tag
        for _ , c in ipairs(t:clients()) do
            if not c.sticky then
                c.screen = scr
                c:tags({ t })
            else
                awful.client.toggletag(t, c)
            end
        end
    end
end
