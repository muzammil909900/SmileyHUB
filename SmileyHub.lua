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
