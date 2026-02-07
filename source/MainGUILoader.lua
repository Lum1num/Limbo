shared.limbo = shared.limbo or {}

for _, v in ipairs(cloneref(game:GetService("CoreGui")):GetDescendants()) do
    if v.Name == "Obsidian" then
        v:Destroy()
    end
end

local Library = loadstring(readfile("limbo/newlibrary/gui.lua"))()

local Window = Library:CreateWindow({
    Size = UDim2.fromOffset(700, 600),
    Title = "<font color='rgb(147, 112, 219)'>Limbo</font> <font color='rgb(183, 183, 183)'>" .. readfile("limbo/version.txt"):gsub("\n", "") .. "</font>\n<font color='rgb(70, 70, 75)' size='13'>(Regular)</font>",
    Footer = "Join the Limbo Community!: <font color='rgb(147, 112, 219)'>https://discord.gg/scMCwnGYJd</font>",
    NotifySide = "Right",
    ShowCustomCursor = false,
    ToggleKeybind = Enum.KeyCode.V,
    Resizable = true
})

local main = Window:AddTab("Main", "door-open")
local tools = Window:AddTab("Tools", "tent-tree")

shared.limbo.Window = Window
shared.limbo.main = main
shared.limbo.tools = tools

function Window:AddLeftGroupboxWithDescription(tab, title, desc)
    if desc and desc ~= "" then
        title = title .. " <font size='10' color='rgb(80,80,80)'>(" .. desc .. ")</font>"
    end
    return tab:AddLeftGroupbox(title)
end

function Window:AddRightGroupboxWithDescription(tab, title, desc)
    if desc and desc ~= "" then
        title = title .. " <font size='10' color='rgb(80,80,80)'>(" .. desc .. ")</font>"
    end
    return tab:AddRightGroupbox(title)
end

local tools1 = Window:AddLeftGroupboxWithDescription(tools, "Game", "Change game settings and more")

tools1:AddButton({
    Text = "Leave Server",
    Func = function()
        game:Shutdown()
    end,
    Tooltip = "Leaves the current server",
    DoubleClick = true
})

tools1:AddButton({
    Text = "Rejoin",
    Func = function()
        cloneref(game:GetService("TeleportService")):Teleport(game.PlaceId, cloneref(game:GetService("Players")).LocalPlayer)
    end,
    Tooltip = "Rejoins the current server",
    DoubleClick = true
})

tools1:AddButton({
    Text = "Serverhop",
    Func = function()
        cloneref(game:GetService("TeleportService")):TeleportToPlaceInstance(
            game.PlaceId,
            cloneref(game:GetService("HttpService")):JSONDecode(
                game:HttpGet("https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100")
            ).data[math.random(1, #cloneref(game:GetService("HttpService")):JSONDecode(
                game:HttpGet("https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100")
            ).data)].id,
            cloneref(game:GetService("Players")).LocalPlayer
        )
    end,
    Tooltip = "Serverhops to a different server",
    DoubleClick = true
})

local SaveManager = loadstring(readfile("limbo/newlibrary/addons/savemanager.lua"))()
local ThemeManager = loadstring(readfile("limbo/newlibrary/addons/thememanager.lua"))()

local Tabs = {
    ["UI Settings"] = Window:AddTab("Settings", "user-cog"),
}

SaveManager:SetLibrary(Library)
SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({ "MenuKeybind" })
SaveManager:SetFolder("MyScriptHub/specific-game")
SaveManager:SetSubFolder("Lobby")
SaveManager:BuildConfigSection(Tabs["UI Settings"])
SaveManager:LoadAutoloadConfig()

ThemeManager:SetLibrary(Library)
ThemeManager:SetFolder("MyScriptHub")
ThemeManager:ApplyToTab(Tabs["UI Settings"])
ThemeManager:LoadDefault()

return Library
