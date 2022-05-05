local Players = game:GetService("Players")
local lp = Players.LocalPlayer
local VU = game:GetService('VirtualUser')
local TS = game:GetService('TweenService')
local camera = game:GetService('Workspace').CurrentCamera
local mouse = Players.LocalPlayer:GetMouse()

local repo = 'https://raw.githubusercontent.com/wally-rblx/LinoriaLib/main/'
local Library = loadstring(game:HttpGet(repo .. 'Library.lua'))()
local ThemeManager = loadstring(game:HttpGet(repo .. 'addons/ThemeManager.lua'))()
local SaveManager = loadstring(game:HttpGet(repo .. 'addons/SaveManager.lua'))()

local w = Library:CreateWindow({
    Title = '['..identifyexecutor()..']'.." Duckyy",
    Center = true,
    AutoShow = true,
})

local main = w:AddTab("main")
local other = w:AddTab("other")

local farm = main:AddLeftGroupbox("Farm")

farm:AddToggle("Clicker", {
    Text = 'Auto Clicker',
    Default = false,
    Tooltip = 'NOTE: ur executor must support "FireSignal"',
})
Toggles["Clicker"]:OnChanged(function()
    spawn(function()
        while Toggles["Clicker"].Value == true do
            if firesignal then
                firesignal(lp.PlayerGui.mainUI.clickerButton.MouseButton1Click)
            else
                ErrorNotif("Sry ur executor not suppurt firesignal", 1)
            end
            wait(0.2)
        end
    end)
end)

local unlockboosts = farm:AddButton("Unlock boosts", function()
    local Folder = lp:WaitForChild("Boosts")

    if Folder ~= nil and Folder:IsA("Folder") then
        for i,boost in pairs(Folder:GetDescendants()) do
            if boost:IsA("IntValue") or boost.ClassName == "IntValue" and boost:FindFirstChild("isActive") then
                if boost["isActive"].Value == false then
                    boost["isActive"].Value = true
                end
            end
        end
    end

    local rbBackground = lp.PlayerGui.mainUI.rebirthBackground.Background.Background

    if rbBackground:FindFirstChild("auto") and rbBackground:FindFirstChild("auto").Visible == false then
        rbBackground:FindFirstChild("auto").Visible = true
    end
end)
unlockboosts:AddTooltip("Unlock all boosts")

local sTeleport = main:AddLeftGroupbox("Teleport")

sTeleport:AddButton("open teleporter menu", function()
    local frame = lp.PlayerGui.NewUI:WaitForChild("Teleporter")

    if frame then
        if frame.Visible == false then
            frame.Visible = true;
        else
            farm.Visible = false;
        end
    end

    do
        local list = {
            "Sky",
            "Ice",
            "Lava",
            "Pirate",
            "Space",
            "Forest",
            "CandyLand",
            "Atlantis",
            "Tropical",
            "Bee",
            "Galaxy",
            "Robot",
            "Chemical",
            "Steampunk",
            "Holographic",
            "Music",
            "Hacker",
            "Mars",
            "Dinosaur",
            "Egypt",
            "Ice Age",
            "Samurai",
            "Rome",
            "Jungle",
            "Time World",
            "Tech World",
        }
        for i,v in pairs(lp.PlayerGui.NewUI.Teleporter.Main.Zones:GetDescendants()) do
            for i2, v2 in pairs(list) do
                if v:IsA("Frame") and v.Name == v2 and v:FindFirstChild("Locked") and v["Locked"]:IsA("Frame") and v["Locked"].Visible == true then
                    v:FindFirstChild("Locked").Visible = false
                end
            end
        end
    end
end)

local sVisual = main:AddRightGroupbox("Visual")

sVisual:AddInput('PetStorageValue', {
    Default = '',
    Numeric = true, -- true / false, only allows numbers
    Finished = false, -- true / false, only calls callback when you press enter

    Text = 'Custom Pet Storage',
    Tooltip = 'This is visual',

    Placeholder = 'Enter number',
})

sVisual:AddButton("Run", function()
    do
        local EggValue = game:GetService("Players").B1gN1nj4.Achievements.Eggs
        local module = require(game:GetService("ReplicatedStorage").FunctionsModule).getMaxInventory;
        local ssetconstant = setconstant or debug.setconstant or nil;

        if ssetconstant ~= nil then
            local Input_Value = tonumber(Options["PetStorageValue"].Value)
            ssetconstant(module, 13, Input_Value)
            wait(.2)
            if EggValue.Value ~= ";1;" then
                EggValue.Value = ";1;"
            elseif EggValue.Value == ";1;" then
                EggValue.Value = ""
            end
        else
            ErrorNotif("Sry ur executor not suppurt setconstant", 1)
        end
    end
end)

sVisual:AddLabel("*It just a visual*")

local sself = main:AddRightGroupbox("Self Options")

sself:AddSlider("Speed", {
    Text = "Walk Speed",
    Default = 16,
    Min = 0,
    Max = 300,
    Rounding = 1,
    Compact = false,
})
Options["Speed"]:OnChanged(function()
    if lp.Character ~= nil and lp.Character:WaitForChild("Humanoid") then
        local Human = lp.Character:WaitForChild("Humanoid")
        Human.WalkSpeed = Options["Speed"].Value
    end
end)

sself:AddSlider("Jump", {
    Text = "Jump Height",
    Default = 50,
    Min = 0,
    Max = 300,
    Rounding = 1,
    Compact = false,
})
Options["Jump"]:OnChanged(function()
    if lp.Character ~= nil and lp.Character:WaitForChild("Humanoid") then
        local Human = lp.Character:WaitForChild("Humanoid")
        Human.JumpPower = Options["Jump"].Value
    end
end)

sself:AddSlider("Gravity", {
    Text = "World Gravity",
    Default = 196,
    Min = 0,
    Max = 196,
    Rounding = 1,
    Compact = false,
})
Options["Gravity"]:OnChanged(function()
    workspace.Gravity = Options["Gravity"].Value
end)

sself:AddButton("Reset all to default", function()
    Options["Speed"]:SetValue(16)
    Options["Jump"]:SetValue(50)
    Options["Gravity"]:SetValue(196)
end)

local misc = other:AddLeftGroupbox("Misc")
misc:AddButton("Destroy UI", function()
    Library:Unload()
end)

function ErrorNotif(str, limit)
    pcall(function()
        for i = 1, limit do
            local Event = game:GetService("ReplicatedStorage").Bindable.Client:WaitForChild("errorMessage")
            Event:Fire(tostring(str))
        end
    end)
end

ThemeManager:SetLibrary(Library)
ThemeManager:SetFolder('DuckyyTheme')
ThemeManager:ApplyToTab(other)

local credit = w:AddTab("credit")
local credits = credit:AddLeftGroupbox("list")
credits:AddLabel("Made by Ghost-Ducky#7698")
credits:AddLabel("Library made by Inori")
credits:AddLabel("Save&Load Theme - wally")

Library:Notify("RControl toggle ui")
