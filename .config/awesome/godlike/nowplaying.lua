local tonumber = tonumber
local setmetatable = setmetatable
local os = { execute = os.execute }
local util = require("awful.util")
local string = {
    format = string.format,
    byte = string.byte,
    sub = string.sub,
}


-- nowplaying: Provides information on current music
local nowplaying = {}

local function trim(s)
    if not s then return end
    local last = string.byte(s, #s)
    if last == 10 or last == 13 then
        return string.sub(s, 1, #s - 1)
    end
    return s
end

local function worker(_)
    local exist = os.execute("which playerctl")

    local ret = ""
    if exist then
        local status = trim(util.pread("playerctl status"))
        if status == "Playing" or status == "Paused" then
            local artist = trim(util.pread("playerctl metadata xesam:artist"))
            local title = trim(util.pread("playerctl metadata xesam:title"))
            if #title > 24 then
                title = string.sub(title, 1, 24)
            end

            ret = string.format("%s - %s", artist, title)
        else
            ret = "No Music"
        end
    end

    return {util.escape(ret)}
end

return setmetatable(nowplaying, { __call = function(_, ...) return worker(...) end })
