
-- some random code so far

local dmenu = "dmenu -b -i -l 10 -nf " .. beautiful.fg_normal .. " -nb " .. beautiful.bg_normal .. " -sf " .. beautiful.bg_urgent .. " -sb " .. beautiful.bg_focus 

local function switchtoapp()
    local clist = ""
    for _,c in ipairs(client.get(mouse.screen)) do
        clist = clist .. c:tags()[1].name .. "-" .. c.name .. "\n"
    end
    local selected = awful.util.pread("echo '" .. clist .. "' | " .. dmenu):gsub("\n", "")
    for _,c in ipairs(client.get(mouse.screen)) do
        if selected == c:tags()[1].name .. "-" .. c.name then
            for _,v in ipairs(c:tags()) do
                awful.tag.viewonly(v)
                client.focus = c
                c:raise()
                c.minimized = false
                return
            end
        end
    end
end
