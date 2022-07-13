local beautiful = require("beautiful")
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
local naughty = require("naughty")
local wibox = require("wibox")

-- setting theme
local theme_path = string.format("%s/.config/awesome/themes/%s/theme.lua",
                                 os.getenv("HOME"), "initial")
beautiful.init(theme_path)
for s = 1, screen.count() do
    gears.wallpaper.maximized(beautiful.wallpaper, s, true)
end


-- Create a wibox for each screen and add it
local taglist_buttons = gears.table.join(
    awful.button({}, 1, function(t) t:view_only() end),
    awful.button({modkey}, 1, function(t)
        if client.focus then
            client.focus:move_to_tag(t)
        end
    end), 
    awful.button({}, 3, awful.tag.viewtoggle),
    awful.button({modkey}, 3, function(t)
        if client.focus then client.focus:toggle_tag(t) end
    end), 
    awful.button({}, 4, function(t) awful.tag.viewnext(t.screen) end),
    awful.button({}, 5, function(t)
        awful.tag.viewprev(t.screen)
    end))

local tasklist_buttons = gears.table.join(
                             awful.button({}, 1, function(c)
        if c == client.focus then
            c.minimized = true
        else
            c:emit_signal("request::activate", "tasklist", {raise = true})
        end
    end), awful.button({}, 3, function()
        awful.menu.client_list({theme = {width = 250}})
    end), awful.button({}, 4, function() awful.client.focus.byidx(1) end),
                             awful.button({}, 5, function()
        awful.client.focus.byidx(-1)
    end))

local function set_wallpaper(s)
    -- Wallpaper
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        -- If wallpaper is a function, call it with the screen
        if type(wallpaper) == "function" then wallpaper = wallpaper(s) end
        gears.wallpaper.maximized(wallpaper, s, true)
    end
end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

awful.screen.connect_for_each_screen(function(s)
    -- Wallpaper
    set_wallpaper(s)

    -- Each screen has its own tag table.
    awful.tag({"1", "2", "3", "4", "5", "6", "7", "8", "9", "10"}, s,
              awful.layout.layouts[1])

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()
    -- Create a taglist widget

    s.taglist = awful.widget.taglist {
        screen = s,
        filter = awful.widget.taglist.filter.all,
        style = {
            shape = gears.shape.square,
        },
        layout = {
            layout = wibox.layout.fixed.horizontal
        },
        widget_template = {
            {
                {
                    {
                        id = 'index_markup',
                        widget = wibox.widget.textbox,
                    },
                    left = 6,
                    right = 6,
                    widget = wibox.container.margin,
                },
                widget = wibox.widget.background,
            },
            id = 'background_role',
            widget = wibox.widget.background,

            -- changes background colour on mouse hover (white to grey)
            create_callback = function(self, c3, index, objects)
                self:get_children_by_id('index_markup')[1].markup = '<b> '..index..' </b>'
                self:connect_signal('mouse::enter',
                    function()
                        if self.bg ~= '#e8e8e8' then
                            self.backup = self.bg
                            self.has_backup = true
                        end
                        self.bg = '#e8e8e8'
                    end
                )
                self:connect_signal('mouse::leave',
                    function()
                        if self.has_backup
                            then self.bg = self.backup 
                        end
                    end
                )
            end
        },

        buttons = taglist_buttons,
    }


    -- clock
    local clock = wibox.widget.textclock("%a %b %d %T", 1)
    -- holds calendar notification object
    local calendar_notifications = {}

    visible = false
    clock:connect_signal("button::press",
        function()
            if not visible then
                calendar_notifications.calendar = naughty.notify({
                    replaces_id = 100,
                    title = "test",
                    text = 'testtest',
                    timeout = 0,
                })
                visible = true;
            else
                naughty.destroy(calendar_notifications.calendar)
                visible = false;
            end
        end
    )

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist {
        screen = s,
        filter = awful.widget.tasklist.filter.currenttags,
        buttons = tasklist_buttons
    }

    s.bar_overlord = awful.wibar({position = "top", screen = s, stretch = false, width = 1880, opacity = 0.85})
    awful.placement.top(s.bar_overlord, { margins = 10 })

    s.bar_overlord:setup {
            layout = wibox.layout.align.horizontal,
            {
                layout = wibox.layout.fixed.horizontal,
                s.taglist
            },
            {
                layout = wibox.layout.fixed.horizontal,
            },
            {
                {
                    layout = wibox.layout.fixed.horizontal,
                    clock,
                },
                right = 10,
                widget = wibox.container.margin,
            },

    }

    -- calendar:attach(clock, "tr")
end)

return awful.tags
