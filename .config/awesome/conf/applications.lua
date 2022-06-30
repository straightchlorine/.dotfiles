-- Terminal prefix
local emulator_exec = "alacritty -e "

defaults = {}

return {
	-- Default applications
	defaults = {
		-- Terminal
		terminal = emulator_exec .. "fish",
		-- File manager
		file_manager = emulator_exec .. "ranger",
		-- Music player
		music_player = emulator_exec .. "ncmpcpp",
		-- Application launcher
		launcher = "rofi -combi-modi {run, windows, ssh} -show run",
		-- Graphical IDE
		graphical_ide = "code",
		-- Terminal IDE
		terminal_ide = "nvim",
		-- Browser
		browser = "firefox",
		
		--todo
		bluetooth_manager = "not yet",
		power_manager = "not yet", 
	}
}
