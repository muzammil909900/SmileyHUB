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

-- [PREVIOUS TABS HERE — Movement + Player] --

-- Visual Tab
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
					box.Color3 = Color3.fromRGB(255,0,0) box.Transparency = 0.4
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

-- Utility Tab
UtilityTab:CreateButton({
	Name = "Dex Explorer",
	Description = "Load UI explorer tool",
	Callback = function()
		loadstring(game:HttpGet("https://cdn.wearedevs.net/scripts/Dex%20Explorer.txt"))()
	end
})

UtilityTab:CreateButton({
	Name = "Remote Spy",
	Description = "Spy on remote events/functions",
	Callback = function()
		loadstring(game:HttpGet("https://raw.githubusercontent.com/exxtremestuffs/SimpleSpySource/master/SimpleSpy.lua"))()
	end
})

UtilityTab:CreateButton({
	Name = "Rejoin Server",
	Description = "Teleport back to current game",
	Callback = function()
		game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId, game.Players.LocalPlayer)
	end
})

UtilityTab:CreateButton({
	Name = "Server Hop",
	Description = "Hop to a different server",
	Callback = function()
		local HttpService = game:GetService("HttpService")
		local Servers = HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?sortOrder=Asc&limit=100"))
		for _,v in pairs(Servers.data) do
			if v.playing < v.maxPlayers then
				game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, v.id)
				break
			end
		end
	end
})

-- Fun Tab
FunTab:CreateToggle({
	Name = "LoopKill Nearest",
	CurrentValue = false,
	Flag = "LoopKillToggle",
	Description = "Keeps killing nearest player repeatedly",
	Callback = function(v)
		if v then
			_G.LoopKill = true
			task.spawn(function()
				while _G.LoopKill do
					task.wait(1)
					local lp = game.Players.LocalPlayer
					local nearest, dist = nil, math.huge
					for _, p in pairs(game.Players:GetPlayers()) do
						if p ~= lp and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
							local d = (lp.Character.HumanoidRootPart.Position - p.Character.HumanoidRootPart.Position).Magnitude
							if d < dist then dist = d nearest = p end
						end
					end
					if nearest and nearest.Character:FindFirstChild("Humanoid") then
						nearest.Character.Humanoid.Health = 0
					end
				end
			end)
		else
			_G.LoopKill = false
		end
	end
})

FunTab:CreateButton({
	Name = "Play Music",
	Description = "Plays ID 142376088",
	Callback = function()
		local s = Instance.new("Sound")
		s.SoundId = "rbxassetid://142376088"
		s.Volume = 5
		s.Looped = true
		s.Parent = workspace
		s:Play()
	end
})

FunTab:CreateButton({
	Name = "Stop All Sounds",
	Description = "Stops every sound in workspace",
	Callback = function()
		for _, s in ipairs(workspace:GetDescendants()) do
			if s:IsA("Sound") then s:Stop() end
		end
	end
})

FunTab:CreateButton({
	Name = "Fling Nearest",
	Description = "Fling nearest player by setting velocity",
	Callback = function()
		local lp = game.Players.LocalPlayer
		local root = lp.Character and lp.Character:FindFirstChild("HumanoidRootPart")
		if not root then return end
		local target, distance = nil, math.huge
		for _, p in pairs(game.Players:GetPlayers()) do
			if p ~= lp and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
				local d = (root.Position - p.Character.HumanoidRootPart.Position).Magnitude
				if d < distance then target = p distance = d end
			end
		end
		if target then
			root.Velocity = (target.Character.HumanoidRootPart.Position - root.Position).Unit * 999
		end
	end
})

Rayfield:LoadConfiguration()
Notify("Infinite Yield", "All categories loaded. Full UI now live.")
