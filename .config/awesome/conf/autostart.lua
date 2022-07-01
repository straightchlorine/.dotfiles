local awful = require("awful")

local function autostart () 
	-- add a mathod, checking whether a program is alreasy running
	awful.spawn("picom --experimental-backends")

end

autostart()

