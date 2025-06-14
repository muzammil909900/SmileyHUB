local success, Rayfield = pcall(function()
    return loadstring(game:HttpGet("https://sirius.menu/rayfield", true))()
end)

if not success then
    warn("Rayfield failed to load. Your executor might not support it.")
    return
end

local Window = Rayfield:CreateWindow({
    Name = "Rayfield Test",
    LoadingTitle = "Checking compatibility...",
    LoadingSubtitle = "No icons used",
    Icon = 0,
    Theme = "DarkBlue",
    ToggleUIKeybind = "RightControl",
    ConfigurationSaving = {
        Enabled = false
    }
})
