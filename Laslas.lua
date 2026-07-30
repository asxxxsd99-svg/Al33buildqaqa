-- Auto Teleport to NPCs Menu (with Top 3 Highest Health Target Selection & Red Highlight)
local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Remove old menu if it exists to avoid duplication
if playerGui:FindFirstChild("TeleportMenu") then
    playerGui.TeleportMenu:Destroy()
end

-- Create ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "TeleportMenu"
screenGui.Parent = playerGui

-- Create Main Frame
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 240, 0, 330)
mainFrame.Position = UDim2.new(0.5, -120, 0.5, -165)
mainFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = screenGui

-- Menu Title
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 35)
title.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextSize = 15
title.Font = Enum.Font.SourceSansBold
title.Text = "NPC Teleport Menu"
title.Parent = mainFrame

-- Top 3 Section Label
local topLabel = Instance.new("TextLabel")
topLabel.Size = UDim2.new(0.86, 0, 0, 25)
topLabel.Position = UDim2.new(0.07, 0, 0, 42)
topLabel.BackgroundTransparency = 1
topLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
topLabel.TextSize = 13
topLabel.Font = Enum.Font.SourceSansBold
topLabel.Text = "Top 3 Max Health NPCs:"
topLabel.Parent = mainFrame

-- Container for Top 3 Buttons
local npcButtonsContainer = Instance.new("Frame")
npcButtonsContainer.Size = UDim2.new(0.86, 0, 0, 105)
npcButtonsContainer.Position = UDim2.new(0.07, 0, 0, 68)
npcButtonsContainer.BackgroundTransparency = 1
npcButtonsContainer.Parent = mainFrame

local topButtons = {}
for i = 1, 3 do
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 30)
    btn.Position = UDim2.new(0, 0, 0, (i - 1) * 35)
    btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 12
    btn.Font = Enum.Font.SourceSans
    btn.Text = "Waiting for NPCs..."
    btn.Parent = npcButtonsContainer
    topButtons[i] = btn
end

-- Speed/Delay TextBox
local speedBox = Instance.new("TextBox")
speedBox.Size = UDim2.new(0.86, 0, 0, 30)
speedBox.Position = UDim2.new(0.07, 0, 0, 180)
speedBox.BackgroundColor3 = Color3.fromRGB(55, 55, 55)
speedBox.TextColor3 = Color3.fromRGB(255, 255, 255)
speedBox.PlaceholderText = "Delay (0.001 - 1)"
speedBox.Text = "0.05"
speedBox.TextSize = 14
speedBox.Font = Enum.Font.SourceSans
speedBox.ClearTextOnFocus = false
speedBox.Parent = mainFrame

-- ON Button
local onButton = Instance.new("TextButton")
onButton.Size = UDim2.new(0.4, 0, 0, 40)
onButton.Position = UDim2.new(0.07, 0, 0, 220)
onButton.BackgroundColor3 = Color3.fromRGB(46, 204, 113)
onButton.TextColor3 = Color3.fromRGB(255, 255, 255)
onButton.TextSize = 15
onButton.Font = Enum.Font.SourceSansBold
onButton.Text = "ON"
onButton.Parent = mainFrame

-- OFF Button
local offButton = Instance.new("TextButton")
offButton.Size = UDim2.new(0.4, 0, 0, 40)
offButton.Position = UDim2.new(0.53, 0, 0, 220)
offButton.BackgroundColor3 = Color3.fromRGB(231, 76, 60)
offButton.TextColor3 = Color3.fromRGB(255, 255, 255)
offButton.TextSize = 15
offButton.Font = Enum.Font.SourceSansBold
offButton.Text = "OFF"
offButton.Parent = mainFrame

-- Status label showing active target
local statusLabel = Instance.new("TextLabel")
statusLabel.Size = UDim2.new(0.86, 0, 0, 25)
statusLabel.Position = UDim2.new(0.07, 0, 0, 270)
statusLabel.BackgroundTransparency = 1
statusLabel.TextColor3 = Color3.fromRGB(255, 215, 0)
statusLabel.TextSize = 12
statusLabel.Font = Enum.Font.SourceSansItalic
statusLabel.Text = "Target: All NPCs (None Selected)"
statusLabel.Parent = mainFrame

-- State variables
local running = false
local selectedNpc = nil
local activeNpcData = {}

-- Function to collect and sort valid NPCs by health
local function getValidNPCs()
    local list = {}
    local character = player.Character
    local npcFolder = workspace:FindFirstChild("Allnoobs")
    
    local function checkModel(obj)
        if obj:IsA("Model") and obj ~= character then
            local humanoid = obj:FindFirstChildOfClass("Humanoid")
            local root = obj:FindFirstChild("HumanoidRootPart") or obj:FindFirstChild("Torso") or obj:FindFirstChild("LowerTorso")
            if humanoid and root and humanoid.Health > 0 then
                local isPlayer = false
                for _, p in ipairs(game.Players:GetPlayers()) do
                    if p.Character == obj then
                        isPlayer = true
                        break
                    end
                end
                if not isPlayer then
                    table.insert(list, {model = obj, humanoid = humanoid, root = root, health = humanoid.Health})
                end
            end
        end
    end

    if npcFolder and #npcFolder:GetChildren() > 0 then
        for _, npc in ipairs(npcFolder:GetChildren()) do
            checkModel(npc)
        end
    else
        for _, obj in ipairs(workspace:GetDescendants()) do
            checkModel(obj)
        end
    end

    -- Sort highest health first
    table.sort(list, function(a, b)
        return a.health > b.health
    end)

    return list
end

-- Update Top 3 UI elements automatically (with RED highlight when selected)
task.spawn(function()
    while screenGui.Parent do
        local npcs = getValidNPCs()
        activeNpcData = npcs
        
        for i = 1, 3 do
            local btn = topButtons[i]
            local data = npcs[i]
            if data and data.model and data.model.Parent then
                btn.Text = i .. ". " .. data.model.Name .. " (" .. math.floor(data.health) .. " HP)"
                if selectedNpc == data.model then
                    btn.BackgroundColor3 = Color3.fromRGB(231, 76, 60) -- Sáng lên màu đỏ khi được chọn
                else
                    btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
                end
            else
                btn.Text = i .. ". None"
                btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            end
        end
        task.wait(1)
    end
end)

-- Click events to select/deselect specific NPC
for i, btn in ipairs(topButtons) do
    btn.MouseButton1Click:Connect(function()
        local data = activeNpcData[i]
        if data and data.model and data.model.Parent then
            if selectedNpc == data.model then
                selectedNpc = nil -- Bỏ chọn nếu bấm lại lần nữa
                statusLabel.Text = "Target: All NPCs (Deselected)"
            else
                selectedNpc = data.model
                statusLabel.Text = "Target: " .. data.model.Name
            end
        else
            selectedNpc = nil
            statusLabel.Text = "Target: All NPCs (Invalid NPC)"
        end
    end)
end

-- Teleport Toggle Logic
onButton.MouseButton1Click:Connect(function()
    if not running then
        running = true
        task.spawn(function()
            while running do
                local speed = tonumber(speedBox.Text) or 0.05
                if speed < 0.001 then speed = 0.001 end
                if speed > 1 then speed = 1 end
                
                local character = player.Character
                if character and character:FindFirstChild("HumanoidRootPart") then
                    local rootPart = character.HumanoidRootPart
                    
                    -- Check if user selected a specific NPC
                    if selectedNpc and selectedNpc.Parent then
                        local npcRoot = selectedNpc:FindFirstChild("HumanoidRootPart") or selectedNpc:FindFirstChild("Torso") or selectedNpc:FindFirstChild("LowerTorso")
                        local humanoid = selectedNpc:FindFirstChildOfClass("Humanoid")
                        if npcRoot and humanoid and humanoid.Health > 0 then
                            rootPart.CFrame = npcRoot.CFrame + Vector3.new(0, 3, 0)
                        else
                            selectedNpc = nil
                            statusLabel.Text = "Target: All NPCs (Target Died)"
                        end
                    else
                        -- Fallback to looping through all NPCs if none selected
                        selectedNpc = nil
                        local npcs = getValidNPCs()
                        for _, data in ipairs(npcs) do
                            if not running then break end
                            if data.root and data.humanoid and data.humanoid.Health > 0 then
                                rootPart.CFrame = data.root.CFrame + Vector3.new(0, 3, 0)
                                task.wait(speed)
                            end
                        end
                    end
                end
                task.wait(speed)
            end
        end)
    end
end)

offButton.MouseButton1Click:Connect(function()
    running = false
end)
