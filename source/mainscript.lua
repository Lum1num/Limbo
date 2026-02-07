local shared = shared or _G
if shared.limbo then
    for key, obj in pairs(shared.limbo) do
        pcall(function()
            if typeof(obj) == "RBXScriptConnection" then
                obj:Disconnect()
            elseif typeof(obj) == "Instance" then
                obj:Destroy()
            end
        end)
        shared.limbo[key] = nil
    end
end
shared.LimboRepository = "https://raw.githubusercontent.com/Lum1num/Limbo"
shared.LimboSource = shared.LimboRepository .. "/main/source"

local folder = "limbo"

if not isfolder(folder) then
    makefolder(folder)
end
local function downloadFile(path, updateFile)
    local fullUrl = shared.LimboSource .. "/" .. path
    local filePath = folder .. "/" .. path
    local suc, res = pcall(function()
        return game:HttpGet(fullUrl)
    end)
    if not suc or not res then
        return
    end
    if not isfile(filePath) then
        writefile(filePath, res)
        return
    end
    if updateFile then
        local old = readfile(filePath)
        if old ~= res and (not res:find('--DisableCaching:True')) then
            writefile(filePath, res)
        end
    end
end
downloadFile("version.txt", true)
local rawVersion = isfile(folder .. "/version.txt") and readfile(folder .. "/version.txt"):gsub("\n", "") or "1.0.0"
shared.LimboVersion = rawVersion:sub(1, 1) == "v" and rawVersion or "v" .. rawVersion

local cloneref = cloneref or function(obj)
    return obj
end
local runService = cloneref(game:GetService("RunService"))
local lightingService = cloneref(game:GetService("Lighting"))
local coreGui = cloneref(game:GetService("CoreGui"))
local tweenService = cloneref(game:GetService("TweenService"))
local soundService = cloneref(game:GetService("SoundService"))
local inputService = cloneref(game:GetService('UserInputService'))

shared.limbo = shared.limbo or {}
if shared.limbo.maingui then
    shared.limbo.maingui:Destroy()
end
local function blur()
    if shared.limbo.blur then
        shared.limbo.blur:Destroy()
    end
    local blurEffect = Instance.new("BlurEffect")
    blurEffect.Size = 15
    blurEffect.Parent = lightingService
    shared.limbo.blur = blurEffect
    return blurEffect
end
shared.limbo.playSound = function(soundName, volume, playback)
    local soundPath = folder .. "/audio/" .. soundName
    local s = Instance.new("Sound")
    s.SoundId = getcustomasset(soundPath)
    s.Volume = volume or 1
    s.PlaybackSpeed = playback or 1
    s.Parent = soundService
    s:Play()
    return s
end
if isfile(folder .. "/audio/StartIntro.ogg") then
    shared.limbo.playSound("StartIntro.ogg", 3, 1)
    task.wait(0.05)
end

local maingui = Instance.new("ScreenGui")
maingui.Name = "LimboGui"
maingui.Parent = coreGui
shared.limbo.maingui = maingui
blur()
local startupgui = Instance.new("ScreenGui")
startupgui.Name = "startupgui"
startupgui.IgnoreGuiInset = true
startupgui.Parent = maingui

local bg = Instance.new("Frame")
bg.Name = "bg"
bg.Parent = startupgui
bg.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
bg.BackgroundTransparency = 0.7
bg.BorderSizePixel = 0
bg.Size = UDim2.new(1, 0, 1, 0)

local title = Instance.new("TextLabel")
title.Name = "title"
title.Parent = bg
title.AnchorPoint = Vector2.new(0.5, 0.5)
title.BackgroundTransparency = 1
title.Position = UDim2.new(0.5, 0, 0.4, 0)
title.Size = UDim2.new(1, 0, 0.2, 0)
title.Font = Enum.Font.Code
title.Text = "Welcome to <font color='rgb(147,112,219)'>" .. folder .. "</font> (" .. shared.LimboVersion .. ")\n\nRunning the Limbo Installer..."
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextSize = 20
title.TextStrokeTransparency = 0
title.TextWrapped = true
title.RichText = true

local text = Instance.new("TextLabel")
text.Name = "text"
text.Parent = bg
text.AnchorPoint = Vector2.new(0.5, 0.5)
text.BackgroundTransparency = 1
text.Position = UDim2.new(0.5, 0, 0.6, 0)
text.Size = UDim2.new(1, 0, 0.2, 0)
text.Font = Enum.Font.Code
text.Text = "..."
text.TextColor3 = Color3.fromRGB(255, 255, 255)
text.TextSize = 20
text.TextStrokeTransparency = 0
text.TextWrapped = true
text.RichText = true

local loading = Instance.new("Frame")
loading.Name = "loading"
loading.Parent = bg
loading.AnchorPoint = Vector2.new(0.5, 0.5)
loading.BackgroundTransparency = 1
loading.BorderSizePixel = 2
loading.Position = UDim2.new(0.5, 0, 0.7, 0)
loading.Size = UDim2.new(0, 600, 0, 30)

local UIPadding = Instance.new("UIPadding")
UIPadding.Parent = loading
UIPadding.PaddingLeft = UDim.new(0, 2)
UIPadding.PaddingRight = UDim.new(0, 2)
UIPadding.PaddingTop = UDim.new(0, 2)
UIPadding.PaddingBottom = UDim.new(0, 2)

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 5)
UICorner.Parent = loading

local UIStroke = Instance.new("UIStroke")
UIStroke.Parent = loading
UIStroke.Color = Color3.fromRGB(255, 255, 255)
UIStroke.Thickness = 1.5

local bar = Instance.new("Frame")
bar.Name = "bar"
bar.Parent = loading
bar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
bar.BorderSizePixel = 0
bar.BackgroundTransparency = 0.2
bar.Size = UDim2.new(0, 0, 1, 0)

local UICorner_2 = Instance.new("UICorner")
UICorner_2.CornerRadius = UDim.new(0, 5)
UICorner_2.Parent = bar

for _, v in ipairs({"libraryaddons", "images", "audio", "places"}) do
    if not isfolder(folder .. "/" .. v) then
        makefolder(folder .. "/" .. v)
    end
end
local files = {
    -- stuff
    "mainguilibrary.lua",
    "libraryaddons/saveManager.lua",
    "libraryaddons/themeManager.lua",
    "images/Limbo.png",
    "images/loading.png",
    "audio/StartIntro.ogg",
    "mainscript.lua",
    "guiselector.lua",
    "placedetectorscript.lua",
    "splashintro.lua",

    -- places
    "places/universal.lua",
    "places/7205641391.lua",

    -- chunky
    --"audio/backgroundambience.mp3", i decided to remove this since its just uh, stupid
    "audio/correctding.mp3",
    "audio/notf.mp3",
    "audio/incorrectding.mp3",
    "audio/splashintro.mp3",
}

local total = #files
local completed = 0
for _, file in ipairs(files) do
    text.Text = "Downloading: " .. file .. "..."
    downloadFile(file, true)
    completed = completed + 1
    local progress = math.clamp(completed / total, 0, 1) - 0.0085
    local targetWidth = math.floor(loading.AbsoluteSize.X * progress)
    tweenService:Create(
        bar,
        TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out),
        { Size = UDim2.new(0, targetWidth, 1, 0) }
    ):Play()
    runService.Heartbeat:Wait()
end

text.Text = "Finished downloading!"
task.delay(1, function()
    local dur = 0.35
    tweenService:Create(text, TweenInfo.new(dur), {
        TextTransparency = 1,
        TextStrokeTransparency = 1
    }):Play()
    tweenService:Create(title, TweenInfo.new(dur), {
        TextTransparency = 1,
        TextStrokeTransparency = 1
    }):Play()
    tweenService:Create(bar, TweenInfo.new(dur), {
        BackgroundTransparency = 1
    }):Play()
    tweenService:Create(loading, TweenInfo.new(dur), {
        BackgroundTransparency = 1
    }):Play()
    tweenService:Create(bg, TweenInfo.new(dur), {
        BackgroundTransparency = 1
    }):Play()
    tweenService:Create(UIStroke, TweenInfo.new(dur), {
        Transparency = 1
    }):Play()
    tweenService:Create(shared.limbo.blur, TweenInfo.new(math.clamp(dur - 0.5, 0.1, math.huge)), {
        Size = 0
    }):Play()
    task.wait(dur + 0.5)

    local suc, res = pcall(function()
        return readfile(folder .. "/guiselector.lua")
    end)
    if suc and res then
        if not inputService.TouchEnabled then
            loadstring(res)()
        else
            loadstring(readfile(folder .. '/placedetectorscript.lua'))()
        end
    end
end)
