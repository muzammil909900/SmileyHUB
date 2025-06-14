-- Infinite Yield Rayfield UI Rebuild (FIXED)
-- By Smiley_Gamerz — All core features working
-- Fixes: Sit, Goto Player Dropdown, Chat Spam, Rainbow Chat, Annoy Random Player

local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield", true))()

local Window = Rayfield:CreateWindow({
	Name = "Infinite Yield Rebuild",
	LoadingTitle = "Loading...",
	LoadingSubtitle = "Fixed Version",
	Theme = "DarkBlue",
	ToggleUIKeybind = Enum.KeyCode.RightControl
})

local TeleportTab = Window:CreateTab("Teleport", 6035196984)
local PlayerTab = Window:CreateTab("Player", 9219179595)
local MovementTab = Window:CreateTab("Movement", 4483362458)
local FunTab = Window:CreateTab("Fun", 4483361897)
local UtilityTab = Window:CreateTab("Utility", 6031280882)

-- Fix: Sit
PlayerTab:CreateButton({
	Name = "Sit",
	Description = "Make your character sit.",
	Callback = function()
		local hum = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
		if hum then hum.Sit = true end
	end
})

-- Fix: Goto with Dropdown
local selectedPlayer = nil
local dropdownRef = nil

TeleportTab:CreateDropdown({
	Name = "Select Player",
	Options = (function()
		local names = {}
		for _, plr in ipairs(game.Players:GetPlayers()) do table.insert(names, plr.Name) end
		return names
	end)(),
	CurrentOption = "",
	Description = "Choose a player to teleport to.",
	Callback = function(opt)
		selectedPlayer = opt
	end
})

TeleportTab:CreateButton({
	Name = "Goto Selected Player",
	Description = "Teleports to selected player",
	Callback = function()
		local plr = game.Players:FindFirstChild(selectedPlayer)
		if plr and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = plr.Character.HumanoidRootPart.CFrame + Vector3.new(0, 3, 0)
		end
	end
})

TeleportTab:CreateButton({
	Name = "🔁 Refresh Player List",
	Callback = function()
		local names = {}
		for _, p in ipairs(game.Players:GetPlayers()) do
			table.insert(names, p.Name)
		end
		if Rayfield.Flags and Rayfield.Flags.Select_Player then
			Rayfield.Flags.Select_Player:SetOptions(names)
		end
	end
})

-- Fix: Chat Spammer
local chatMsg = "Hello"
local chatDelay = 2

UtilityTab:CreateInput({
	Name = "Chat Spam Message",
	PlaceholderText = "Enter message",
	Callback = function(msg)
		chatMsg = msg
	end
})

UtilityTab:CreateSlider({
	Name = "Chat Spam Delay",
	Range = {1, 10},
	Increment = 1,
	CurrentValue = 2,
	Callback = function(v)
		chatDelay = v
	end
})

UtilityTab:CreateToggle({
	Name = "Enable Chat Spam",
	CurrentValue = false,
	Callback = function(state)
		_G.ChatSpam = state
		while _G.ChatSpam do
			game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer(chatMsg, "All")
			task.wait(chatDelay)
		end
	end
})

-- Fix: Rainbow Chat
FunTab:CreateToggle({
	Name = "Rainbow Chat",
	CurrentValue = false,
	Description = "Cycles chat colors",
	Callback = function(state)
		_G.RainbowChat = state
		local colors = {"red", "orange", "yellow", "green", "blue", "purple"}
		while _G.RainbowChat do
			for _, c in pairs(colors) do
				if not _G.RainbowChat then break end
				local msg = "<font color=\""..c.."\">🌈 Rainbow Mode!</font>"
				game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer(msg, "All")
				task.wait(0.5)
			end
		end
	end
})

-- Fix: Annoy Random Player
FunTab:CreateToggle({
	Name = "Annoy Random Player",
	CurrentValue = false,
	Callback = function(state)
		_G.Annoy = state
		while _G.Annoy do
			local others = {}
			for _, p in ipairs(game.Players:GetPlayers()) do
				if p ~= game.Players.LocalPlayer then table.insert(others, p) end
			end
			if #others > 0 then
				local rand = others[math.random(1, #others)]
				if rand.Character and rand.Character:FindFirstChild("Humanoid") then
					rand.Character.Humanoid.Sit = true
				end
			end
			task.wait(1.5)
		end
	end
})
