-- Based on Nice and Clean awesome theme
local awful = require("awful")

local theme = {}
theme.theme_dir = awful.util.getdir("config") .. "/markus-theme"
theme.wallpaper = theme.theme_dir .. "/background.png"

theme.font          = "Aller 11"

theme.red           = "#f07746"
theme.yellow        = "#f0a746"
theme.green         = "#30a573"
theme.blue          = "#346e9a"

theme.bg_normal     = "#3c3b37"
theme.bg_focus      = "#66645e"
theme.bg_urgent     = theme.red
theme.bg_minimize   = theme.blue

theme.fg_normal     = "#d1cec5"
theme.fg_focus      = "#f2efe4"
theme.fg_urgent     = "#262624"
theme.fg_minimize   = "#f2efe4"

theme.border_width  = 2
theme.border_normal = "#262624"
theme.border_focus  = "#66645e"
theme.border_marked = theme.red

theme.wibox_height  = 18

-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- [taglist|tasklist]_[bg|fg]_[focus|urgent]
-- titlebar_[bg|fg]_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- mouse_finder_[color|timeout|animate_timeout|radius|factor]
-- Example:
--theme.taglist_bg_focus = "#ff0000"

theme.taglist_squares_sel = false
theme.taglist_squares_unsel = false
theme.taglist_squares_sel_empty = false
theme.taglist_squares_unsel_empty = false

theme.tasklist_floating_icon = theme.theme_dir .. "/tasklist/floatingw.png"

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_submenu_icon = theme.theme_dir .. "/submenu.png"
theme.menu_height = "15"
theme.menu_width  = "110"
theme.menu_border_width = "0"

-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.bg_widget = "#cc0000"

-- Define the image to load
theme.titlebar_close_button_normal = theme.theme_dir .. "/titlebar/close_normal.png"
theme.titlebar_close_button_focus  = theme.theme_dir .. "/titlebar/close_focus.png"

theme.titlebar_ontop_button_normal_inactive = theme.theme_dir .. "/titlebar/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive  = theme.theme_dir .. "/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active = theme.theme_dir .. "/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active  = theme.theme_dir .. "/titlebar/ontop_focus_active.png"

theme.titlebar_sticky_button_normal_inactive = theme.theme_dir .. "/titlebar/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive  = theme.theme_dir .. "/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active = theme.theme_dir .. "/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active  = theme.theme_dir .. "/titlebar/sticky_focus_active.png"

theme.titlebar_floating_button_normal_inactive = theme.theme_dir .. "/titlebar/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive  = theme.theme_dir .. "/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active = theme.theme_dir .. "/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_active  = theme.theme_dir .. "/titlebar/floating_focus_active.png"

theme.titlebar_maximized_button_normal_inactive = theme.theme_dir .. "/titlebar/maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive  = theme.theme_dir .. "/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active = theme.theme_dir .. "/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active  = theme.theme_dir .. "/titlebar/maximized_focus_active.png"


-- You can use your own layout icons like this:
theme.layout_fairh = theme.theme_dir .. "/layouts/fairhw.png"
theme.layout_fairv = theme.theme_dir .. "/layouts/fairvw.png"
theme.layout_floating  = theme.theme_dir .. "/layouts/floatingw.png"
theme.layout_magnifier = theme.theme_dir .. "/layouts/magnifierw.png"
theme.layout_max = theme.theme_dir .. "/layouts/maxw.png"
theme.layout_fullscreen = theme.theme_dir .. "/layouts/fullscreenw.png"
theme.layout_tilebottom = theme.theme_dir .. "/layouts/tilebottomw.png"
theme.layout_tileleft   = theme.theme_dir .. "/layouts/tileleftw.png"
theme.layout_tile = theme.theme_dir .. "/layouts/tilew.png"
theme.layout_tiletop = theme.theme_dir .. "/layouts/tiletopw.png"
theme.layout_spiral  = theme.theme_dir .. "/layouts/spiralw.png"
theme.layout_dwindle = theme.theme_dir .. "/layouts/dwindlew.png"

theme.awesome_icon = theme.theme_dir .. "/awesome16.png"

return theme