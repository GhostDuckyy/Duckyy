local Players = game:GetService("Players")
local lp = Players.LocalPlayer
local VU = game:GetService('VirtualUser')
local TS = game:GetService('TweenService')
local camera = game:GetService('Workspace').CurrentCamera
local mouse = Players.LocalPlayer:GetMouse()

local repo = 'https://raw.githubusercontent.com/wally-rblx/LinoriaLib/main/'
local Library = loadstring(game:HttpGet(repo .. 'Library.lua'))()
local ThemeManager = loadstring(game:HttpGet(repo .. 'addons/ThemeManager.lua'))()

local w = Library:CreateWindow({
    Title = '['..identifyexecutor()..']'.." Duckyy",
    Center = true,
    AutoShow = true,
})

local main = w:AddTab("main")
local other = w:AddTab("other")

local Farm = main:AddLeftGroupbox("Farm")

Farm:AddToggle("Swing", {
    Text = "Auto Swing",
    Default = false,
    Tooltip = "auto swing katana",
})
Toggles["Swing"]:OnChanged(function()
    spawn(function()
        local tool;
        lp.Character.Humanoid:UnequipTools()
        while wait(.2) do
            if Toggles['Swing'].Value == false then break end

            pcall(function()
                repeat wait() until lp.Character.Humanoid.Health > 0 or lp.Character.Humanoid.Health ~= 0 or Toggles['Swing'].Value == false
                for i,v in pairs(lp.Backpack:GetChildren()) do
                    if v:IsA("Tool") and v.Name ~= "Shuriken" and v.Name ~= "InvisibilityTool" and v.Name ~= "ShadowCloneTool" and v.Name ~= "TeleportTool" then lp.Character.Humanoid:EquipTool(v); end
                end
                tool = lp.Character:FindFirstChildOfClass("Tool") or nil
                if tool ~= nil then
                    tool:Activate()
                else
                    tool = lp.Character:FindFirstChildOfClass("Tool") or nil
                end
            end)
        end
    end)
end)

Farm:AddToggle("FloatingVoid", {
    Text = "Floating on the void",
    Default = false,
    Tooltip = "Safest place"
})
Toggles["FloatingVoid"]:OnChanged(function()
    spawn(function()
        while wait() do
            if Toggles["FloatingVoid"].Value == false then for i = 1,6 do if lp.Character ~= nil then lp.Character.PrimaryPart.CFrame = CFrame.new(45.0906029, 82.7582855, -44.1422195) end end break; end
            if lp.Character.Humanoid.Health > 0 or lp.Character.Humanoid.Health ~= 0 then
                repeat
                    lp.Character.PrimaryPart.CFrame = CFrame.new(6969,999,6969)
                    task.wait()
                until Toggles["FloatingVoid"].Value == false
            end
        end
    end)
end)

do
    if firesignal then
        Farm:AddDropdown("UpgradeDrop", {
            Values = {"Sword","Shuriken","Class","Realm"},
            Default = nil,
            Multi = true,

            Text = "Select to upgrade/rank",
            Tooltip = "Can select multi target",
        })
        Farm:AddToggle("Upgrade",{
            Text = "Auto upgrade/rank",
            Default = false,
            Tooltip = "none"
        })
        Toggles["Upgrade"]:OnChanged(function()
            spawn(function()
                while task.wait(1) do
                    if Toggles["Upgrade"].Value == false then break; end
                    local swordbtn = lp.PlayerGui.MainGui.UpgradeF.SwordF.MaxUpgradeBtn;
                    local shurikenbtn = lp.PlayerGui.MainGui.UpgradeF.ShurikenF.ShurikenImgBtn;
                    local classbtn = lp.PlayerGui.MainGui.UpgradeF.ClassF.ClassImgBtn;
                    local realmbtn = lp.PlayerGui.MainGui.UpgradeF.AscendF.AscendImgBtn;

                    for index,bool in next, Options["UpgradeDrop"].Value do
                        if index == "Sword" and bool == true then
                            firesignal(swordbtn.MouseButton1Down)
                        end

                        if index == "Shuriken" and bool == true then
                            firesignal(shurikenbtn.MouseButton1Down)
                        end

                        if index == "Class" and bool == true then
                            firesignal(classbtn.MouseButton1Down)
                        end

                        if index == "Realm" and bool == true then
                            firesignal(realmbtn.MouseButton1Down)
                        end
                    end
                end
            end)
        end)
    end
end

Farm:AddButton("Anti AFK", function()
    repeat wait() until game:IsLoaded()

    if getconnections then
        pcall(function()
            for _, v in next, getconnections(lp.Idled) do
                v:Disable()
            end
        end)
    end
    if not getconnections then -- copy form here https://v3rmillion.net/showthread.php?tid=772135
        pcall(function()
            lp.Idled:connect(function()
                VU:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
                wait(1)
                VU:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
            end)
        end)
    end
end)

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

local sfun = main:AddRightGroupbox("Fun")

getgenv().hitboxloaded = false
sfun:AddButton("Hitbox Expander", function()
    if getgenv().hitboxloaded == false then
        pcall(function()
            loadstring(game:HttpGet("http://gameovers.net/Scripts/Free/HitboxExpander/main.lua", true))()
        end)
        getgenv().hitboxloaded = true;
    end
end)
sfun:AddLabel("Made by GameOverAgain#1875")

getgenv().UnnamedEsp = false
sfun:AddButton("Unnamed ESP", function()
    if getgenv().UnnamedEsp == false then
        pcall(function()
            loadstring(game:HttpGet("https://pastebin.com/raw/kvr0AuWz", true))()
        end)
        getgenv().UnnamedEsp = true
    end
end)
sfun:AddLabel("Made by Ic3w0lf")

local misc = other:AddLeftGroupbox("Misc")
misc:AddButton("Destroy UI", function()
    Library:Unload()
end)

ThemeManager:SetLibrary(Library)
ThemeManager:SetFolder('DuckyyTheme')
ThemeManager:ApplyToTab(other)

local credit = w:AddTab("credit")
local credits = credit:AddLeftGroupbox("list")
credits:AddLabel("Made by Ghost-Ducky#7698")
credits:AddLabel("Library made by Inori")
credits:AddLabel("Save&Load Theme - wally")
Library:Notify("RControl toggle ui")
