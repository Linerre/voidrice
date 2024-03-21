-- Simple widgets for awesome status bar
-- If this file grows ever larger than 200 lines, consider a split

local awful = require("awful")
local wibox = require("wibox")
local timer = require("gears.timer")

local bat = {}
bat.capacity = "/sys/class/power_supply/BAT0/capacity"
bat.status = "/sys/class/power_supply/BAT0/status"

local function trim(s)
   return s:match('^%s*(.*%S)%s*$') or ''
end

local function battery_info()
   local f_cap = assert(io.open(bat.capacity), "r")
   local bat_cap = tonumber(f_cap:read("*n"))
   f_cap.close()

   local f_st = assert(io.open(bat.status), "r")
   local bat_st = trim(f_st:read("*l"))
   f_st.close()

   return bat_cap, bat_st
end

-- local battery_widget = wibox.widget {
--    text = "Bat ",
--    align = "center",
--    valign = "center",
--    widget = wibox.widget.textbox,
-- }

-- Update battery info every 5 minutes
-- local update_timer = timer({ timeout = 300 })
-- update_timer:connect_signal(
--    "timeout",
--    function()
--       local cap, st = battery_info()
--       battery_widget.text = string.format("Bat: %d%%", cap)
--    end
-- )
-- update_timer:start()

return battery_info
