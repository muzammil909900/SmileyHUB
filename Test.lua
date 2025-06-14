local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

local Window = Rayfield:CreateWindow({
   Name = "Test",
   LoadingTitle = "Rayfield Loading...",
   LoadingSubtitle = "Check UI",
   Theme = "DarkBlue",
   ToggleUIKeybind = "RightControl",
   ConfigurationSaving = {
      Enabled = false
   }
})

local Tab = Window:CreateTab("Test", "terminal")
Tab:CreateButton({
   Name = "Click Me",
   Callback = function()
      Rayfield:Notify({ Title = "It works!", Content = "Rayfield UI is running", Duration = 4 })
   end
})
