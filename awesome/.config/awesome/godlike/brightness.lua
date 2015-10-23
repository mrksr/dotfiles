local tonumber = tonumber
local setmetatable = setmetatable
local math = { floor = math.floor }
local helpers = require("vicious.helpers")

-- brightness: Provides backlight brightness values
local brightness = {}

local function worker(format, warg)
    if not warg then return end

    local _bright = helpers.pathtotable("/sys/class/backlight/" .. warg .. "/")

    local curr = tonumber(_bright.brightness) or 0
    local max = tonumber(_bright.max_brightness) or 1

    local percent = math.floor(100 * curr / max + 0.5)

    return {curr, max, percent}
end

return setmetatable(brightness, { __call = function(_, ...) return worker(...) end })
