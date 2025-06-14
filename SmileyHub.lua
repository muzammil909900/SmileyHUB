-- Infinite Yield Rebuild - Final UI Edition
-- All core features + full command support + fixes
-- Built on Rayfield UI by Smiley_Gamerz

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
local MovementTab = MainWindow:CreateTab("Movement", 0)
local PlayerTab = MainWindow:CreateTab("Player", 0)
local TeleportTab = MainWindow:CreateTab("Teleport", 0)
local ServerTab = MainWindow:CreateTab("Server", 0)
local FunTab = MainWindow:CreateTab("Fun", 0)
local UtilityTab = MainWindow:CreateTab("Utility", 0)
local VisualTab = MainWindow:CreateTab("Visual", 0)

-- Visual Tab Commands
VisualTab:CreateToggle({
	Name = "ESP Boxes",
	CurrentValue = false,
	Flag = "ESPToggle",
	Description = "Show red boxes on other players",
	Callback = function(v)
		if v then
			for _, plr in pairs(game.Players:GetPlayers()) do
				if plr ~= game.Players.LocalPlayer and plr.Character then
					local box = Instance.new("BoxHandleAdornment")
					box.Name = "ESPBox"
					box.Adornee = plr.Character:FindFirstChild("HumanoidRootPart")
					box.AlwaysOnTop = true box.ZIndex = 5 box.Size = Vector3.new(4,6,1)
					box.Color3 = Color3.new(1,0,0) box.Transparency = 0.4
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

VisualTab:CreateButton({
	Name = "Dex Explorer",
	Description = "Load UI explorer tool",
	Callback = function()
		loadstring(game:HttpGet("https://cdn.wearedevs.net/scripts/Dex%20Explorer.txt"))()
	end
})

VisualTab:CreateButton({
	Name = "Remote Spy",
	Description = "Spy on remote events/functions",
	Callback = function()
		loadstring(game:HttpGet("https://raw.githubusercontent.com/exxtremestuffs/SimpleSpySource/master/SimpleSpy.lua"))()
	end
})
