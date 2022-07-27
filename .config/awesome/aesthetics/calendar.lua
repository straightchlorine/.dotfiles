local wibox = require('wibox')
local gears = require('gears')
local awful = require('awful')

-- initial future widget setup
-- maybe try to turn in into dock of sorts?
calendar_widget = wibox.widget {
    date        = os.date('*t'),
    font        = "sans 8",
    long_weekdays = false,
    spacing     = dpi(3),
    fn_enabled  = decorate_cell,
    widget      = wibox.widget.calendar.month
}
