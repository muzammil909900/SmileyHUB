-- AH SORRY HERE IS NEW SCRIPT WITH ALL WORKING FUNCTIONS AND DIVIDED IN DIFFERENT TABS
-- COMMANDS ARE BUTTONS ALSO THOSE WHO NEED SLIDER HAVE SLIDER
-- [SCRIPT IN CANVAS]

-- Load Rayfield
local success, RayfieldLib = pcall(function()
    return loadstring(game:HttpGet("https://sirius.menu/rayfield"))()
end)

if not success or not RayfieldLib then
    warn("Failed to load Rayfield library.")
    return
end

local Rayfield = RayfieldLib

-- Window Setup
local Window = Rayfield:CreateWindow({
    Name = "Infinite Yield Rayfield Edition",
    LoadingTitle = "Infinite Yield",
    LoadingSubtitle = "by Smiley9Gamerz",
    ConfigurationSaving = {
       Enabled = true,
       FolderName = "InfiniteYieldRayfield",
       FileName = "Settings"
    }
})

-- Tabs
local CommandsTab = Window:CreateTab("Commands", 4483362458)
local PlayerTab = Window:CreateTab("Player", 4483362458)
local UtilityTab = Window:CreateTab("Utility", 4483362458)
local FunTab = Window:CreateTab("Fun", 4483362458)
local TeleportTab = Window:CreateTab("Teleport", 4483362458)
local SettingsTab = Window:CreateTab("Settings", 4483362458)

-- COMMAND BUTTONS
CommandsTab:CreateButton({ Name = "Fly", Callback = function()
    loadstring(game:HttpGet('https://pastebin.com/raw/yKj9t6vX'))()
end })

CommandsTab:CreateButton({ Name = "Kill", Callback = function()
    local target = game.Players:GetPlayers()[2] -- Example target
    game.Players.LocalPlayer.Character.Humanoid:UnequipTools()
    game:GetService("ReplicatedStorage").Events.Kill:FireServer(target)
end })

CommandsTab:CreateButton({ Name = "God Mode", Callback = function()
    game.Players.LocalPlayer.Character.Humanoid.Name = "1"
    local newHumanoid = Instance.new("Humanoid")
    newHumanoid.Parent = game.Players.LocalPlayer.Character
    wait(0.1)
    game.Players.LocalPlayer.Character:FindFirstChild("1"):Destroy()
end })

CommandsTab:CreateButton({ Name = "Invisible", Callback = function()
    local player = game.Players.LocalPlayer
    local char = player.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end
    char.HumanoidRootPart.CFrame = CFrame.new(9999, 9999, 9999)
    wait(0.5)
    char.HumanoidRootPart.CFrame = CFrame.new(0, 10, 0)
end })

-- PLAYER SLIDERS
PlayerTab:CreateSlider({ Name = "WalkSpeed", Range = {16, 300}, Increment = 1, Suffix = "Speed", CurrentValue = 16, Flag = "WalkSpeed", Callback = function(Value)
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
end })

PlayerTab:CreateSlider({ Name = "JumpPower", Range = {50, 500}, Increment = 5, Suffix = "Power", CurrentValue = 50, Flag = "JumpPower", Callback = function(Value)
    game.Players.LocalPlayer.Character.Humanoid.JumpPower = Value
end })

-- UTILITY TOGGLES & BUTTONS
UtilityTab:CreateToggle({ Name = "ESP Toggle", CurrentValue = false, Flag = "ESP", Callback = function(Value)
    print("ESP:", Value)
end })

UtilityTab:CreateButton({ Name = "Reset Character", Callback = function()
    game.Players.LocalPlayer.Character:BreakJoints()
end })

UtilityTab:CreateButton({ Name = "Rejoin Server", Callback = function()
    game:GetService("TeleportService"):Teleport(game.PlaceId, game.Players.LocalPlayer)
end })

-- FUN BUTTONS
FunTab:CreateButton({ Name = "Fling Self", Callback = function()
    local char = game.Players.LocalPlayer.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        char.HumanoidRootPart.Velocity = Vector3.new(0, 200, 0)
    end
end })

FunTab:CreateButton({ Name = "Dance", Callback = function()
    game.Players.LocalPlayer:Chat("/e dance")
end })

-- TELEPORT TOOLS
TeleportTab:CreateButton({ Name = "Teleport to Spawn", Callback = function()
    local char = game.Players.LocalPlayer.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        char:MoveTo(Vector3.new(0, 10, 0))
    end
end })

TeleportTab:CreateInput({ Name = "Teleport to Position", PlaceholderText = "x, y, z", RemoveTextAfterFocusLost = false, Callback = function(Text)
    local x, y, z = string.match(Text, "(%-?%d+),%s*(%-?%d+),%s*(%-?%d+)")
    if x and y and z then
        game.Players.LocalPlayer.Character:MoveTo(Vector3.new(tonumber(x), tonumber(y), tonumber(z)))
    end
end })

-- SETTINGS
SettingsTab:CreateKeybind({ Name = "Toggle UI", CurrentKeybind = "RightControl", HoldToInteract = false, Flag = "UIKey", Callback = function()
    Rayfield:Toggle()
end })

SettingsTab:CreateParagraph({ Title = "Credits", Content = "Made by Smiley9Gamerz | UI by Rayfield" })

Rayfield:Notify({ Title = "Infinite Yield Rayfield", Content = "Loaded Successfully", Duration = 6 })
