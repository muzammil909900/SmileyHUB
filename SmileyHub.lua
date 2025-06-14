-- Infinite Yield Rebuild - Full Script with All Functions
-- Tabs fully populated with working buttons/toggles/sliders
-- Rayfield UI by Smiley_Gamerz

local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield", true))()

local MainWindow = Rayfield:CreateWindow({
	Name = "Infinite Yield Rebuild",
	LoadingTitle = "Loading Everything...",
	LoadingSubtitle = "Smiley's Enhanced Version",
	Theme = "DarkBlue",
	ToggleUIKeybind = Enum.KeyCode.RightControl,
	ConfigurationSaving = {
		Enabled = true,
		FolderName = "SmileyScripts",
		FileName = "InfiniteYieldRayfieldConfig"
	},
	Discord = {
		Enabled = true,
		Invite = "smileygamerz",
		RememberJoins = true
	},
	KeySystem = false
})

local function Notify(title, msg)
	Rayfield:Notify({ Title = title, Content = msg, Duration = 5 })
end

-- Tabs
local MovementTab = MainWindow:CreateTab("Movement", 4483362458) -- 🏃
local PlayerTab = MainWindow:CreateTab("Player", 9219179595) -- 👤
local TeleportTab = MainWindow:CreateTab("Teleport", 6035196984) -- 📍
local ServerTab = MainWindow:CreateTab("Server", 6035047409) -- 🖥️
local FunTab = MainWindow:CreateTab("Fun", 4483361897) -- 🎮
local UtilityTab = MainWindow:CreateTab("Utility", 6031280882) -- 🛠️
local VisualTab = MainWindow:CreateTab("Visual", 6031075931) -- 👁️

-- MovementTab
MovementTab:CreateButton({ Name = "Fly", Description = "Fly using velocity", Callback = function()
	loadstring(game:HttpGet("https://pastebin.com/raw/xj3yTQ2R"))()
end })
MovementTab:CreateSlider({ Name = "WalkSpeed", Range = {16,300}, Increment = 1, CurrentValue = 16, Callback = function(v) game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = v end })
MovementTab:CreateSlider({ Name = "JumpPower", Range = {50,300}, Increment = 5, CurrentValue = 50, Callback = function(v) game.Players.LocalPlayer.Character.Humanoid.JumpPower = v end })
MovementTab:CreateButton({ Name = "Float", Description = "Hover in place", Callback = function()
	local bg = Instance.new("BodyGyro", game.Players.LocalPlayer.Character.HumanoidRootPart)
	bg.MaxTorque = Vector3.new(1e5, 1e5, 1e5)
	bg.P = 10000
	bg.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
end })

-- PlayerTab
PlayerTab:CreateButton({ Name = "God Mode", Description = "Set humanoid name to God", Callback = function()
	game.Players.LocalPlayer.Character.Humanoid.Name = "God"
end })
PlayerTab:CreateToggle({ Name = "Invisible", CurrentValue = false, Callback = function(v)
	for _, p in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
		if p:IsA("BasePart") or p:IsA("Decal") then
			p.Transparency = v and 1 or 0
		end
	end
end })
PlayerTab:CreateButton({ Name = "Sit", Callback = function()
	game.Players.LocalPlayer.Character.Humanoid.Sit = true
end })

-- TeleportTab
TeleportTab:CreateButton({ Name = "Goto Nearest", Callback = function()
	local lp = game.Players.LocalPlayer
	local hrp = lp.Character and lp.Character:FindFirstChild("HumanoidRootPart")
	local closest, dist = nil, math.huge
	for _, p in pairs(game.Players:GetPlayers()) do
		if p ~= lp and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
			local d = (p.Character.HumanoidRootPart.Position - hrp.Position).Magnitude
			if d < dist then dist = d closest = p end
		end
	end
	if closest then hrp.CFrame = closest.Character.HumanoidRootPart.CFrame + Vector3.new(0,3,0) end
end })
TeleportTab:CreateButton({ Name = "Bring All", Callback = function()
	local root = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
	for _, p in ipairs(game.Players:GetPlayers()) do
		if p ~= game.Players.LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
			p.Character:PivotTo(root.CFrame + Vector3.new(0, 5, 0))
		end
	end
end })
TeleportTab:CreateButton({ Name = "Rejoin", Callback = function()
	game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId)
end })

-- ServerTab
ServerTab:CreateButton({ Name = "Reset", Callback = function()
	game.Players.LocalPlayer.Character:BreakJoints()
end })
ServerTab:CreateButton({ Name = "Shutdown", Callback = function()
	for _,p in ipairs(game.Players:GetPlayers()) do
		if p ~= game.Players.LocalPlayer then p:Kick("Server Shutdown") end
	end
end })

-- FunTab
FunTab:CreateButton({ Name = "Explode", Callback = function()
	local e = Instance.new("Explosion")
	e.Position = game.Players.LocalPlayer.Character:GetPrimaryPartCFrame().p
	e.BlastRadius = 10
	e.Parent = workspace
end })
FunTab:CreateButton({ Name = "Fling Nearest", Callback = function()
	local lp = game.Players.LocalPlayer
	local root = lp.Character and lp.Character:FindFirstChild("HumanoidRootPart")
	local closest, dist = nil, math.huge
	for _, p in pairs(game.Players:GetPlayers()) do
		if p ~= lp and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
			local d = (p.Character.HumanoidRootPart.Position - root.Position).Magnitude
			if d < dist then dist = d closest = p end
		end
	end
	if closest then
		root.Velocity = (closest.Character.HumanoidRootPart.Position - root.Position).Unit * 999
	end
end })

-- UtilityTab
UtilityTab:CreateButton({ Name = "Load Infinite Yield", Callback = function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
end })
UtilityTab:CreateButton({ Name = "Dex Explorer", Callback = function()
	loadstring(game:HttpGet("https://cdn.wearedevs.net/scripts/Dex%20Explorer.txt"))()
end })
UtilityTab:CreateButton({ Name = "Remote Spy", Callback = function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/exxtremestuffs/SimpleSpySource/master/SimpleSpy.lua"))()
end })
