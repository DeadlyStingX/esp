-- Get the Players service
local Players = game:GetService("Players")

-- Set to true to use the Highlight effect, or false to use BoxHandleAdornment
local useHighlight = true

-- Function to apply either highlight or box to a player's character
local function applyEffect(player)
    player.CharacterAdded:Connect(function(character)
        -- Wait for the character's HumanoidRootPart to load
        character:WaitForChild("HumanoidRootPart")

        if useHighlight then
            -- Apply Highlight effect
            local highlight = Instance.new("Highlight")
            highlight.Parent = character
            highlight.FillColor = Color3.fromRGB(0, 255, 0) -- Green glow
            highlight.OutlineColor = Color3.fromRGB(255, 255, 255) -- White outline
            highlight.Adornee = character

        else
            -- Apply BoxHandleAdornment effect
            local box = Instance.new("BoxHandleAdornment")
            box.Size = Vector3.new(5, 7, 5) -- Adjust box size to fit around the character
            box.Color3 = Color3.fromRGB(255, 0, 0) -- Red box
            box.Transparency = 0.3 -- Slightly transparent
            box.Adornee = character:FindFirstChild("HumanoidRootPart")
            box.AlwaysOnTop = true
            box.ZIndex = 10
            box.Parent = character
        end
    end)
end

-- Apply effect to all current players
for _, player in ipairs(Players:GetPlayers()) do
    applyEffect(player)
end

-- Apply effect to any new players joining the game
Players.PlayerAdded:Connect(applyEffect)
