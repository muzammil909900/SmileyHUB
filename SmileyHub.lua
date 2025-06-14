-- FIXED Infinite Yield Rayfield UI — Finalized Corrections
-- Author: Smiley_Gamerz
-- Fixes: Dropdown Goto, Rainbow Chat, Chat Spam, Annoy Player (now functional)

local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield", true))()
local Window = Rayfield:CreateWindow({
    Name = "Infinite Yield Rebuild",
    LoadingTitle = "Final Fixes Loaded",
    LoadingSubtitle = "v1.0 Stable",
    Theme = "DarkBlue",
    ToggleUIKeybind = Enum.KeyCode.RightControl
})

-- Tabs
local TeleportTab = Window:CreateTab("Teleport", 6035196984)
local PlayerTab = Window:CreateTab("Player", 9219179595)
local FunTab = Window:CreateTab("Fun", 4483361897)
local UtilityTab = Window:CreateTab("Utility", 6031280882)

-- Goto: Live Dropdown + Working Sync
local selectedPlayer = nil
local function getPlayerNames()
    local names = {}
    for _, p in ipairs(game.Players:GetPlayers()) do
        table.insert(names, p.Name)
    end
    return names
end

local dropdown = TeleportTab:CreateDropdown({
    Name = "Select Player",
    Options = getPlayerNames(),
    CurrentOption = "",
    Flag = "Select_Player",
    Description = "Choose player to teleport to",
    Callback = function(p)
        selectedPlayer = p
    end
})

TeleportTab:CreateButton({
    Name = "Goto Selected Player",
    Description = "Teleports to the selected player",
    Callback = function()
        local target = game.Players:FindFirstChild(selectedPlayer)
        if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
            game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart").CFrame = target.Character.HumanoidRootPart.CFrame + Vector3.new(0, 3, 0)
        end
    end
})

TeleportTab:CreateButton({
    Name = "🔁 Refresh Player List",
    Callback = function()
        dropdown:SetOptions(getPlayerNames())
    end
})

-- Chat Spam: Reliable State
local ChatMessage = "Spam Message"
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
    Description = "Loops message in public chat",
    Callback = function(state)
        _G.ChatSpam = state
        task.spawn(function()
            while _G.ChatSpam do
                game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer(ChatMessage, "All")
                task.wait(ChatDelay)
            end
        end)
    end
})

-- Rainbow Chat: Full Text Coloring
FunTab:CreateToggle({
    Name = "Rainbow Chat",
    CurrentValue = false,
    Description = "Cycles colorful chat text",
    Callback = function(state)
        _G.RainbowChat = state
        local colors = {"red", "orange", "yellow", "green", "blue", "purple"}
        task.spawn(function()
            while _G.RainbowChat do
                for _, c in ipairs(colors) do
                    if not _G.RainbowChat then break end
                    local msg = string.format("<font color=\"%s\">🌈 Rainbow!</font>", c)
                    game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer(msg, "All")
                    task.wait(0.4)
                end
            end
        end)
    end
})

-- Annoy: Valid Target Only
FunTab:CreateToggle({
    Name = "Annoy Random Player",
    CurrentValue = false,
    Callback = function(state)
        _G.Annoying = state
        task.spawn(function()
            while _G.Annoying do
                local pool = {}
                for _, p in pairs(game.Players:GetPlayers()) do
                    if p ~= game.Players.LocalPlayer and p.Character and p.Character:FindFirstChild("Humanoid") then
                        table.insert(pool, p)
                    end
                end
                if #pool > 0 then
                    local target = pool[math.random(1, #pool)]
                    target.Character.Humanoid.Sit = true
                end
                task.wait(1.2)
            end
        end)
    end
})
