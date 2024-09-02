-- Shadow Configuration
local SHADOW_SETTINGS = {
    SPREAD = 3, -- Controls how far the shadow extends (higher = wider spread)
    BLUR = 8,   -- Controls the number of layers (higher = more blur)
    OPACITY = 0.7, -- Controls the darkness of the shadow (lower = darker) [0-1]
}

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

-- Create ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "UserCreationHookUI"
screenGui.Parent = Players.LocalPlayer:WaitForChild("PlayerGui")

-- Create main frame
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 220, 0, 30)
mainFrame.Position = UDim2.new(0, 10, 0, 10)
mainFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui
mainFrame.BackgroundTransparency = 1  -- Start fully transparent for fade-in effect

-- Add corner radius
local cornerRadius = Instance.new("UICorner")
cornerRadius.CornerRadius = UDim.new(0, 4)
cornerRadius.Parent = mainFrame

-- Add thicker border
local border = Instance.new("UIStroke")
border.Color = Color3.fromRGB(80, 80, 80)
border.Thickness = 2
border.Parent = mainFrame
border.Transparency = 1  -- Start fully transparent

-- Create customizable shadow
local function createShadowPart(size, position, transparency)
    local shadow = Instance.new("Frame")
    shadow.BackgroundColor3 = Color3.new(0, 0, 0)
    shadow.BorderSizePixel = 0
    shadow.Size = size
    shadow.Position = position
    shadow.BackgroundTransparency = 1  -- Start fully transparent
    shadow.ZIndex = -1
    shadow.Parent = mainFrame

    local shadowCorner = Instance.new("UICorner")
    shadowCorner.CornerRadius = UDim.new(0, 6)
    shadowCorner.Parent = shadow
    
    return shadow
end

-- Create multiple shadow layers based on configuration
local shadowParts = {}
for i = 1, SHADOW_SETTINGS.BLUR do
    local size = UDim2.new(1, i * SHADOW_SETTINGS.SPREAD, 1, i * SHADOW_SETTINGS.SPREAD)
    local position = UDim2.new(0, -i * (SHADOW_SETTINGS.SPREAD / 2), 0, -i * (SHADOW_SETTINGS.SPREAD / 2))
    local transparency = SHADOW_SETTINGS.OPACITY + (i * ((1 - SHADOW_SETTINGS.OPACITY) / SHADOW_SETTINGS.BLUR))
    local shadow = createShadowPart(size, position, transparency)
    table.insert(shadowParts, {part = shadow, finalTransparency = transparency})
end

-- Create title text
local titleText = Instance.new("TextLabel")
titleText.Name = "TitleText"
titleText.Size = UDim2.new(0, 150, 1, 0)
titleText.Position = UDim2.new(0, 10, 0, 0)
titleText.BackgroundTransparency = 1
titleText.Font = Enum.Font.GothamBold
titleText.TextSize = 14
titleText.TextColor3 = Color3.new(1, 1, 1)
titleText.TextXAlignment = Enum.TextXAlignment.Left
titleText.Parent = mainFrame
titleText.Text = ""  -- Start with empty text
titleText.TextTransparency = 1  -- Start fully transparent

-- Text reveal effect
local fullText = "UserCreationHook"
local revealIndex = 0
local revealInterval = 0.5  -- 0.5 seconds per letter

local function revealNextLetter()
    revealIndex = revealIndex + 1
    if revealIndex <= #fullText then
        local visibleText = fullText:sub(1, revealIndex)
        
        -- Color "Hook" in yellow, ensuring the 'h' is also yellow
        if revealIndex > 12 then
            local userCreation = visibleText:sub(1, 12)
            local hook = visibleText:sub(13)
            titleText.RichText = true
            titleText.Text = userCreation .. '<font color="rgb(255,255,0)">' .. hook .. '</font>'
        else
            titleText.RichText = false
            titleText.Text = visibleText
        end
    else
        revealIndex = 0
    end
end

-- Improved FPS counter
local fpsFrame = Instance.new("Frame")
fpsFrame.Name = "FPSFrame"
fpsFrame.Size = UDim2.new(0, 70, 0, 20)
fpsFrame.Position = UDim2.new(1, -80, 0.5, -10)
fpsFrame.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
fpsFrame.BorderSizePixel = 0
fpsFrame.Parent = mainFrame
fpsFrame.BackgroundTransparency = 1  -- Start fully transparent

local fpsCorner = Instance.new("UICorner")
fpsCorner.CornerRadius = UDim.new(0, 4)
fpsCorner.Parent = fpsFrame

local fpsLabel = Instance.new("TextLabel")
fpsLabel.Name = "FPSLabel"
fpsLabel.Size = UDim2.new(1, -10, 1, 0)
fpsLabel.Position = UDim2.new(0, 5, 0, 0)
fpsLabel.BackgroundTransparency = 1
fpsLabel.Font = Enum.Font.GothamBold
fpsLabel.TextSize = 14
fpsLabel.TextColor3 = Color3.fromRGB(255, 255, 0)
fpsLabel.Text = "FPS: --"  -- Start with placeholder text
fpsLabel.TextXAlignment = Enum.TextXAlignment.Left
fpsLabel.Parent = fpsFrame
fpsLabel.TextTransparency = 1  -- Start fully transparent

-- Function to update FPS
local lastUpdate = tick()
local frameCount = 0

local function updateFPS()
    frameCount = frameCount + 1
    local now = tick()
    local elapsed = now - lastUpdate
    if elapsed >= 0.5 then  -- Update every 0.5 seconds for smoother display
        local fps = math.floor(frameCount / elapsed)
        fpsLabel.Text = "FPS: " .. tostring(fps)
        lastUpdate = now
        frameCount = 0
    end
end

-- Fade-in effect
local function fadeIn()
    local fadeInfo = TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    
    -- Fade in main frame
    local mainFrameFade = TweenService:Create(mainFrame, fadeInfo, {BackgroundTransparency = 0})
    mainFrameFade:Play()
    
    -- Fade in border
    local borderFade = TweenService:Create(border, fadeInfo, {Transparency = 0})
    borderFade:Play()
    
    -- Fade in shadow parts
    for _, shadowInfo in ipairs(shadowParts) do
        local shadowFade = TweenService:Create(shadowInfo.part, fadeInfo, {BackgroundTransparency = shadowInfo.finalTransparency})
        shadowFade:Play()
    end
    
    -- Fade in FPS frame and label
    local fpsFrameFade = TweenService:Create(fpsFrame, fadeInfo, {BackgroundTransparency = 0})
    fpsFrameFade:Play()
    
    local fpsLabelFade = TweenService:Create(fpsLabel, fadeInfo, {TextTransparency = 0})
    fpsLabelFade:Play()
    
    -- Fade in title text
    local titleTextFade = TweenService:Create(titleText, fadeInfo, {TextTransparency = 0})
    titleTextFade:Play()
end

-- Connect update functions
RunService.RenderStepped:Connect(updateFPS)

-- Use a separate loop for the text reveal to avoid blocking
spawn(function()
    wait(1)  -- Wait for 1 second before starting the fade-in and text reveal
    fadeIn()
    wait(1)  -- Wait for fade-in to complete before starting text reveal
    while true do
        wait(revealInterval)
        revealNextLetter()
    end
end)
