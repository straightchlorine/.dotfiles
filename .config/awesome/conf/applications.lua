-- terminal prefix
local emulator_exec = "alacritty -e "

-- default applications
defaults = {}

return {
	defaults = {
		-- terminal
		terminal = emulator_exec .. "fish",
		-- file manager
		file_manager = emulator_exec .. "ranger",
		-- music player
		music_player = emulator_exec .. "ncmpcpp",
		-- application launcher
		launcher = "rofi -combi-modi {run, windows, ssh} -show run",
		-- graphical ide
		graphical_ide = "code",
		-- terminal ide
		terminal_ide = "nvim",
		-- browser
		browser = "firefox",
		
		-- in the future, for now not functional
		bluetooth_manager = "not yet",
		power_manager = "not yet", 
	}
}
