-- Infinite Yield Rebuild - Full UI Version using Rayfield
-- Structured Tabs, Descriptions, Toggles, Sliders
-- Based on official source: https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source

local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield", true))()

local MainWindow = Rayfield:CreateWindow({
	Name = "Infinite Yield Rebuild",
	LoadingTitle = "Loading All Features...",
	LoadingSubtitle = "by Smiley_Gamerz",
	Theme = "DarkBlue",
	ToggleUIKeybind = Enum.KeyCode.RightControl,
	ConfigurationSaving = {
		Enabled = true,
		FileName = "InfiniteYieldRayfield"
	},
	Discord = { Enabled = false },
	KeySystem = false
})

local function Notify(title, msg)
	Rayfield:Notify({ Title = title, Content = msg, Duration = 5 })
end

-- Tabs
local MovementTab = MainWindow:CreateTab("Movement", 0)
local PlayerTab = MainWindow:CreateTab("Player", 0)
local VisualTab = MainWindow:CreateTab("Visual", 0)
local UtilityTab = MainWindow:CreateTab("Utility", 0)
local FunTab = MainWindow:CreateTab("Fun", 0)

-- Movement
MovementTab:CreateToggle({
	Name = "Fly",
	CurrentValue = false,
	Flag = "FlyToggle",
	Description = "Toggle flying on/off",
	Callback = function(enabled)
		local plr = game.Players.LocalPlayer
		local hrp = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")
		if enabled then
			local bv = Instance.new("BodyVelocity")
			bv.Name = "FlyControl"
			bv.MaxForce = Vector3.new(1e9, 1e9, 1e9)
			bv.Velocity = Vector3.zero
			bv.Parent = hrp
			_G.FlyConnection = game:GetService("RunService").Heartbeat:Connect(function()
				bv.Velocity = Vector3.new(0, 50, 0)
			end)
		else
			if _G.FlyConnection then _G.FlyConnection:Disconnect() end
			if hrp:FindFirstChild("FlyControl") then hrp:FindFirstChild("FlyControl"):Destroy() end
		end
	end
})

MovementTab:CreateToggle({
	Name = "Noclip",
	CurrentValue = false,
	Flag = "NoclipToggle",
	Description = "Walk through walls",
	Callback = function(state)
		local char = game.Players.LocalPlayer.Character
		if state then
			_G.NoclipConnection = game:GetService("RunService").Stepped:Connect(function()
				for _, p in ipairs(char:GetDescendants()) do
					if p:IsA("BasePart") then p.CanCollide = false end
				end
			end)
		else
			if _G.NoclipConnection then _G.NoclipConnection:Disconnect() end
		end
	end
})

MovementTab:CreateSlider({
	Name = "WalkSpeed",
	Range = {16, 300},
	Increment = 5,
	CurrentValue = 16,
	Flag = "SpeedSlider",
	Description = "Adjust player walkspeed",
	Callback = function(speed)
		local hum = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid")
		if hum then hum.WalkSpeed = speed end
	end
})

MovementTab:CreateSlider({
	Name = "JumpPower",
	Range = {50, 500},
	Increment = 10,
	CurrentValue = 50,
	Flag = "JumpPowerSlider",
	Description = "Adjust player jump power",
	Callback = function(power)
		local hum = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid")
		if hum then hum.JumpPower = power end
	end
})

-- Player
PlayerTab:CreateButton({
	Name = "Bring All Players",
	Description = "Brings everyone to your position",
	Callback = function()
		local root = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
		if not root then return end
		for _, p in pairs(game.Players:GetPlayers()) do
			if p ~= game.Players.LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
				p.Character:SetPrimaryPartCFrame(root.CFrame + Vector3.new(0, 5, 0))
			end
		end
	end
})

PlayerTab:CreateButton({
	Name = "Goto Nearest Player",
	Description = "Teleports to the closest player",
	Callback = function()
		local lp = game.Players.LocalPlayer
		local root = lp.Character and lp.Character:FindFirstChild("HumanoidRootPart")
		if not root then return end
		local closest, dist = nil, math.huge
		for _, p in ipairs(game.Players:GetPlayers()) do
			if p ~= lp and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
				local d = (p.Character.HumanoidRootPart.Position - root.Position).Magnitude
				if d < dist then dist = d closest = p end
			end
		end
		if closest then
			root.CFrame = closest.Character.HumanoidRootPart.CFrame + Vector3.new(0, 5, 0)
		end
	end
})

-- Add more categories in next steps...
-- Tabs to continue: VisualTab, UtilityTab, FunTab

Rayfield:LoadConfiguration()
Notify("Infinite Yield", "Base layout and commands loaded. More coming next.")
