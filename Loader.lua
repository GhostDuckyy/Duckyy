local list = {
    a4225025295 = "Op_Ninja_Simulator.lua",
    a7560156054 = "Clicker_Simulator.lua",
    a2619187362 = "Super_Power_Fighting_Simulator.lua",
    a8540346411 = "Rebirth_Champions_X.lua"
}
local repo = "https://raw.githubusercontent.com/GhostDuckyy/Duckyy/main/"
local load = loadstring
for index, value in pairs(list) do
    if "a"..game.PlaceId == index then
        pcall(function()
            load(game:HttpGet(repo..value, true))()
        end)
    end
end
