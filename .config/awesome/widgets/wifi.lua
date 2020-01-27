local awful = require('awful')
local wibox = require('wibox')
local beautiful = require('beautiful')

-- arrays start with 1 in lua
local normal = { '冷', '爛', '嵐', '襤', '蠟' }
local alert =  { '浪', '蘭', '濫', '拉', '廊' }
local lock =   { '狼', '鸞', '藍', '臘', '朗' }
local disconnected = '郎'

local widget = wibox.widget {
        {
                id = 'wifi_icon',
                markup = disconnected,
                font = 'Material Design Icons',
                widget = wibox.widget.textbox,
                align = 'center',
                valign = 'center'
        },
        layout = wibox.layout.fixed.horizontal,
        color = beautiful.red
}
return widget
