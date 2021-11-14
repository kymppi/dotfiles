local dpi = beautiful.xresources.apply_dpi

local box = function(w)
    return {
        {    
            {
                w,
                widget = wibox.container.margin,
                left = 8,
                top = 6,
                bottom = 6,
            },
            widget = wibox.container.background,
            shape = gears.shape.rounded_rect,
            bg = beautiful.accent,
        },
        widget = wibox.container.margin,
        margins = 4
    }
end

local command = function(c,t,i)
    return awful.widget.watch(c,t,function(widget,stdout)
    widget:set_text(stdout:sub(1,-2))
    end)
end

local sidemenu = function(s)
    menu = wibox {
        screen = s,
        x = s.geometry.x,
        y = s.geometry.y + 42,
        width = 500,
        height = s.geometry.height - 50,
        visible = false,
        ontop = true,
        bg = beautiful.bg_normal,
        shape = function(cr,w,h) 
            gears.shape.partially_rounded_rect(cr,w,h,false,true,true,false)
        end
        }
    menu : setup {
        {
            layout = wibox.layout.fixed.vertical,
            box(awful.widget.textclock("%A %B | %T %F | %::z")),
            {
                box(command("/bin/sh -c ~/scripts/covid-data",1800)),
                box(command("/bin/sh -c ~/scripts/weather-extra", 1800)),
                layout = wibox.layout.flex.horizontal,
            },
            {
                box(command("/bin/sh -c 'echo \"kernel: $(uname -r)\"'")),
                box(command("/bin/sh -c 'echo \"packages: $(pacman -Q | wc -l)\"'")),
                layout = wibox.layout.align.vertical,
            },
	    {
	    	box({
                    command("/bin/sh -c ~/.config/scripts/disk-usage", 600),
                    layout = wibox.layout.align.vertical,
                }),
                layout = wibox.layout.flex.horizontal,
	    },
            {
                box(wibox.widget.textbox("AwesomeWM " .. awesome.version)),
                box(wibox.widget.textbox("Hostname: " .. awesome.hostname)),
                box(wibox.widget.textbox("Shell: " .. awful.util.shell)),
                layout = wibox.layout.flex.horizontal,
            },
            box(command("/bin/sh -c 'echo \"Uptime: $(~/.config/scripts/uptime.sh)\"'", 1)),
            {
                box(command("/bin/sh -c 'ps -eo comm:26,%cpu --sort=-%cpu | head -n5'",1)),
                box(command("/bin/sh -c 'ps -eo comm:26,%mem --sort=-%mem | head -n5'",1)),
                layout = wibox.layout.flex.horizontal,
            },
            {
                box(command([[/bin/sh -c "curl -s https://koira.testausserveri.fi/api/guildInfo | grep -Po '(?<=\"memberCount\":)\d*'"]])),
                box(command([[/bin/sh -c "curl -s https://koira.testausserveri.fi/api/guildInfo | grep -Po '(?<=\"messagesToday\":)\d*'"]])),
                layout = wibox.layout.flex.horizontal,
            },
        },
        widget = wibox.container.margin,
        margins = 6,
    }
    return menu
end

return sidemenu
