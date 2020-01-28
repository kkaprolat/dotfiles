local awful = require('awful')
local wibox = require('wibox')
local beautiful = require('beautiful')

-- arrays start with 1 in lua
-- add 1 space padding around the icons
local function get_status()
        awful.spawn.easy_async_with_shell(command, function()
    awful.spawn.easy_async_with_shell("", function(out)
        mylabel.text = out
    end)
end)
end

local function set_ssid()
        awful.spawn.easy_async_with_shell(command, function()
    awful.spawn.easy_async_with_shell("nmcli -f NAME -t -c no connection show --active | tail -1", function(out)
            widget.text = out
    end)
end)
end

local normal = { ' 冷 ', ' 爛 ', ' 嵐 ', ' 襤 ', ' 蠟 ' }
local alert =  { ' 浪 ', ' 蘭 ', ' 濫 ', ' 拉 ', ' 廊 ' }
local lock =   { ' 狼 ', ' 鸞 ', ' 藍 ', ' 臘 ', ' 朗 ' }
local disconnected = ' 郎 '
local color_default = ""
local color_warning = "#BF616A"
local color_vpn =     ""
local widget = wibox.widget {
        {
                        widget = wibox.widget.textbox,
                        markup = alert[1],
                        align = 'center',
                        valign = 'center',
                        font = 'Material Design Icons 15',
                        id = 'wifi_icon'
                },
        fg = color_warning,
        widget = wibox.container.background
}
return widget

