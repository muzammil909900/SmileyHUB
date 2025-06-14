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

-- 🔁 Old Function Pack Restored

-- MOVEMENT TAB
local MovementTab = Window:CreateTab("Movement", 4483362458)

MovementTab:CreateSlider({
    Name = "WalkSpeed",
    Range = {16, 300},
    Increment = 5,
    CurrentValue = 16,
    Description = "Change character walkspeed",
    Callback = function(v)
        if LocalPlayer.Character then
            LocalPlayer.Character:FindFirstChildOfClass("Humanoid").WalkSpeed = v
        end
    end
})

MovementTab:CreateSlider({
    Name = "JumpPower",
    Range = {50, 300},
    Increment = 10,
    CurrentValue = 50,
    Description = "Change character jump power",
    Callback = function(v)
        if LocalPlayer.Character then
            LocalPlayer.Character:FindFirstChildOfClass("Humanoid").JumpPower = v
        end
    end
})

MovementTab:CreateToggle({
    Name = "Noclip",
    CurrentValue = false,
    Description = "Walk through walls (looped)",
    Callback = function(state)
        _G.Noclip = state
        game:GetService("RunService").Stepped:Connect(function()
            if _G.Noclip and LocalPlayer.Character then
                for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
            end
        end)
    end
})

-- PLAYER TAB
local PlayerTab = Window:CreateTab("Player", 9219179595)

PlayerTab:CreateButton({
    Name = "Sit",
    Description = "Force your character to sit",
    Callback = function()
        local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if hum then hum.Sit = true end
    end
})

PlayerTab:CreateButton({
    Name = "God Mode",
    Description = "Rename Humanoid to become invincible",
    Callback = function()
        local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid")
        if hum then hum.Name = "God" end
    end
})

PlayerTab:CreateButton({
    Name = "BTools",
    Description = "Gives building tools (client only)",
    Callback = function()
        for i = 2, 4 do
            local tool = Instance.new("HopperBin")
            tool.BinType = i
            tool.Parent = LocalPlayer.Backpack
        end
    end
})

-- TELEPORT TAB
local TeleportTab = Window:CreateTab("Teleport", 6035196984)

TeleportTab:CreateButton({
    Name = "Teleport Tool",
    Description = "Gives a click-to-teleport tool",
    Callback = function()
        local tool = Instance.new("Tool")
        tool.RequiresHandle = false
        tool.Name = "TP Tool"
        tool.Activated:Connect(function()
            local mouse = LocalPlayer:GetMouse()
            local char = LocalPlayer.Character
            if mouse and char and char:FindFirstChild("HumanoidRootPart") then
                char.HumanoidRootPart.CFrame = CFrame.new(mouse.Hit.Position + Vector3.new(0,3,0))
            end
        end)
        tool.Parent = LocalPlayer.Backpack
    end
})

TeleportTab:CreateButton({
    Name = "Rejoin Server",
    Description = "Reconnect to current server",
    Callback = function()
        game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId, LocalPlayer)
    end
})
