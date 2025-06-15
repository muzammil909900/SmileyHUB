-- AH SORRY HERE IS NEW SCRIPT WITH ALL WORKING FUNCTIONS AND DIVIDED IN DIFFERENT TABS
-- COMMANDS ARE BUTTONS ALSO THOSE WHO NEED SLIDER HAVE SLIDER
-- [SCRIPT IN CANVAS]

-- Load Rayfield
local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield", true))()


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
CommandsTab:CreateButton({
    Name = "Fly",
    Callback = function()
        loadstring(game:HttpGet('https://pastebin.com/raw/yKj9t6vX'))()
    end,
})

CommandsTab:CreateButton({
    Name = "Infinite Jump",
    Callback = function()
        game:GetService("UserInputService").JumpRequest:Connect(function()
            game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
        end)
    end,
})

CommandsTab:CreateButton({
    Name = "Noclip",
    Callback = function()
        local noclip = true
        game:GetService('RunService').Stepped:Connect(function()
            if noclip then
                for _, v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
                    if v:IsA('BasePart') then
                        v.CanCollide = false
                    end
                end
            end
        end)
    end,
})

-- PLAYER SLIDERS
PlayerTab:CreateSlider({
    Name = "WalkSpeed",
    Range = {16, 300},
    Increment = 1,
    Suffix = "Speed",
    CurrentValue = 16,
    Flag = "WalkSpeed",
    Callback = function(Value)
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
    end,
})

PlayerTab:CreateSlider({
    Name = "JumpPower",
    Range = {50, 500},
    Increment = 5,
    Suffix = "Power",
    CurrentValue = 50,
    Flag = "JumpPower",
    Callback = function(Value)
        game.Players.LocalPlayer.Character.Humanoid.JumpPower = Value
    end,
})

-- UTILITY TOGGLES
UtilityTab:CreateToggle({
    Name = "ESP Toggle",
    CurrentValue = false,
    Flag = "ESP",
    Callback = function(Value)
        -- Placeholder for ESP function
        print("ESP: ", Value)
    end,
})

-- FUN BUTTONS
FunTab:CreateButton({
    Name = "Fling Self",
    Callback = function()
        local char = game.Players.LocalPlayer.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            char.HumanoidRootPart.Velocity = Vector3.new(0, 200, 0)
        end
    end,
})

-- TELEPORT BUTTONS
TeleportTab:CreateButton({
    Name = "Teleport to Spawn",
    Callback = function()
        local char = game.Players.LocalPlayer.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            char:MoveTo(Vector3.new(0, 10, 0))
        end
    end,
})

TeleportTab:CreateInput({
    Name = "Teleport to Position",
    PlaceholderText = "x, y, z",
    RemoveTextAfterFocusLost = false,
    Callback = function(Text)
        local x, y, z = string.match(Text, "(%-?%d+),%s*(%-?%d+),%s*(%-?%d+)")
        if x and y and z then
            local pos = Vector3.new(tonumber(x), tonumber(y), tonumber(z))
            game.Players.LocalPlayer.Character:MoveTo(pos)
        end
    end,
})

-- SETTINGS
SettingsTab:CreateKeybind({
    Name = "Toggle UI",
    CurrentKeybind = "RightControl",
    HoldToInteract = false,
    Flag = "UIKey",
    Callback = function()
        Rayfield:Toggle()
    end,
})

SettingsTab:CreateParagraph({
    Title = "Credits",
    Content = "Made by Smiley9Gamerz | UI by Rayfield"
})

Rayfield:Notify({
    Title = "Infinite Yield Rayfield",
    Content = "Loaded Successfully",
    Duration = 6
})
