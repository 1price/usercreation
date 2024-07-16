-- Load the AntiChatLogger script immediately
loadstring(game:HttpGet("https://raw.githubusercontent.com/1price/usercreation/main/AntiChatLogger%20(LEGACY).lua", true))()

-- Services
local TextChatService = game:GetService("TextChatService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local StarterGui = game:GetService("StarterGui")

-- Letter Replacement Graph
local replacementGraph = {
    [" "] = "", ["a"] = "а", ["c"] = "с", ["e"] = "е",
    ["h"] = "һ", ["i"] = "і", ["y"] = "у", ["o"] = "о",
    ["s"] = "ѕ", ["p"] = "р", ["x"] = "х", ["l"] = "ӏ",
    ["A"] = "А", ["B"] = "В", ["E"] = "Е", ["K"] = "К",
    ["M"] = "М", ["H"] = "Н", ["O"] = "О", ["P"] = "Р",
    ["C"] = "С", ["T"] = "Т", ["Y"] = "У", ["X"] = "Х",
}

-- Function to replace letters based on the graph
local function replaceLetters(message)
    local replacedMessage = ""
    for i = 1, #message do
        local char = message:sub(i, i)
        replacedMessage = replacedMessage .. (replacementGraph[char] or char)
    end
    return replacedMessage
end

-- Function to send message
local function sendMessage(message)
    local replacedMessage = replaceLetters(message)
    if TextChatService.ChatVersion == Enum.ChatVersion.TextChatService then
        -- New chat system
        TextChatService.ChatInputBarConfiguration.TargetTextChannel:SendAsync(replacedMessage)
    elseif ReplicatedStorage:FindFirstChild("DefaultChatSystemChatEvents") and ReplicatedStorage.DefaultChatSystemChatEvents:FindFirstChild("SayMessageRequest") then
        -- Legacy chat system
        ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer(replacedMessage, "All")
    else
        warn("Unable to find a suitable chat system.")
    end
end

-- Creating the chatbox
local player = Players.LocalPlayer
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "CustomChatGui"
screenGui.ResetOnSpawn = false
screenGui.Parent = player.PlayerGui

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 300, 0, 40)
frame.Position = UDim2.new(0.5, -150, 1, 10)
frame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
frame.BorderSizePixel = 0
frame.Parent = screenGui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 8)
corner.Parent = frame

local shadow = Instance.new("ImageLabel")
shadow.Size = UDim2.new(1, 20, 1, 20)
shadow.Position = UDim2.new(0.5, 0, 0.5, 0)
shadow.AnchorPoint = Vector2.new(0.5, 0.5)
shadow.BackgroundTransparency = 1
shadow.Image = "rbxassetid://5554236805"
shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
shadow.ScaleType = Enum.ScaleType.Slice
shadow.SliceCenter = Rect.new(23, 23, 277, 277)
shadow.Parent = frame

local textBox = Instance.new("TextBox")
textBox.Size = UDim2.new(1, -60, 1, -10)
textBox.Position = UDim2.new(0, 10, 0, 5)
textBox.BackgroundTransparency = 1
textBox.Font = Enum.Font.GothamSemibold
textBox.TextSize = 14
textBox.TextColor3 = Color3.new(1, 1, 1)
textBox.PlaceholderText = "Type your message here..."
textBox.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
textBox.TextXAlignment = Enum.TextXAlignment.Left
textBox.ClearTextOnFocus = false
textBox.Parent = frame

-- Keybind button
local keybindButton = Instance.new("TextButton")
keybindButton.Size = UDim2.new(0, 40, 0, 30)
keybindButton.Position = UDim2.new(1, -50, 0, 5)
keybindButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
keybindButton.BorderSizePixel = 0
keybindButton.Font = Enum.Font.GothamBold
keybindButton.TextSize = 12
keybindButton.TextColor3 = Color3.new(1, 1, 1)
keybindButton.Text = "/"
keybindButton.Parent = frame

local keybindCorner = Instance.new("UICorner")
keybindCorner.CornerRadius = UDim.new(0, 4)
keybindCorner.Parent = keybindButton

-- Chat toggle flag and current keybind
local isChatVisible = false
local currentKeybind = Enum.KeyCode.Slash
local isChangingKeybind = false

-- Animation functions
local function showChat()
    frame.Position = UDim2.new(0.5, -150, 1, 10)
    local goal = {}
    goal.Position = UDim2.new(0.5, -150, 1, -50)
    
    local tween = TweenService:Create(frame, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), goal)
    tween:Play()
    
    isChatVisible = true
    task.wait(0.1) -- Short delay before focusing to avoid capturing the keybind
    if not isChangingKeybind then
        textBox:CaptureFocus()
    end
end

local function hideChat()
    if isChangingKeybind then return end
    
    local goal = {}
    goal.Position = UDim2.new(0.5, -150, 1, 10)
    
    local tween = TweenService:Create(frame, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.In), goal)
    tween:Play()
    
    isChatVisible = false
    textBox:ReleaseFocus()
    textBox.Text = ""  -- Clear the textbox when hiding
end

-- Detecting enter key press or focus lost
textBox.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        if textBox.Text ~= "" then
            sendMessage(textBox.Text)
        end
    end
    hideChat()
end)

-- Disable default chat
StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, false)

-- Keybind change function
local function changeKeybind()
    isChangingKeybind = true
    keybindButton.Text = "..."
    keybindButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
    
    local connection
    connection = UserInputService.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Keyboard then
            currentKeybind = input.KeyCode
            keybindButton.Text = string.sub(tostring(input.KeyCode), 14)
            keybindButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
            isChangingKeybind = false
            connection:Disconnect()
        end
    end)
end

keybindButton.MouseButton1Click:Connect(function()
    if not isChatVisible then
        showChat()
    end
    changeKeybind()
end)

-- Detect custom keybind
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if input.KeyCode == currentKeybind and not isChangingKeybind then
        if not isChatVisible then
            showChat()
        else
            hideChat()
        end
    end
end)

-- Initially hide the chat
hideChat()

-- Re-enable our custom chat functionality when the default chat tries to open
StarterGui.CoreGuiChangedSignal:Connect(function(coreGuiType)
    if coreGuiType == Enum.CoreGuiType.Chat then
        StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, false)
        if not isChatVisible then
            showChat()
        end
    end
end)