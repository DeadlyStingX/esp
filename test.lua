local players = game:GetService("Players")
local runService = game:GetService("RunService")
local highlightEnabled = false

-- Function to create a highlight box around a player's character
local function createHighlightBox(character)
    -- Create BillboardGui for the highlight box
    local billboardGui = Instance.new("BillboardGui")
    billboardGui.AlwaysOnTop = true
    billboardGui.Size = UDim2.new(4, 0, 5, 0) -- Adjust size as needed
    billboardGui.Adornee = character:WaitForChild("Head") -- Attach to player's head
    billboardGui.Name = "HighlightGui"
    billboardGui.Parent = character

    -- Create frame for the box
    local frame = Instance.new("Frame")
    frame.BackgroundTransparency = 1
    frame.Size = UDim2.new(1, 0, 1, 0)
    frame.BorderSizePixel = 2
    frame.BorderColor3 = Color3.fromRGB(255, 0, 0) -- Color of the box
    frame.Parent = billboardGui

    -- Create BoxHandleAdornment for the character
    local boxHandle = Instance.new("BoxHandleAdornment")
    boxHandle.Size = character:GetExtentsSize()
    boxHandle.Adornee = character
    boxHandle.ZIndex = 0
    boxHandle.AlwaysOnTop = true
    boxHandle.Color3 = Color3.fromRGB(255, 0, 0) -- Color of the box
    boxHandle.Transparency = 0.5
    boxHandle.Name = "HighlightBox"
    boxHandle.Parent = character
end

-- Function to remove highlight boxes from a player's character
local function removeHighlightBox(character)
    if character:FindFirstChild("HighlightGui") then
        character.HighlightGui:Destroy()
    end
    if character:FindFirstChild("HighlightBox") then
        character.HighlightBox:Destroy()
    end
end

-- Function to highlight all players in the game
local function highlightAllPlayers()
    for _, player in pairs(players:GetPlayers()) do
        if player ~= players.LocalPlayer then
            local character = player.Character or player.CharacterAdded:Wait()
            if highlightEnabled then
                createHighlightBox(character)
            else
                removeHighlightBox(character)
            end
        end
    end
end

-- Toggle highlight on and off
local function toggleHighlight()
    highlightEnabled = not highlightEnabled
    highlightAllPlayers()
end

-- Bind the toggle highlight function to the 'Z' key
game:GetService("UserInputService").InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and input.KeyCode == Enum.KeyCode.Z then
        toggleHighlight()
    end
end)

-- Keep highlighting new players when they join or respawn
players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function(character)
        if highlightEnabled then
            createHighlightBox(character)
        end
    end)
end)

-- Remove highlight boxes when a player leaves
players.PlayerRemoving:Connect(function(player)
    if player.Character then
        removeHighlightBox(player.Character)
    end
end)
