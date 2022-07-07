local awful = require("awful")

-- called at the end of the configuration (launches apps required to start after the wm setup
local function autostart () 
	-- add a mathod, checking whether a program is alreasy running i suppose?
	awful.spawn("picom --experimental-backends")

end

autostart()

