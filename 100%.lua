local players = game:GetService("Players")
local runService = game:GetService("RunService")

-- Function to create a 3D box around a player's character
local function createBox(character)
    if character:FindFirstChild("HumanoidRootPart") then
        local box = Instance.new("BoxHandleAdornment")
        box.Size = character:GetExtentsSize()
        box.Adornee = character.HumanoidRootPart
        box.Color3 = Color3.fromRGB(255, 0, 0) -- Color of the box
        box.Transparency = 0.5
        box.AlwaysOnTop = true
        box.ZIndex = 0
        box.Parent = character
    end
end

-- Function to add boxes around all players in the game
local function addBoxesToAllPlayers()
    for _, player in pairs(players:GetPlayers()) do
        if player ~= players.LocalPlayer then
            local character = player.Character or player.CharacterAdded:Wait()
            createBox(character)
        end
    end
end

-- Add boxes to all players when the script runs
addBoxesToAllPlayers()

-- Add boxes to new players when they join
players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function(character)
        createBox(character)
    end)
end)

-- Remove boxes when a player's character is removed
players.PlayerRemoving:Connect(function(player)
    if player.Character then
        for _, adornment in pairs(player.Character:GetChildren()) do
            if adornment:IsA("BoxHandleAdornment") then
                adornment:Destroy()
            end
        end
    end
end)
