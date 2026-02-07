if not isfolder("limbo") then return end
local Library = loadstring(readfile("limbo/MainGUILoader.lua"))()
local limbo = shared.limbo

limbo.Window:AddLeftGroupboxWithDescription(
    limbo.main,
    "Box",
    "new" 
)
