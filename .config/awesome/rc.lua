-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
-- For awesome-client to communicate with current instance of awesome
require("awful.remote")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")
-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require("awful.hotkeys_popup.keys")


---------------- Default Theme ---------------------
local theme_path = string.format(
   "%s/.config/awesome/themes/%s/theme.lua",
   os.getenv("HOME"), "default"
)

beautiful.init(theme_path)

local icons = require("icons")

-- TODO: Merge these colors and fonts with theme module
local display_font = "Liberation Sans 13"
local dim_text = "#5c5c5c"

---------------- Helper Functions -------------------
local function trim(s)
   return s:match("^%s*(.*%S)%s*$") or ""
end


---------------- Personal widgets -------------------

-----------------------------------------------------
-- 1. Battery
-----------------------------------------------------
local bat = {
   capacity = "/sys/class/power_supply/BAT0/capacity",
   status = "/sys/class/power_supply/AC/online",
   batdbus = "/org/freedesktop/UPower/devices/battery_BAT0",
   acdbus = "/org/freedesktop/UPower/devices/line_power_AC",
}

local battery_icon = wibox.widget {
   -- pre-defined/built-in attrs of imagebox widget
   resize = false,
   downscale = true,
   forced_height = 24,
   forced_width= 24,
   widget = wibox.widget.imagebox,
}


local function get_batinfo()
   -- Battery capactiy 0 - 100
   local f_cap = assert(io.open(bat.capacity, "r"))
   local bat_cap = tonumber(f_cap:read("*n"))
   f_cap:close()

   -- AC status: 1(on/true)/0(off/false)
   local f_st = assert(io.open(bat.status, "r"))
   local ac_st = tonumber(f_st:read("*l"))
   f_st:close()
   local ac_on = ac_st == 1 and true or false
   return bat_cap, ac_on
end

-- Update battery icon only
local function update_bat_icon()
   local bat_cap, ac_on = get_batinfo()
   if ac_on then
      if bat_cap >= 92 then
         battery_icon:set_image(icons.battery.charging.justfull)
      elseif bat_cap >= 75 then
         battery_icon:set_image(icons.battery.charging.good)
      elseif bat_cap >= 50 then
         battery_icon:set_image(icons.battery.charging.low)
      elseif bat_cap <= 30 then
         battery_icon:set_image(icons.battery.charging.caution)
      else
         battery_icon:set_image(icons.battery.charging.empty)
      end
   else
      if bat_cap >= 92 then
         battery_icon:set_image(icons.battery.charging.justfull)
      elseif bat_cap >= 75 then
         battery_icon:set_image(icons.battery.charging.good)
      elseif bat_cap >= 50 then
         battery_icon:set_image(icons.battery.charging.low)
      elseif bat_cap <= 30 then
         battery_icon:set_image(icons.battery.charging.caution)
      else
         battery_icon:set_image(icons.battery.charging.empty)
      end
   end
end

-- Update battery icon at startup
update_bat_icon()

-- Then battery info is updated only on upower event
local blgi = require("battery")
local myblgi = blgi {}

-- Update on AC un/plug
myblgi:connect_signal('upower::plugchange',
                      function(widget, client)
                         update_bat_icon()
                       -- if client.on_battery then
                       --    update_bat_icon(false)
                       -- end
                       --    update_bat_icon(true)
                      end
)

-- Update on Battery percentage change
myblgi:connect_signal('upower::update',
                      function(widget, device)
                         update_bat_icon()
                         -- if device.power_supply then
                         --  -- not charging
                         --  update_bat_icon(false)
                         -- else
                         --  update_bat_icon(true)
                      end
)


local bat_tooltip= awful.tooltip {}
bat_tooltip:add_to_object(battery_icon)
battery_icon:connect_signal(
   "mouse::enter",
   function()
      bat_tooltip.text = string.format("%s", myblgi.text)
   end
)

-----------------------------------------------------
-- 2. Network (use nm-applet for now)
-----------------------------------------------------
-- local nw = {
--    operstate = "/sys/class/net/wlan0/operstate",
--    ip = "",
-- }
--
-- local net_icon  = wibox.widget {
--    resize = true,
--    valign = "center",
--    halign = "center",
--    downscale = true,
--    widget = wibox.widget.imagebox,
-- }
--
-- local net_tooltip = awful.tooltip {
--    align = "bottom"
-- }
-- net_tooltip:add_to_object(net_icon)
-- net_icon:connect_signal(
--    "mouse::enter",
--    function()
--       awful.spawn.easy_async(
--          "awk '/^\\s*w/ {printf \"%d\",int($3 * 100 / 70)}' /proc/net/wireless",
--          function(stdout,stderr,reason,exit)
--             trimed = trim(stdout)
--             net_tooltip.text = string.format("Quality: %s%%", trimed)
--          end
--       )
--    end
-- )
--
-- -- Check network connection every minite
-- gears.timer {
--    timeout = 60,
--    autostart = true,
--    call_now = true,
--    callback = function()
--       local f_dev = assert(io.open(nw.operstate, "r"))
--       local dev_stat = trim(f_dev:read("*l"))
--       f_dev:close()
--
--       if dev_stat == "up" then
--          net_icon.image = icons.network.connected.excellent
--       else
--          net_icon.image = icons.network.disconnected
--       end
--    end
-- }

-----------------------------------------------------
-- 3. Volume
-----------------------------------------------------
local vol_icon = wibox.widget {
   muted = false,
   image = icons.audio.volume.high,
   widget = wibox.widget.imagebox,
}

local vol_tlp = awful.tooltip {
   align = "bottom"
}
vol_tlp:add_to_object(vol_icon)
vol_icon:connect_signal(
   "mouse::enter",
   function()
      awful.spawn.easy_async(
         -- -n, --quiet, --slient are all equivalent
         "amixer sget Master",
         function(stdout,stderr,reason,exit)
            trimed = trim(stdout)
            vol_tlp.text = string.format("Volume: %s%%", trimed)
         end
      )
   end
)


-- `:add_button` is the API for dev-version of awesome
vol_icon:buttons(gears.table.join(
                    awful.button(
                       {},        -- No mod key needed
                       1,         -- Left click
                       function() -- press
                          awful.spawn.with_shell("amixer -q set Master toggle")
                          if vol_icon.muted then
                             vol_icon:set_image(icons.audio.volume.high)
                             vol_icon.muted = false
                          else
                             vol_icon:set_image(icons.audio.volume.muted)
                             vol_icon.muted = true
                          end
                       end,
                       nil        -- release
                    )
))


-----------------------------------------------------
-- 4. Clock and Calendar
-----------------------------------------------------
local txtclk = wibox.widget {
   format = " %b %d %a %H:%M ",
   font = display_font,
   refresh = 60,
   valign = "center",
   halign = "center",
   widget = wibox.widget.textclock,
}

local month_calendar = awful.widget.calendar_popup.month {
   font = display_font,
   week_numbers = true,
   start_sunday = false,
   style_weeknumber = {
      fg_color = dim_text,
   }
}

month_calendar:attach(txtclk, "tr")

-----------------------------------------------------
-- 5. System actions
-----------------------------------------------------
-- TODO: Finish button functions
local system_menu = awful.menu({
      items = {
         {"Sleep", function(args)
             print("sleep")
         end, icons.system.suspend
         },
         {"Logout", function() print("lock")
         end, icons.system.logout},
         {"Lock", function() print("logout") end, icons.system.lock},
         {"Reboot", function() print("reboot") end, icons.system.reboot},
         {"Shutdown", function() print("shutdown") end, icons.system.shutdown},
      }
})

local system_actions = awful.widget.launcher({
      image = icons.system.shutdown,
      menu = system_menu
})

-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
-- Error handling
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, errors during startup!",
                     text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = tostring(err) })
        in_error = false
    end)
end

-- This is used later as the default terminal and editor to run.
terminal = "konsole"
editor = os.getenv("EDITOR") or "emacs"
editor_cmd = terminal .. " -e " .. editor
ff = "firefox-bin"
gg = "google-chrome-stable"
chr = "chromium"
emacs = "emacs"

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may conflict with others.
modkey = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
    awful.layout.suit.tile,
    awful.layout.suit.spiral,
    awful.layout.suit.floating,
}

-- Menu
-- Create a launcher widget and a main menu
myawesomemenu = {
   { "Hotkeys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
   { "Manual", terminal .. " -e man awesome" },
   { "Config", editor_cmd .. " " .. awesome.conffile },
   { "Restart", awesome.restart },
   { "Quit", function() awesome.quit() end },
}

mymainmenu = awful.menu({ items = { { "Awesome", myawesomemenu, beautiful.awesome_icon },
                                    { "Terminal", terminal },
                                    { "Emacs",     emacs },
                                    { "Fifrefox",  ff },
                                    { "Chrome",    gg },
                                  }
                        })

mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon,
                                     menu = mymainmenu })

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for apps that require it


-- Keyboard map indicator and switcher
mykeyboardlayout = awful.widget.keyboardlayout()


-- Create a wibox for each screen and add it
local taglist_buttons = gears.table.join(
                    awful.button({ }, 1, function(t) t:view_only() end),
                    awful.button({ modkey }, 1, function(t)
                                              if client.focus then
                                                  client.focus:move_to_tag(t)
                                              end
                                          end),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, function(t)
                                              if client.focus then
                                                  client.focus:toggle_tag(t)
                                              end
                                          end),
                    awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
                    awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
                )

local tasklist_buttons = gears.table.join(
                     awful.button({ }, 1, function (c)
                                              if c == client.focus then
                                                  c.minimized = true
                                              else
                                                  c:emit_signal(
                                                      "request::activate",
                                                      "tasklist",
                                                      {raise = true}
                                                  )
                                              end
                                          end),
                     awful.button({ }, 3, function()
                                              awful.menu.client_list({ theme = { width = 250 } })
                                          end),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                          end))

local function set_wallpaper(s)
    -- Wallpaper
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        -- If wallpaper is a function, call it with the screen
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        gears.wallpaper.maximized(wallpaper, s, true)
    end
end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

awful.screen.connect_for_each_screen(function(s)
    -- Wallpaper
    set_wallpaper(s)

    -- Each screen has its own tag table.
    local l = awful.layout.suit    -- alias
    local lyts = {l.tile, l.tile, l.floating,
                  l.tile, l.tile, l.tile,
                  l.tile, l.tile, l.tile}
    awful.tag({ "1", "2", "3", "4", "5", "6", "7", "8", "9" }, s, lyts)

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()
    -- Create an imagebox widget which will contain an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(gears.table.join(
                           awful.button({ }, 1, function () awful.layout.inc( 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(-1) end),
                           awful.button({ }, 4, function () awful.layout.inc( 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(-1) end)))
    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist {
        screen  = s,
        filter  = awful.widget.taglist.filter.all,
        buttons = taglist_buttons
    }

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist {
        screen  = s,
        filter  = awful.widget.tasklist.filter.currenttags,
        buttons = tasklist_buttons
    }

    -- Create the wibox
    s.mywibox = awful.wibar({ position = "top", screen = s })

    -- Add widgets to the wibox
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            mylauncher,
            s.mytaglist,
            s.mypromptbox,
        },
        s.mytasklist, -- Middle widget
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            spacing = 5,
            -- mykeyboardlayout,
            wibox.widget.systray(),
            -- wibox.widget.imagebox(bat.icon, false, nil),
            vol_icon,
            -- net_icon,
            battery_icon,
            txtclk,
            system_actions,
            s.mylayoutbox,
        },
    }
end)

root.buttons(gears.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))

globalkeys = gears.table.join(
    awful.key({ modkey,           }, "s",      hotkeys_popup.show_help,
              {description="show help", group="awesome"}),
    awful.key({ modkey,           }, "Left",   awful.tag.viewprev,
              {description = "view previous", group = "tag"}),
    awful.key({ modkey,           }, "Right",  awful.tag.viewnext,
              {description = "view next", group = "tag"}),
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore,
              {description = "go back", group = "tag"}),

    awful.key({ modkey,           }, "j",
        function ()
            awful.client.focus.byidx( 1)
        end,
        {description = "focus next by index", group = "client"}
    ),
    awful.key({ modkey,           }, "k",
        function ()
            awful.client.focus.byidx(-1)
        end,
        {description = "focus previous by index", group = "client"}
    ),
    awful.key({ modkey,           }, "w", function () mymainmenu:show() end,
              {description = "show main menu", group = "awesome"}),

    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end,
              {description = "swap with next client by index", group = "client"}),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end,
              {description = "swap with previous client by index", group = "client"}),
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end,
              {description = "focus the next screen", group = "screen"}),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end,
              {description = "focus the previous screen", group = "screen"}),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto,
              {description = "jump to urgent client", group = "client"}),
    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end,
        {description = "go back", group = "client"}),

    -- Standard program
    awful.key({ modkey,           }, "Return", function () awful.spawn(terminal) end,
              {description = "open a terminal", group = "launcher"}),
    awful.key({ modkey, "Control" }, "r", awesome.restart,
              {description = "reload awesome", group = "awesome"}),
    awful.key({ modkey, "Shift"   }, "q", awesome.quit,
              {description = "quit awesome", group = "awesome"}),

    awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)          end,
              {description = "increase master width factor", group = "layout"}),
    awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)          end,
              {description = "decrease master width factor", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1, nil, true) end,
              {description = "increase the number of master clients", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1, nil, true) end,
              {description = "decrease the number of master clients", group = "layout"}),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1, nil, true)    end,
              {description = "increase the number of columns", group = "layout"}),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1, nil, true)    end,
              {description = "decrease the number of columns", group = "layout"}),
    awful.key({ modkey,           }, "space", function () awful.layout.inc( 1)                end,
              {description = "select next", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(-1)                end,
              {description = "select previous", group = "layout"}),

    awful.key({ modkey, "Control" }, "n",
              function ()
                  local c = awful.client.restore()
                  -- Focus restored client
                  if c then
                    c:emit_signal(
                        "request::activate", "key.unminimize", {raise = true}
                    )
                  end
              end,
              {description = "restore minimized", group = "client"}),

    -- Prompt
    awful.key({ modkey },            "r",     function () awful.screen.focused().mypromptbox:run() end,
              {description = "run prompt", group = "launcher"}),

    awful.key({ modkey }, "x",
              function ()
                  awful.prompt.run {
                    prompt       = "Run Lua code: ",
                    textbox      = awful.screen.focused().mypromptbox.widget,
                    exe_callback = awful.util.eval,
                    history_path = awful.util.get_cache_dir() .. "/history_eval"
                  }
              end,
              {description = "lua execute prompt", group = "awesome"}),
    -- Menubar
    awful.key({ modkey }, "p", function() menubar.show() end,
              {description = "show the menubar", group = "launcher"})
)

clientkeys = gears.table.join(
   awful.key({ modkey,           }, "f",
      function (c)
         c.fullscreen = not c.fullscreen
         c:raise()
      end,
      {description = "toggle fullscreen", group = "client"}),
   awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end,
      {description = "close", group = "client"}),
   awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ,
      {description = "toggle floating", group = "client"}),
   awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end,
      {description = "move to master", group = "client"}),
   awful.key({ modkey,           }, "o",      function (c) c:move_to_screen()               end,
      {description = "move to screen", group = "client"}),
   awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end,
      {description = "toggle keep on top", group = "client"}),
   awful.key({ modkey,           }, "n",
      function (c)
         -- The client currently has the input focus, so it cannot be
         -- minimized, since minimized clients can't have the focus.
         c.minimized = true
      end ,
      {description = "minimize", group = "client"}),
   awful.key({ modkey,           }, "m",
      function (c)
         c.maximized = not c.maximized
         c:raise()
      end ,
      {description = "(un)maximize", group = "client"}),
   awful.key({ modkey, "Control" }, "m",
      function (c)
         c.maximized_vertical = not c.maximized_vertical
         c:raise()
      end ,
      {description = "(un)maximize vertically", group = "client"}),
   awful.key({ modkey, "Shift"   }, "m",
      function (c)
         c.maximized_horizontal = not c.maximized_horizontal
         c:raise()
      end ,
      {description = "(un)maximize horizontally", group = "client"})
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    globalkeys = gears.table.join(globalkeys,
        -- View tag only.
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = awful.screen.focused()
                        local tag = screen.tags[i]
                        if tag then
                           tag:view_only()
                        end
                  end,
                  {description = "view tag #"..i, group = "tag"}),
        -- Toggle tag display.
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = awful.screen.focused()
                      local tag = screen.tags[i]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end,
                  {description = "toggle tag #" .. i, group = "tag"}),
        -- Move client to tag.
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:move_to_tag(tag)
                          end
                     end
                  end,
                  {description = "move focused client to tag #"..i, group = "tag"}),
        -- Toggle tag on focused client.
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
           function ()
              if client.focus then
                 local tag = client.focus.screen.tags[i]
                 if tag then
                    client.focus:toggle_tag(tag)
                 end
              end
           end,
           {description = "toggle focused client on tag #" .. i, group = "tag"}),

        -- Somehow, XF86-* keys repeat the bound commands 9 times. For example,
        -- Passing 1 will increase by 9%, not 1%. Reason remains unknown to me.
        -- Brightness of display using `light` package
        awful.key({}, "XF86MonBrightnessUp",
           function()
              os.execute("light -s sysfs/backlight/intel_backlight -A 1")
           end,
           {description = "Increase screen brightness by 5%", group = "extra"}),
        awful.key({}, "XF86MonBrightnessDown",
           function()
              os.execute("light -s sysfs/backlight/intel_backlight -U 1")
           end,
           {description = "Decrease screen brightness by 5%", group = "extra"}),
        -- Volume ALSA
        awful.key({}, "XF86AudioRaiseVolume",
           function()
              os.execute("amixer -q sset Master 1%+")
              -- awful.spawn(terminal .. "-e echo test")
           end,
           {description = "Raise volume by 5%", group = "extra"}),
        awful.key({}, "XF86AudioLowerVolume",
           function()
              os.execute("amixer -q sset Master 1%-")
           end,
           {description = "Lower volume by 5%", group = "extra"}),
        awful.key({}, "XF86AudioMute",
           function()
              os.execute("amixer -q set Master toggle")
              if vol_icon.muted then
                 vol_icon:set_image(icons.audio.volume.high)
                 vol_icon.muted = false
              else
                 vol_icon:set_image(icons.audio.volume.muted)
                 vol_icon.muted = true
              end
           end,
           {description = "Mute audio", group = "extra"}),
        awful.key({}, "XF86AudioMicMute",
           function()
              os.execute("amixer -q set Capture toggle")
           end,
           {description = "Mute microphone", group = "extra"})
    )
end

clientbuttons = gears.table.join(
    awful.button({ }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
    end),
    awful.button({ modkey }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.move(c)
    end),
    awful.button({ modkey }, 3, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.resize(c)
    end)
)

-- Set keys
root.keys(globalkeys)

-- Rules to apply to new clients (through the "manage" signal).
-- Use `xprop` to find out how to match an app, i.e. name? instance? or class?
awful.rules.rules = {
   -- General rule
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = awful.client.focus.filter,
                     raise = true,
                     keys = clientkeys,
                     buttons = clientbuttons,
                     screen = awful.screen.preferred,
                     placement = awful.placement.no_overlap+awful.placement.no_offscreen
     }
    },

    -- Telegram
    { rule = { class = "TelegramDesktop",
               name =  "Media viewer",  -- telegram
    },
      properties = { floating = true,
                     titlebars_enabled = false,
                     placement = awful.placement.centered,
                     maximized_vertical = true,
                     maximized_horizontal = true,
      }
    },

    -- GoldenDict
    { rule = { class    = "GoldenDict-ng",
               instance = "goldendict",
    },
      properties = { floating = true,
                     titlebars_enabled = true,
                     placement = awful.placement.left,
                     maximized_vertical = true,
                     width = 800,
      }
    },

    -- Anki
    { rule = { class    = "Anki",
               instance = "anki",
    },
      properties = { floating = true,
                     titlebars_enabled = true,
                     placement = awful.placement.center,
                     height = 767,
                     width = 680,
      }
    },

    -- Floating with title bars
    { rule_any = {
        instance = {
           "DTA",  -- Firefox addon DownThemAll
           "Devtools", -- Firefox devtools as separate window
           "copyq",  -- Includes session name in class.
           "pinentry",
           "nm-connection-editor", -- wifi configuration
           "nm-applet",            -- wifi password
           "pcmanfm",
           "obs",
           "vlc",
           "sublime_text",
        },
        class = {
          "Arandr",
          "spectacle",
          "fcitx5-config-qt",
          "mpv",
        },
        -- Note that the name property shown in xprop might be set slightly after creation of the client
        -- and the name shown there might not match defined rules here.
        name = {
           "Event Tester",  -- xev
        },
        role = {
          "pop-up", -- Chrome's (detached) Developer Tools
        }
    },
      properties = { floating = true,
                     titlebars_enabled = true,
                     placement = awful.placement.centered,

    }},
}

-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    -- if not awesome.startup then awful.client.setslave(c) end

    if awesome.startup
      and not c.size_hints.user_position
      and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end
end)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
    -- buttons for the titlebar
    local buttons = gears.table.join(
        awful.button({ }, 1, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            awful.mouse.client.move(c)
        end),
        awful.button({ }, 3, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            awful.mouse.client.resize(c)
        end)
    )

    awful.titlebar(c) : setup {
        { -- Left
            awful.titlebar.widget.iconwidget(c),
            buttons = buttons,
            layout  = wibox.layout.fixed.horizontal
        },
        { -- Middle
            { -- Title
                align  = "center",
                widget = awful.titlebar.widget.titlewidget(c)
            },
            buttons = buttons,
            layout  = wibox.layout.flex.horizontal
        },
        { -- Right
            awful.titlebar.widget.floatingbutton (c),
            awful.titlebar.widget.maximizedbutton(c),
            awful.titlebar.widget.closebutton    (c),
            layout = wibox.layout.fixed.horizontal()
        },
        layout = wibox.layout.align.horizontal
    }
end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
    c:emit_signal("request::activate", "mouse_enter", {raise = false})
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)

-- Spawn a few programs
-- os.execute("xset r rate 400 100")
