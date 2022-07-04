local awful = require("awful")

-- Method called at the end of the main rc.lua file; contains programs, required to start
-- after wm starts and loads configuration
local function autostart () 
	-- add a mathod, checking whether a program is alreasy running
	awful.spawn("picom --experimental-backends")

end

autostart()

