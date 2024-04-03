-- Battery widgets for awesome status bar using upower instead of polling
-- lgi comes from extra/lua53-lgi (current v0.9.2)
-- Lib installed at /lib/libupower-glib.so, owned by upower (current v1.90.2)
local upower = require("lgi").require("UPowerGlib")
local timer = require("gears.timer")
local wibox = require("wibox")
local icons = require("icons")
local setmetatable = setmetatable

-- Some metadata for the battery BAT0 and AC on my machine
local batmeta = {
   capacity = "/sys/class/power_supply/BAT0/capacity",
   status = "/sys/class/power_supply/AC/online",
   batdev = "/org/freedesktop/UPower/devices/battery_BAT0",
   acdev = "/org/freedesktop/UPower/devices/line_power_AC",
}

local battery_widget = {}

-- Callback function
function battery_widget.callb()
   local client = upower.Client()
   local device = client:get_display_device()

   local widget = wibox.widget.imagebox()
   widget.client = client
   widget.device = device

   -- Attach device to this widget to
   if device then
      widget.text = string.format("Remainng: %d%%; Rate: %.2fW",
                                          device.percentage,
                                          device.energy_rate)
   else
      widget.text = "Unknown"
   end

   widget.device.on_notify = function(dev)
      widget:emit_signal('upower::update', dev)
   end

   widget.client.on_notify = function(c)
      widget:emit_signal('upower::plugchange', c)
   end

   return widget
end

local mt = {}

function mt.__call(self, ...)
   return battery_widget.callb()
end

return setmetatable(battery_widget, mt)
