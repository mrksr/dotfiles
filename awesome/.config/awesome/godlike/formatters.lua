local format    = string.format
local beautiful = require("beautiful")

local formatters = {}

function formatters.colored(str, color)
    return format("<span color='%s'>%s</span>", color, str)
end

function formatters.net(_, data)
    local function activeInterface()
        local interfaces = {"wlp3s0", "enp0s25", "enp3s0"}

        local max = {0, -1}
        for ix, name in pairs(interfaces) do
            if data["{" .. name .. " up_b}"] then
                local traffic = data["{" .. name .. " up_b}"] + data["{" .. name.. " down_b}"]
                if traffic > max[2] then
                    max[1] = ix
                    max[2] = traffic
                end
            end
        end

        if max[1] < 0 then
            return "?"
        else
            return interfaces[max[1]]
        end
    end

    local function activeUnit(traffic)
        if traffic > 1024^3 then
            unit = "gb"
        elseif traffic > 1024^2 then
            unit = "mb"
        elseif traffic > 1024 then
            unit = "kb"
        else
            unit = "b"
        end

        return unit
    end

    local function colorize(str, traffic, direction)
        local colors = {
            ["up"] = {
                {0, "", ""},
                {64 * 1024, format("<span color='%s'>", beautiful.green), "</span>"},
                {128 * 1024, format("<span color='%s'>", beautiful.red), "</span>"}
            },
            ["down"] = {
                {0, "", ""},
                {256 * 1024, format("<span color='%s'>", beautiful.green), "</span>"},
                {2048 * 1024, format("<span color='%s'>", beautiful.red), "</span>"}
            }
        }

        local c = 1
        for ix, th in ipairs(colors[direction]) do
            if traffic >= th[1] then
                c = ix
            end
        end

        return format("%s%s%s", colors[direction][c][2], str, colors[direction][c][3])
    end

    local function direction(interface, dir)
        local low = {
            ["up"] = 64 * 1024, -- in kb
            ["down"] = 256 * 1024
        }

        local traffic = tonumber(data["{" .. interface .. " " .. dir .. "_b}"])
        local unit = "low"
        local out = "low"
        if traffic > low[dir] then
            unit = activeUnit(traffic)
            out = format("%s%s", data["{" .. interface .. " " .. dir .. "_" .. unit .. "}"], unit)
        end

        return colorize(out, traffic, dir)
    end

    local active = activeInterface()
    local up = direction(active, "up")
    local down = direction(active, "down")

    return format("%s %s %s", down, formatters.colored("⇵", beautiful.yellow), up)
end

function formatters.battery(_, data)
    local battery_state = {
        ["↯"] = format('<span color="%s">↯</span>', beautiful.green),
        ["⌁"] = format('<span color="%s">? </span>', beautiful.green),
        ["+"] = format('<span color="%s">▲</span>', beautiful.blue),
        ["−"] = format('<span color="%s">▼</span>', beautiful.red),
    }

    if not data then return battery_state["⌁"] end

    local state = data[1]
    local percent = data[2]
    local time = data[3]

    if time == "N/A" then
        return format("%s%s%%", battery_state[state], percent)
    else
        return format("%s%s%% - %s", battery_state[state], percent, time)
    end
end

function formatters.mail(name)
    local function fmt(_, data)
        local news = data[1] + data[2]
        if news > 0 then
            return format(" %s:%d", name, news)
        else
            return ""
        end
    end

    return fmt
end

return formatters
