local function createBoxAroundPlayer(player)
    -- Get the player's character model
    local character = player.Character
    if not character then return end

    -- Define the box (Part) around the player
    local box = Instance.new("Part")
    box.Name = player.Name .. "_Box"
    box.Anchored = true
    box.CanCollide = false
    box.Transparency = 0.5
    box.Color = Color3.fromRGB(255, 0, 0) -- Red color
    box.Size = Vector3.new(5, 10, 5) -- Adjust size as needed
    box.Parent = workspace

    -- Function to update box position and size to match player's character
    local function updateBox()
        if character and character.PrimaryPart then
            box.CFrame = character.PrimaryPart.CFrame
            box.Size = character:GetExtentsSize() + Vector3.new(1, 1, 1)
        end
    end

    -- Update the box whenever the character moves
    game:GetService("RunService").Heartbeat:Connect(updateBox)
end

-- Connect the function to all players currently in the game
game.Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function(character)
        createBoxAroundPlayer(player)
    end)
end)

-- Apply to all existing players
for _, player in pairs(game.Players:GetPlayers()) do
    if player.Character then
        createBoxAroundPlayer(player)
    else
        player.CharacterAdded:Connect(function()
            createBoxAroundPlayer(player)
        end)
    end
end
