local awful = require('awful')
local wibox = require('wibox')
local beautiful = require('beautiful')

-- arrays start with 1 in lua
-- add 1 space padding around the icons
local normal = { ' 冷 ', ' 爛 ', ' 嵐 ', ' 襤 ', ' 蠟 ' }
local alert =  { ' 浪 ', ' 蘭 ', ' 濫 ', ' 拉 ', ' 廊 ' }
local lock =   { ' 狼 ', ' 鸞 ', ' 藍 ', ' 臘 ', ' 朗 ' }
local disconnected = ' 郎 '

local widget = wibox.widget {
        {
                        widget = wibox.widget.textbox,
                        markup = alert[1],
                        align = 'center',
                        valign = 'center',
                        font = 'Material Design Icons 15',
                        id = 'wifi_icon'
                },
                fg = beautiful.red, -- does not work
                widget = wibox.container.background
}
return widget
