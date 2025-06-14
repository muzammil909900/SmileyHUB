-- Infinite Yield Rebuild — Rayfield UI Edition
-- Fixed Fly | All Commands Functional Core

local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield", true))()

local Window = Rayfield:CreateWindow({
    Name = "Infinite Yield Rebuild",
    LoadingTitle = "Loading All Features...",
    LoadingSubtitle = "Powered by Rayfield UI",
    Theme = "DarkBlue",
    ToggleUIKeybind = Enum.KeyCode.RightControl
})

-- Tabs
local MovementTab = Window:CreateTab("Movement", 4483362458)
local PlayerTab = Window:CreateTab("Player", 9219179595)
local ServerTab = Window:CreateTab("Server", 6035047409)
local TeleportTab = Window:CreateTab("Teleport", 6035196984)
local UtilityTab = Window:CreateTab("Utility", 6031280882)
local FunTab = Window:CreateTab("Fun", 4483361897)

-- Fly Script (Working Implementation)
MovementTab:CreateToggle({
    Name = "Fly",
    CurrentValue = false,
    Description = "Toggle Fly Mode (WASD to move)",
    Callback = function(on)
        if on then
            local Player = game.Players.LocalPlayer
            local Character = Player.Character or Player.CharacterAdded:Wait()
            local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")

            local BodyGyro = Instance.new("BodyGyro")
            local BodyVelocity = Instance.new("BodyVelocity")
            BodyGyro.P = 9e4
            BodyGyro.maxTorque = Vector3.new(9e9, 9e9, 9e9)
            BodyGyro.cframe = HumanoidRootPart.CFrame
            BodyGyro.Parent = HumanoidRootPart

            BodyVelocity.velocity = Vector3.new(0, 0, 0)
            BodyVelocity.maxForce = Vector3.new(9e9, 9e9, 9e9)
            BodyVelocity.Parent = HumanoidRootPart

            local UIS = game:GetService("UserInputService")
            local flying = true
            local speed = 50
            local direction = Vector3.zero

            local function updateVelocity()
                local cam = workspace.CurrentCamera.CFrame
                local moveDir = Vector3.zero
                if UIS:IsKeyDown(Enum.KeyCode.W) then moveDir = moveDir + cam.LookVector end
                if UIS:IsKeyDown(Enum.KeyCode.S) then moveDir = moveDir - cam.LookVector end
                if UIS:IsKeyDown(Enum.KeyCode.A) then moveDir = moveDir - cam.RightVector end
                if UIS:IsKeyDown(Enum.KeyCode.D) then moveDir = moveDir + cam.RightVector end
                if UIS:IsKeyDown(Enum.KeyCode.Space) then moveDir = moveDir + cam.UpVector end
                if UIS:IsKeyDown(Enum.KeyCode.LeftShift) then moveDir = moveDir - cam.UpVector end
                BodyVelocity.Velocity = moveDir.Unit * speed
                BodyGyro.CFrame = cam
            end

            _G.FlyConnection = game:GetService("RunService").RenderStepped:Connect(function()
                if flying then updateVelocity() end
            end)
        else
            if _G.FlyConnection then _G.FlyConnection:Disconnect() end
            local root = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            if root then
                if root:FindFirstChildOfClass("BodyGyro") then root:FindFirstChildOfClass("BodyGyro"):Destroy() end
                if root:FindFirstChildOfClass("BodyVelocity") then root:FindFirstChildOfClass("BodyVelocity"):Destroy() end
            end
        end
    end
})

-- Add Core Commands Below

-- MOVEMENT
MovementTab:CreateToggle({
    Name = "Noclip",
    CurrentValue = false,
    Description = "Walk through walls and objects.",
    Callback = function(state)
        _G.Noclip = state
        local plr = game.Players.LocalPlayer
        game:GetService("RunService").Stepped:Connect(function()
            if _G.Noclip and plr.Character then
                for _, v in pairs(plr.Character:GetDescendants()) do
                    if v:IsA("BasePart") then
                        v.CanCollide = false
                    end
                end
            end
        end)
    end
})

-- PLAYER TAB
PlayerTab:CreateButton({
    Name = "Anti-Ragdoll",
    Description = "Removes ragdoll parts from your character.",
    Callback = function()
        for _, v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
            if v:IsA("JointInstance") or v:IsA("BallSocketConstraint") then
                v:Destroy()
            end
        end
    end
})

-- FUN TAB
FunTab:CreateButton({
    Name = "Flash",
    Description = "Rapidly changes screen brightness to flash",
    Callback = function()
        for i = 1, 5 do
            game.Lighting.Brightness = 10
            wait(0.1)
            game.Lighting.Brightness = 1
            wait(0.1)
        end
    end
})

-- VISUAL TAB
local VisualTab = Window:CreateTab("Visual", 6031075931)
VisualTab:CreateToggle({
    Name = "ESP Boxes",
    CurrentValue = false,
    Description = "Show red boxes on other players",
    Callback = function(v)
        if v then
            for _, plr in pairs(game.Players:GetPlayers()) do
                if plr ~= game.Players.LocalPlayer and plr.Character then
                    local box = Instance.new("BoxHandleAdornment")
                    box.Name = "ESPBox"
                    box.Adornee = plr.Character:FindFirstChild("HumanoidRootPart")
                    box.AlwaysOnTop = true
                    box.ZIndex = 5
                    box.Size = Vector3.new(4,6,1)
                    box.Color3 = Color3.new(1,0,0)
                    box.Transparency = 0.4
                    box.Parent = plr.Character
                end
            end
        else
            for _, plr in pairs(game.Players:GetPlayers()) do
                if plr.Character then
                    local b = plr.Character:FindFirstChild("ESPBox")
                    if b then b:Destroy() end
                end
            end
        end
    end
})

-- UTILITY TAB
UtilityTab:CreateInput({
    Name = "Chat Spammer",
    PlaceholderText = "Type message to auto spam",
    RemoveTextAfterFocusLost = false,
    Callback = function(text)
        _G.ChatSpamMessage = text
    end
})

UtilityTab:CreateSlider({
    Name = "Chat Spam Delay",
    Range = {1, 10},
    Increment = 1,
    CurrentValue = 2,
    Description = "Time between messages",
    Callback = function(v)
        _G.ChatDelay = v
    end
})

UtilityTab:CreateToggle({
    Name = "Enable Chat Spam",
    CurrentValue = false,
    Description = "Send chat messages repeatedly",
    Callback = function(state)
        _G.ChatSpamming = state
        while _G.ChatSpamming do
            if _G.ChatSpamMessage and _G.ChatSpamMessage ~= "" then
                game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer(_G.ChatSpamMessage, "All")
            end
            task.wait(_G.ChatDelay or 2)
        end
    end
})

-- PLAYER TAB
PlayerTab:CreateButton({
    Name = "BTools",
    Description = "Gives Building Tools (FE limited)",
    Callback = function()
        for i = 2, 4 do
            local tool = Instance.new("HopperBin")
            tool.BinType = i
            tool.Parent = game.Players.LocalPlayer.Backpack
        end
    end
})

-- MOVEMENT
MovementTab:CreateButton({
    Name = "Float",
    Description = "Float in midair with a BodyPosition",
    Callback = function()
        local root = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if root then
            local bp = Instance.new("BodyPosition", root)
            bp.Position = root.Position + Vector3.new(0, 20, 0)
            bp.MaxForce = Vector3.new(1e6, 1e6, 1e6)
            bp.P = 5000
        end
    end
})

-- SERVER
ServerTab:CreateButton({
    Name = "Crash Client",
    Description = "Crashes your own client (simulated lag)",
    Callback = function()
        while true do end
    end
})

-- TELEPORT TAB COMMANDS

TeleportTab:CreateButton({
    Name = "Teleport Tool",
    Description = "Gives you a tool to click-teleport anywhere.",
    Callback = function()
        local tool = Instance.new("Tool")
        tool.RequiresHandle = false
        tool.Name = "TP Tool"
        tool.Activated:Connect(function()
            local mouse = game.Players.LocalPlayer:GetMouse()
            if mouse then
                local char = game.Players.LocalPlayer.Character
                if char and char:FindFirstChild("HumanoidRootPart") then
                    char:FindFirstChild("HumanoidRootPart").CFrame = CFrame.new(mouse.Hit.Position + Vector3.new(0, 3, 0))
                end
            end
        end)
        tool.Parent = game.Players.LocalPlayer.Backpack
    end
})
TeleportTab:CreateButton({
    Name = "Goto Nearest Player",
    Description = "Teleport to the closest player in the game.",
    Callback = function()
        local lp = game.Players.LocalPlayer
        local hrp = lp.Character and lp.Character:FindFirstChild("HumanoidRootPart")
        local closest, dist = nil, math.huge
        for _, p in pairs(game.Players:GetPlayers()) do
            if p ~= lp and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                local d = (p.Character.HumanoidRootPart.Position - hrp.Position).Magnitude
                if d < dist then
                    dist = d
                    closest = p
                end
            end
        end
        if closest then
            hrp.CFrame = closest.Character.HumanoidRootPart.CFrame + Vector3.new(0, 3, 0)
        end
    end
})

TeleportTab:CreateButton({
    Name = "Bring All Players",
    Description = "Teleport all players to your position.",
    Callback = function()
        local lp = game.Players.LocalPlayer
        local root = lp.Character and lp.Character:FindFirstChild("HumanoidRootPart")
        if root then
            for _, p in pairs(game.Players:GetPlayers()) do
                if p ~= lp and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                    p.Character:PivotTo(root.CFrame + Vector3.new(0, 5, 0))
                end
            end
        end
    end
})

TeleportTab:CreateButton({
    Name = "Rejoin Server",
    Description = "Reconnect to this current game server.",
    Callback = function()
        local TeleportService = game:GetService("TeleportService")
        local Players = game:GetService("Players")
        TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, Players.LocalPlayer)
    end
})

-- FUN TAB EXTRA
FunTab:CreateToggle({
    Name = "Loop Kill Nearest Player",
    CurrentValue = false,
    Description = "Constantly kill the nearest player (can cause lag).",
    Callback = function(state)
        _G.LoopKill = state
        while _G.LoopKill do
            local lp = game.Players.LocalPlayer
            local char = lp.Character
            local hrp = char and char:FindFirstChild("HumanoidRootPart")
            local closest, dist = nil, math.huge
            for _, p in pairs(game.Players:GetPlayers()) do
                if p ~= lp and p.Character and p.Character:FindFirstChild("Humanoid") then
                    local d = (p.Character.HumanoidRootPart.Position - hrp.Position).Magnitude
                    if d < dist then
                        dist = d
                        closest = p
                    end
                end
            end
            if closest and closest.Character then
                closest.Character:BreakJoints()
            end
            task.wait(1)
        end
    end
})

FunTab:CreateInput({
    Name = "Play Sound ID",
    PlaceholderText = "Enter Roblox sound ID",
    RemoveTextAfterFocusLost = false,
    Callback = function(id)
        local s = Instance.new("Sound", game.Workspace)
        s.SoundId = "rbxassetid://" .. id
        s.Volume = 10
        s:Play()
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

MovementTab:CreateSlider({
    Name = "JumpPower",
    Range = {50, 300},
    Increment = 10,
    CurrentValue = 50,
    Description = "Adjust jump height",
    Callback = function(v)
        game.Players.LocalPlayer.Character.Humanoid.JumpPower = v
    end
})

PlayerTab:CreateButton({
    Name = "God Mode",
    Description = "Set Humanoid name to God for immortality",
    Callback = function()
        game.Players.LocalPlayer.Character.Humanoid.Name = "God"
    end
})

PlayerTab:CreateToggle({
    Name = "Invisible",
    CurrentValue = false,
    Description = "Toggle full invisibility",
    Callback = function(v)
        for _, p in ipairs(game.Players.LocalPlayer.Character:GetDescendants()) do
            if p:IsA("BasePart") or p:IsA("Decal") then
                p.Transparency = v and 1 or 0
            end
        end
    end
})

PlayerTab:CreateButton({
    Name = "Sit",
    Description = "Force your character to sit",
    Callback = function()
        game.Players.LocalPlayer.Character.Humanoid.Sit = true
    end
})

ServerTab:CreateButton({
    Name = "Reset Character",
    Description = "Break joints to reset your character",
    Callback = function()
        game.Players.LocalPlayer.Character:BreakJoints()
    end
})

UtilityTab:CreateButton({
    Name = "Load Infinite Yield",
    Description = "Execute the full Infinite Yield command bar",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
    end
})

FunTab:CreateButton({
    Name = "Explode Yourself",
    Description = "Create an explosion at your position",
    Callback = function()
        local e = Instance.new("Explosion")
        e.Position = game.Players.LocalPlayer.Character:GetPrimaryPartCFrame().p
        e.BlastRadius = 10
        e.Parent = workspace
    end
})
