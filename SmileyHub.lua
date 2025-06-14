
-- Infinite Yield Rebuild - Rayfield UI Edition
local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield", true))()

local Window = Rayfield:CreateWindow({
    Name = "Infinite Yield Rebuild",
    LoadingTitle = "Loading All Features...",
    LoadingSubtitle = "Powered by Rayfield UI",
    Theme = "DarkBlue",
    ToggleUIKeybind = Enum.KeyCode.RightControl
})

-- Movement Tab
local MovementTab = Window:CreateTab("Movement", 4483362458)

MovementTab:CreateToggle({
    Name = "Fly",
    CurrentValue = false,
    Description = "Toggle fly mode (WASD movement)",
    Callback = function(on)
        if on then
            loadstring(game:HttpGet("https://pastebin.com/raw/xj3yTQ2R"))()
        end
    end
})

MovementTab:CreateSlider({
    Name = "WalkSpeed",
    Range = {16, 300},
    Increment = 5,
    CurrentValue = 16,
    Description = "Adjust your movement speed",
    Callback = function(v)
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = v
    end
})

-- Add more features...
