local awful = require("awful")
local beautiful = require("beautiful")
local keys = require("keys")

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = awful.client.focus.filter,
                     raise = true,
                     keys = keys.clientkeys,
                     buttons = keys.clientbuttons,
                     screen = awful.screen.preferred,
                     placement = awful.placement.no_overlap+awful.placement.no_offscreen
     }
    },

    -- Floating clients.
    { rule_any = {
        instance = {
          "DTA",  -- Firefox addon DownThemAll.
          "copyq",  -- Includes session name in class.
          "pinentry",
        },
        class = {
          "Arandr",
          "Blueman-manager",
          "Gpick",
          "Kruler",
          "MessageWin",  -- kalarm.
          "Sxiv",
          "Tor Browser", -- Needs a fixed window size to avoid fingerprinting by screen size.
          "Wpa_gui",
          "veromix",
          "xtightvncviewer"},

        -- Note that the name property shown in xprop might be set slightly after creation of the client
        -- and the name shown there might not match defined rules here.
        name = {
          "Event Tester",  -- xev.
          "win0",
        },
        role = {
          "AlarmWindow",  -- Thunderbird's calendar.
          "ConfigManager",  -- Thunderbird's about:config.
          "pop-up",       -- e.g. Google Chrome's (detached) Developer Tools.
        }
      }, properties = { floating = true }},

    -- Add titlebars to normal clients and dialogs
    { rule_any = {type = { "normal", "dialog" }
      }, properties = { titlebars_enabled = false }
    },

    -- Set Firefox to always map on the tag named "2" on screen 1.
    { rule = { class = "firefox" },
    properties = { screen = 1, tag = "5" } },
    { rule = { class = "KeePassXC"},
    properties = { screen = 1, tag = "8"} },
    { rule = { class = "Steam" },
    properties = { screen = 1, tag = "2" } },
    { rule = { name = "ncmpcpp" },
    properties = { screen = 1, tag = "3" } },
    { rule = { class = "Clementine" },
    properties = { screen = 1, tag = "3" } },
    { rule = { class = "Thunderbird" },
    properties = { screen = 1, tag = "6" } },
    { rule = { class = "discord" },
    properties = { screen = 1, tag = "7" } },
    { rule_any = {  class = { "Rofi", }, },
    properties = { skip_taskbar = true, floating = true, ontop = true, sticky = true, fullscreen = false, maximized = true },
    -- callback = function (c)
    --         awful.placement.centered(c,{honor_padding = true, honor_workarea=true})
    --         if not beautiful.titlebars_imitate_borders then
    --                 awful.titlebar.hide(c)
    --         end
    -- end
    },
}
-- }}}
