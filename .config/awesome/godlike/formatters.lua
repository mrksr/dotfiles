local format = string.format

local formatters = {}

function formatters.net(_, data)
    local function activeInterface()
        interfaces = {"wlp3s0", "enp0s25"}

        max = {0, -1}
        for ix, name in pairs(interfaces) do
            traffic = data["{" .. name .. " up_b}"] + data["{" .. name.. " down_b}"]
            if traffic > max[2] then
                max[1] = ix
                max[2] = traffic
            end
        end

        return interfaces[max[1]]
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

    local function colorize(str, unit)
        local colors = {
            {0, "", ""},
            {64 * 1024, "<span color='green'>", "</span>"},
            {128 * 1024, "<span color='red'>", "</span>"}
        }

        c = 1
        for ix, th in ipairs(colors) do
            if unit >= th[1] then
                c = ix
            end
        end

        return format("%s%s%s", colors[c][2], str, colors[c][3])
    end

    local function direction(interface, dir)
        low = 64 * 1024 -- in kb

        traffic = tonumber(data["{" .. interface .. " " .. dir .. "_b}"])
        if traffic < low then
            unit = "low"
            out = "low"
        else
            unit = activeUnit(traffic)
            out = format("%s%s", data["{" .. interface .. " " .. dir .. "_" .. unit .. "}"], unit)
        end

        return colorize(out, traffic)
    end


    active = activeInterface()
    up = direction(active, "up")
    down = direction(active, "down")

    return format("%s ⇅ %s", up, down)
end

function formatters.battery(_, data)
    local state = data[1]
    local percent = data[2]
    local time = data[3]

    local battery_state = {
        ["↯"] = '<span color="green">AC</span> - ',
        ["⌁"] = '<span color="green">AC</span> - ',
        ["+"] = '<span color="green">AC</span> - ',
        ["−"] = ""
    }

    return format("%s%s%% - %s", battery_state[state], percent, time)
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
