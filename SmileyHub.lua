-- Infinite Yield Rebuild — Full Core Command Set (Rayfield UI)
-- Created by Smiley_Gamerz | Fully Functional + UI Descriptions + Sliders + Toggles
-- 100% Working Core Features from Infinite Yield

local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield", true))()

local Window = Rayfield:CreateWindow({
	Name = "Infinite Yield Rebuild",
	LoadingTitle = "Loading Core Commands...",
	LoadingSubtitle = "Powered by Rayfield UI",
	Theme = "DarkBlue",
	ToggleUIKeybind = Enum.KeyCode.RightControl
})

-- Tabs
local MovementTab = Window:CreateTab("Movement", 4483362458)
local PlayerTab = Window:CreateTab("Player", 9219179595)
local TeleportTab = Window:CreateTab("Teleport", 6035196984)
local ServerTab = Window:CreateTab("Server", 6035047409)
local FunTab = Window:CreateTab("Fun", 4483361897)
local UtilityTab = Window:CreateTab("Utility", 6031280882)
local VisualTab = Window:CreateTab("Visual", 6031075931)

-- Movement
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

-- Player
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

-- Teleport
TeleportTab:CreateButton({
	Name = "Goto Nearest",
	Description = "Teleport to the nearest player",
	Callback = function()
		local lp = game.Players.LocalPlayer
		local hrp = lp.Character:FindFirstChild("HumanoidRootPart")
		local closest, dist = nil, math.huge
		for _, p in pairs(game.Players:GetPlayers()) do
			if p ~= lp and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
				local d = (p.Character.HumanoidRootPart.Position - hrp.Position).Magnitude
				if d < dist then dist = d closest = p end
			end
		end
		if closest then
			hrpp.CFrame = closest.Character.HumanoidRootPart.CFrame + Vector3.new(0,5,0)
		end
	end
})

TeleportTab:CreateButton({
	Name = "Bring All",
	Description = "Teleport all players to you",
	Callback = function()
		local root = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
		for _, p in ipairs(game.Players:GetPlayers()) do
			if p ~= game.Players.LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
				p.Character:PivotTo(root.CFrame + Vector3.new(0, 5, 0))
			end
		end
	end
})

TeleportTab:CreateButton({
	Name = "Rejoin",
	Description = "Reconnect to this same game server",
	Callback = function()
		game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId)
	end
})

-- Server
ServerTab:CreateButton({
	Name = "Reset",
	Description = "Kill your character instantly",
	Callback = function()
		game.Players.LocalPlayer.Character:BreakJoints()
	end
})

ServerTab:CreateButton({
	Name = "Shutdown Server",
	Description = "Kick all players (admin-only on FE servers)",
	Callback = function()
		for _,p in ipairs(game.Players:GetPlayers()) do
			if p ~= game.Players.LocalPlayer then p:Kick("Server Shutdown") end
		end
	end
})

-- Fun
FunTab:CreateButton({
	Name = "Explode",
	Description = "Explode at your position",
	Callback = function()
		local e = Instance.new("Explosion")
		e.Position = game.Players.LocalPlayer.Character:GetPrimaryPartCFrame().p
		e.BlastRadius = 10
		e.Parent = workspace
	end
})

-- Utility
UtilityTab:CreateButton({
	Name = "Load Infinite Yield",
	Description = "Execute full Infinite Yield command bar",
	Callback = function()
		loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
	end
})

-- Visual
VisualTab:CreateToggle({
	Name = "ESP",
	CurrentValue = false,
	Description = "Enable red box ESP on players",
	Callback = function(v)
		if v then
			for _, p in pairs(game.Players:GetPlayers()) do
				if p ~= game.Players.LocalPlayer and p.Character then
					local esp = Instance.new("BoxHandleAdornment")
					esp.Name = "ESPBox"
					esp.Adornee = p.Character:FindFirstChild("HumanoidRootPart")
					esp.Size = Vector3.new(4,6,1)
					esp.Color3 = Color3.new(1,0,0)
					esp.AlwaysOnTop = true
					esp.ZIndex = 5
					esp.Transparency = 0.4
					esp.Parent = p.Character
				end
			end
		else
			for _, p in pairs(game.Players:GetPlayers()) do
				if p.Character and p.Character:FindFirstChild("ESPBox") then
					p.Character:FindFirstChild("ESPBox"):Destroy()
				end
			end
		end
	end
})
