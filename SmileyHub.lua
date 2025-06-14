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

-- Speed Slider
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

-- Auto Chat Feature
local AutoChatDelay = 2
local AutoChatMessage = ""

FunTab:CreateInput({
	Name = "Auto Chat Text",
	PlaceholderText = "Enter message to auto chat",
	RemoveTextAfterFocusLost = false,
	Flag = "AutoChatText",
	Callback = function(text)
		AutoChatMessage = text
	end
})

FunTab:CreateSlider({
	Name = "Auto Chat Delay (seconds)",
	Range = {1, 30},
	Increment = 1,
	CurrentValue = 2,
	Flag = "AutoChatDelay",
	Description = "Time between each chat",
	Callback = function(delay)
		AutoChatDelay = delay
	end
})

FunTab:CreateToggle({
	Name = "Enable Auto Chat",
	CurrentValue = false,
	Flag = "AutoChatToggle",
	Description = "Sends your custom message repeatedly in chat",
	Callback = function(enabled)
		_G.AutoChatEnabled = enabled
		if enabled then
			task.spawn(function()
				while _G.AutoChatEnabled do
					game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer(AutoChatMessage, "All")
					task.wait(AutoChatDelay)
				end
			end)
		end
	end
})

-- Replace commands list button with actual buttons
UtilityTab:CreateButton({
	Name = "Fly",
	Description = "Enable fly (toggle in Movement tab)",
	Callback = function()
		Notify("Fly", "Use toggle in Movement tab")
	end
})

UtilityTab:CreateButton({
	Name = "Goto Nearest",
	Description = "Teleport to nearest player",
	Callback = function()
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
			root.CFrame = closest.Character.HumanoidRootPart.CFrame + Vector3.new(0, 5, 0)
		end
	end
})

UtilityTab:CreateButton({
	Name = "Rejoin",
	Description = "Teleport back to this server",
	Callback = function()
		game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId, game.Players.LocalPlayer)
	end
})

UtilityTab:CreateButton({
	Name = "Reset",
	Description = "Reset your character",
	Callback = function()
		game.Players.LocalPlayer.Character:BreakJoints()
	end
})

Rayfield:LoadConfiguration()
Notify("Infinite Yield", "UI ready with auto chat, speed slider, and command buttons!")
