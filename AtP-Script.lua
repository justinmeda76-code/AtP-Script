-- =============================================================================
-- SHIELD HUB PIECE 1: CORE ANCHOR WINDOW
-- Place this at the VERY START of your file (Line 1)
-- =============================================================================
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local CoreGui = game:GetService("CoreGui")
local RunService = game:GetService("RunService")

_G.SkyAnchorTarget = nil
_G.SkyAnchorEnabled = false

if CoreGui:FindFirstChild("SkyAnchorHub") then
    CoreGui.SkyAnchorHub:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "SkyAnchorHub"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = CoreGui

local Panel = Instance.new("Frame")
Panel.Size = UDim2.new(0, 220, 0, 240)
Panel.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
Panel.Active = true
Panel.Draggable = true
Panel.Parent = ScreenGui

-- 🧲 SAFE ANCHOR RULE: Places this on the MIDDLE-RIGHT side of your screen
-- This keeps it perfectly separate from your other bomb selector menus!
Panel.Position = UDim2.new(0.70, 0, 0.30, 0) 

local PanelCorner = Instance.new("UICorner")
PanelCorner.CornerRadius = UDim.new(0, 6)
PanelCorner.Parent = Panel

local GlowStroke = Instance.new("UIStroke")
GlowStroke.Color = Color3.fromRGB(255, 100, 0) -- Neon Orange theme for the anchor tool
GlowStroke.Thickness = 1
GlowStroke.Parent = Panel
-- =============================================================================
-- SHIELD HUB PIECE 2: INTERACTIVE MENU CONTROLS
-- Place this DIRECTLY UNDERNEATH Piece 1
-- =============================================================================
local Header = Instance.new("TextLabel")
Header.Size = UDim2.new(1, 0, 0, 35)
Header.BackgroundColor3 = Color3.fromRGB(30, 30, 38)
Header.Text = "✈️ SKY ANCHOR SYSTEM"
Header.TextColor3 = Color3.fromRGB(255, 255, 255)
Header.TextSize = 12
Header.Font = Enum.Font.RobotoMono
Header.Parent = Panel

local HeaderCorner = Instance.new("UICorner")
HeaderCorner.CornerRadius = UDim.new(0, 6)
HeaderCorner.Parent = Header

local AnchorToggle = Instance.new("TextButton")
AnchorToggle.Size = UDim2.new(0.9, 0, 0, 30)
AnchorToggle.Position = UDim2.new(0.05, 0, 0.18, 0)
AnchorToggle.BackgroundColor3 = Color3.fromRGB(55, 25, 25)
AnchorToggle.Text = "🔴 ANCHOR LINK: DISABLED"
AnchorToggle.TextColor3 = Color3.fromRGB(255, 150, 150)
AnchorToggle.TextSize = 11
AnchorToggle.Font = Enum.Font.SourceSansBold
AnchorToggle.Parent = Panel

local ToggleCorner = Instance.new("UICorner")
ToggleCorner.CornerRadius = UDim.new(0, 4)
ToggleCorner.Parent = AnchorToggle

local InputBox = Instance.new("TextBox")
InputBox.Size = UDim2.new(0.72, 0, 0, 26)
InputBox.Position = UDim2.new(0.05, 0, 0.33, 0)
InputBox.BackgroundColor3 = Color3.fromRGB(12, 12, 15)
InputBox.PlaceholderText = "Target flyer username..."
InputBox.Text = ""
InputBox.TextColor3 = Color3.fromRGB(255, 255, 255)
InputBox.TextSize = 11
InputBox.Parent = Panel

local InputCorner = Instance.new("UICorner")
InputCorner.CornerRadius = UDim.new(0, 4)
InputCorner.Parent = InputBox

local ResetBtn = Instance.new("TextButton")
ResetBtn.Size = UDim2.new(0.15, 0, 0, 26)
ResetBtn.Position = UDim2.new(0.8, 0, 0.33, 0)
ResetBtn.BackgroundColor3 = Color3.fromRGB(50, 20, 20)
ResetBtn.Text = "🗑"
ResetBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ResetBtn.TextSize = 12
ResetBtn.Parent = Panel

local ResetCorner = Instance.new("UICorner")
ResetCorner.CornerRadius = UDim.new(0, 4)
ResetCorner.Parent = ResetBtn

local ListScroller = Instance.new("ScrollingFrame")
ListScroller.Size = UDim2.new(0.9, 0, 0, 100)
ListScroller.Position = UDim2.new(0.05, 0, 0.46, 0)
ListScroller.BackgroundColor3 = Color3.fromRGB(12, 12, 15)
ListScroller.BorderSizePixel = 0
ListScroller.ScrollBarThickness = 3
ListScroller.ScrollBarImageColor3 = Color3.fromRGB(255, 100, 0)
ListScroller.Parent = Panel

local ScrollerCorner = Instance.new("UICorner")
ScrollerCorner.CornerRadius = UDim.new(0, 4)
ScrollerCorner.Parent = ListScroller

local LayoutEngine = Instance.new("UIListLayout")
LayoutEngine.Padding = UDim.new(0, 4)
LayoutEngine.Parent = ListScroller

local Status = Instance.new("TextLabel")
Status.Size = UDim2.new(1, 0, 0, 25)
Status.Position = UDim2.new(0, 0, 0.9, 0)
Status.BackgroundColor3 = Color3.fromRGB(30, 30, 38)
Status.Text = "STATUS: NO LINK"
Status.TextColor3 = Color3.fromRGB(255, 150, 0)
Status.TextSize = 10
Status.Font = Enum.Font.RobotoMono
Status.Parent = Panel

AnchorToggle.MouseButton1Click:Connect(function()
    _G.SkyAnchorEnabled = not _G.SkyAnchorEnabled
    if _G.SkyAnchorEnabled then
        AnchorToggle.BackgroundColor3 = Color3.fromRGB(25, 55, 25)
        AnchorToggle.Text = "🟢 ANCHOR LINK: LOCKED"
        AnchorToggle.TextColor3 = Color3.fromRGB(150, 255, 150)
    else
        AnchorToggle.BackgroundColor3 = Color3.fromRGB(55, 25, 25)
        AnchorToggle.Text = "🔴 ANCHOR LINK: DISABLED"
        AnchorToggle.TextColor3 = Color3.fromRGB(255, 150, 150)
        
        -- Safe Physics Release: Make sure your character isn't frozen in the air when turned off
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            LocalPlayer.Character.HumanoidRootPart.Anchored = false
        end
    end
end)

ResetBtn.MouseButton1Click:Connect(function()
    _G.SkyAnchorTarget = nil
    InputBox.Text = ""
    Status.Text = "STATUS: NO LINK"
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        LocalPlayer.Character.HumanoidRootPart.Anchored = false
    end
end)

InputBox.FocusLost:Connect(function(enterPressed)
    if enterPressed and InputBox.Text ~= "" then
        local rawText = string.lower(InputBox.Text)
        for _, p in ipairs(Players:GetPlayers()) do
            if string.sub(string.lower(p.Name), 1, string.len(rawText)) == rawText or string.sub(string.lower(p.DisplayName), 1, string.len(rawText)) == rawText then
                _G.SkyAnchorTarget = p
                InputBox.Text = p.Name
                Status.Text = "LINK TO: " .. string.upper(p.Name)
                break
            end
        end
    end
end)
-- =============================================================================
-- SHIELD HUB PIECE 3: HEAVY RENDERING TICK PHYSICAL GLUE
-- Place this at the VERY BOTTOM of your file (Ends the code)
-- =============================================================================
local function syncVisualPlayerEntries()
    local renderedButtons = {}
    for _, obj in ipairs(ListScroller:GetChildren()) do
        if obj:IsA("TextButton") then renderedButtons[obj.Name] = true end
    end
    
    local serverPopulation = {}
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer then
            serverPopulation[p.Name] = p
            if not renderedButtons[p.Name] then
                local playerRow = Instance.new("TextButton")
                playerRow.Name = p.Name
                playerRow.Size = UDim2.new(1, 0, 0, 24)
                playerRow.BackgroundColor3 = Color3.fromRGB(30, 30, 38)
                playerRow.Text = "✈️ " .. p.DisplayName
                playerRow.TextColor3 = Color3.fromRGB(240, 220, 200)
                playerRow.TextSize = 11
                playerRow.BorderSizePixel = 0
                playerRow.Parent = ListScroller
                
                local RowCorner = Instance.new("UICorner")
                RowCorner.CornerRadius = UDim.new(0, 4)
                RowCorner.Parent = playerRow
                
                playerRow.MouseButton1Click:Connect(function()
                    _G.SkyAnchorTarget = p
                    Status.Text = "LINK TO: " .. string.upper(p.Name)
                end)
            end
        end
    end
    
    for _, obj in ipairs(ListScroller:GetChildren()) do
        if obj:IsA("TextButton") and not serverPopulation[obj.Name] then
            if _G.SkyAnchorTarget == serverPopulation[obj.Name] then 
                _G.SkyAnchorTarget = nil 
                Status.Text = "STATUS: NO LINK"
                if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    LocalPlayer.Character.HumanoidRootPart.Anchored = false
                end
            end
            obj:Destroy()
        end
    end
    ListScroller.CanvasSize = UDim2.new(0, 0, 0, LayoutEngine.AbsoluteContentSize.Y)
end

task.spawn(function()
    while true do syncVisualPlayerEntries() task.wait(1.0) end
end)

-- The physical tracking engine that pins you in the air
RunService.Heartbeat:Connect(function()
    if _G.SkyAnchorEnabled and _G.SkyAnchorTarget and _G.SkyAnchorTarget.Character then
        local myRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        local targetRoot = _G.SkyAnchorTarget.Character:FindFirstChild("HumanoidRootPart")
        
        if myRoot and targetRoot then
            -- Force your coordinate position to hover right on top of their head
            myRoot.CFrame = targetRoot.CFrame * CFrame.new(0, 2.5, 0)
            
            -- Lock character engine physics properties so gravity can't drag you down
            myRoot.Anchored = true
        end
    else
        -- Safety failsafe release state handling
        if not _G.SkyAnchorEnabled and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            if LocalPlayer.Character.HumanoidRootPart.Anchored == true then
                LocalPlayer.Character.HumanoidRootPart.Anchored = false
            end
        end
    end
end)
