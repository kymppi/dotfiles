-- local awful = require("awful")
local gfs = require("gears.filesystem")

local mainmenu = function()
    myapplist = {
        { "firefox", function() awesome.spawn("firefox") end},
        { "steam", function() awesome.spawn("steam") end},
        { "discord", function() awesome.spawn("discord") end},
        { "profanity", terminal .. " -e profanity" }
    }

    myawesomemenu = {
       { "hotkeys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
       { "manual", terminal .. " -e man awesome" },
       { "restart", function() awesome.restart() end },
       { "quit", function() awesome.quit() end },
    }

    mymainmenu = awful.menu({ 
        items = { 
            { "awesome", myawesomemenu, beautiful.awesome_icon },
            { "common apps", myapplist },
            { "open terminal", terminal },
            { "run", function() menubar.show() end }
        }
    })
    return mymainmenu
end

return mainmenu
