

-- get a quake-like console
-- code from https://github.com/vincentbernat/awesome-configuration 

local awful = require('awful')

-- register some cleanup code
client.connect_signal("unmanage", function(c)
	for si = 1, screen.count() do
		if c == godlike.screens[si].quake then
			godlike.screens[si].quake = nil
		end
	end
end)

local function toggle()
	local si = mouse.screen

	if not godlike.screens[1].quake then
		-- self destroying setup code
		local function spawnw(c)
			godlike.screens[si].quake = c
			local geom = screen[si].workarea
			local height = 0.25 * geom.height
			awful.client.floating.set(c, true)
			c.border_width = 0
			c.size_hints_honor = false
			c:geometry({ x = geom.x, y=0, width=geom.width, height=height })
			c.ontop = true
			c.above = true
			c.skip_taskbar = true
			-- c.sticky = true
			if c.titlebar then awful.titlebar.remove(c) end
			c:buttons({})
			c:keys({})
			c:raise()
			client.focus = c
			client.disconnect_signal("manage", spawnw)
		end

		-- create new quake terminal
		client.connect_signal("manage", spawnw)
		awful.util.spawn(godlike.terminal, false)
	else
		local c = godlike.screens[si].quake
		-- move to current tag
		if c:isvisible() == false then 
			c.hidden = true
			awful.client.movetotag(awful.tag.selected(si), c)
		end

		-- actual toggle code
		if c.hidden then
			awful.placement.center_horizontal(c)
			c.hidden = false
			c:raise()
			client.focus = c
		else
			c.hidden = true
			c:tags({})
		end
	end
end

return { toggle = toggle }


