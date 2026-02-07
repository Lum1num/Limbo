
if isfile('limbo/splashintro.lua') then
    loadstring(readfile('limbo/splashintro.lua'), true)()
    repeat
        task.wait()
    until shared.limbo.SplashIntroCompleted == true
end

function universal()
    loadstring(game:HttpGet('https://raw.githubusercontent.com/Lum1num/Limbo/refs/heads/main/source/places/universal.lua', true))()
end
function place()
    loadstring(game:HttpGet('https://raw.githubusercontent.com/Lum1num/Limbo/refs/heads/main/source/places/'..tostring(game.PlaceId)..'.lua', true))()
end
local suc, _ = pcall(place)
if not suc then
    pcall(universal)
end
