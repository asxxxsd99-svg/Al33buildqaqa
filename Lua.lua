-- MOBILE COMBAT MASTER MENU (ENGLISH + IMAGE BACKGROUND - OPTIMIZED)
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("ImageLabel") 
local UICorner = Instance.new("UICorner")
local Title = Instance.new("TextLabel")
local ToggleTarget = Instance.new("TextButton")
local ToggleEat = Instance.new("TextButton")
local ToggleAntiSafe = Instance.new("TextButton")
local HitboxInput = Instance.new("TextBox") -- Upgraded Hitbox input box
local StatusLabel = Instance.new("TextLabel")
local OpenCloseBtn = Instance.new("TextButton")

-- [ CONFIGURATION ] --
local FURRY_IMAGE_ID = "rbxassetid://76482189124530" -- Synchronized to your sharp image ID
_G.AutoTarget = false
_G.SuperFastEat = false
_G.AntiFallSafeZone = true
_G.HitboxSize = 15
_G.PredictIntensity = 0.5

-- [ UI SETUP ] --
ScreenGui.Parent = game.CoreGui
ScreenGui.Name = "MobileCombatGui"

-- Toggle Button (Mini Button)
OpenCloseBtn.Parent = ScreenGui
OpenCloseBtn.Name = "OpenCloseBtn"
OpenCloseBtn.Size = UDim2.new(0, 60, 0, 30)
OpenCloseBtn.Position = UDim2.new(0.1, 0, 0.1, 0)
OpenCloseBtn.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
OpenCloseBtn.BackgroundTransparency = 0.4
OpenCloseBtn.Text = "MENU"
OpenCloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
OpenCloseBtn.Draggable = true

-- Main Menu Frame
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
MainFrame.Image = FURRY_IMAGE_ID
MainFrame.ImageTransparency = 0.2 
MainFrame.Position = UDim2.new(0.5, -90, 0.3, 0)
MainFrame.Size = UDim2.new(0, 180, 0, 280)
MainFrame.Visible = true
MainFrame.Active = true
MainFrame.Draggable = true

UICorner.CornerRadius = UDim.new(0, 12)
UICorner.Parent = MainFrame

Title.Parent = MainFrame
Title.Size = UDim2.new(1, 0, 0, 35)
Title.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Title.BackgroundTransparency = 0.5
Title.Text = "COMBAT MASTER"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.SourceSansBold

-- Logic: Open/Close
OpenCloseBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

-- Buttons Setup
local function StyleButton(btn, text, pos, color)
    btn.Parent = MainFrame
    btn.Text = text
    btn.Size = UDim2.new(0.85, 0, 0, 35)
    btn.Position = pos
    btn.BackgroundColor3 = color
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.SourceSansBold
    local c = Instance.new("UICorner", btn)
    c.CornerRadius = UDim.new(0, 6)
end

StyleButton(ToggleTarget, "TARGET: OFF", UDim2.new(0.075, 0, 0.15, 0), Color3.fromRGB(180, 0, 0))
StyleButton(ToggleEat, "AUTO EAT: OFF", UDim2.new(0.075, 0, 0.3, 0), Color3.fromRGB(180, 0, 0))
StyleButton(ToggleAntiSafe, "ANTI-SAFE: ON", UDim2.new(0.075, 0, 0.45, 0), Color3.fromRGB(0, 120, 0))

-- UPGRADED HITBOX INPUT BOX INTO A PROFESSIONAL BUTTON STYLE
HitboxInput.Parent = MainFrame
HitboxInput.Text = "" -- Leave blank to show Placeholder
HitboxInput.PlaceholderText = "HITBOX SIZE: 15" -- Default size suggestion
HitboxInput.PlaceholderColor3 = Color3.fromRGB(200, 200, 200)
HitboxInput.Size = UDim2.new(0.85, 0, 0, 35)
HitboxInput.Position = UDim2.new(0.075, 0, 0.6, 0)
HitboxInput.BackgroundColor3 = Color3.fromRGB(40, 40, 40) -- Change to button gray color instead of dark translucent black
HitboxInput.TextColor3 = Color3.fromRGB(255, 255, 255)
HitboxInput.Font = Enum.Font.SourceSansBold
HitboxInput.TextSize = 14
local InputCorner = Instance.new("UICorner", HitboxInput)
InputCorner.CornerRadius = UDim.new(0, 6)

StatusLabel.Parent = MainFrame
StatusLabel.Size = UDim2.new(1, 0, 0, 30)
StatusLabel.Position = UDim2.new(0, 0, 0.85, 0)
StatusLabel.Text = "Status: Ready"
StatusLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
StatusLabel.BackgroundTransparency = 1
StatusLabel.Font = Enum.Font.SourceSansBold

---------------- LOGIC ----------------

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

ToggleTarget.MouseButton1Click:Connect(function()
    _G.AutoTarget = not _G.AutoTarget
    ToggleTarget.Text = _G.AutoTarget and "TARGET: ON" or "TARGET: OFF"
    ToggleTarget.BackgroundColor3 = _G.AutoTarget and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(180, 0, 0)
end)

ToggleEat.MouseButton1Click:Connect(function()
    _G.SuperFastEat = not _G.SuperFastEat
    ToggleEat.Text = _G.SuperFastEat and "AUTO EAT: ON" or "AUTO EAT: OFF"
    ToggleEat.BackgroundColor3 = _G.SuperFastEat and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(180, 0, 0)
end)

ToggleAntiSafe.MouseButton1Click:Connect(function()
    _G.AntiFallSafeZone = not _G.AntiFallSafeZone
    ToggleAntiSafe.Text = _G.AntiFallSafeZone and "ANTI-SAFE: ON" or "ANTI-SAFE: OFF"
    ToggleAntiSafe.BackgroundColor3 = _G.AntiFallSafeZone and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(180, 0, 0)
end)

-- LOGIC TO HANDLE WHEN USER TYPES A NUMBER AND EXITS FOCUS
HitboxInput.FocusLost:Connect(function(enterPressed)
    local val = tonumber(HitboxInput.Text)
    if val then 
        _G.HitboxSize = val 
        StatusLabel.Text = "Hitbox set to: "..val
        HitboxInput.Text = "" -- Clear typed text to show new placeholder
        HitboxInput.PlaceholderText = "HITBOX SIZE: " .. val -- Change suggestion text to entered number
        HitboxInput.BackgroundColor3 = Color3.fromRGB(0, 100, 0) -- Change to green for success
        task.wait(0.5)
        HitboxInput.BackgroundColor3 = Color3.fromRGB(40, 40, 40) -- Revert to normal gray
    else
        StatusLabel.Text = "Invalid Number!"
        HitboxInput.Text = ""
        HitboxInput.BackgroundColor3 = Color3.fromRGB(150, 0, 0) -- Change to red for text input error
        task.wait(0.5)
        HitboxInput.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    end
end)

-- Main Loop (Pursuit & Anti-Fall)
task.spawn(function()
    while true do
        if _G.AutoTarget then
            local char = LocalPlayer.Character
            local myRoot = char and char:FindFirstChild("HumanoidRootPart")
            if myRoot then
                if _G.AntiFallSafeZone then
                  local ray = workspace:Raycast(myRoot.Position, Vector3.new(0, -100, 0))
                    if ray and ray.Instance and (ray.Instance.Name:lower():find("safe") or ray.Instance.Name:lower():find("spawn")) then
                        myRoot.Velocity = Vector3.new(0, 0, 0)
                        myRoot.CFrame = myRoot.CFrame + Vector3.new(15, 10, 15)
                    end
                end
                local target, velocity = nil, Vector3.new(0,0,0)
                local dist = math.huge
                for _, p in pairs(Players:GetPlayers()) do
                    if p ~= LocalPlayer and p.Character then
                        local r = p.Character:FindFirstChild("HumanoidRootPart")
                        if r and not p.Character:FindFirstChildOfClass("ForceField") then
                            local d = (r.Position - myRoot.Position).Magnitude
                            if d < dist then dist = d; target = r; velocity = r.Velocity end
                        end
                    end
                end
                if target then
                    myRoot.CFrame = CFrame.new(target.Position + (velocity * _G.PredictIntensity)) * CFrame.new(0, 0, 1)
                end
            end
        end
        task.wait(0.01)
    end
end)

-- Hitbox & Auto Eat Loop (NO RENDER - NO LAG)
task.spawn(function()
    while true do
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                -- Keep hidden size, do not render colors to maximize FPS
                p.Character.HumanoidRootPart.Size = Vector3.new(_G.HitboxSize, _G.HitboxSize, _G.HitboxSize)
                p.Character.HumanoidRootPart.CanCollide = false
            end
        end
        if _G.SuperFastEat and LocalPlayer.Character then
            for _, t in pairs(LocalPlayer.Backpack:GetChildren()) do if t:IsA("Tool") then t.Parent = LocalPlayer.Character end end
            for _, t in pairs(LocalPlayer.Character:GetChildren()) do 
                if t:IsA("Tool") then 
                    t:Activate() 
                    local r = t:FindFirstChildOfClass("RemoteEvent") or game:GetService("ReplicatedStorage"):FindFirstChild("EatRemote", true)
                    if r then r:FireServer() end
                end 
            end
        end
        task.wait(0.5)
    end
end)

