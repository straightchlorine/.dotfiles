require("awful.hotkeys_popup.keys")

local awful = require("awful")
local gears = require("gears")
local naughty = require("naughty")
local gears = require("gears")
local apps = require("conf.applications")
local hotkeys_popup = require("awful.hotkeys_popup")

local keys = {}

-- Key aliases
-- ~-~-~-~-~-~-~-~-~-~-~-~-
mod = "Mod4"
alt = "Mod1"
ctrl = "Control"
shift = "Shift"

-- Global key bindings
-- ~-~-~-~-~-~-~-~-~-~-~-~-
keys.globalkeys = gears.table.join(
	-- Window manager
	-- ~-~-~-~-~-~-~-~-
	awful.key({ mod, ctrl }, "r", awesome.restart,
		{ description = "restart", group = "wm" }),
	awful.key({ mod, ctrl }, "q", awesome.quit,
		{ description = "quit", group = "wm" }),
	awful.key({ mod }, "F1", hotkeys_popup.show_help,
		{ description = "help", group = "wm" }),

	-- Hardware
	-- ~-~-~-~-~-~-~-~-
	-- Brightness
	awful.key( { }, "XF86MonBrightnessDown",
        	function ()
            		awful.spawn.with_shell("light -U 10")
        	end,
        { description = "decrease brightness", group = "brightness" }),

    	awful.key( { }, "XF86MonBrightnessUp",
        	function ()
        	    awful.spawn.with_shell("light -A 10")
       		end,
        { description = "increase brightness", group = "brightness" }),

	-- Volume
	awful.key( { }, "XF86AudioRaiseVolume",
		function ()
			awful.spawn.with_shell("amixer set Master 2%+")
		end,
	{ description = "volume up", group = "volume" }),

	awful.key( { }, "XF86AudioLowerVolume",
		function ()
			awful.spawn.with_shell("amixer set Master 2%-")
		end,
	{ description = "volume up", group = "volume" }),

	awful.key( { }, "XF86AudioMute", 
		function ()
			awful.spawn.with_shell("amixer set Master 0%")
		end,
	{ description = "mute", group = "volume" }),

	-- Applications
	-- ~-~-~-~-~-~-~-~-
	-- Terminal
	awful.key({ mod }, "Return", function()
		awful.spawn(apps.defaults.terminal)
	end,
	{ descrpion = "terminal", group = "applications" }),

	-- Application launcher
	awful.key({ mod }, "r", function()
		awful.spawn(apps.defaults.launcher)
	end,
	{ desciption = "application launcher", group = "applications" }),

	-- File manager
	awful.key({ mod, shift }, "f", function()
		awful.spawn(apps.defaults.file_manager)
	end,
	{ descrption = "file manager", gruop = "applications" }),

	-- Music player
	awful.key({ mod, shift }, "m", function()
		awful.spawn(apps.defaults.music_player)
	end, 
	{ description = "music player", group = "applications" }),

	-- Graphical IDE
	awful.key({ mod, shift }, "c", function()
		awful.spawn(apps.defaults.graphical_ide)
	end,
	{ description = "graphical ide", group = "applications" }),

	-- Browser
	awful.key({ mod, shift }, "w", function()
		awful.spawn(apps.defaults.browser)
	end,
	{ description = "web browser", group = "applications" }),

	-- Navigation
	-- ~-~-~-~-~-~-~-~-
	awful.key({ mod }, "j", 
		function()
			awful.client.focus.byidx(1)
		end,
	{ description = "focus next by index", group = "navigation" }),

	awful.key({ mod }, "k",
		function()
			awful.client.focus.byidx(-1)
		end, 
	{ description = "focus previous by index", group = "navigation" }),
	
	awful.key({ mod }, "Tab", 
		function()
			awful.client.focus.history.previous()
			if client.focus then
				client.focus:raise()
			end
		end,
        { description = "focus on the previous client", group = "navigation" }),

	-- Layout manipulation
	-- ~-~-~-~-~-~-~-~-
	awful.key({ mod, shift }, "j",
		function()
			awful.client.swap.byidx(1)
		end,
	{ description = "swap with next client by index",
	  group = "layout" }),

	awful.key({ mod, shift }, "k",
		function()
			awful.client.swap.byidx(-1)
		end, 
	{ description = "swap with previous client by index",
	  group = "layout" }),

	awful.key({ mod }, "l", 
		function()
			awful.tag.incmwfact(0.05)
		end,
	{ description = "increase master width factor",
          group = "layout" }),
	
	awful.key({ mod }, "h",
		function()
			awful.tag.incmwfact(-0.05)
		end,
	{ description = "decrease master width factor",
	  group = "layout" }),

	awful.key({ mod, shift }, "h",
		function() 
			awful.tag.incnmaster(1, nil, true)
		end,
	{ description = "increase the number of master clients",
	  group = "layout" }),
              
    	awful.key({ mod, shift }, "l",
		function ()
			awful.tag.incnmaster(-1, nil, true)
		end,
        { description = "decrease the number of master clients",
	  group = "layout" }),


	awful.key({ mod }, "h",
		function ()
			awful.tag.incncol( 1, nil, true)
		end,
       	{ description = "increase the number of columns",
          group = "layout" }),

    	awful.key({ mod, control }, "l",
		function ()
			awful.tag.incncol(-1, nil, true)
		end,
       	{ description = "decrease the number of columns",
	  group = "layout" }),

    	awful.key({ mod }, "space",
		function ()
			awful.layout.inc(1)
		end,
       	{ description = "select next layout",
	  group = "layout" }),

    	awful.key({ mod, shift }, "space",
		function ()
			awful.layout.inc(-1)
		end,
        { description = "select previous layout",
	  group = "layout"}),

    	awful.key({ mod, control }, "n",
    	          function ()
    	              local c = awful.client.restore()
    	              -- Focus restored client
    	              if c then
    	                c:emit_signal(
    	                    "request::activate", "key.unminimize", {raise = true}
    	                )
    	              end
    	          end,
	{ description = "restore minimized",
          group = "navigation" }),

    	awful.key({ mod }, "x",
    	          function ()
    	              awful.prompt.run {
    	                prompt       = "Run Lua code: ",
    	                textbox      = awful.screen.focused().mypromptbox.widget,
    	                exe_callback = awful.util.eval,
    	                history_path = awful.util.get_cache_dir() .. "/history_eval"
    	              }
    	          end,
    	{ description = "lua execute prompt",
	  group = "wm" }),

        -- Screen focus
	-- ~-~-~-~-~-~-~-~-
	awful.key({ mod, control }, "j",
		function()
			awful.screen.focus_relative(1)
		end,
        { description = "focus the next screen",
	  group = "screen" }),

	awful.key({ mod, control }, "k",
		function()
			awful.screen.focus_relative(-1)
		end,
        { description = "focus the previous screen",
	  group = "screen" })
)

-- Client key bindings
-- ~-~-~-~-~-~-~-~-~-~-~-~-
keys.clientkeys = gears.table.join(
	
	-- Fullscreen
	awful.key({ mod }, "f",
        	function (c)
            		c.fullscreen = not c.fullscreen
            		c:raise()
        	end,
    	{ description = "toggle fullscreen", group = "window management" }),
	
	-- Killing the focused application
    	awful.key({ mod, shift }, "q",
		function (c)
			c:kill()
		end,
	{ description = "close", group = "window management" }),

	-- Toggle floating layout
    	awful.key({ mod, control }, "space",
		awful.client.floating.toggle                     ,
        { description = "toggle floating", group = "layout" }),

	-- Switch focus to master client
    	awful.key({ mod, control }, "Return",
		function (c)
			c:swap(awful.client.getmaster())
		end,
        { description = "move to master", group = "window management" }),

	-- Keeping current window on top (floating)
    	awful.key({ mod }, "t",
		function (c)
			c.ontop = not c.ontop
		end,
        { description = "toggle keep on top", group = "window management" }),
	
	-- Minimalize
    	awful.key({ mod }, "n",
        	function (c)
            		c.minimized = true
        	end,
        { description = "minimize", group = "window management" }),

	-- Toggle maximize	
    	awful.key({ mod }, "m",
        	function (c)
            		c.maximized = not c.maximized
            		c:raise()
        	end,
        { description = "toggle maximize", group = "window management" }),

	-- Toggle maximize vertically
    	awful.key({ mod, control }, "m",
        	function (c)
            		c.maximized_vertical = not c.maximized_vertical
            		c:raise()
        	end,
        { description = "toggle maximize vertically", group = "window management" }),
	
	-- Toggle maximize horizontally
    	awful.key({ mod, shift}, "m",
		function (c)
        	    c.maximized_horizontal = not c.maximized_horizontal
        	    c:raise()
        	end ,
        { description = "toggle maximize horizontally", group = "window management" })
)

-- Tags
-- ~-~-~-~-~-~-~-~-~-~-~-~-
local n = 10
for i = 1, n do
    keys.globalkeys = gears.table.join(keys.globalkeys,
        -- View tag only.
        awful.key({ mod }, "#" .. i + 9,
		function ()
			local screen = mouse.screen
			local tag = screen.tags[i]
			if tag then
				if tag == screen.selected_tag then
					awful.tag.history.restore()
				else 
					tag:view_only()
				end
			end
		end,
		-- original script
                -- function ()
                --       local screen = awful.screen.focused()
                --       local tag = screen.tags[i]
                --       if tag then
                --          tag:view_only()
                --       end
                -- end,
        { description = "view tag #"..i, group = "tag" }),

        -- Toggle tag display.
        awful.key({ mod, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = awful.screen.focused()
                      local tag = screen.tags[i]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end,
        { description = "toggle tag #" .. i, group = "tag" }),

        -- Move client to tag.
        awful.key({ mod, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:move_to_tag(tag)
                          end
                     end
                  end,
        { description = "move focused client to tag #"..i, group = "tag" }),

        -- Toggle tag on focused client.
        awful.key({ mod, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:toggle_tag(tag)
                          end
                      end
                  end,
	{ description = "toggle focused client on tag #" .. i, group = "tag" })
    )
end

root.keys(keys.globalkeys)

return keys
