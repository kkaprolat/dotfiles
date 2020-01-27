local awful = require('awful')
local wibox = require('wibox')

local widget = wibox.widget {
        {
                id = 'wifi_icon',
                markup = '爛',
                font = 'Material Design Icons',
                widget = wibox.widget.textbox,
                align = 'center',
                valign = 'center'
        },
        layout = wibox.layout.fixed.horizontal
}
return widget
