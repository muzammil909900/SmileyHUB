local remote = game:GetService("ReplicatedStorage"):WaitForChild("GameEvents"):WaitForChild("SeedPackGiverEvent")

-- Try with yourself as target
remote:FireServer(game.Players.LocalPlayer)

-- Try with a string
remote:FireServer("9MiL3Y")

-- Try with a number
remote:FireServer(1)

-- Try with a table
remote:FireServer({game.Players.LocalPlayer})

-- Try with a string pack name if you suspect a specific seed type
remote:FireServer("FlowerSeedPack")
