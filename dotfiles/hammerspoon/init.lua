--------------------------------------------------------------------------------
-- Configuration

hs.window.animationDuration = 0
hs.window.setShadows(false)

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

hs.hotkey.bind({"cmd", "shift", "ctrl"}, "escape", function()
    hs.caffeinate.startScreensaver()
    hs.alert.show("Locking screen")
end)

--------------------------------------------------------------------------------
-- Pasteboard

hs.hotkey.bind({"cmd", "shift", "ctrl"}, "]", function()
    hs.pasteboard.clearContents()
    hs.alert.show("Pasteboard cleared")
end)

--------------------------------------------------------------------------------
-- Window management

hs.hotkey.bind({"cmd", "shift", "ctrl"}, "F", function()
    local win = hs.window.focusedWindow()
    local screen = win:screen()
    local screenFrame = screen:frame()

    win:setFrame(screenFrame)

    hs.alert.show("Fullscreen")
end)

hs.hotkey.bind({"cmd", "shift", "ctrl"}, "H", function()
    local win = hs.window.focusedWindow()
    local winFrame = win:frame()
    local screen = win:screen()
    local screenFrame = screen:frame()

    winFrame.x = screenFrame.x
    winFrame.y = screenFrame.y
    winFrame.w = screenFrame.w * 2 / 3
    winFrame.h = screenFrame.h
    win:setFrame(winFrame)

    hs.alert.show("Left 2/3")
end)

k = hs.hotkey.modal.new({"cmd", "shift", "ctrl"}, "L")

function k:entered()
    hs.alert.show("Right 1/3 -> {JKL}")
end

k:bind({}, 'escape', function()
    hs.alert.show("Canceled")
    k:exit()
end)

k:bind({"cmd", "shift", "ctrl"}, 'J', function()
    local win = hs.window.focusedWindow()
    local winFrame = win:frame()
    local screen = win:screen()
    local screenFrame = screen:frame()

    winFrame.x = screenFrame.x + screenFrame.w * 2 / 3
    winFrame.y = screenFrame.y + screenFrame.h * 2 / 3
    winFrame.w = screenFrame.w / 3
    winFrame.h = screenFrame.h / 3
    win:setFrame(winFrame)

    hs.alert.show("Right 1/3, Bottom 1/3")

    k:exit()
end)

k:bind({"cmd", "shift", "ctrl"}, 'K', function()
    local win = hs.window.focusedWindow()
    local winFrame = win:frame()
    local screen = win:screen()
    local screenFrame = screen:frame()

    winFrame.x = screenFrame.x + screenFrame.w * 2 / 3
    winFrame.y = screenFrame.y
    winFrame.w = screenFrame.w / 3
    winFrame.h = screenFrame.h * 2 / 3
    win:setFrame(winFrame)

    hs.alert.show("Right 1/3, Top 2/3")

    k:exit()
end)

k:bind({"cmd", "shift", "ctrl"}, 'L', function()
    local win = hs.window.focusedWindow()
    local winFrame = win:frame()
    local screen = win:screen()
    local screenFrame = screen:frame()

    winFrame.x = screenFrame.x + screenFrame.w * 2 / 3
    winFrame.y = screenFrame.y
    winFrame.w = screenFrame.w / 3
    winFrame.h = screenFrame.h
    win:setFrame(winFrame)

    hs.alert.show("Right 1/3")

    k:exit()
end)
