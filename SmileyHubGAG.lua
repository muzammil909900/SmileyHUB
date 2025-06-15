-- List of valid seed pack types from SeedPackData
local packTypes = {
    "Normal",
    "Exotic",
    "SeedSackBasic",
    "SeedSackPremium",
    "RainbowSeedSackBasic",
    "RainbowSeedSackPremium",
    "Night",
    "Flower Seed Pack",
    "Exotic Flower Seed Pack",
    "Rainbow Exotic Flower Seed Pack",
    "Crafters Seed Pack",
    "Exotic Crafters Seed Pack",
    "Rainbow Exotic Crafters Seed Pack",
    "NightPremium"
}

-- Remote path
local remote = game:GetService("ReplicatedStorage"):WaitForChild("GameEvents"):WaitForChild("SeedPackGiverEvent")

-- Function to test each pack
local function tryPack(packName)
    local success, err = pcall(function()
        remote:FireServer({ seedPackType = packName })
    end)
    if success then
        print("Tried pack:", packName)
    else
        warn("Failed pack:", packName, err)
    end
end

-- Loop through each and try
for _, packName in ipairs(packTypes) do
    tryPack(packName)
    wait(1.2) -- Give time between
end

-- Optional: copy to clipboard last tried (you can move this inside tryPack if needed)
setclipboard("Last tried seed pack: " .. packTypes[#packTypes])
