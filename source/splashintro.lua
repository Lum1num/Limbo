if shared.limbo.SplashIntroCompleted then
    shared.limbo.SplashIntroCompleted = false
end
if shared.limbo.splashintro then
    shared.limbo.splashintro:Destroy()
end
if shared.limbo.splash then
    shared.limbo.splash:Destroy()
end
local sound = shared.limbo.playSound('splashintro.mp3', 2)
shared.limbo.splashintro = sound
local Players = cloneref(game:GetService("Players"))
local TweenService = cloneref(game:GetService("TweenService"))
local Lighting = cloneref(game:GetService("Lighting"))

local blur = Instance.new("BlurEffect")
blur.Size = 20
blur.Parent = Lighting

local blurTween = TweenService:Create(
    blur,
    TweenInfo.new(2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
    {Size = 0}
)

blurTween:Play()

local gui = Instance.new("ScreenGui")
gui.IgnoreGuiInset = true
gui.ResetOnSpawn = false
gui.Parent = cloneref(game:GetService('CoreGui'))

local image = Instance.new("ImageLabel")
image.AnchorPoint = Vector2.new(0.5, 0.5)
image.Position = UDim2.fromScale(0.5, 0.5)
image.Size = UDim2.fromScale(0.6, 0.1)
image.BackgroundTransparency = 1
image.ImageTransparency = 0
image.Image = getcustomasset("limbo/images/Limbo.png")
image.ZIndex = 10
image.Parent = gui
image.Rotation = math.random(-20, 20)

shared.limbo.splash = image

local imageTween = TweenService:Create(
    image,
    TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
    {
        Size = UDim2.fromScale(0.33, 0.22),
        ImageTransparency = 1,
        Rotation = 0
    }
)

imageTween:Play()

imageTween.Completed:Wait()
gui:Destroy()
blur:Destroy()

task.wait(2)
shared.limbo.SplashIntroCompleted = true
