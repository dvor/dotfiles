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
    hs.caffeinate.startScreensaver()
    hs.alert.show("Locking screen")
end)

--------------------------------------------------------------------------------
-- Pasteboard

hs.hotkey.bind(hyper, "delete", function()
    hs.pasteboard.clearContents()
    hs.alert.show("Pasteboard cleared")
end)

--------------------------------------------------------------------------------
-- Window management

function equalFrames(first, second)
    return (first.x == second.x) and (first.y == second.y) and (first.w == second.w) and (first.h == second.h)
end

function windowFullScreen()
    return hs.screen.mainScreen():frame()
end

function windowLeft()
    local frame = hs.screen.mainScreen():frame()
    frame.w = frame.w * 2 / 3
    return frame
end

function windowRight()
    local frame = hs.screen.mainScreen():frame()
    frame.x = frame.x + frame.w * 2 / 3
    frame.w = frame.w / 3
    return frame
end

function windowTop()
    local frame = hs.screen.mainScreen():frame()
    frame.h = frame.h * 2 / 3
    return frame
end

function windowBottom()
    local frame = hs.screen.mainScreen():frame()
    frame.y = frame.y + frame.h * 2 / 3
    frame.h = frame.h / 3
    return frame
end

hs.hotkey.bind(hyper, "F", function()
    hs.window.focusedWindow():setFrame(windowFullScreen())
    hs.alert.show("Fullscreen")
end)

hs.hotkey.bind(hyper, "H", function()
    local windowFrame = hs.window.focusedWindow():frame()
    local frame = windowLeft()
    local text = "Left"

    if equalFrames(windowFrame, windowTop()) then
        frame.h = windowTop().h
        text = "Top/" .. text
    elseif equalFrames(windowFrame, windowBottom()) then
        frame.y = windowBottom().y
        frame.h = windowBottom().h
        text = "Bottom/" .. text
    end

    hs.window.focusedWindow():setFrame(frame)
    hs.alert.show(text)
end)

hs.hotkey.bind(hyper, "L", function()
    local windowFrame = hs.window.focusedWindow():frame()
    local frame = windowRight()
    local text = "Right"

    if equalFrames(windowFrame, windowTop()) then
        frame.h = windowTop().h
        text = "Top/" .. text
    elseif equalFrames(windowFrame, windowBottom()) then
        frame.y = windowBottom().y
        frame.h = windowBottom().h
        text = "Bottom/" .. text
    end

    hs.window.focusedWindow():setFrame(frame)
    hs.alert.show(text)
end)

hs.hotkey.bind(hyper, "J", function()
    local windowFrame = hs.window.focusedWindow():frame()
    local frame = windowBottom()
    local text = "Bottom"

    if equalFrames(windowFrame, windowLeft()) then
        frame.w = windowLeft().w
        text = text .. "/Left"
    elseif equalFrames(windowFrame, windowRight()) then
        frame.x = windowRight().x
        frame.w = windowRight().w
        text = text .. "/Right"
    end

    hs.window.focusedWindow():setFrame(frame)
    hs.alert.show(text)
end)

hs.hotkey.bind(hyper, "K", function()
    local windowFrame = hs.window.focusedWindow():frame()
    local frame = windowTop()
    local text = "Top"

    if equalFrames(windowFrame, windowLeft()) then
        frame.w = windowLeft().w
        text = text .. "/Left"
    elseif equalFrames(windowFrame, windowRight()) then
        frame.x = windowRight().x
        frame.w = windowRight().w
        text = text .. "/Right"
    end

    hs.window.focusedWindow():setFrame(frame)
    hs.alert.show(text)
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
