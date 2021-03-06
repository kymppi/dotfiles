pcall(require, "luarocks.loader")

-- Standard awesome library
gears = require("gears")
awful = require("awful")
require("awful.autofocus")

-- Widget and layout library
wibox = require("wibox")

-- Theme handling library
beautiful = require("beautiful")

-- Notification library
naughty = require("naughty")
menubar = require("menubar")
hotkeys_popup = require("awful.hotkeys_popup")
require("awful.hotkeys_popup.keys")

-- {{{ Error handling
if awesome.startup_errors then
    naughty.notify({
        preset = naughty.config.presets.critical,
        title = "Oopsie woopsie >-<, there were errors during startup! uwu",
        text = awesome.startup_errors
    })
end

beautiful.theme_path = "/home/midka/.config/awesome/themes/viletheme/"

do
    local in_error = false
    awesome.connect_signal("debug::error", function(err)
        -- Make sure we don't go into an endless error loop
        if in_error then
            return
        end
        in_error = true

        naughty.notify({
            preset = naughty.config.presets.critical,
            title = "Error!",
            text = tostring(err)
        })
        in_error = false
    end)
end
-- }}}

-- {{{ Variable definitions
beautiful.init("~/.config/awesome/themes/viletheme/theme.lua")

-- local themes_path = "/home/midka/.config/awesome/themes/"

terminal = "alacritty"
editor = "nvim"
screenshot_script = "flameshot gui"
editor_cmd = terminal .. " -e " .. editor

awful.util.shell = "/bin/zsh"

-- Modkey
modkey = "Mod4"

awful.layout.layouts = { -- awful.layout.suit.floating,
awful.layout.suit.tile, -- awful.layout.suit.tile.left,
-- awful.layout.suit.tile.bottom,
-- awful.layout.suit.tile.top,
awful.layout.suit.fair, awful.layout.suit.fair.horizontal, -- awful.layout.suit.spiral,
-- awful.layout.suit.spiral.dwindle,
awful.layout.suit.max, awful.layout.suit.max.fullscreen -- awful.layout.suit.magnifier,
-- awful.layout.suit.corner.nw,
-- awful.layout.suit.corner.ne,
-- awful.layout.suit.corner.sw,
-- awful.layout.suit.corner.se,
}
-- }}}

-- {{{ Awesome menu
mymainmenu = require('conf.awesomemenu')()

mylauncher = awful.widget.launcher({
    image = beautiful.awesome_icon,
    menu = mymainmenu,
    widget_template = {
        {
            widget = wibox.widget.imagebox
        },
        widget = wibox.container.margin,
        margins = 4
    }
})

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}

-- Keyboard map indicator and switcher
mykeyboardlayout = awful.widget.keyboardlayout()

-- {{{ Wibar
-- create a wibox for each screen and add it
local taglist_buttons = gears.table.join(awful.button({}, 1, function(t)
    t:view_only()
end), awful.button({modkey}, 1, function(t)
    if client.focus then
        client.focus:move_to_tag(t)
    end
end), awful.button({}, 3, awful.tag.viewtoggle), awful.button({modkey}, 3, function(t)
    if client.focus then
        client.focus:toggle_tag(t)
    end
end), awful.button({}, 4, function(t)
    awful.tag.viewnext(t.screen)
end), awful.button({}, 5, function(t)
    awful.tag.viewprev(t.screen)
end))

local tasklist_buttons = gears.table.join(awful.button({}, 1, function(c)
    if c == client.focus then
        c.minimized = true
    else
        c:emit_signal("request::activate", "tasklist", {
            raise = true
        })
    end
end), awful.button({}, 3, function()
    awful.menu.client_list({
        theme = {
            width = 250
        }
    })
end), awful.button({}, 4, function()
    awful.client.focus.byidx(1)
end), awful.button({}, 5, function()
    awful.client.focus.byidx(-1)
end))

local function set_wallpaper(s)
    -- wallpaper
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        -- if wallpaper is a function, call it with the screen
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        gears.wallpaper.maximized(wallpaper, s, false)
    end
end

-- re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

-- Create clock
mytextclock = wibox.widget.textclock("%H:%M %d.%m.%Y")

local widget_rect = function(cr, width, height)
    gears.shape.rounded_rect(cr, width, height, 3)
end

local rounded_box = function(w, bg, fg)
    bg = bg or beautiful.bg_normal
    fg = fg or beautiful.fg_normal
    return {
        {
            {
                w,
                widget = wibox.container.margin,
                left = 10,
                right = 10
            },
            widget = wibox.container.background,
            shape = widget_rect,
            bg = bg,
            fg = fg
        },
        widget = wibox.container.margin,
        margins = 3
    }
end

awful.screen.connect_for_each_screen(function(s)
    -- wallpaper
    set_wallpaper(s)

    -- each screen has its own tag table.
    awful.tag({"1", "2", "3", "4", "5", "6", "7", "8", "9"}, s, awful.layout.layouts[1])

    -- create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()
    -- create an imagebox widget which will contain an icon indicating which layout we're using.
    -- we need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s);
    s.mylayoutbox:buttons(gears.table.join(awful.button({}, 1, function()
        awful.layout.inc(1)
    end), awful.button({}, 3, function()
        awful.layout.inc(-1)
    end), awful.button({}, 4, function()
        awful.layout.inc(1)
    end), awful.button({}, 5, function()
        awful.layout.inc(-1)
    end)))

    if (s.index == screen.primary.index) then
        s.sidemenu = require('conf.sidemenu')(s)
    end

    if (s.index == screen.primary.index) then

        local ww = 700;
        local wh = 1;

        s.greeter = wibox {
            screen = s,
            x = s.geometry.x + (s.geometry.width - ww) / 2,
            y = s.geometry.y + (s.geometry.height - wh) / 2,
            width = ww,
            height = wh,
            visible = false,
            ontop = false,
            bg = beautiful.bg_normal,
            shape = function(cr, w, h)
                gears.shape.rounded_rect(cr, w, h)
            end
        }
    end

    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist {
        screen = s,
        filter = awful.widget.taglist.filter.all,
        style = {
            shape = widget_rect
        },
        widget_template = {
            {
                {
                    {
                        {
                            id = 'text_role',
                            widget = wibox.widget.textbox
                        },
                        layout = wibox.layout.fixed.horizontal
                    },
                    left = 7,
                    right = 7,
                    widget = wibox.container.margin
                },
                id = 'background_role',
                widget = wibox.container.background
            },
            widget = wibox.container.margin,
            top = 3,
            bottom = 3
        },
        buttons = taglist_buttons
    }

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist {
        screen = s,
        filter = awful.widget.tasklist.filter.currenttags,
        buttons = tasklist_buttons,
        style = {
            spacing = 8,
            shape = widget_rect
        },
        widget_template = {
            {
                {
                    {
                        id = "text_role",
                        widget = wibox.widget.textbox,
                        align = "center"
                    },
                    widget = wibox.container.margin,
                    left = 6
                },
                id = 'background_role',
                widget = wibox.container.background,
                bg = beautiful.bg_secondary,
                fg = beautiful.fg_secondary,
                shape = widget_rect
            },
            widget = wibox.container.margin,
            top = 3,
            bottom = 3
        }
    }

    -- Create the wibox
    s.mywibox = awful.wibar({
        position = "top",
        height = 33,
        bg = "#0000000",
        screen = s
    })

    -- add widgets to the wibox
    s.mywibox:setup{
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            {
                {
                    {
                        s.mytaglist,
                        widget = wibox.container.margin,
                        left = 3,
                        top = -1,
                        bottom = -1,
                        right = 3
                    },
                    widget = wibox.container.background,
                    bg = beautiful.bg_secondary,
                    fg = beautiful.fg_secondary,
                    shape = widget_rect
                },
                widget = wibox.container.margin,
                left = 13,
                right = 3,
                top = 3,
                bottom = 3
            }
        },
        {
            s.mytasklist, -- Middle widget
            widget = wibox.container.margin,
            left = 5,
            right = 5
        },
        { -- right widgets
            layout = wibox.layout.fixed.horizontal,
            rounded_box({
                awful.widget.watch('/bin/sh -c ~/.config/scripts/headphone_battery.sh', 2),
                widget = wibox.container.margin
            }),
            rounded_box({
                awful.widget.watch('/bin/sh -c ~/.config/scripts/currently_playing.sh', 2),
                widget = wibox.container.margin
            }),
            rounded_box({
                awful.widget.watch('/bin/sh -c ~/.config/scripts/bar_mem.sh', 1),
                widget = wibox.container.margin
            }),
            rounded_box({
                awful.widget.watch('/bin/sh -c ~/.config/scripts/bar_volume.sh', 1),
                widget = wibox.container.margin
            }),
            rounded_box({
                awful.widget.watch('/bin/sh -c ~/.config/scripts/weather.sh', 3600),
                widget = wibox.container.margin
            }),
            rounded_box(mytextclock, beautiful.bg_secondary, beautiful.fg_secondary),
            rounded_box(wibox.widget.systray(), beautiful.bg_secondary, beautiful.fg_secondary),
            rounded_box(s.mylayoutbox, beautiful.bg_secondary, beautiful.fg_secondary)
        },
        widget = wibox.container.margin,
        left = 0,
        right = 10
    }

end)

-- }}}

-- {{{ Mouse bindings
root.buttons(gears.table.join(awful.button({}, 3, function()
    mymainmenu:toggle()
end) -- awful.button({ }, 4, awful.tag.viewnext),
-- awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ Key bindings
globalkeys = require("conf.globalkeys")

clientkeys = gears.table.join(awful.key({modkey}, "f", function(c)
    c.fullscreen = not c.fullscreen
    c:raise()
end, {
    description = "toggle fullscreen",
    group = "client"
}), awful.key({modkey, "Shift"}, "c", function(c)
    c:kill()
end, {
    description = "close",
    group = "client"
}), awful.key({modkey, "Control"}, "space", awful.client.floating.toggle, {
    description = "toggle floating",
    group = "client"
}), awful.key({modkey, "Control"}, "Return", function(c)
    c:swap(awful.client.getmaster())
end, {
    description = "move to master",
    group = "client"
}), awful.key({modkey}, "o", function(c)
    c:move_to_screen()
end, {
    description = "move to screen",
    group = "client"
}), awful.key({modkey}, "t", function(c)
    c.ontop = not c.ontop
end, {
    description = "toggle keep on top",
    group = "client"
}), awful.key({modkey}, "n", function(c)
    -- The client currently has the input focus, so it cannot be
    -- minimized, since minimized clients can't have the focus.
    c.minimized = true
end, {
    description = "minimize",
    group = "client"
}), awful.key({modkey}, "m", function(c)
    c.maximized = not c.maximized
    c:raise()
end, {
    description = "(un)maximize",
    group = "client"
}), awful.key({modkey, "Control"}, "m", function(c)
    c.maximized_vertical = not c.maximized_vertical
    c:raise()
end, {
    description = "(un)maximize vertically",
    group = "client"
}), awful.key({modkey, "Shift"}, "m", function(c)
    c.maximized_horizontal = not c.maximized_horizontal
    c:raise()
end, {
    description = "(un)maximize horizontally",
    group = "client"
}))

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.

clientbuttons = gears.table.join(awful.button({}, 1, function(c)
    c:emit_signal("request::activate", "mouse_click", {
        raise = true
    })
end), awful.button({modkey}, 1, function(c)
    c:emit_signal("request::activate", "mouse_click", {
        raise = true
    })
    awful.mouse.client.move(c)
end), awful.button({modkey}, 3, function(c)
    c:emit_signal("request::activate", "mouse_click", {
        raise = true
    })
    awful.mouse.client.resize(c)
end))

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = { -- All clients will match this rule.
{
    rule = {},
    properties = {
        border_width = beautiful.border_width,
        border_color = beautiful.border_normal,
        focus = awful.client.focus.filter,
        raise = true,
        keys = clientkeys,
        buttons = clientbuttons,
        screen = awful.screen.preferred,
        placement = awful.placement.no_overlap + awful.placement.no_offscreen
    }
}, -- Floating clients.
{
    rule_any = {
        instance = {"DTA", -- Firefox addon DownThemAll.
        "copyq", -- Includes session name in class.
        "pinentry"},
        class = {"Arandr", "Blueman-manager", "Gpick", "Kruler", "MessageWin", -- kalarm.
        "Sxiv", "Tor Browser", -- Needs a fixed window size to avoid fingerprinting by screen size.
        "Wpa_gui", "veromix", "xtightvncviewer", "flameshot"},

        -- Note that the name property shown in xprop might be set slightly after creation of the client
        -- and the name shown there might not match defined rules here.
        name = {"Event Tester" -- xev.
        },
        role = {"AlarmWindow", -- Thunderbird's calendar.
        "ConfigManager", -- Thunderbird's about:config.
        "pop-up" -- e.g. Google Chrome's (detached) Developer Tools.
        }
    },
    properties = {
        floating = true
    }
}, -- Add titlebars to normal clients and dialogs
{
    rule_any = {
        type = {"normal", "dialog"}
    },
    properties = {
        titlebars_enabled = beautiful.titlebar_enabled
    }
} -- Set Firefox to always map on the tag named "2" on screen 1.
-- { rule = { class = "Firefox" },
--   properties = { screen = 1, tag = "2" } },
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function(c)
    if awesome.startup and not c.size_hints.user_position and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end
end)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
    -- buttons for the titlebar
    local buttons = gears.table.join(awful.button({}, 1, function()
        c:emit_signal("request::activate", "titlebar", {
            raise = true
        })
        awful.mouse.client.move(c)
    end), awful.button({}, 3, function()
        c:emit_signal("request::activate", "titlebar", {
            raise = true
        })
        awful.mouse.client.resize(c)
    end))

    awful.titlebar(c, {
        size = 24
    }):setup{
        {
            { -- Left
                awful.titlebar.widget.iconwidget(c),
                buttons = buttons,
                layout = wibox.layout.fixed.horizontal
            },
            { -- Middle
                { -- Title
                    align = "center",
                    widget = awful.titlebar.widget.titlewidget(c)
                },
                buttons = buttons,
                layout = wibox.layout.flex.horizontal
            },
            { -- Right
                awful.titlebar.widget.floatingbutton(c),
                awful.titlebar.widget.maximizedbutton(c),
                awful.titlebar.widget.stickybutton(c),
                awful.titlebar.widget.ontopbutton(c),
                awful.titlebar.widget.closebutton(c),

                layout = wibox.layout.fixed.horizontal()
            },
            layout = wibox.layout.align.horizontal
        },
        widget = wibox.container.margin,
        margins = 3,
        left = 5
    }
end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
    c:emit_signal("request::activate", "mouse_enter", {
        raise = false
    })
end)

client.connect_signal("focus", function(c)
    c.border_color = beautiful.border_focus
end)
client.connect_signal("unfocus", function(c)
    c.border_color = beautiful.border_normal
end)
-- }}}
do
    awful.spawn("/home/midka/.config/awesome/autorun.sh", false)
end

awful.spawn.with_shell('if (xrdb -query | grep -q "^awesome\\.started:\\s*true$"); then exit; fi;' ..
                           'xrdb -merge <<< "awesome.started:true";' ..
    -- list each of your autostart commands, followed by ; inside single quotes, followed by ..
                           'dex --environment Awesome --autostart --search-paths "$XDG_CONFIG_DIRS/autostart:$XDG_CONFIG_HOME/autostart"' -- https://github.com/jceb/dex
)

