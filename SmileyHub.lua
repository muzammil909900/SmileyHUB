--// Basic GUI Creator for "Ban All" -- Use in an executor with caution

local player = game.Players.LocalPlayer

-- Create GUI
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.Name = "BanGui"

local title = Instance.new("TextLabel", gui)
title.Size = UDim2.new(0, 200, 0, 50)
title.Position = UDim2.new(0.5, -100, 0.4, -60)
title.Text = "Ban"
title.TextColor3 = Color3.new(1, 0, 0)
title.Font = Enum.Font.GothamBold
title.TextSize = 30
title.BackgroundColor3 = Color3.fromRGB(30, 30, 30)

local corner1 = Instance.new("UICorner", title)
corner1.CornerRadius = UDim.new(0, 10)

-- Create Ban Button
local button = Instance.new("TextButton", gui)
button.Size = UDim2.new(0, 200, 0, 40)
button.Position = UDim2.new(0.5, -100, 0.4, 0)
button.Text = "Ban All"
button.TextColor3 = Color3.new(1, 1, 1)
button.Font = Enum.Font.GothamBold
button.TextSize = 20
button.BackgroundColor3 = Color3.fromRGB(255, 0, 0)

local corner2 = Instance.new("UICorner", button)
corner2.CornerRadius = UDim.new(0, 10)

-- Ban logic
button.MouseButton1Click:Connect(function()
    for _, p in pairs(game.Players:GetPlayers()) do
        if p ~= player then
            p:Kick("Banned by owner")
        end
    end
end)
