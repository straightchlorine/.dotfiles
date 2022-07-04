local naughty = require("naughty")

-- basically initial snipped of code from rc.lua sample
local function error_handling ()
	-- error notification
	if awesome.startup_errors then
	    naughty.notify({ preset = naughty.config.presets.critical,
	                     title = "i'm really disappointed in you",
	                     text = awesome.startup_errors })
	end
	
	-- runtime errors after startup
	do
	    local in_error = false
	    awesome.connect_signal("debug::error", function (err)
	        -- Make sure we don't go into an endless error loop
	        if in_error then return end
	        in_error = true
	
	        naughty.notify({ preset = naughty.config.presets.critical,
	                         title = "dumbass (-_-)",
	                         text = tostring(err) })
	        in_error = false
	    end)
	end
end

error_handling()
