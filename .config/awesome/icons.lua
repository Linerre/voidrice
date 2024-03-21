-- Icons for status bar
-- Lua strings can also be enclosed by single quotes
-- For consistency, double quotes are used across config files

-- Elementary icons
local icon_root = "/usr/share/icons/elementary/"
local status_icon = "status/32/"
local action_icon = "action/32/"
-- Sub paths

icons = {
   battery = {
      charging = {
         charged = status_icon .. "battery-full-charged.svg",
         justfull = status_icon .. status .. "battery-full-charging.svg",
         good = status_icon .. status .. "battery-good-charging.svg", -- 3/4
         low = status_icon .. "battery-low-charging.svg",   -- half
         caution = status_icon .. "battery-caution-charging.svg", -- 1/4
         empty = status_icon .. "battery-empty-charging.svg"
      },
      discharging = {
         full = status_icon .. "battery-full.svg",
         good = status_icon .. "battery-good.svg", -- 3/4
         low = status_icon .. "battery-low.svg",   -- half
         caution = status_icon .. "battery-caution.svg", -- 1/4
         empty = status_icon .. "battery-empty.svg"
      },
   },
   network = {
      connected = {
         excellent = status_icon .. "network-wireless-signal-excellent.svg",
         good = status_icon .. "network-wireless-signal-good.svg",
         ok = status_icon .. "network-wireless-signal-ok.svg",
         weak = status_icon .. "network-wireless-signal-weak.svg",
      },
      disconnected = status_icon .. "network-error.svg"
   },
   system = {
      shutdown = action_icon .. "system-shutdown.svg",
      reboot = action_icon .. "system-reboot.svg",
      logout = action_icon .. "system-log-out.svg",
      suspend = action_icon .. "system-suspend.svg",
      lock = action_icon .. "system-lock-screen.svg",
   }
}

return icons
