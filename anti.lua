getgenv().UsedAdonisBypass = true 

local oldfunction; 
oldfunction = hookfunction(debug.info, function(...)
    local args = {...}
    if (args[1] == 2 and args[2] == "f") then
        return nil
    else
        return oldfunction(...);
    end
end)

repeat task.wait(0.1) until game:IsLoaded()

for Index, Data in next, getgc() do
    pcall(function()
        local info = debug.getinfo(Data)
        local up = debug.getconstants(Data)
        if typeof(Data) == "function" and info.name == "Immutable" then
            hookfunction(Data, function()
                return nil
            end)
        elseif typeof(Data) == "function" and table.find(up, "MethodError") and table.find(up, "ServerError") and table.find(up, "ReadError") then
            hookfunction(Data, function()
                return nil
            end)
        elseif typeof(Data) == "function" and table.find(up, "Disconnected from server") then
            hookfunction(Data, function()
                return nil
            end)
        elseif typeof(Data) == "function" and table.find(up, "fakePlayer") then
            hookfunction(Data, function()
                return nil
            end)
        elseif typeof(Data) == "function" and table.find(up, "Tampering with Client [read rt0001]") and table.find(up, "ReadError") and table.find(up, "Potentially dangerous index") then
            hookfunction(Data, function()
                return nil
            end)
        end
    end)
end

local LocalPlayer = game.Players.LocalPlayer
local oldhmmi
local oldhmmnc
oldhmmi = hookmetamethod(game, "__index", function(self, method)
    if self == LocalPlayer and method:lower() == "kick" then
        return function()
            --print("lol dumb adonis")
        end
    end
    return oldhmmi(self, method)
end)
oldhmmnc = hookmetamethod(game, "__namecall", function(self, ...)
    if self == LocalPlayer and getnamecallmethod():lower() == "kick" then
        return
    end
    return oldhmmnc(self, ...)
end)

function findRemoteEventWithFunction(parent)
    -- Iterate through all the children of the parent
    for _, child in ipairs(parent:GetChildren()) do
        -- Check if the child is a RemoteEvent
        if child:IsA("RemoteEvent") then
            -- Iterate through all the children of the RemoteEvent
            for _, grandchild in ipairs(child:GetChildren()) do
                -- Check if the grandchild is a RemoteFunction named "__function"
                if grandchild:IsA("RemoteFunction") and grandchild.Name == "__FUNCTION" then
                    -- Return the RemoteEvent if found
                    return child
                end
            end
        end
    end
    -- Return nil if no such RemoteEvent is found
    return nil
end

local rf = findRemoteEventWithFunction(game:GetService("ReplicatedStorage"))
local ofunc
ofunc = hookfunction(rf.FireServer, function (...)
    local args = {...}
    if args[2] == "BadMemes" or table.find(args,"kick") then
        --print("blocked adonis rcall")
        return nil
    end
    --print(...)
    return ofunc(...)
end)
local foundfunc = nil
local foundtable1 = nil
local foundtable2 = nil
while getgenv().UsedAdonisBypass do
    if foundfunc == nil then
        for Index, Data in next, getgc(false) do
            pcall(function()
                local info
                if type(Data) == "function" then
                    info = debug.getinfo(Data)
                end
                if foundfunc == nil and type(Data) == "function" and info.name == "Send" and islclosure(Data) then
                    foundfunc = Data
                end
            end)
        end
        for Index, Data in next, getgc(true) do
            pcall(function()
                if foundfunc ~= nil and type(Data) == "table" and Data.CheckClient and Data.Returnables and Data.Send == foundfunc then
                    --print("Remote: " .. tostring(Data))
                    foundtable1 = Data
                end
                if type(Data) == "table" and Data.Remote and Data.DepsName then
                    --print("Client: " .. tostring(Data))
                    foundtable2 = Data
                end
            end)
        end
    else
        foundfunc("ClientCheck", {Sent = foundtable1.Sent or 0, Received = foundtable1.Received}, foundtable2.DepsName)
    end
    task.wait(10)
end

print("anti-cheat bypasser loaded")
