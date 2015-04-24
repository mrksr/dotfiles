-- functions to share tags on multiple screens
local capi = { screen = screen }
local math = math
local setmetatable = setmetatable
local ipairs = ipairs

local awful = require("awful")

local sharetags = { }

--- create_tags: create a table of tags and bind them to screens
-- @param names : list to label the tags
-- @param layouts : list of layouts for the tags
-- @return table of tag objects
function sharetags.create_tags(names, layouts)
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
    return tags
end

--- tag_move: move a tag to a screen
-- @param t : the tag object to move
-- @param scr : the screen object to move to
function sharetags.tag_move(t, scr)
    if not t or not scr then return end
    local t_screen = awful.tag.getproperty(t, "screen")

    if t_screen and scr ~= t_screen then
        -- switch for tag
        awful.tag.setproperty(t, "screen", scr)
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

--- tag_viewonly: switch to tag on current screen
-- @param t : the tag to view
function sharetags.tag_viewonly(t)
    local swap_t = awful.tag.selected()
    local sel = awful.tag.getproperty(t, "selected")
    local t_screen = awful.tag.getproperty(t, "screen")

    if t_screen ~= mouse.screen then
        sharetags.tag_move(t, mouse.screen)
    end

    if swap_t and sel == true then
        sharetags.tag_move(swap_t, t_screen)
        awful.tag.viewonly(swap_t)
    end
    awful.tag.viewonly(t)
end

return sharetags
