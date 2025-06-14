--[[
Rayfield Yield - Full Rayfield Port of Infinite Yield
This file includes a GUI-based recreation of core Infinite Yield features using Rayfield.
Author: Smiley9Gamerz
]]

-- Load Rayfield
loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

local RayfieldWindow = Rayfield:CreateWindow({
   Name = "Rayfield Yield",
   LoadingTitle = "Infinite Yield UI",
   LoadingSubtitle = "Rayfield Version by Smiley9Gamerz",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = "RayfieldYield",
      FileName = "config"
   }
})

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local function notify(title, msg)
   Rayfield:Notify({Title = title, Content = msg, Duration = 4})
end

-- Core Command Executor
local CommandTab = RayfieldWindow:CreateTab("⚙️ Commands", 4483362458)
CommandTab:CreateInput({
   Name = "Command Bar",
   PlaceholderText = "e.g. fly, noclip, speed 100",
   RemoveTextAfterFocusLost = false,
   Callback = function(input)
      local args = input:lower():split(" ")
      local cmd = args[1]
      table.remove(args, 1)

      if cmd == "fly" then
         loadstring(game:HttpGet("https://pastebin.com/raw/5G7QvM6G"))()
         notify("Fly", "Fly enabled")
      elseif cmd == "unfly" then
         if _G.FlyLoop then _G.FlyLoop:Disconnect() end
         LocalPlayer.Character.Humanoid.PlatformStand = false
         notify("Fly", "Fly disabled")
      elseif cmd == "noclip" then
         game:GetService("RunService").Stepped:Connect(function()
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
               LocalPlayer.Character.Humanoid:ChangeState(11)
            end
         end)
         notify("Noclip", "Noclip enabled")
      elseif cmd == "speed" and tonumber(args[1]) then
         LocalPlayer.Character.Humanoid.WalkSpeed = tonumber(args[1])
         notify("Speed", "Set to " .. args[1])
      elseif cmd == "jump" and tonumber(args[1]) then
         LocalPlayer.Character.Humanoid.JumpPower = tonumber(args[1])
         notify("JumpPower", "Set to " .. args[1])
      elseif cmd == "re" then
         notify("Rejoin", "Rejoining...")
         game:GetService("TeleportService"):Teleport(game.PlaceId, LocalPlayer)
      else
         notify("Unknown", "Command not recognized")
      end
   end
})

-- Movement Controls
local MoveTab = RayfieldWindow:CreateTab("🏃 Movement", 4483362458)
MoveTab:CreateSlider({
   Name = "WalkSpeed",
   Range = {16, 300},
   Increment = 1,
   CurrentValue = 16,
   Callback = function(val)
      LocalPlayer.Character.Humanoid.WalkSpeed = val
   end,
})
MoveTab:CreateSlider({
   Name = "JumpPower",
   Range = {50, 300},
   Increment = 5,
   CurrentValue = 50,
   Callback = function(val)
      LocalPlayer.Character.Humanoid.JumpPower = val
   end,
})
MoveTab:CreateToggle({
   Name = "Infinite Jump",
   CurrentValue = false,
   Callback = function(state)
      getgenv().InfJump = state
      game:GetService("UserInputService").JumpRequest:Connect(function()
         if getgenv().InfJump then
            LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
         end
      end)
   end,
})

-- Teleport to Player
local TeleTab = RayfieldWindow:CreateTab("📦 Teleport", 4483362458)
TeleTab:CreateInput({
   Name = "Teleport to Player",
   PlaceholderText = "Player name",
   Callback = function(name)
      local plr = Players:FindFirstChild(name)
      if plr and plr.Character then
         LocalPlayer.Character:MoveTo(plr.Character.HumanoidRootPart.Position)
         notify("Teleport", "Moved to " .. name)
      else
         notify("Teleport", "Player not found")
      end
   end
})

-- Utilities Tab
local UtilTab = RayfieldWindow:CreateTab("🧰 Utilities", 4483362458)
UtilTab:CreateButton({
   Name = "Rejoin",
   Callback = function()
      game:GetService("TeleportService"):Teleport(game.PlaceId, LocalPlayer)
   end
})
UtilTab:CreateButton({
   Name = "Server Hop",
   Callback = function()
      local Http = game:GetService("HttpService")
      local Servers = Http:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?sortOrder=Asc&limit=100")).data
      for _,v in pairs(Servers) do
         if v.playing < v.maxPlayers then
            game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, v.id)
            break
         end
      end
   end
})

-- Credits Tab
local Credits = RayfieldWindow:CreateTab("📜 Credits", 4483362458)
Credits:CreateParagraph({
   Title = "Credits",
   Content = "Remade by Smiley9Gamerz\nInspired by Infinite Yield\nUI: Rayfield by Sirius"
})
