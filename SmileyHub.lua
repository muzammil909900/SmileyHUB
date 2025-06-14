-- Load Rayfield Library
local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

-- Create Window without loading icons
local Window = Rayfield:CreateWindow({
   Name = "Infinite Yield Rebuild",
   LoadingTitle = "Loading Infinite Yield...",
   LoadingSubtitle = "Rayfield UI Version",
   Icon = 0, -- 🛑 Disables icon loading (prevents icon.lua error)
   Theme = "DarkBlue",
   ToggleUIKeybind = "RightControl",
   ConfigurationSaving = {
      Enabled = true,
      FileName = "InfiniteYieldRebuilt"
   }
})

-- Commands Tab
local CmdTab = Window:CreateTab("Commands", "terminal")
CmdTab:CreateSection("Command Bar")

-- Command Bar Input
CmdTab:CreateInput({
   Name = "Command Input",
   PlaceholderText = ";fly, ;kill, etc.",
   RemoveTextAfterFocusLost = true,
   Flag = "CommandInput",
   Callback = function(Text)
      local success, err = pcall(function()
         _G.PLAYER = game.Players.LocalPlayer
         loadstring("return " .. Text)()
      end)
      if not success then
         Rayfield:Notify({ Title = "Command Error", Content = tostring(err), Duration = 4, Image = "x" })
      end
   end
})

-- Predefined Commands Section
CmdTab:CreateSection("Core Player Commands")

local function safeFindPlayer(name)
   for _, plr in pairs(game.Players:GetPlayers()) do
      if string.lower(plr.Name) == string.lower(name) then
         return plr
      end
   end
end

CmdTab:CreateButton({
   Name = "Rejoin",
   Callback = function()
      game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId, game.Players.LocalPlayer)
   end
})

CmdTab:CreateButton({
   Name = "Server Hop",
   Callback = function()
      Rayfield:Notify({ Title = "Server Hop", Content = "Finding new server...", Duration = 4 })
      local HttpService = game:GetService("HttpService")
      local TeleportService = game:GetService("TeleportService")
      local Servers = HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?sortOrder=Asc&limit=100"))
      for _,v in pairs(Servers.data) do
         if v.playing < v.maxPlayers then
            TeleportService:TeleportToPlaceInstance(game.PlaceId, v.id)
            break
         end
      end
   end
})

CmdTab:CreateButton({
   Name = "Dex Explorer",
   Callback = function()
      loadstring(game:HttpGet("https://cdn.wearedevs.net/scripts/Dex%20Explorer.txt"))()
   end
})

CmdTab:CreateButton({
   Name = "Remote Spy",
   Callback = function()
      loadstring(game:HttpGet("https://raw.githubusercontent.com/exxtremestuffs/SimpleSpySource/master/SimpleSpy.lua"))()
   end
})

CmdTab:CreateButton({
   Name = "Console",
   Callback = function()
      loadstring(game:HttpGet("https://pastebin.com/raw/pFznk5LJ"))()
   end
})

CmdTab:CreateButton({
   Name = "Ping",
   Callback = function()
      local stats = game:GetService("Stats"):FindFirstChild("Network")
      local ping = stats and stats:FindFirstChild("ServerStatsItem[Data Ping]")
      if ping then
         Rayfield:Notify({ Title = "Ping", Content = "Ping: "..math.floor(ping:GetValue()).." ms", Duration = 3 })
      else
         Rayfield:Notify({ Title = "Ping", Content = "Ping data not available.", Duration = 3 })
      end
   end
})

CmdTab:CreateButton({
   Name = "Invisible",
   Callback = function()
      local char = game.Players.LocalPlayer.Character
      for _,v in pairs(char:GetDescendants()) do
         if v:IsA("BasePart") then v.Transparency = 1 end
      end
   end
})

CmdTab:CreateButton({
   Name = "Visible",
   Callback = function()
      local char = game.Players.LocalPlayer.Character
      for _,v in pairs(char:GetDescendants()) do
         if v:IsA("BasePart") then v.Transparency = 0 end
      end
   end
})

CmdTab:CreateToggle({
   Name = "ESP (simple)",
   CurrentValue = false,
   Flag = "SimpleESP",
   Callback = function(state)
      if state then
         for _, plr in pairs(game.Players:GetPlayers()) do
            if plr ~= game.Players.LocalPlayer and plr.Character then
               local box = Instance.new("BoxHandleAdornment")
               box.Name = "ESPBox"
               box.Adornee = plr.Character:FindFirstChild("HumanoidRootPart")
               box.Size = Vector3.new(4,6,1)
               box.Color3 = Color3.new(1,0,0)
               box.AlwaysOnTop = true
               box.ZIndex = 5
               box.Transparency = 0.5
               box.Parent = plr.Character
            end
         end
      else
         for _, plr in pairs(game.Players:GetPlayers()) do
            if plr.Character then
               local box = plr.Character:FindFirstChild("ESPBox")
               if box then box:Destroy() end
            end
         end
      end
   end
})

CmdTab:CreateButton({
   Name = "Clear Waypoints",
   Callback = function()
      Rayfield:Notify({ Title = "Waypoints", Content = "Waypoints cleared (simulated).", Duration = 3 })
   end
})

-- Settings Tab
local SettingsTab = Window:CreateTab("Settings", "settings")
SettingsTab:CreateToggle({
   Name = "Keep UI Open",
   CurrentValue = true,
   Flag = "KeepUI",
   Callback = function(Value)
      -- Optionally implement if needed
   end
})

-- Load saved state
Rayfield:LoadConfiguration()

-- UI Ready Notification
Rayfield:Notify({
   Title = "Infinite Yield Recreated",
   Content = "All core commands loaded successfully!",
   Duration = 5,
   Image = "terminal"
})


-- Advanced Player Interaction
CmdTab:CreateButton({
   Name = "Bring Nearest Player",
   Callback = function()
      local lp = game.Players.LocalPlayer
      local nearest, minDist = nil, math.huge
      for _, plr in pairs(game.Players:GetPlayers()) do
         if plr ~= lp and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
            local dist = (lp.Character.HumanoidRootPart.Position - plr.Character.HumanoidRootPart.Position).Magnitude
            if dist < minDist then
               minDist = dist
               nearest = plr
            end
         end
      end
      if nearest then
         nearest.Character:SetPrimaryPartCFrame(lp.Character.HumanoidRootPart.CFrame + Vector3.new(0, 5, 0))
         Rayfield:Notify({ Title = "Bring", Content = "Brought " .. nearest.Name, Duration = 3 })
      else
         Rayfield:Notify({ Title = "Bring", Content = "No valid players found.", Duration = 3 })
      end
   end
})

CmdTab:CreateToggle({
   Name = "LoopKill Nearest",
   CurrentValue = false,
   Flag = "LoopKillToggle",
   Callback = function(Value)
      if Value then
         _G.LoopKill = true
         task.spawn(function()
            while _G.LoopKill do
               local lp = game.Players.LocalPlayer
               local nearest, minDist = nil, math.huge
               for _, plr in pairs(game.Players:GetPlayers()) do
                  if plr ~= lp and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                     local dist = (lp.Character.HumanoidRootPart.Position - plr.Character.HumanoidRootPart.Position).Magnitude
                     if dist < minDist then
                        minDist = dist
                        nearest = plr
                     end
                  end
               end
               if nearest and nearest.Character:FindFirstChild("Humanoid") then
                  nearest.Character.Humanoid.Health = 0
               end
               task.wait(1)
            end
         end)
      else
         _G.LoopKill = false
      end
   end
})

CmdTab:CreateButton({
   Name = "Tool Invisible",
   Callback = function()
      local lp = game.Players.LocalPlayer
      if lp.Character:FindFirstChild("HumanoidRootPart") then
         local tool = Instance.new("Tool")
         tool.RequiresHandle = false
         tool.Name = "Invisible"
         tool.Parent = lp.Backpack
         tool.Activated:Connect(function()
            for _, v in pairs(lp.Character:GetDescendants()) do
               if v:IsA("BasePart") then
                  v.Transparency = 1
                  if v.Name == "Head" then
                     local face = v:FindFirstChild("face")
                     if face then face:Destroy() end
                  end
               elseif v:IsA("Decal") then
                  v.Transparency = 1
               end
            end
         end)
         Rayfield:Notify({ Title = "Tool Invisible", Content = "Tool added to backpack", Duration = 3 })
      end
   end
})
