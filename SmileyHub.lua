-- Load Rayfield Library
local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

-- Create Window
local Window = Rayfield:CreateWindow({
   Name = "Infinite Yield Rebuild",
   LoadingTitle = "Loading Commands...",
   LoadingSubtitle = "Rayfield UI Version",
   Theme = "DarkBlue",
   ToggleUIKeybind = "RightControl",
   ConfigurationSaving = {
      Enabled = true,
      FileName = "InfiniteYieldCommands"
   }
})

-- Create Tabs
local CommandTab = Window:CreateTab("Commands", "terminal")
local SettingsTab = Window:CreateTab("Settings", "settings")

-- Section: Input Command (Simulating CmdBar)
CommandTab:CreateInput({
   Name = "Command Bar",
   PlaceholderText = "Type ;cmd here (e.g. ;fly)",
   RemoveTextAfterFocusLost = true,
   Flag = "CmdBar",
   Callback = function(Text)
      -- Command parser placeholder
      local success, err = pcall(function()
         loadstring("_G.PLAYER = game.Players.LocalPlayer; " .. Text)()
      end)
      if not success then
         Rayfield:Notify({
            Title = "Command Error",
            Content = tostring(err),
            Duration = 4,
            Image = "x"
         })
      end
   end
})

-- Example Commands Converted (Add more as needed)
CommandTab:CreateButton({
   Name = ";fly",
   Callback = function()
      local plr = game.Players.LocalPlayer
      local chr = plr.Character or plr.CharacterAdded:Wait()
      local hum = chr:FindFirstChildOfClass("Humanoid")
      local hrp = chr:FindFirstChild("HumanoidRootPart")
      if not hum or not hrp then return end
      local flying = true
      local speed = 50
      local bodyGyro = Instance.new("BodyGyro", hrp)
      local bodyVel = Instance.new("BodyVelocity", hrp)
      bodyGyro.P = 9e4
      bodyGyro.maxTorque = Vector3.new(9e9, 9e9, 9e9)
      bodyGyro.cframe = hrp.CFrame
      bodyVel.velocity = Vector3.new(0, 0, 0)
      bodyVel.maxForce = Vector3.new(9e9, 9e9, 9e9)

      local UIS = game:GetService("UserInputService")
      local flyingConn
      flyingConn = game:GetService("RunService").RenderStepped:Connect(function()
         if not flying then flyingConn:Disconnect() return end
         local camCF = workspace.CurrentCamera.CFrame
         local dir = Vector3.new()
         if UIS:IsKeyDown(Enum.KeyCode.W) then dir += camCF.LookVector end
         if UIS:IsKeyDown(Enum.KeyCode.S) then dir -= camCF.LookVector end
         if UIS:IsKeyDown(Enum.KeyCode.A) then dir -= camCF.RightVector end
         if UIS:IsKeyDown(Enum.KeyCode.D) then dir += camCF.RightVector end
         bodyVel.velocity = dir.Unit * speed
         bodyGyro.CFrame = camCF
      end)
   end
})

-- Add the rest of the commands here using the same pattern
-- You can find the original Infinite Yield command list from your file and port them into Rayfield buttons/input logic

-- Example Settings (Optional)
SettingsTab:CreateToggle({
   Name = "Keep UI Open",
   CurrentValue = true,
   Flag = "KeepUI",
   Callback = function(Value)
      -- Implement UI stay logic if needed
   end
})

-- Load configuration at end
Rayfield:LoadConfiguration()

Rayfield:Notify({
   Title = "Infinite Yield Rebuild Loaded",
   Content = "All systems go.",
   Duration = 5,
   Image = "terminal"
})
