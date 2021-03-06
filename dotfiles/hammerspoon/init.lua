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
hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reloadConfig):start()
hs.alert.show("Config reloaded")

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
local dndKilledApps = {}

hs.urlevent.bind("dnd", function()
    dndModeOn = not dndModeOn

    if dndModeOn then
        hs.osascript.applescript([[
        do shell script "
            defaults -currentHost write ~/Library/Preferences/ByHost/com.apple.notificationcenterui doNotDisturb -boolean true
            defaults -currentHost write ~/Library/Preferences/ByHost/com.apple.notificationcenterui doNotDisturbDate -date \"`date -u +\"%Y-%m-%d %H:%M:%S +0000\"`\"
            killall NotificationCenter
        "
        ]])

        local apps = {"Thunderbird", "Slack", "Messages"}

        for i, name in pairs(apps) do
            local app = hs.appfinder.appFromName(name)

            if app and app:isRunning() then
                table.insert(dndKilledApps, name)
                hs.application.kill(app)
            end
        end

        hs.alert.show("Do not disturb ON")
    else
        hs.osascript.applescript([[
        do shell script "
            defaults -currentHost write ~/Library/Preferences/ByHost/com.apple.notificationcenterui doNotDisturb -boolean false
            killall NotificationCenter
        "
        ]])

        -- Restore killed apps
        for i, name in pairs(dndKilledApps) do
            hs.application.open(name)
        end
        dndKilledApps = {}

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

hs.application.enableSpotlightForNameSearches(true)

bindAppWithNameToKey(false, "Calendar",     "C")
bindAppWithNameToKey(false, "Tor Browser",   "D")
bindAppWithNameToKey(false, "Contacts",     "N")
bindAppWithNameToKey(false, "Dash",         "H")
bindAppWithNameToKey(false, "Finder",       "R")
bindAppWithNameToKey(false, "/Applications/Firefox.app",      "F")
bindAppWithNameToKey(false, "KeePassX",     "K")
bindAppWithNameToKey(false, "MacVim",       "V")
bindAppWithNameToKey(false, "Spotify",      "L")
bindAppWithNameToKey(false, "VLC",          "O")
bindAppWithNameToKey(false, "Kindle",       "B")
bindAppWithNameToKey(false, "iTerm",        "T")
bindAppWithNameToKey(false, "Charles",      "]")

bindAppWithNameToKey(true,  "Thunderbird",  "M")
bindAppWithNameToKey(true,  "LimeChat",     "E")
bindAppWithNameToKey(true,  "Slack",        "S")
bindAppWithNameToKey(true,  "Messages",     "A")
bindAppWithNameToKey(true,  "Telegram",     "G")

bindAppWithNameToKey(false, "/Applications/Xcode_11.app",        "X")
bindAppWithNameToKey(false, "/Applications/Xcode_11.app/Contents/Developer/Applications/Simulator.app",    "I")

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


local interactiveMovingUp = false
local interactiveMovingBottom = false
local interactiveMovingRight = false
local interactiveMovingLeft = false
local interactiveResizing = 0

interactiveWindowMode = hs.hotkey.modal.new(hyper, "I")

function interactiveWindowMode:entered()
    hs.alert.show("Interactive window mode")

    local speedX = 0
    local speedY = 0
    local acceleration = 1.5

    interactiveWindowTimer = hs.timer.doEvery(0.01, function()
        if interactiveMovingRight then
            speedX = speedX + acceleration
        elseif interactiveMovingLeft then
            speedX = speedX - acceleration
        else
            speedX = 0
        end

        if interactiveMovingTop then
            speedY = speedY - acceleration
        elseif interactiveMovingBottom then
            speedY = speedY + acceleration
        else
            speedY = 0
        end

        local frame = hs.window.focusedWindow():frame()

        if interactiveResizing > 0 then
            frame.w = frame.w + speedX
            frame.h = frame.h + speedY
        else
            frame.x = frame.x + speedX
            frame.y = frame.y + speedY
        end

        hs.window.focusedWindow():setFrame(frame)
    end)
end

interactiveWindowMode:bind({}, 'escape', function()
    hs.alert.show("Normal mode")
    interactiveWindowTimer:stop()
    interactiveWindowMode:exit()
end)

interactiveWindowMode:bind({}, 'H', function()
    interactiveMovingLeft = true
end, function()
    interactiveMovingLeft = false
end)

interactiveWindowMode:bind({}, 'L', function()
    interactiveMovingRight = true
end, function()
    interactiveMovingRight = false
end)

interactiveWindowMode:bind({}, 'K', function()
    interactiveMovingTop = true
end, function()
    interactiveMovingTop = false
end)

interactiveWindowMode:bind({}, 'J', function()
    interactiveMovingBottom = true
end, function()
    interactiveMovingBottom = false
end)

interactiveWindowMode:bind({"ctrl"}, 'H', function()
    interactiveMovingLeft = true
    interactiveResizing = interactiveResizing + 1
end, function()
    interactiveMovingLeft = false
    interactiveResizing = interactiveResizing - 1
end)

interactiveWindowMode:bind({"ctrl"}, 'L', function()
    interactiveMovingRight = true
    interactiveResizing = interactiveResizing + 1
end, function()
    interactiveMovingRight = false
    interactiveResizing = interactiveResizing - 1
end)

interactiveWindowMode:bind({"ctrl"}, 'K', function()
    interactiveMovingTop = true
    interactiveResizing = interactiveResizing + 1
end, function()
    interactiveMovingTop = false
    interactiveResizing = interactiveResizing - 1
end)

interactiveWindowMode:bind({"ctrl"}, 'J', function()
    interactiveMovingBottom = true
    interactiveResizing = interactiveResizing + 1
end, function()
    interactiveMovingBottom = false
    interactiveResizing = interactiveResizing - 1
end)

--------------------------------------------------------------------------------
-- Moving mouse

local mouseMovingUp = false
local mouseMovingBottom = false
local mouseMovingRight = false
local mouseMovingLeft = false
local mouseIsDragging = false

mouseMode = hs.hotkey.modal.new(hyper, "M")

function mouseMode:entered()
    hs.alert.show("Mouse mode")

    local speedX = 0
    local speedY = 0
    local acceleration = 0.5

    mouseTimer = hs.timer.doEvery(0.01, function()
        if mouseMovingRight then
            speedX = speedX + acceleration
        elseif mouseMovingLeft then
            speedX = speedX - acceleration
        else
            speedX = 0
        end

        if mouseMovingTop then
            speedY = speedY - acceleration
        elseif mouseMovingBottom then
            speedY = speedY + acceleration
        else
            speedY = 0
        end

        local position = hs.mouse.getAbsolutePosition()
        position.x = position.x + speedX
        position.y = position.y + speedY
        hs.mouse.setAbsolutePosition(position)

        if mouseIsDragging then
            hs.eventtap.event.newMouseEvent(hs.eventtap.event.types.leftmousedragged, position):post()
        end
    end)
end

function stopMouseMode()
    hs.alert.show("Normal mode")
    mouseTimer:stop()
    mouseMode:exit()
end

mouseMode:bind({}, 'escape', stopMouseMode)
mouseMode:bind(hyper, 'M', stopMouseMode)

mouseMode:bind({}, 'H', function()
    mouseMovingLeft = true
end, function()
    mouseMovingLeft = false
end)

mouseMode:bind({}, 'L', function()
    mouseMovingRight = true
end, function()
    mouseMovingRight = false
end)

mouseMode:bind({}, 'K', function()
    mouseMovingTop = true
end, function()
    mouseMovingTop = false
end)

mouseMode:bind({}, 'J', function()
    mouseMovingBottom = true
end, function()
    mouseMovingBottom = false
end)

mouseMode:bind({}, 'F', function()
    local position = hs.mouse.getAbsolutePosition()
    hs.eventtap.event.newMouseEvent(hs.eventtap.event.types.leftmousedown, position):post()

    mouseIsDragging = true
end, function()
    local position = hs.mouse.getAbsolutePosition()
    hs.eventtap.event.newMouseEvent(hs.eventtap.event.types.leftmouseup, position):post()

    mouseIsDragging = false
end)

mouseMode:bind({"shift"}, 'F', function()
    hs.eventtap.rightClick(hs.mouse.getAbsolutePosition())
end)
