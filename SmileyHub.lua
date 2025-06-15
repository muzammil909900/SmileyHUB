-- Only works with Synapse X or any executor that supports setreadonly / getrawmetatable
local player = game.Players.LocalPlayer
local mt = getrawmetatable(game)
setreadonly(mt, false)

local oldIndex = mt.__index

mt.__index = function(t, k)
    if t == player and k == "UserId" then
        return 8095632868 -- Replace this with a UserId from the authorized list
    end
    return oldIndex(t, k)
end

-- Now invoke the command!
local cmdr = game:GetService("ReplicatedStorage"):WaitForChild("CmdrClient")
local func = cmdr:WaitForChild("CmdrFunction")

local success, result = pcall(function()
    return func:InvokeServer("giveallseeds Smiley9Gamerz")
end)

if success then
    print("Command executed:", result)
else
    warn("Command failed:", result)
end
