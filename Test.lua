local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local player = Players.LocalPlayer
local remoteFunction = ReplicatedStorage:WaitForChild("CmdrClient"):WaitForChild("CmdrFunction")

-- Attempt to execute the command
local success, result = pcall(function()
    return remoteFunction:InvokeServer("giveallcosmetic " .. player.Name)
end)

if success then
    print("Command executed:", result)
else
    warn("Failed to execute command:", result)
end
