-- Script in ServerScriptService
local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")
local DataStoreService = game:GetService("DataStoreService")
local BanStore = DataStoreService:GetDataStore("BanList")

-- Check if player is banned on join
Players.PlayerAdded:Connect(function(player)
	local isBanned = BanStore:GetAsync("Ban_" .. player.UserId)
	if isBanned then
		player:Kick("You are permanently banned from this game.")
	end

	-- Create ban GUI for the player
	local gui = Instance.new("ScreenGui")
	gui.Name = "BanGUI"
	gui.ResetOnSpawn = false

	local layout = Instance.new("UIListLayout")
	layout.Parent = gui
	layout.Padding = UDim.new(0, 5)
	layout.HorizontalAlignment = Enum.HorizontalAlignment.Left
	layout.VerticalAlignment = Enum.VerticalAlignment.Top

	for _, target in pairs(Players:GetPlayers()) do
		if target ~= player then
			local button = Instance.new("TextButton")
			button.Size = UDim2.new(0, 200, 0, 40)
			button.Text = "BAN: " .. target.Name
			button.BackgroundColor3 = Color3.fromRGB(255, 100, 100)
			button.TextColor3 = Color3.new(1, 1, 1)
			button.Parent = gui

			button.MouseButton1Click:Connect(function()
				BanStore:SetAsync("Ban_" .. target.UserId, true)
				target:Kick("You were banned.")
			end)
		end
	end

	-- Update when new players join
	Players.PlayerAdded:Connect(function(newPlayer)
		if newPlayer ~= player and player.Parent then
			local button = Instance.new("TextButton")
			button.Size = UDim2.new(0, 200, 0, 40)
			button.Text = "BAN: " .. newPlayer.Name
			button.BackgroundColor3 = Color3.fromRGB(255, 100, 100)
			button.TextColor3 = Color3.new(1, 1, 1)
			button.Parent = gui

			button.MouseButton1Click:Connect(function()
				BanStore:SetAsync("Ban_" .. newPlayer.UserId, true)
				newPlayer:Kick("You were banned.")
			end)
		end
	end)

	gui.Parent = player:WaitForChild("PlayerGui")
end)
