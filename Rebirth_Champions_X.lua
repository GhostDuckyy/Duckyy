local Players = game:GetService("Players")
local lp = Players.LocalPlayer
local VU = game:GetService('VirtualUser')
local TS = game:GetService('TweenService')
local camera = game:GetService('Workspace').CurrentCamera
local mouse = Players.LocalPlayer:GetMouse()
local identify = identifyexecutor or nil

local repo = 'https://raw.githubusercontent.com/wally-rblx/LinoriaLib/main/'
local Library = loadstring(game:HttpGet(repo .. 'Library.lua'))()
local ThemeManager = loadstring(game:HttpGet(repo .. 'addons/ThemeManager.lua'))()
local SaveManager = loadstring(game:HttpGet(repo .. 'addons/SaveManager.lua'))()

local w = Library:CreateWindow({
    Title = '['..identify()..']'.." Duckyy",
    Center = true,
    AutoShow = true,
})

local main = w:AddTab("main")
local other = w:AddTab("other")

local farm = main:AddLeftGroupbox("Farm")

farm:AddToggle("Aclick",{
    Text = "Auto Click",
    Default = false,
    Tooltip = nil,
})
Toggles["Aclick"]:OnChanged(function()
    spawn(function()
        local event = game:GetService("ReplicatedStorage").Events:WaitForChild("Click3")
        if event ~= nil then
            while wait() do
                if Toggles["Aclick"].Value == false then break; end
                event:FireServer()
            end
        end
    end)
end)

farm:AddDropdown("passDrop",{
    Values = {
        "AutoClicker",
        "AutoRebirth",
    },
    Default = nil,
    Multi = true,
    Text = "Unlock Gamepass",
    Tooltip = "this is multi dropdown"
})
Options["passDrop"]:OnChanged(function()
    for sname,sbool in next, Options["passDrop"].Value do
        for _,v in pairs(lp.Passes:GetChildren()) do
            if sname == v.Name then
                if sbool == true then
                    v.Value = true;
                else
                    v.Value = false;
                end
            end
        end
    end
end)

local sMap = main:AddLeftGroupbox("Map")

sMap:AddButton("Unlock all island", function()
    if workspace:FindFirstChild("Scripts") and workspace.Scripts:FindFirstChild("Portals") then
        local pfolder = workspace.Scripts.Portals
        for _,z in pairs(pfolder:GetChildren()) do
            if z:IsA("Model") or z.ClassName == "Model" and z:FindFirstChildOfClass("BoolValue") == false and z:FindFirstChild("LabelUI") then
                z:FindFirstChildOfClass("BoolValue").Value = true;
                if z:FindFirstChild("LabelUI") then
                    z:FindFirstChild("LabelUI"):Destroy()
                end
            end
        end

        local area = workspace.Scripts.Portals.Areas
        if area:FindFirstChild("Volcano") and area.Volcano:FindFirstChildOfClass("BoolValue") and area.Volcano["Unlocked"].Value == false then
            if area.Volcano:FindFirstChildOfClass("SurfaceGui") then
                area.Volcano:FindFirstChildOfClass("SurfaceGui"):Destroy()
            end
            if area.Volcano:FindFirstChildOfClass("BoolValue") then
                area.Volcano:FindFirstChildOfClass("BoolValue").Value = true;
            end
            area.Volcano.Transparency = 1;
            area.Volcano.CanCollide = false;
        end
    end
end)

sMap:AddDropdown("xIsland", {
    Values = {
        "Spawn",
        "Forest",
        "Beach",
        "Atlantis",
        "Desert",
        "Winter",
        "Volcano",
        "Moon",
        "Cyber",
        "Magic",
        "Heaven",
        "Nuclear",
        "Void",
        "Spooky",
        "Cave",
        "Steampunk",
        "Hell",
    },
    Default = 1,
    Multi = false,
    Text = "Select Island",
    Tooltip = nil,
})
sMap:AddButton("Teleport to selected island", function()
    if lp.Character ~= nil and workspace:FindFirstChild("Scripts") and workspace.Scripts:FindFirstChild("TeleportTo") then
        local ttfolder = workspace.Scripts.TeleportTo
        local old_pos;
        local new_pos;
        for _,z in pairs(ttfolder:GetChildren()) do
            if lp.Character ~= nil and z.Name == tostring(Options["xIsland"].Value) and z:IsA("Part") then
                -- This part copy form they module script lol path: game:GetService("Players").LocalPlayer.PlayerScripts.Library.Portals
                old_pos = z.CFrame
                new_pos = old_pos * CFrame.new(0,2,0)
                lp.Character.PrimaryPart.CFrame = new_pos
                game:GetService("ReplicatedStorage").Events.WorldBoost:FireServer(z.Name)
            end
        end
    end
end)

sMap:AddDropdown("xShopMachine", {
    Values = {
        "Potions",
        "Upgrades",
        "Shop",
        "Auras",
        "Index",
        "PetMachine",
    },
    Default = 1,
    Multi = false,
    Text = "Selcet Shop or Machine",
    Tooltip = nil,
})
sMap:AddButton("Teleport to Shop or Machine", function()
    if lp.Character ~= nil and workspace:FindFirstChild("Scripts") and workspace.Scripts:FindFirstChild("Spawn") then
        local old_pos;
        local new_pos;
        local sFolder = workspace.Scripts.Spawn
        for _,v in pairs(sFolder:GetChildren()) do
            if lp.Character ~= nil and v:IsA("Model") and v.Name == tostring(Options["xShopMachine"].Value) and v:FindFirstChild("Spin") ~= nil then
                old_pos = v["Spin"].CFrame
                new_pos = old_pos * CFrame.new(0,2,0)
                lp.Character.PrimaryPart.CFrame = new_pos
            end
        end
    end
end)

sMap:AddButton("Claim all chest", function()
    local remote = game:GetService("ReplicatedStorage").Events.Chest
    local ffolder = lp.Chests
    if remote and ffolder then
        for _,z in pairs(ffolder:GetChildren()) do
            if z:IsA("NumberValue") and z.Value == 0 then
                remote:FireServer(z.Name)
            end
        end
    end
end)

local sCustom = main:AddRightGroupbox("Custom")

sCustom:AddInput("xWS", {
    Default = 16,
    Numeric = true,
    Finished = true,

    Text = "Walk Speed",
    Tooltip = "custom walk speed",
    Placeholder = "number only",
})
Options["xWS"]:OnChanged(function()
    if lp:FindFirstChild("Upgrades") and lp["Upgrades"]:FindFirstChild("WalkSpeed") then
        local NumberValue = lp["Upgrades"]:FindFirstChild("WalkSpeed")
        local num = (tonumber(Options["xWS"].Value) - 24)
        NumberValue.Value = tonumber(num)
    end
end)

sCustom:AddInput("xStorage", {
    Default = tonumber(lp.Data["MaxStorage"].Value),
    Numeric = true,
    Finished = true,

    Text = "Pet Storage",
    Tooltip = "custom pet storage",
    Placeholder = "number only",
})
Options["xStorage"]:OnChanged(function()
    local maxstorage = lp.Data.MaxStorage;
    local petstorage = lp.Upgrades.PetStorage;
    local num = Options["xStorage"].Value;
    if maxstorage and petstorage then
        maxstorage.Value = tonumber(num); petstorage.Value = tonumber(num);
    end
end)

sCustom:AddInput("xEquip", {
    Default = tonumber(lp.Data["MaxEquip"].Value),
    Numeric = true,
    Finished = true,

    Text = "Pet Equip",
    Tooltip = "custom pet equip",
    Placeholder = "number only",
})
Options["xEquip"]:OnChanged(function()
    local maxEq = lp.Data.MaxEquip;
    local petEq = lp.Upgrades.PetEquip;
    local num = Options["xEquip"].Value;
    if maxEq and petEq then
        maxEq.Value = tonumber(num); petEq.Value = tonumber(num);
    end
end)
sCustom:AddLabel("^ only show 3 pet but it working")

local xEgg = main:AddRightGroupbox("Egg")

xEgg:AddDropdown("xSelectedEgg", {
    Values = {
        "Basic",
        "Mythic",
        "Forest",
        "Beach",
        "Atlantis",
        "Desert",
        "Winter",
        "Volcano",
        "Magma",
        "Moon",
        "Cyber",
        "Magic",
        "Heaven",
        "Nuclear",
        "Void",
        "Spooky",
        "Cave",
        "Steampunk",
        "Hell",
    },
    Default = 1,
    Multi = false,
    Text = "Select Egg",
    Tooltip = nil,
})

xEgg:AddDropdown("xType", {
    Values = {"Single","Triple"},
    Default = 1,
    Multi = false,
    Text = "Select Type",
    Tooltip = nil,
})

do
    local Remote = game:GetService("ReplicatedStorage").Functions.Unbox
    xEgg:AddButton("Buy once", function()
        if Remote then
            local Egg = tostring(Options["xSelectedEgg"].Value)
            local Type = tostring(Options["xType"].Value)
            Remote:InvokeServer(Egg, Type)
        end
    end)

    xEgg:AddToggle("xAutoBuy", {
        Text = 'Auto buy',
        Default = false,
        Tooltip = nil,
    })
    Toggles["xAutoBuy"]:OnChanged(function()
        spawn(function()
            while wait(.1) do
                if Toggles["xAutoBuy"].Value == false then break; end
                local Egg = tostring(Options["xSelectedEgg"].Value)
                local Type = tostring(Options["xType"].Value)
                Remote:InvokeServer(Egg, Type)
            end
        end)
    end)
end

local misc = other:AddLeftGroupbox("Misc")
misc:AddInput("cNameTag", {
    Default = tostring(lp.Name),
    Numeric = false,
    Finished = true,

    Text = "Custom nametag",
    Tooltip = "custom name tag",
    Placeholder = "whatever u want",
})
Options["cNameTag"]:OnChanged(function()
    local lp_Head = lp.Character.Head
    local Tag;
    if lp.Character ~= nil and lp_Head then
        Tag = lp_Head:FindFirstChild("Rank")["PlayerName"]
        if Tag then
            Tag.Text = Options["cNameTag"].Value
        end
    end
end)

misc:AddButton("Show/Hide nametag", function()
    local lp_Head = lp.Character.Head
    local Tag;
    if lp.Character ~= nil and lp_Head then
        Tag = lp_Head:FindFirstChild("Rank")["PlayerName"]
        if Tag then
            if Tag.Visible == true then
                Tag.Visible = false;
            else
                Tag.Visible = true;
            end
        end
    end
end)

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

-- i guess they have or working on anti-cheat in server-side ( i didn't found any can ban u or whatelse in dex )
if lp.Data:FindFirstChild("Banned") then
    lp.Data:FindFirstChild("Banned"):Destroy()
end

-- print something
if identifyexecutor then
    print("Hi "..identify().." User!")
end
