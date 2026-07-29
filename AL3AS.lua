-- Micro Menu Script for Delta Executor (Advanced Features)
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- Variables to store platforms and references
local createdPlatforms = {}
local lastPlatform = nil

local function addPlatform(platform)
    table.insert(createdPlatforms, platform)
    lastPlatform = platform
end

-- Remove old menu if it already exists to avoid duplication
if CoreGui:FindFirstChild("MicroMenu") then
    CoreGui.MicroMenu:Destroy()
end

-- Create main ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "MicroMenu"
ScreenGui.Parent = CoreGui
ScreenGui.ResetOnSpawn = false

-- Create micro menu frame
local Frame = Instance.new("Frame")
Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
Frame.BorderColor3 = Color3.fromRGB(0, 170, 255)
Frame.BorderSizePixel = 1
Frame.Position = UDim2.new(0.5, -75, 0.5, -145)
Frame.Size = UDim2.new(0, 150, 0, 295)
Frame.Active = true
Frame.Draggable = true -- Allows dragging the menu around

-- Title / Header Label
local Title = Instance.new("TextLabel")
Title.Parent = Frame
Title.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Title.Size = UDim2.new(1, 0, 0, 28)
Title.Font = Enum.Font.SourceSansBold
Title.Text = "  Micro Menu"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 13
Title.TextXAlignment = Enum.TextXAlignment.Left

-- Minimize / Hide Toggle Button (Top Right Corner)
local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Parent = Title
ToggleBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
ToggleBtn.Position = UDim2.new(1, -26, 0.5, -11)
ToggleBtn.Size = UDim2.new(0, 22, 0, 22)
ToggleBtn.Font = Enum.Font.SourceSansBold
ToggleBtn.Text = "-"
ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleBtn.TextSize = 12

-- Button 1: Teleport forward 5 studs
local Btn1 = Instance.new("TextButton")
Btn1.Parent = Frame
Btn1.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
Btn1.Position = UDim2.new(0.07, 0, 0, 35)
Btn1.Size = UDim2.new(0.86, 0, 0, 30)
Btn1.Font = Enum.Font.SourceSansBold
Btn1.Text = "Forward 5 Studs"
Btn1.TextColor3 = Color3.fromRGB(255, 255, 255)
Btn1.TextSize = 12

Btn1.MouseButton1Click:Connect(function()
    local char = LocalPlayer.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        local hrp = char.HumanoidRootPart
        hrp.CFrame = hrp.CFrame + (hrp.CFrame.LookVector * 5)
    end
end)

-- Button 2: Teleport up 5 studs + create 2s platform
local Btn2 = Instance.new("TextButton")
Btn2.Parent = Frame
Btn2.BackgroundColor3 = Color3.fromRGB(0, 170, 100)
Btn2.Position = UDim2.new(0.07, 0, 0, 71)
Btn2.Size = UDim2.new(0.86, 0, 0, 30)
Btn2.Font = Enum.Font.SourceSansBold
Btn2.Text = "Up 5 + Platform (2s)"
Btn2.TextColor3 = Color3.fromRGB(255, 255, 255)
Btn2.TextSize = 12

Btn2.MouseButton1Click:Connect(function()
    local char = LocalPlayer.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        local hrp = char.HumanoidRootPart
        hrp.CFrame = hrp.CFrame + Vector3.new(0, 5, 0)
        
        local platform = Instance.new("Part")
        platform.Size = Vector3.new(4, 1, 4)
        platform.Position = hrp.Position - Vector3.new(0, 3.5, 0)
        platform.Anchored = true
        platform.BrickColor = BrickColor.new("Bright blue")
        platform.Material = Enum.Material.SmoothPlastic
        platform.Parent = workspace
        
        addPlatform(platform)
        
        task.delay(2, function()
            if platform and platform.Parent then
                platform:Destroy()
            end
        end)
    end
end)

-- Button 3: Teleport up 5 studs + create 10s platform
local Btn3 = Instance.new("TextButton")
Btn3.Parent = Frame
Btn3.BackgroundColor3 = Color3.fromRGB(200, 130, 0)
Btn3.Position = UDim2.new(0.07, 0, 0, 107)
Btn3.Size = UDim2.new(0.86, 0, 0, 30)
Btn3.Font = Enum.Font.SourceSansBold
Btn3.Text = "Up 5 + Platform (10s)"
Btn3.TextColor3 = Color3.fromRGB(255, 255, 255)
Btn3.TextSize = 12

Btn3.MouseButton1Click:Connect(function()
    local char = LocalPlayer.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        local hrp = char.HumanoidRootPart
        hrp.CFrame = hrp.CFrame + Vector3.new(0, 5, 0)
        
        local platform = Instance.new("Part")
        platform.Size = Vector3.new(4, 1, 4)
        platform.Position = hrp.Position - Vector3.new(0, 3.5, 0)
        platform.Anchored = true
        platform.BrickColor = BrickColor.new("Orange")
        platform.Material = Enum.Material.SmoothPlastic
        platform.Parent = workspace
        
        addPlatform(platform)
        
        task.delay(10, function()
            if platform and platform.Parent then
                platform:Destroy()
            end
        end)
    end
end)

-- Button 4: Create permanent platform (10x10 studs, 70% transparent)
local Btn4 = Instance.new("TextButton")
Btn4.Parent = Frame
Btn4.BackgroundColor3 = Color3.fromRGB(150, 0, 200)
Btn4.Position = UDim2.new(0.07, 0, 0, 143)
Btn4.Size = UDim2.new(0.86, 0, 0, 30)
Btn4.Font = Enum.Font.SourceSansBold
Btn4.Text = "Permanent Platform"
Btn4.TextColor3 = Color3.fromRGB(255, 255, 255)
Btn4.TextSize = 12

Btn4.MouseButton1Click:Connect(function()
    local char = LocalPlayer.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        local hrp = char.HumanoidRootPart
        
        local platform = Instance.new("Part")
        platform.Size = Vector3.new(10, 1, 10)
        platform.Position = hrp.Position - Vector3.new(0, 3.5, 0)
        platform.Anchored = true
        platform.Transparency = 0.7
        platform.BrickColor = BrickColor.new("Medium stone grey")
        platform.Material = Enum.Material.SmoothPlastic
        platform.Parent = workspace
        
        addPlatform(platform)
    end
end)

-- Button 5: Create 30-stud platform (60% transparent)
local Btn5 = Instance.new("TextButton")
Btn5.Parent = Frame
Btn5.BackgroundColor3 = Color3.fromRGB(0, 140, 140)
Btn5.Position = UDim2.new(0.07, 0, 0, 179)
Btn5.Size = UDim2.new(0.86, 0, 0, 30)
Btn5.Font = Enum.Font.SourceSansBold
Btn5.Text = "Platform 30s (60%)"
Btn5.TextColor3 = Color3.fromRGB(255, 255, 255)
Btn5.TextSize = 12

Btn5.MouseButton1Click:Connect(function()
    local char = LocalPlayer.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        local hrp = char.HumanoidRootPart
        
        local platform = Instance.new("Part")
        platform.Size = Vector3.new(30, 1, 30)
        platform.Position = hrp.Position - Vector3.new(0, 3.5, 0)
        platform.Anchored = true
        platform.Transparency = 0.6
        platform.BrickColor = BrickColor.new("Dark stone grey")
        platform.Material = Enum.Material.SmoothPlastic
        platform.Parent = workspace
        
        addPlatform(platform)
    end
end)

-- Button 6: Teleport to the most recent platform
local Btn6 = Instance.new("TextButton")
Btn6.Parent = Frame
Btn6.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
Btn6.Position = UDim2.new(0.07, 0, 0, 215)
Btn6.Size = UDim2.new(0.86, 0, 0, 30)
Btn6.Font = Enum.Font.SourceSansBold
Btn6.Text = "To Nearest Platform"
Btn6.TextColor3 = Color3.fromRGB(255, 255, 255)
Btn6.TextSize = 12

Btn6.MouseButton1Click:Connect(function()
    if lastPlatform and lastPlatform.Parent then
        local char = LocalPlayer.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            char.HumanoidRootPart.CFrame = lastPlatform.CFrame + Vector3.new(0, 3, 0)
        end
    end
end)

-- Button 7: Delete all created platforms
local Btn7 = Instance.new("TextButton")
Btn7.Parent = Frame
Btn7.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
Btn7.Position = UDim2.new(0.07, 0, 0, 251)
Btn7.Size = UDim2.new(0.86, 0, 0, 30)
Btn7.Font = Enum.Font.SourceSansBold
Btn7.Text = "Delete All Platforms"
Btn7.TextColor3 = Color3.fromRGB(255, 255, 255)
Btn7.TextSize = 12

Btn7.MouseButton1Click:Connect(function()
    for _, p in ipairs(createdPlatforms) do
        if p and p.Parent then
            p:Destroy()
        end
    end
    createdPlatforms = {}
    lastPlatform = nil
end)

-- Minimize/Maximize Logic
local isMinimized = false
local allButtons = {Btn1, Btn2, Btn3, Btn4, Btn5, Btn6, Btn7}

ToggleBtn.MouseButton1Click:Connect(function()
    isMinimized = not isMinimized
    if isMinimized then
        Frame.Size = UDim2.new(0, 150, 0, 28)
        ToggleBtn.Text = "+"
        for _, btn in ipairs(allButtons) do
            btn.Visible = false
        end
    else
        Frame.Size = UDim2.new(0, 150, 0, 295)
        ToggleBtn.Text = "-"
        for _, btn in ipairs(allButtons) do
            btn.Visible = true
        end
    end
end)

