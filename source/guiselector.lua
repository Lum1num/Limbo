local shared = shared or _G

local LiteIsAvailable = false

if shared.limbo then
    for _, obj in pairs(shared.limbo) do
        pcall(function()
            obj:Destroy()
        end)
        pcall(function()
            obj:Disconnect()
        end)
    end
end

local function playonClick(inst, sound, vol, pb)
    inst.MouseButton1Down:Connect(function()
        shared.limbo.playSound(sound, vol, pb)
    end)
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
        if old ~= res then
            writefile(filePath, res)
        end
    end
end

local getasset = getcustomasset
local getcustomasset = function(asset)
    local suc, res = pcall(function()
        return getasset(asset)
    end)
    if not suc then
        pcall(function()
            shared.LimboRepository = shared.LimboRepository or "https://raw.githubusercontent.com/Lum1num/Limbo"
            shared.LimboSource = shared.LimboSource or shared.LimboRepository .. "/main/source"
            if not isfolder('limbo') then
                makefolder('limbo')
            end
            if not isfile('limbo/mainscript.lua') then
                writefile('limbo/mainscript.lua', game:HttpGet(shared.LimboSource..'/mainscript.lua'))
            end
            loadstring(readfile('limbo/mainscript.lua'))()
        end)
    end
    return res
end

shared.limbo = shared.limbo or {}

local cloneref = cloneref or function(obj) return obj end

local function blur()
    if shared.limbo.blur then
        shared.limbo.blur:Destroy()
    end
    local blurEffect = Instance.new("BlurEffect")
    blurEffect.Size = 15
    blurEffect.Parent = cloneref(game:GetService("Lighting"))
    shared.limbo.blur = blurEffect
    return blurEffect
end

local blur2 = blur()
blur2.Size = 10

if shared.limbo.startgui then
    shared.limbo.startgui:Destroy()
end

local StartGui = Instance.new("ScreenGui")
StartGui.Name = "StartGui"
StartGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
StartGui.IgnoreGuiInset = false
StartGui.Parent = game.Players.LocalPlayer.PlayerGui
shared.limbo.startgui = StartGui

local UIScale = Instance.new("UIScale")
UIScale.Scale = 0.96
UIScale.Parent = StartGui

local function quitGui()
    if shared.limbo.startgui then
        shared.limbo.startgui:Destroy()
        shared.limbo.startgui = nil
    end
    if shared.limbo.blur then
        shared.limbo.blur:Destroy()
        shared.limbo.blur = nil
    end
    --[[if shared.limbo.backgroundambience then
        shared.limbo.backgroundambience:Destroy()
    end]]
end

local function removeonClick(btn)
    if btn:IsA("TextButton") then
        btn.MouseButton1Click:Connect(quitGui)
    end
end

local window = Instance.new("Frame")
window.BorderColor3 = Color3.fromRGB(0, 0, 0)
window.AnchorPoint = Vector2.new(0.5, 0.5)
window.BackgroundTransparency = 0.05000000074505806
window.Position = UDim2.new(0.4988594949245453, 0, 0.5, 0)
window.Name = "window"
window.Size = UDim2.new(0, 450, 0, 390)
window.BorderSizePixel = 0
window.BackgroundColor3 = Color3.fromRGB(26, 26, 26)
window.Parent = StartGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 9)
UICorner.Parent = window

local UIStroke = Instance.new("UIStroke")
UIStroke.Thickness = 1.100000023841858
UIStroke.Color = Color3.fromRGB(112, 112, 112)
UIStroke.Parent = window

local topbarend = Instance.new("Frame")
topbarend.Name = "topbarend"
topbarend.Position = UDim2.new(0, 0, 0.023000000044703484, 0)
topbarend.BorderColor3 = Color3.fromRGB(0, 0, 0)
topbarend.Size = UDim2.new(1, 0, 0.05999999865889549, 0)
topbarend.BorderSizePixel = 0
topbarend.BackgroundColor3 = Color3.fromRGB(49, 49, 49)
topbarend.Parent = window

local topbar = Instance.new("Frame")
topbar.Name = "topbar"
topbar.BorderColor3 = Color3.fromRGB(0, 0, 0)
topbar.Size = UDim2.new(1, 0, 0.07000000029802322, 0)
topbar.BorderSizePixel = 0
topbar.BackgroundColor3 = Color3.fromRGB(49, 49, 49)
topbar.Parent = window

local UICorner2 = Instance.new("UICorner")
UICorner2.CornerRadius = UDim.new(0, 9)
UICorner2.Parent = topbar

local topbardontdelete = Instance.new("Frame")
topbardontdelete.BackgroundTransparency = 1
topbardontdelete.Name = "topbardontdelete"
topbardontdelete.BorderColor3 = Color3.fromRGB(0, 0, 0)
topbardontdelete.Size = UDim2.new(1, 0, 0.07999999821186066, 0)
topbardontdelete.BorderSizePixel = 0
topbardontdelete.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
topbardontdelete.Parent = window

local TextLabel = Instance.new("TextLabel")
TextLabel.FontFace = Font.new("rbxasset://fonts/families/Inconsolata.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
TextLabel.Text = "Launcher"
TextLabel.Size = UDim2.new(1, 0, 1, 0)
TextLabel.BackgroundTransparency = 1
TextLabel.TextXAlignment = Enum.TextXAlignment.Left
TextLabel.BorderSizePixel = 0
TextLabel.TextWrapped = true
TextLabel.TextSize = 15
TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.Parent = topbardontdelete

local UIPadding = Instance.new("UIPadding")
UIPadding.PaddingTop = UDim.new(0, 3)
UIPadding.PaddingBottom = UDim.new(0, 2)
UIPadding.PaddingRight = UDim.new(0, 11)
UIPadding.PaddingLeft = UDim.new(0, 11)
UIPadding.Parent = TextLabel

local exit = Instance.new("TextButton")
exit.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
exit.TextColor3 = Color3.fromRGB(0, 0, 0)
exit.BorderColor3 = Color3.fromRGB(0, 0, 0)
exit.Text = ""
exit.AutoButtonColor = false
exit.Name = "exit"
exit.Position = UDim2.new(0.9466667175292969, 0, 0.3205128312110901, 0)
exit.Size = UDim2.new(0, 10, 0, 10)
exit.BorderSizePixel = 0
exit.TextSize = 14
exit.BackgroundColor3 = Color3.fromRGB(218, 82, 82)
exit.Parent = topbardontdelete

removeonClick(exit)

local UICorner3 = Instance.new("UICorner")
UICorner3.CornerRadius = UDim.new(0, 15)
UICorner3.Parent = exit

local windowcontents = Instance.new("Frame")
windowcontents.Name = "windowcontents"
windowcontents.BackgroundTransparency = 1
windowcontents.Position = UDim2.new(0, 0, 1, 0)
windowcontents.BorderColor3 = Color3.fromRGB(0, 0, 0)
windowcontents.Size = UDim2.new(1, 0, -0.9169999957084656, 0)
windowcontents.BorderSizePixel = 0
windowcontents.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
windowcontents.Parent = window

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.FillDirection = Enum.FillDirection.Horizontal
UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Wraps = true
UIListLayout.Parent = windowcontents

local TextLabel2 = Instance.new("TextLabel")
TextLabel2.FontFace = Font.new("rbxasset://fonts/families/Inconsolata.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
TextLabel2.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel2.BorderColor3 = Color3.fromRGB(0, 0, 0)
TextLabel2.RichText = true
local userRelated = cloneref(game:GetService("Players")).LocalPlayer.Name ~= cloneref(game:GetService("Players")).LocalPlayer.DisplayName
if isfile('limbo/used') then
    TextLabel2.Text = "Welcome back, <b><font color=\"rgb(147, 112, 219)\">"..cloneref(game:GetService("Players")).LocalPlayer.Name.."</font></b> "..(userRelated and "<font color=\"rgb(121, 121, 121)\">("..cloneref(game:GetService("Players")).LocalPlayer.DisplayName..")</font>" or "")
else
    TextLabel2.Text = "Welcome, <b><font color=\"rgb(147, 112, 219)\">"..cloneref(game:GetService("Players")).LocalPlayer.Name.."</font></b> "..(userRelated and "<font color=\"rgb(121, 121, 121)\">("..cloneref(game:GetService("Players")).LocalPlayer.DisplayName..")</font>" or "")
end
writefile('limbo/used', 'true')
TextLabel2.Size = UDim2.new(0, 414, 0, 61)
TextLabel2.BackgroundTransparency = 1
TextLabel2.Position = UDim2.new(0.003113070735707879, 0, 1.0000001192092896, 0)
TextLabel2.BorderSizePixel = 0
TextLabel2.TextWrapped = true
TextLabel2.TextSize = 15
TextLabel2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextLabel2.Parent = windowcontents

local windowtabcontents = Instance.new("Frame")
windowtabcontents.Name = "windowtabcontents"
windowtabcontents.BackgroundTransparency = 1
windowtabcontents.Position = UDim2.new(0.01888885535299778, 0, 0.8294326663017273, 0)
windowtabcontents.BorderColor3 = Color3.fromRGB(0, 0, 0)
windowtabcontents.Size = UDim2.new(0, 433, 0, 45)
windowtabcontents.BorderSizePixel = 0
windowtabcontents.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
windowtabcontents.Parent = windowcontents

local UIListLayout2 = Instance.new("UIListLayout")
UIListLayout2.VerticalAlignment = Enum.VerticalAlignment.Center
UIListLayout2.FillDirection = Enum.FillDirection.Horizontal
UIListLayout2.HorizontalAlignment = Enum.HorizontalAlignment.Center
UIListLayout2.Padding = UDim.new(0, 8)
UIListLayout2.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout2.Parent = windowtabcontents

local ChooseScript2 = Instance.new("TextButton")
ChooseScript2.FontFace = Font.new("rbxasset://fonts/families/Inconsolata.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
ChooseScript2.TextColor3 = Color3.fromRGB(255, 255, 255)
ChooseScript2.BorderColor3 = Color3.fromRGB(0, 0, 0)
ChooseScript2.Text = "Choose Version"
ChooseScript2.AutoButtonColor = false
ChooseScript2.Name = "ChooseScript"
ChooseScript2.Position = UDim2.new(0.34180137515068054, 0, 0.20000000298023224, 0)
ChooseScript2.Size = UDim2.new(0, 132, 0, 32)
ChooseScript2.BorderSizePixel = 0
ChooseScript2.TextSize = 15
ChooseScript2.BackgroundColor3 = Color3.fromRGB(65, 65, 65)
ChooseScript2.Parent = windowtabcontents

local ChooseScript1 = Instance.new("TextButton")
ChooseScript1.FontFace = Font.new("rbxasset://fonts/families/Inconsolata.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
ChooseScript1.TextColor3 = Color3.fromRGB(255, 255, 255)
ChooseScript1.BorderColor3 = Color3.fromRGB(0, 0, 0)
ChooseScript1.Text = "Credits"
ChooseScript1.AutoButtonColor = false
ChooseScript1.Name = "ChooseScript"
ChooseScript1.Position = UDim2.new(0.34180137515068054, 0, 0.20000000298023224, 0)
ChooseScript1.Size = UDim2.new(0, 132, 0, 32)
ChooseScript1.BorderSizePixel = 0
ChooseScript1.TextSize = 15
ChooseScript1.BackgroundColor3 = Color3.fromRGB(65, 65, 65)
ChooseScript1.Parent = windowtabcontents

local UICorner4 = Instance.new("UICorner")
UICorner4.CornerRadius = UDim.new(0, 6)
UICorner4.Parent = ChooseScript1

local UICorner5 = Instance.new("UICorner")
UICorner5.CornerRadius = UDim.new(0, 6)
UICorner5.Parent = ChooseScript2

local spacer = Instance.new("TextLabel")
spacer.FontFace = Font.new("rbxasset://fonts/families/Inconsolata.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
spacer.TextColor3 = Color3.fromRGB(255, 255, 255)
spacer.BorderColor3 = Color3.fromRGB(0, 0, 0)
spacer.Text = ""
spacer.Name = "spacer"
spacer.Size = UDim2.new(0, 414, 0, 28)
spacer.BackgroundTransparency = 1
spacer.Position = UDim2.new(0.03999996557831764, 0, 0.7259737849235535, 0)
spacer.BorderSizePixel = 0
spacer.TextWrapped = true
spacer.TextSize = 1
spacer.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
spacer.Parent = windowcontents

local Frame = Instance.new("Frame")
Frame.Position = UDim2.new(0, 0, 0.4000000059604645, 0)
Frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
Frame.Size = UDim2.new(1, 0, 0.05000000074505806, 0)
Frame.BorderSizePixel = 0
Frame.BackgroundColor3 = Color3.fromRGB(54, 54, 54)
Frame.Parent = spacer

local UICorner6 = Instance.new("UICorner")
UICorner6.CornerRadius = UDim.new(0, 123)
UICorner6.Parent = Frame

local tabcontents = Instance.new("Frame")
tabcontents.BackgroundTransparency = 1
tabcontents.Name = "tabcontents"
tabcontents.BorderColor3 = Color3.fromRGB(0, 0, 0)
tabcontents.Size = UDim2.new(0.8799999952316284, 0, 0.699999988079071, 0)
tabcontents.BorderSizePixel = 0
tabcontents.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
tabcontents.Parent = windowcontents

local chooseversiontab = Instance.new("Frame")
chooseversiontab.BackgroundTransparency = 1
chooseversiontab.Name = "chooseversiontab"
chooseversiontab.BorderColor3 = Color3.fromRGB(0, 0, 0)
chooseversiontab.Size = UDim2.new(1, 0, 1, 0)
chooseversiontab.BorderSizePixel = 0
chooseversiontab.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
chooseversiontab.Parent = tabcontents

local limbolite = Instance.new("Frame")
limbolite.Name = "limbolite"
limbolite.BackgroundTransparency = 0.10000000149011612
limbolite.Position = UDim2.new(0.24242424964904785, 0, 0, 0)
limbolite.BorderColor3 = Color3.fromRGB(0, 0, 0)
limbolite.Size = UDim2.new(0, 206, 0, 153)
limbolite.BorderSizePixel = 0
limbolite.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
limbolite.Parent = chooseversiontab

local UICorner7 = Instance.new("UICorner")
UICorner7.CornerRadius = UDim.new(0, 6)
UICorner7.Parent = limbolite

local TextLabel3 = Instance.new("TextLabel")
TextLabel3.FontFace = Font.new("rbxasset://fonts/families/Inconsolata.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
TextLabel3.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel3.BorderColor3 = Color3.fromRGB(0, 0, 0)
TextLabel3.Text = "Lite"
TextLabel3.BackgroundTransparency = 1
TextLabel3.Size = UDim2.new(1, 0, 0.15000000596046448, 0)
TextLabel3.BorderSizePixel = 0
TextLabel3.TextWrapped = true
TextLabel3.TextSize = 15
TextLabel3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextLabel3.Parent = limbolite

local UIListLayout3 = Instance.new("UIListLayout")
UIListLayout3.Padding = UDim.new(0, 10)
UIListLayout3.HorizontalAlignment = Enum.HorizontalAlignment.Center
UIListLayout3.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout3.Parent = limbolite

local TextLabel4 = Instance.new("TextLabel")
TextLabel4.TextWrapped = true
TextLabel4.TextColor3 = Color3.fromRGB(147, 147, 147)
TextLabel4.BorderColor3 = Color3.fromRGB(0, 0, 0)
TextLabel4.Text = "Serves lesser features but easy navigation"
TextLabel4.Size = UDim2.new(1, 0, 0.15653593838214874, 0)
TextLabel4.BorderSizePixel = 0
TextLabel4.BackgroundTransparency = 1
TextLabel4.Position = UDim2.new(0, 0, 0.254575252532959, 0)
TextLabel4.TextSize = 13
TextLabel4.FontFace = Font.new("rbxasset://fonts/families/Inconsolata.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
TextLabel4.TextScaled = true
TextLabel4.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextLabel4.Parent = limbolite

local TextButton1 = Instance.new("TextButton")
TextButton1.FontFace = Font.new("rbxasset://fonts/families/Inconsolata.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
TextButton1.TextColor3 = Color3.fromRGB(255, 255, 255)
TextButton1.BorderColor3 = Color3.fromRGB(0, 0, 0)
TextButton1.Text = "Select"
TextButton1.AutoButtonColor = false
TextButton1.Position = UDim2.new(0.09951456636190414, 0, 0.3588234782218933, 0)
TextButton1.Size = UDim2.new(0, 165, 0, 31)
TextButton1.BorderSizePixel = 0
TextButton1.TextSize = 15
TextButton1.BackgroundColor3 = Color3.fromRGB(147, 112, 219)
TextButton1.Parent = limbolite
TextButton1.MouseButton1Click:Connect(function()
    if not LiteIsAvailable then
        TextButton1.Text = "Not Available!"
        task.delay(2, function()
            TextButton1.Text = "Select"
        end)
    else
        removeonClick(TextButton1)
    end
end)

local UICorner8 = Instance.new("UICorner")
UICorner8.CornerRadius = UDim.new(0, 6)
UICorner8.Parent = TextButton1

local UIListLayout4 = Instance.new("UIListLayout")
UIListLayout4.FillDirection = Enum.FillDirection.Horizontal
UIListLayout4.HorizontalAlignment = Enum.HorizontalAlignment.Center
UIListLayout4.Padding = UDim.new(0, 10)
UIListLayout4.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout4.Parent = chooseversiontab

local limbo = Instance.new("Frame")
limbo.Name = "limbo"
limbo.BackgroundTransparency = 0.10000000149011612
limbo.Position = UDim2.new(0.24242424964904785, 0, 0, 0)
limbo.BorderColor3 = Color3.fromRGB(0, 0, 0)
limbo.Size = UDim2.new(0, 206, 0, 153)
limbo.BorderSizePixel = 0
limbo.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
limbo.Parent = chooseversiontab

local UICorner9 = Instance.new("UICorner")
UICorner9.CornerRadius = UDim.new(0, 6)
UICorner9.Parent = limbo

local TextLabel5 = Instance.new("TextLabel")
TextLabel5.FontFace = Font.new("rbxasset://fonts/families/Inconsolata.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
TextLabel5.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel5.BorderColor3 = Color3.fromRGB(0, 0, 0)
TextLabel5.Text = "Regular"
TextLabel5.BackgroundTransparency = 1
TextLabel5.Size = UDim2.new(1, 0, 0.15000000596046448, 0)
TextLabel5.BorderSizePixel = 0
TextLabel5.TextWrapped = true
TextLabel5.TextSize = 15
TextLabel5.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextLabel5.Parent = limbo

local UIListLayout5 = Instance.new("UIListLayout")
UIListLayout5.Padding = UDim.new(0, 10)
UIListLayout5.HorizontalAlignment = Enum.HorizontalAlignment.Center
UIListLayout5.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout5.Parent = limbo

local TextLabel6 = Instance.new("TextLabel")
TextLabel6.TextWrapped = true
TextLabel6.TextColor3 = Color3.fromRGB(147, 147, 147)
TextLabel6.BorderColor3 = Color3.fromRGB(0, 0, 0)
TextLabel6.Text = "Regular Limbo, much more features and recommended."
TextLabel6.Size = UDim2.new(1, 0, 0.15653593838214874, 0)
TextLabel6.BorderSizePixel = 0
TextLabel6.BackgroundTransparency = 1
TextLabel6.Position = UDim2.new(0, 0, 0.254575252532959, 0)
TextLabel6.TextSize = 13
TextLabel6.FontFace = Font.new("rbxasset://fonts/families/Inconsolata.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
TextLabel6.TextScaled = true
TextLabel6.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextLabel6.Parent = limbo

local TextButton2 = Instance.new("TextButton")
TextButton2.FontFace = Font.new("rbxasset://fonts/families/Inconsolata.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
TextButton2.TextColor3 = Color3.fromRGB(255, 255, 255)
TextButton2.BorderColor3 = Color3.fromRGB(0, 0, 0)
TextButton2.Text = "Select"
TextButton2.AutoButtonColor = false
TextButton2.Position = UDim2.new(0.09951456636190414, 0, 0.3588234782218933, 0)
TextButton2.Size = UDim2.new(0, 165, 0, 31)
TextButton2.BorderSizePixel = 0
TextButton2.TextSize = 15
TextButton2.BackgroundColor3 = Color3.fromRGB(147, 112, 219)
TextButton2.Parent = limbo
removeonClick(TextButton2)
TextButton2.MouseButton1Click:Connect(function()
    local file = 'limbo/placedetectorscript.lua'
    if isfile(file) then
        pcall(function()
            loadstring(readfile(file), true)() 
        end)
    end
end)

local UICorner10 = Instance.new("UICorner")
UICorner10.CornerRadius = UDim.new(0, 6)
UICorner10.Parent = TextButton2

local creditstab = Instance.new("Frame")
creditstab.Visible = false
creditstab.BackgroundTransparency = 1
creditstab.Name = "creditstab"
creditstab.BorderColor3 = Color3.fromRGB(0, 0, 0)
creditstab.Size = UDim2.new(1, 0, 1, 0)
creditstab.BorderSizePixel = 0
creditstab.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
creditstab.Parent = tabcontents

local UIListLayout6 = Instance.new("UIListLayout")
UIListLayout6.FillDirection = Enum.FillDirection.Vertical
UIListLayout6.HorizontalAlignment = Enum.HorizontalAlignment.Center
UIListLayout6.Padding = UDim.new(0, 1)
UIListLayout6.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout6.Parent = creditstab

local TextLabel7 = Instance.new("TextLabel")
TextLabel7.FontFace = Font.new("rbxasset://fonts/families/Inconsolata.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
TextLabel7.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel7.BorderColor3 = Color3.fromRGB(0, 0, 0)
TextLabel7.Text = [[<font color='rgb(255, 50, 50)'>Luminum</font> - Main Developer & Maintainer]]


TextLabel7.Size = UDim2.new(0, 412, 0, 22)
TextLabel7.BackgroundTransparency = 1
TextLabel7.Position = UDim2.new(-0.02020205929875374, 0, 0, 0)
TextLabel7.BorderSizePixel = 0
TextLabel7.RichText = true
TextLabel7.TextSize = 15
TextLabel7.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextLabel7.Parent = creditstab

function createspaceidk()
    local SPACER = Instance.new("TextLabel")
    SPACER.FontFace = Font.new("rbxasset://fonts/families/Inconsolata.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
    SPACER.TextColor3 = Color3.fromRGB(255, 255, 255)
    SPACER.BorderColor3 = Color3.fromRGB(0, 0, 0)
    SPACER.Text = ''
    SPACER.Size = UDim2.new(0, 412, 0, 22)
    SPACER.BackgroundTransparency = 1
    SPACER.Position = UDim2.new(-0.02020205929875374, 0, 0, 0)
    SPACER.BorderSizePixel = 0
    SPACER.RichText = true
    SPACER.TextSize = 15
    SPACER.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    SPACER.Parent = creditstab
end

createspaceidk();createspaceidk()

local TextLabel83 = Instance.new("TextButton")
TextLabel83.FontFace = Font.new("rbxasset://fonts/families/Inconsolata.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
TextLabel83.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel83.BorderColor3 = Color3.fromRGB(0, 0, 0)
TextLabel83.Text = "<b><font color='rgb(147, 112, 219)'>" .. shared.LimboRepository .. "</font></b>"

TextLabel83.MouseEnter:Connect(function()
    TextLabel83.Text = "<b><font color='rgb(194, 170, 243)'>" .. shared.LimboRepository .. "</font></b>"
end)

TextLabel83.MouseLeave:Connect(function()
    TextLabel83.Text = "<b><font color='rgb(147, 112, 219)'>" .. shared.LimboRepository .. "</font></b>"
end)

function copyidk()
    if not setclipboard then return end
    setclipboard(shared.LimboRepository)
    TextLabel83.Text = "<font color='rgb(113, 255, 113)'>Copied repository url!</font>"
end

TextLabel83.MouseButton1Down:Connect(function()
    copyidk()
    shared.limbo.playSound('correctding.mp3')
end)

TextLabel83.Size = UDim2.new(0, 412, 0, 22)
TextLabel83.BackgroundTransparency = 1
TextLabel83.Position = UDim2.new(-0.02020205929875374, 0, 0, 0)
TextLabel83.BorderSizePixel = 0
TextLabel83.RichText = true
TextLabel83.TextSize = 15
TextLabel83.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextLabel83.Parent = creditstab

local function switchTab(showVersion)
    if showVersion then
        chooseversiontab.Visible = true
        creditstab.Visible = false
        ChooseScript2.BackgroundColor3 = Color3.fromRGB(147, 112, 219)
        ChooseScript1.BackgroundColor3 = Color3.fromRGB(65, 65, 65)
    else
        chooseversiontab.Visible = false
        creditstab.Visible = true
        ChooseScript2.BackgroundColor3 = Color3.fromRGB(65, 65, 65)
        ChooseScript1.BackgroundColor3 = Color3.fromRGB(147, 112, 219)
    end
end

ChooseScript1.MouseButton1Click:Connect(function()
    switchTab(false)
end)

ChooseScript2.MouseButton1Click:Connect(function()
    switchTab(true)
end)

ChooseScript2.BackgroundColor3 = Color3.fromRGB(147, 112, 219)

--[[if shared.limbo.playSound then
    local backgroundambience = shared.limbo.playSound('backgroundambience.mp3')
    backgroundambience.Volume = 0.3
    backgroundambience.Looped = true
    shared.limbo.backgroundambience = backgroundambience
end]]
