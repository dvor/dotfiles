--------------------------------------------------------------------------------
-- Configuration

hs.window.animationDuration = 0
hs.window.setShadows(false)

local hyper = {"cmd", "shift", "ctrl"}

--------------------------------------------------------------------------------
-- Confing reloading

function reloadConfig(files)
    doReload = false
    for _,file in pairs(files) do
        if file:sub(-4) == ".lua" then
            doReload = true
        end
    end
    if doReload then
        hs.reload()
    end
end
myWatcher = hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reloadConfig):start()
hs.alert.show("Config loaded")

--------------------------------------------------------------------------------
-- Locking screen

hs.hotkey.bind(hyper, "escape", function()
    hs.alert.show("Locking screen")
    hs.caffeinate.startScreensaver()
end)

--------------------------------------------------------------------------------
-- Pasteboard

hs.hotkey.bind(hyper, "delete", function()
    hs.pasteboard.clearContents()
    hs.alert.show("Pasteboard cleared")
end)

--------------------------------------------------------------------------------
-- Caffeine

hs.urlevent.bind("toggle-caffeine", function(event, params)
    result = hs.caffeinate.toggle("displayIdle")
    if result then
        hs.alert.show("Caffeine ON")
    else
        hs.alert.show("Caffeine OFF")
    end
end)

--------------------------------------------------------------------------------
-- Showing notification
--
-- Usage:
-- notify?message="Message to show"

hs.urlevent.bind("notify", function(event, params)
    hs.alert.show(params["message"])
end)

--------------------------------------------------------------------------------
-- DND mode

local dndModeOn = false

hs.urlevent.bind("dnd", function()
    dndModeOn = not dndModeOn

    if dndModeOn then
        hs.alert.show("Do not disturb ON")
    else
        hs.alert.show("Do not disturb OFF")
    end
end)

--------------------------------------------------------------------------------
-- Application management

function bindAppWithNameToKey(dependsOnDnd, name, key)
    hs.hotkey.bind({"cmd", "ctrl"}, key, function()
        if dependsOnDnd and dndModeOn then
            return
        end
        hs.application.open(name)
    end)
end

function bindAppleScriptToKey(script, key)
    hs.hotkey.bind({"cmd", "ctrl"}, key, function()
        hs.osascript.applescript(script)
    end)
end

hs.application.enableSpotlightForNameSearches(true)

bindAppWithNameToKey(false, "Calendar",     "C")
bindAppWithNameToKey(false, "Tor Browser",   "D")
bindAppWithNameToKey(false, "Standard Notes",     "N")
bindAppWithNameToKey(false, "Dash",         "H")
bindAppWithNameToKey(false, "/Applications/Firefox.app",      "F")
bindAppWithNameToKey(false, "KeePassX",     "K")
bindAppWithNameToKey(false, "MacVim",       "V")
bindAppWithNameToKey(false, "Kindle",       "B")
bindAppWithNameToKey(false, "iTerm",        "T")
bindAppWithNameToKey(false, "Charles",      "]")
bindAppWithNameToKey(false, "Trello",      "J")
bindAppWithNameToKey(false, "Miro",      "E")
bindAppWithNameToKey(false, "DeepL",      "L")

bindAppWithNameToKey(true,  "Microsoft Outlook",  "M")
bindAppWithNameToKey(true,  "Microsoft Teams",     "R")
bindAppWithNameToKey(true,  "Slack",        "S")
bindAppWithNameToKey(false,  "Messages",     "A")
bindAppWithNameToKey(false,  "Telegram",     "G")

bindAppWithNameToKey(false, "/Applications/Xcode_13.3.app",        "X")
bindAppWithNameToKey(false, "/Applications/Xcode_13.3.app/Contents/Developer/Applications/Simulator.app",    "I")

bindAppleScriptToKey("tell application \"Flow\" \nlaunch \nshow \n end tell", "O")

--------------------------------------------------------------------------------
-- Window management

function almostEqualFrames(first, second)
    local delta = 25.0

    return
        math.abs(first.x - second.x) < delta and
        math.abs(first.y - second.y) < delta and
        math.abs(first.w - second.w) < delta and
        math.abs(first.h - second.h) < delta
end

-- Return screen frame available for window placement
function currentScreenFrame()
    return hs.screen.mainScreen():frame()
end

function windowLeft()
    local frame = currentScreenFrame()
    frame.w = frame.w / 2
    return frame
end

function windowRight()
    local frame = currentScreenFrame()
    frame.x = frame.x + frame.w / 2
    frame.w = frame.w / 2
    return frame
end

function windowTop()
    local frame = currentScreenFrame()
    frame.h = frame.h / 2
    return frame
end

function windowBottom()
    local frame = currentScreenFrame()
    frame.y = frame.y + frame.h / 2
    frame.h = frame.h / 2
    return frame
end

hs.hotkey.bind(hyper, "F", function()
    hs.window.focusedWindow():setFrame(currentScreenFrame())
end)

function getFocusBackToWindow(window)
    local other = window:otherWindowsAllScreens()

    for i, win in pairs(other) do
        if win:screen() ~= window:screen() then
            win:focus()
            window:focus()
            break
        end
    end
end

hs.hotkey.bind(hyper, "H", function()
    local window = hs.window.focusedWindow()
    local windowFrame = window:frame()
    local frame = windowLeft()

    if almostEqualFrames(windowFrame, frame) then
        local screen = hs.screen.mainScreen():toWest()

        if screen then
            window:moveToScreen(screen)
            getFocusBackToWindow(window)
            return
        end
    elseif almostEqualFrames(windowFrame, windowTop()) then
        frame.h = windowTop().h
    elseif almostEqualFrames(windowFrame, windowBottom()) then
        frame.y = windowBottom().y
        frame.h = windowBottom().h
    end

    hs.window.focusedWindow():setFrame(frame)
end)

hs.hotkey.bind(hyper, "L", function()
    local window = hs.window.focusedWindow()
    local windowFrame = window:frame()
    local frame = windowRight()

    if almostEqualFrames(windowFrame, frame) then
        local screen = hs.screen.mainScreen():toEast()

        if screen then
            window:moveToScreen(screen)
            getFocusBackToWindow(window)
            return
        end
    elseif almostEqualFrames(windowFrame, windowTop()) then
        frame.h = windowTop().h
    elseif almostEqualFrames(windowFrame, windowBottom()) then
        frame.y = windowBottom().y
        frame.h = windowBottom().h
    end

    hs.window.focusedWindow():setFrame(frame)
end)

hs.hotkey.bind(hyper, "J", function()
    local windowFrame = hs.window.focusedWindow():frame()
    local frame = windowBottom()

    if almostEqualFrames(windowFrame, windowLeft()) then
        frame.w = windowLeft().w
    elseif almostEqualFrames(windowFrame, windowRight()) then
        frame.x = windowRight().x
        frame.w = windowRight().w
    end

    hs.window.focusedWindow():setFrame(frame)
end)

hs.hotkey.bind(hyper, "K", function()
    local windowFrame = hs.window.focusedWindow():frame()
    local frame = windowTop()

    if almostEqualFrames(windowFrame, windowLeft()) then
        frame.w = windowLeft().w
    elseif almostEqualFrames(windowFrame, windowRight()) then
        frame.x = windowRight().x
        frame.w = windowRight().w
    end

    hs.window.focusedWindow():setFrame(frame)
end)
