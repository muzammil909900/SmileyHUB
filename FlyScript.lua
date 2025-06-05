-- Create ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "FlyUI"
screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

-- Create main button
local flyButton = Instance.new("TextButton")
flyButton.Size = UDim2.new(0, 100, 0, 40)
flyButton.Position = UDim2.new(0.5, -50, 0.9, -20)
flyButton.BackgroundColor3 = Color3.fromRGB(50, 150, 255)
flyButton.Text = "Fly"
flyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
flyButton.Font = Enum.Font.GothamBold
flyButton.TextSize = 18
flyButton.Parent = screenGui

-- Add round corners
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 10)
corner.Parent = flyButton

-- Flying logic
local flying = false
local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local hrp = char:WaitForChild("HumanoidRootPart")

-- Create BodyVelocity
local bodyVelocity = Instance.new("BodyVelocity")
bodyVelocity.MaxForce = Vector3.new(1e5, 1e5, 1e5)
bodyVelocity.Velocity = Vector3.zero
bodyVelocity.P = 10_000

-- Input detection
local UIS = game:GetService("UserInputService")
local moveDirection = Vector3.zero

UIS.InputBegan:Connect(function(input, gpe)
	if gpe then return end
	if input.KeyCode == Enum.KeyCode.W then moveDirection = Vector3.new(0, 0, -1) end
	if input.KeyCode == Enum.KeyCode.S then moveDirection = Vector3.new(0, 0, 1) end
	if input.KeyCode == Enum.KeyCode.A then moveDirection = Vector3.new(-1, 0, 0) end
	if input.KeyCode == Enum.KeyCode.D then moveDirection = Vector3.new(1, 0, 0) end
end)

UIS.InputEnded:Connect(function(input, gpe)
	if gpe then return end
	moveDirection = Vector3.zero
end)

-- Flying toggle
flyButton.MouseButton1Click:Connect(function()
	flying = not flying
	if flying then
		bodyVelocity.Parent = hrp
	else
		bodyVelocity.Parent = nil
	end
end)

-- Update loop
game:GetService("RunService").RenderStepped:Connect(function()
	if flying and hrp then
		local cam = workspace.CurrentCamera
		local direction = cam.CFrame:VectorToWorldSpace(moveDirection).Unit
		bodyVelocity.Velocity = direction * 50
	end
end)
