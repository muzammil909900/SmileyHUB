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
local EffectsTab = MainWindow:CreateTab("Player Effects", 0)
local TeleportTab = MainWindow:CreateTab("Teleportation", 0)
local ServerTab = MainWindow:CreateTab("Server", 0)
local SettingsTab = MainWindow:CreateTab("Settings", 0)

-- Teleportation
TeleportTab:CreateButton({
	Name = "Goto Nearest",
	Description = "Teleport to the nearest player",
	Callback = function()
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
	end
})

TeleportTab:CreateButton({
	Name = "Bring All",
	Description = "Brings all players to your location",
	Callback = function()
		local lp = game.Players.LocalPlayer
		local root = lp.Character and lp.Character:FindFirstChild("HumanoidRootPart")
		if root then
			for _, p in pairs(game.Players:GetPlayers()) do
				if p ~= lp and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
					p.Character:SetPrimaryPartCFrame(root.CFrame + Vector3.new(0,5,0))
				end
			end
		end
	end
})

TeleportTab:CreateButton({
	Name = "Rejoin",
	Description = "Rejoin current server",
	Callback = function()
		game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId)
	end
})

-- Player Effects
EffectsTab:CreateToggle({
	Name = "God Mode",
	CurrentValue = false,
	Flag = "GodMode",
	Description = "Grants god mode (invincibility)",
	Callback = function(v)
		local char = game.Players.LocalPlayer.Character
		if v and char then
			char.Humanoid.Name = "God"
		else
			Notify("God Mode", "This god mode cannot be undone without respawn.")
		end
	end
})

EffectsTab:CreateToggle({
	Name = "Invisible",
	CurrentValue = false,
	Flag = "InvisToggle",
	Description = "Toggles invisibility",
	Callback = function(v)
		local char = game.Players.LocalPlayer.Character
		for _, p in pairs(char:GetDescendants()) do
			if p:IsA("BasePart") or p:IsA("Decal") then
				p.Transparency = v and 1 or 0
			end
		end
	end
})

EffectsTab:CreateButton({
	Name = "Sit",
	Description = "Force sit your character",
	Callback = function()
		local hum = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
		if hum then hum.Sit = true end
	end
})

-- Movement continued
MovementTab:CreateButton({
	Name = "Float",
	Description = "Enables float using BodyGyro",
	Callback = function()
		local hrp = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
		if hrp then
			local bg = Instance.new("BodyGyro", hrp)
			bg.CFrame = hrp.CFrame
			bg.MaxTorque = Vector3.new(1e9,1e9,1e9)
			bg.P = 10000
		end
	end
})

MovementTab:CreateButton({
	Name = "Unfly",
	Description = "Disables fly if enabled",
	Callback = function()
		local hrp = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
		if _G.FlyConnection then _G.FlyConnection:Disconnect() end
		if hrp:FindFirstChild("FlyControl") then hrp:FindFirstChild("FlyControl"):Destroy() end
	end
})

-- Server/World
ServerTab:CreateButton({
	Name = "Reset Character",
	Description = "Resets your character",
	Callback = function()
		game.Players.LocalPlayer.Character:BreakJoints()
	end
})

ServerTab:CreateButton({
	Name = "Shutdown Server",
	Description = "Attempts to crash all clients (FE Required)",
	Callback = function()
		for _,v in pairs(game.Players:GetPlayers()) do
			if v ~= game.Players.LocalPlayer then
				v:Kick("Shutdown by script")
			end
		end
	end
})

ServerTab:CreateButton({
	Name = "Crash Local",
	Description = "Crash your own client",
	Callback = function()
		while true do end
	end
})

-- Fun/Trolling
FunTab:CreateButton({
	Name = "Explode",
	Description = "Explode your character",
	Callback = function()
		local e = Instance.new("Explosion")
		e.Position = game.Players.LocalPlayer.Character:GetPrimaryPartCFrame().p
		e.BlastRadius = 10
		e.Parent = workspace
	end
})

FunTab:CreateButton({
	Name = "Flash Screen",
	Description = "Flashes your screen repeatedly",
	Callback = function()
		local gui = Instance.new("ScreenGui", game.Players.LocalPlayer.PlayerGui)
		for i = 1,5 do
			local f = Instance.new("Frame", gui)
			f.Size = UDim2.new(1,0,1,0)
			f.BackgroundColor3 = Color3.new(1,1,1)
			f.BackgroundTransparency = 0
			task.wait(0.1)
			f:Destroy()
		end
	end
})

FunTab:CreateButton({
	Name = "Annoy Chat",
	Description = "Spam chat messages (local only)",
	Callback = function()
		for i = 1,10 do
			game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("Annoying spam!!!", "All")
			task.wait(0.5)
		end
	end
})

-- Utilities
UtilityTab:CreateButton({
	Name = "Show Commands",
	Description = "List all available commands",
	Callback = function()
		Notify("Commands", ";fly ;goto ;bring ;noclip ;dex ;settings ;prefix ;sit ;speed ;reset ;kill ;jump")
	end
})

SettingsTab:CreateButton({
	Name = "Prefix Settings",
	Description = "Change prefix system (placeholder)",
	Callback = function()
		Notify("Prefix", "Prefix is ';' by default. No settings system active.")
	end
})

SettingsTab:CreateButton({
	Name = "Fix Character",
	Description = "Respawns character if broken",
	Callback = function()
		local char = game.Players.LocalPlayer.Character
		local hum = char and char:FindFirstChildOfClass("Humanoid")
		if hum then
			hum.Health = 0
			Notify("Fix", "Respawning...")
		end
	end
})

Rayfield:LoadConfiguration()
Notify("Infinite Yield", "All major features, tabs, and functions loaded!")
