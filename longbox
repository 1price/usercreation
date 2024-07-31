local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TextChatService = game:GetService("TextChatService")
local IsLegacy = (TextChatService.ChatVersion == Enum.ChatVersion.LegacyChatService)
local ChatRemote = ReplicatedStorage:FindFirstChild("SayMessageRequest", true)
local Channel = not IsLegacy and TextChatService.TextChannels.RBXGeneral

local Chat = function(Message)
    if IsLegacy then
        ChatRemote:FireServer(Message, "All")
    else
        Channel:SendAsync(Message)
    end
end

Chat(" "..string.rep("ৌ", 199))
