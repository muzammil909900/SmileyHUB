local remote = game:GetService("ReplicatedStorage"):WaitForChild("GameEvents"):WaitForChild("SeedPackGiverEvent")

-- Replace with any valid pack name from the game’s SeedPackData
remote:FireServer({
    seedPackType = "FlowerSeedPack",
    resultIndex = 1 -- 1 usually means the "first possible result"
})
