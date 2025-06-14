-- FINAL CLEAN FIX - ONLY Chat Spam Fixed, Others Removed
-- By Smiley_Gamerz

local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield", true))()
local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")
local LocalPlayer = Players.LocalPlayer

local Window = Rayfield:CreateWindow({
    Name = "Infinite Yield Rebuild",
    LoadingTitle = "Stripped Version",
    LoadingSubtitle = "Only Chat Fixed",
    Theme = "DarkBlue",
    ToggleUIKeybind = Enum.KeyCode.RightControl
})

local UtilityTab = Window:CreateTab("Utility", 6031280882)

-- ✅ Chat Spam Fully Working
local ChatMessage = "Hello!"
local ChatDelay = 2

UtilityTab:CreateInput({
    Name = "Chat Message",
    PlaceholderText = "Message to spam",
    Callback = function(v)
        ChatMessage = v
    end
})

UtilityTab:CreateSlider({
    Name = "Chat Delay",
    Range = {1, 10},
    Increment = 1,
    CurrentValue = 2,
    Callback = function(v)
        ChatDelay = v
    end
})

UtilityTab:CreateToggle({
    Name = "Enable Chat Spam",
    CurrentValue = false,
    Description = "Loops colorful system messages",
    Callback = function(state)
        _G.ChatSpam = state
        task.spawn(function()
            while _G.ChatSpam do
                StarterGui:SetCore("ChatMakeSystemMessage", {
                    Text = ChatMessage,
                    Color = Color3.fromRGB(math.random(100,255), math.random(100,255), math.random(100,255)),
                    Font = Enum.Font.SourceSansBold
                })
                task.wait(ChatDelay)
            end
        end)
    end
})

-- ❗ All other unstable features removed. Safe base rebuilt. Add more when ready.
