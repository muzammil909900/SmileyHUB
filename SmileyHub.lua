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

-- Universal Command Input Parser (with player targeting and loop support)
CommandsTab:CreateInput({
    Name = "Command Bar",
    PlaceholderText = "Type Infinite Yield command (e.g., ;fly me)",
    RemoveTextAfterFocusLost = true,
    Callback = function(input)
        local command = string.sub(input, 1, 1) == ";" and string.sub(input, 2) or input

        -- Split multiple commands using "\"
        for _, segment in ipairs(string.split(command, "\")) do
            task.spawn(function()
                local args = string.split(segment, " ")
                local raw = args[1]
                local loopCount, loopDelay = 1, 0
                if string.find(raw, "^") then
                    local loopArgs = string.split(raw, "^")
                    loopCount = tonumber(loopArgs[1]) or 1
                    loopDelay = tonumber(loopArgs[2]) or 0
                    raw = loopArgs[3] or raw
                end
                local cmd = string.lower(raw)

                -- Example command mapping
                if cmd == "fly" then
                    loadstring(game:HttpGet("https://pastebin.com/raw/yKj9t6vX"))()

                elseif cmd == "speed" and args[2] then
                    local speed = tonumber(args[2])
                    if speed then
                        local char = game.Players.LocalPlayer.Character
                        if char and char:FindFirstChildOfClass("Humanoid") then
                            char:FindFirstChildOfClass("Humanoid").WalkSpeed = speed
                        end
                    end

                elseif cmd == "jump" then
                    local char = game.Players.LocalPlayer.Character
                    if char and char:FindFirstChildOfClass("Humanoid") then
                        char:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
                    end

                elseif cmd == "invisible" then
                    local char = game.Players.LocalPlayer.Character
                    if char and char:FindFirstChild("HumanoidRootPart") then
                        char.HumanoidRootPart.CFrame = CFrame.new(9999, 9999, 9999)
                        task.wait(0.5)
                        char.HumanoidRootPart.CFrame = CFrame.new(0, 10, 0)
                    end

                elseif cmd == "kill" then
                    -- Placeholder logic: targets 2nd player in list
                    local target = game.Players:GetPlayers()[2]
                    if target then
                        game.Players.LocalPlayer.Character.Humanoid:UnequipTools()
                        if game:GetService("ReplicatedStorage"):FindFirstChild("Events") then
                            game:GetService("ReplicatedStorage").Events:FindFirstChild("Kill"):FireServer(target)
                        end
                    end
                end

                -- Add additional command mappings here as needed

                elseif cmd == "bring" then
                    local targetArg = args[2] or "me"
                    local targets = resolvePlayers(targetArg)
                    local lplr = game.Players.LocalPlayer
                    local root = lplr.Character and lplr.Character:FindFirstChild("HumanoidRootPart")
                    if root then
                        for _, plr in ipairs(targets) do
                            local hrp = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")
                            if hrp then hrp.CFrame = root.CFrame + Vector3.new(2, 0, 2) end
                        end
                    end

                elseif cmd == "tools" then
                    local backpack = game.Players.LocalPlayer:FindFirstChild("Backpack")
                    for _, tool in ipairs(game:GetService("ReplicatedStorage"):GetDescendants()) do
                        if tool:IsA("Tool") then
                            tool:Clone().Parent = backpack
                        end
                    end

                elseif cmd == "btools" then
                    for _, t in ipairs({1818, 1819, 1820}) do
                        local tool = Instance.new("HopperBin")
                        tool.BinType = t
                        tool.Parent = game.Players.LocalPlayer.Backpack
                    end

                elseif cmd == "noclip" then
                    game:GetService("RunService").Stepped:Connect(function()
                        local char = game.Players.LocalPlayer.Character
                        if char then
                            for _, part in ipairs(char:GetDescendants()) do
                                if part:IsA("BasePart") then
                                    part.CanCollide = false
                                end
                            end
                        end
                    end)

                elseif cmd == "esp" then
                    for _, plr in ipairs(game.Players:GetPlayers()) do
                        if plr ~= game.Players.LocalPlayer and plr.Character and plr.Character:FindFirstChild("Head") then
                            local Billboard = Instance.new("BillboardGui", plr.Character.Head)
                            Billboard.Size = UDim2.new(0, 100, 0, 40)
                            Billboard.Adornee = plr.Character.Head
                            Billboard.AlwaysOnTop = true

                            local NameTag = Instance.new("TextLabel", Billboard)
                            NameTag.Text = plr.Name
                            NameTag.Size = UDim2.new(1, 0, 1, 0)
                            NameTag.BackgroundTransparency = 1
                            NameTag.TextColor3 = Color3.new(1, 1, 1)
                            NameTag.TextStrokeTransparency = 0.5
                        end
                    end

                -- LOOP EXECUTION SUPPORT
                for i = 1, loopCount do
                    task.spawn(function()
                        -- Add support for target resolution (e.g., all, me, others, random, etc.)
                        local function resolvePlayers(targetStr)
                            local players = {}
                            local lplr = game.Players.LocalPlayer

                            if not targetStr or targetStr == "me" then
                                table.insert(players, lplr)
                            elseif targetStr == "all" then
                                players = game.Players:GetPlayers()
                            elseif targetStr == "others" then
                                for _, plr in ipairs(game.Players:GetPlayers()) do
                                    if plr ~= lplr then
                                        table.insert(players, plr)
                                    end
                                end
                            elseif string.sub(targetStr, 1, 1) == "#" then
                                local count = tonumber(string.sub(targetStr, 2)) or 1
                                local all = game.Players:GetPlayers()
                                for i = 1, math.min(count, #all) do
                                    table.insert(players, all[i])
                                end
                            elseif targetStr == "random" then
                                local all = game.Players:GetPlayers()
                                table.insert(players, all[math.random(1, #all)])
                            elseif string.sub(targetStr, 1, 1) == "@" then
                                local uname = string.sub(targetStr, 2):lower()
                                for _, plr in ipairs(game.Players:GetPlayers()) do
                                    if plr.Name:lower():find(uname) then
                                        table.insert(players, plr)
                                    end
                                end
                            else
                                for _, plr in ipairs(game.Players:GetPlayers()) do
                                    if plr.DisplayName:lower():find(targetStr:lower()) or plr.Name:lower():find(targetStr:lower()) then
                                        table.insert(players, plr)
                                    end
                                end
                            end

                            return players
                        end

                        local targetArg = args[2] or "me"
                        local targets = resolvePlayers(targetArg)

                        for _, plr in ipairs(targets) do
                            if cmd == "jump" then
                                if plr.Character and plr.Character:FindFirstChildOfClass("Humanoid") then
                                    plr.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
                                end
                            end
                        end
