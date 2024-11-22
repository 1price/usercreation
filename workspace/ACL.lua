--[[
    ACL used in "usercreation"
    Credits | AnthonyIsntHere & Jay
]]--

if not game:IsLoaded() then
    game.Loaded:Wait()
end

local TextChatService = game:GetService("TextChatService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local StarterGui = game:GetService("StarterGui")

if TextChatService.ChatVersion == Enum.ChatVersion.TextChatService then
    local hasExecuted = LocalPlayer:FindFirstChild("HasExecuted")
    if not hasExecuted then
        hasExecuted = Instance.new("BoolValue")
        hasExecuted.Name = "HasExecuted"
        hasExecuted.Value = false
        hasExecuted.Parent = LocalPlayer
    end

    local startTime = tick()

    local function showNotification(title, description, imageId)
        if StarterGui then
            StarterGui:SetCore("SendNotification", {
                Title = title;
                Text = description;
                Icon = imageId;
                Duration = 15;
            })
        end
    end

    local function executeScript()
        if hasExecuted.Value then
            print("ACL already loaded!")
            return
        end

        hasExecuted.Value = true

        local ACLloadTime = tick() - startTime

        print(string.format("ACL successfully loaded in %.2f seconds!", ACLloadTime))

        if setfflag then
            pcall(function()
                setfflag("AbuseReportScreenshot", "False")
                setfflag("AbuseReportScreenshotPercentage", "0")
            end)
        end

        local function AntiChatLog(message)
            if message:sub(1, 2) == "/e" then
                return message
            else
                return message .. ""
            end
        end

        TextChatService.OnIncomingMessage = function(message)
            local modifiedMessage = AntiChatLog(message.Text)
            message.Text = modifiedMessage
        end
    end

    wait(0.21)
    executeScript()

    task.spawn(function()
        if StarterGui then
            repeat
                StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, true)
                task.wait()
            until StarterGui:GetCoreGuiEnabled(Enum.CoreGuiType.Chat)
        end
    end)

else
    if not pcall(function() loadstring(game:HttpGet("https://raw.githubusercontent.com/1price/usercreation/refs/heads/main/workspace/ACL.lua"))() end) then
        loadstring(game:HttpGet("https://raw.githubusercontent.com/1price/usercreation/refs/heads/main/workspace/ACL.lua"))()
    end
end

task.spawn(function()
    repeat
        StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, true)
        task.wait()
    until StarterGui:GetCoreGuiEnabled(Enum.CoreGuiType.Chat)
end)
