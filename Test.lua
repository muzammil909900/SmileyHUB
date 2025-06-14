-- Load Rayfield Library
local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

-- Create Window (No Icon)
local Window = Rayfield:CreateWindow({
   Name = "Infinite Yield Rebuild",
   LoadingTitle = "Loading Infinite Yield...",
   LoadingSubtitle = "Rayfield UI Version",
   Icon = 0,
   Theme = "DarkBlue",
   ToggleUIKeybind = "RightControl",
   DisableRayfieldPrompts = true,
   DisableBuildWarnings = true,
   ConfigurationSaving = {
      Enabled = true,
      FileName = "InfiniteYieldRebuilt"
   }
})

-- Commands Tab without icon
local CmdTab = Window:CreateTab("Commands", 0)
CmdTab:CreateSection("Command Bar")

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
         Rayfield:Notify({ Title = "Command Error", Content = tostring(err), Duration = 4 })
      end
   end
})

CmdTab:CreateButton({
   Name = "Rejoin",
   Callback = function()
      game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId, game.Players.LocalPlayer)
   end
})

-- Add more commands here...

-- Settings Tab
local SettingsTab = Window:CreateTab("Settings", 0)
SettingsTab:CreateToggle({
   Name = "Keep UI Open",
   CurrentValue = true,
   Flag = "KeepUI",
   Callback = function(Value) end
})

-- Finalize
Rayfield:LoadConfiguration()

Rayfield:Notify({
   Title = "Infinite Yield Recreated",
   Content = "Core commands loaded!",
   Duration = 5
})
