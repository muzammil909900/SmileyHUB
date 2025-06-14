-- FINAL FIX — Rayfield Infinite Yield Rebuild (Chat + Goto + Annoy)
-- By Smiley_Gamerz | All errors fixed

local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield", true))()
local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")
local LocalPlayer = Players.LocalPlayer

local Window = Rayfield:CreateWindow({
    Name = "Infinite Yield Rebuild",
    LoadingTitle = "Stabilizing Chat + Goto + Annoy...",
    LoadingSubtitle = "Fixed vFinal",
    Theme = "DarkBlue",
    ToggleUIKeybind = Enum.KeyCode.RightControl
})

local TeleportTab = Window:CreateTab("Teleport", 6035196984)
local PlayerTab = Window:CreateTab("Player", 9219179595)
local FunTab = Window:CreateTab("Fun", 4483361897)
local UtilityTab = Window:CreateTab("Utility", 6031280882)

-- GOTO PLAYER FIXED
local selectedPlayer = nil
local function getPlayerNames()
    local names = {}
    for _, p in ipairs(Players:GetPlayers()) do table.insert(names, p.Name) end
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
        local target = Players:FindFirstChild(selectedPlayer)
        if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
            LocalPlayer.Character.HumanoidRootPart.CFrame = target.Character.HumanoidRootPart.CFrame + Vector3.new(0, 3, 0)
        else
            StarterGui:SetCore("ChatMakeSystemMessage", {
                Text = "⚠️ Target player not valid or not loaded.",
                Color = Color3.fromRGB(255, 75, 75)
            })
        end
    end
})

TeleportTab:CreateButton({
    Name = "🔁 Refresh Player List",
    Callback = function()
        dropdown:SetOptions(getPlayerNames())
        StarterGui:SetCore("ChatMakeSystemMessage", {
            Text = "🔁 Player list refreshed!",
            Color = Color3.fromRGB(100, 255, 100)
        })
    end
})

-- CHAT SPAM FIXED
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
    Description = "Loops system messages as spam",
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

-- RAINBOW CHAT FIXED
FunTab:CreateToggle({
    Name = "Rainbow Chat",
    CurrentValue = false,
    Description = "Loop colorful system chat messages",
    Callback = function(state)
        _G.RainbowChat = state
        local colors = {
            Color3.fromRGB(255, 0, 0),
            Color3.fromRGB(255, 128, 0),
            Color3.fromRGB(255, 255, 0),
            Color3.fromRGB(0, 255, 0),
            Color3.fromRGB(0, 170, 255),
            Color3.fromRGB(128, 0, 255)
        }
        task.spawn(function()
            while _G.RainbowChat do
                for _, c in ipairs(colors) do
                    if not _G.RainbowChat then break end
                    StarterGui:SetCore("ChatMakeSystemMessage", {
                        Text = "🌈 Rainbow Mode!",
                        Color = c,
                        Font = Enum.Font.GothamBold
                    })
                    task.wait(0.4)
                end
            end
        end)
    end
})

-- ANNOY FIXED
FunTab:CreateToggle({
    Name = "Annoy Random Player",
    CurrentValue = false,
    Description = "Force sit random player on loop",
    Callback = function(state)
        _G.AnnoyLoop = state
        task.spawn(function()
            while _G.AnnoyLoop do
                local valid = {}
                for _, p in ipairs(Players:GetPlayers()) do
                    if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("Humanoid") then
                        table.insert(valid, p)
                    end
                end
                if #valid > 0 then
                    local pick = valid[math.random(1, #valid)]
                    pcall(function()
                        pick.Character.Humanoid.Sit = true
                    end)
                end
                task.wait(1.5)
            end
        end)
    end
})
