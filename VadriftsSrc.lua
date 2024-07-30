--OrionHub source for future me: https://raw.githubusercontent.com/shlexware/Orion/main/source


Events = true -- Allow RemoteEvents (if true, blocks if false) --fucntion hook detect bypass (for events)
Requests = false -- Allow RemoteFunctions (if true, blocks if false) --fucntion hook detect bypass (for Requests)
local getinfo = getinfo or debug.getinfo
local DEBUG = false
local Hooked = {}

local Detected, Kill

setthreadidentity(2)

for i, v in getgc(true) do
    if typeof(v) == "table" then
        local DetectFunc = rawget(v, "Detected")
        local KillFunc = rawget(v, "Kill")
    
        if typeof(DetectFunc) == "function" and not Detected then
            Detected = DetectFunc
            
            local Old; Old = hookfunction(Detected, function(Action, Info, NoCrash)
                if Action ~= "_" then
                    if DEBUG then
                        warn("Adonis AntiCheat flagged\nMethod: {Action}\nInfo: {Info}")
                    end
                end
                
                return true
            end)

            table.insert(Hooked, Detected)
        end

        if rawget(v, "Variables") and rawget(v, "Process") and typeof(KillFunc) == "function" and not Kill then
            Kill = KillFunc
            local Old; Old = hookfunction(Kill, function(Info)
                if DEBUG then
                    warn("Adonis AntiCheat tried to kill (fallback): {Info}")
                end
            end)

            table.insert(Hooked, Kill)
        end
    end
end

local Old; Old = hookfunction(getrenv().debug.info, newcclosure(function(...)
    local LevelOrFunc, Info = ...

    if Detected and LevelOrFunc == Detected then
        if DEBUG then
            warn("zins | adonis bypassed")
        end

        return coroutine.yield(coroutine.running())
    end
    
    return Old(...)
end))
-- setthreadidentity(9)
setthreadidentity(7)
    wait(0.1)

repeat task.wait() until game:IsLoaded()

local TextChatService = game:GetService("TextChatService")
local Players = game:GetService("Players")

if TextChatService.ChatVersion == Enum.ChatVersion.TextChatService then
    game:GetService("Players").LocalPlayer:Kick("This game uses ModernChatService which Vadrifts does not support.")
    return
end
wait(0.1)

loadstring(game:HttpGet('https://raw.githubusercontent.com/AnthonyIsntHere/anthonysrepository/main/scripts/AntiChatLogger.lua'))()

local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()
local Window = OrionLib:MakeWindow({ Name = "vadrifts.byp |  V1.3.9", HidePremium = false, SaveConfig = save, ConfigFolder ="OrionTest", ScriptIntro = enabled, IntroText = "V3rge's bypassing society" })

local startTime = tick()

local Tab = Window:MakeTab({
    Name = "Script Setup",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

local Section = Tab:AddSection({
    Name = "Loading"
})
Tab:AddParagraph("Loading..", "Please wait")
Tab:AddParagraph("Quick Tip!","If the script isn't loading, it could be due to your device or executor!")

local function loadScript()

    local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()
    local Window = OrionLib:MakeWindow({ Name = "vadrifts.byp |  V1.3.9", HidePremium = false, SaveConfig = save, ConfigFolder = "OrionTest", IntroEnabled = false })

    local endTime = tick()
    local loadTime = endTime - startTime
    game.StarterGui:SetCore("SendNotification",
        { Title = "Loaded!", Text = "Succesfully loaded in " ..
        loadTime .. " seconds.", Duration = 5, })

    local Tab = Window:MakeTab({
        Name = "Home",
        Icon = "rbxassetid://4483345998",
        PremiumOnly = false
    })
local Section = Tab:AddSection({
    Name = "Discord"
})

local playerName = game.Players.LocalPlayer.Name

Tab:AddButton({
    Name = "Welcome " .. playerName .. ", updates n stuff @ our discord",
    Callback = function()
    end
})

Tab:AddButton({
    Name = "Discord | Click To Copy (TW: Small Server)",
    Callback = function()
setclipboard("https://dsc.gg/vadriftz")
    end
}) 

local Section = Tab:AddSection({
    Name = "UI Stuff"
})

  Tab:AddButton({
    Name = "Close Interface",
    Callback = function()
OrionLib:Destroy()
    end
})

Tab:AddButton({
    Name = "Un-hide UI button (when ui closed)",
    Callback = function()
        local Toggle = Instance.new("ScreenGui")
        local UIToggle = Instance.new("TextButton")
        local CloseButton = Instance.new("TextButton")
        Toggle.Name = "Un-Hide"
        Toggle.Parent = game.CoreGui
        UIToggle.Name = "Un-hide"
        UIToggle.Parent = Toggle
        UIToggle.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
        UIToggle.BackgroundTransparency = 0
        UIToggle.Position = UDim2.new(0, 0, 0.454706937, 0)
        UIToggle.Size = UDim2.new(0.0650164187, 0, 0.0888099447, 0)
        UIToggle.Font = Enum.Font.SourceSans
        UIToggle.Text = "Un-Hide!"
        UIToggle.TextColor3 = Color3.fromRGB(75, 0, 130)
        UIToggle.TextSize = 24.000
        UIToggle.TextXAlignment = Enum.TextXAlignment.Left

        local UserInputService = game:GetService("UserInputService")
        local dragging = false
        local dragStart
        local startPos

        local function updateDragging(input)
            local delta = input.Position - dragStart
            UIToggle.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end

        UIToggle.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                dragging = true
                dragStart = input.Position
                startPos = UIToggle.Position
            end
        end)

        UIToggle.InputChanged:Connect(function(input)
            if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                updateDragging(input)
            end
        end)

        UIToggle.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                dragging = false
            end
        end)

        local function executeScript()
            if OrionLib and OrionLib.Destroy then
                OrionLib:Destroy() -- Reduces lag
            end
            if loadScript then
                loadScript() -- Reopens script
            end
        end

        UIToggle.MouseButton1Click:Connect(executeScript)

        -- Create a close button
        CloseButton.Name = "CloseButton"
        CloseButton.Parent = UIToggle
        CloseButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        CloseButton.BackgroundTransparency = 0
        CloseButton.Position = UDim2.new(0.8, 0, 0.1, 0)
        CloseButton.Size = UDim2.new(0.2, 0, 0.2, 0)
        CloseButton.Font = Enum.Font.SourceSans
        CloseButton.TextColor3 = Color3.fromRGB(255, 0, 0)
        CloseButton.TextSize = 16
        CloseButton.Text = "X"
        CloseButton.MouseButton1Click:Connect(function()
            UIToggle:Destroy() -- Destroy the UI elements when the close button is clicked
        end)
    end
})


local Section = Tab:AddSection({
    Name = "Help"
})
Tab:AddParagraph("Notice","If the script gives you a warning on execution, that means that game isn't supported!")
 Tab:AddLabel("Your account must be 13+ for everything to work.")
 Tab:AddLabel("If something gets tagged, say something normal and try again.")
 Tab:AddLabel("Everyone can see the things you say in chat.")
 Tab:AddLabel("For more info go and ask on the Discord")

local Section = Tab:AddSection({
    Name = "Credits"
})

 Tab:AddLabel("B4krs - Development and bypassing.")
 Tab:AddLabel("Sauce_boss01 - Made some Bypasses")
 Tab:AddLabel("clickgameplay - Automatic chat bypasser")
 Tab:AddLabel("Anthony - Chat Logger")
 Tab:AddLabel("OG Vadrifts - Most bypass ideas")
 Tab:AddLabel("d34dly - Made some Bypasses")
 Tab:AddLabel("Dank6s - Script setup")
 Tab:AddLabel("N4 - Made some Bypasses")
 Tab:AddLabel("Tyler - Made some Bypasses")
 Tab:AddLabel("BANANAN. - Development.")

local Section = Tab:AddSection({
    Name = "More Vadrifts/V3rge Scripts"
})

  Tab:AddButton({
    Name = "V3rg. Horrific Housing (OUTDATED)",
    Callback = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/BakaPraselol/HH-loader1/main/HH"))()
    end
})

Tab:AddParagraph("Creating more soon..","Making scripts actually work..")

local Tab = Window:MakeTab({
    Name = "Bypassed Words",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

local Section = Tab:AddSection({
    Name = "Extra"
})


Tab:AddParagraph("Recommended Games"," Rate My Avatar                                                 Public Bathroom Simlator                                                               White room                                                        Natrual Disaster Survival                                                        Ragdoll Engine                                                 Spray Paint!")

  Tab:AddButton({
    Name = "Automatic Chat Bypasser",
    Callback = function()
game.StarterGui:SetCore("SendNotification", {Title="Activated"; Text="Try saying a swear in chat!"; Duration=5;})
print(string.format("vdr.ACB: The Automatic Chat Bypasses has every bypass from the script with some extra ones, for example:"))
print(string.format("wife, suck, kill, yourself, fuck(sometimes works).. And more!"))

repeat task.wait() until game:IsLoaded()
loadstring(game:HttpGet('https://raw.githubusercontent.com/AnthonyIsntHere/anthonysrepository/main/scripts/AntiChatLogger.lua'))()
wait(0.1)
local chatService, players = game:GetService("Chat"), game:GetService("Players")

local custom_chars = {
    [" "] = "",
    ["stfu"] = "ѕ󠀕󠀕t󠀕󠀕󠀕󠀕󠀕󠀕󠀕󠀕󠀖󠀕⁥⁥⁥⁥f󠀖󠀕⁥⁥⁥u",
    ["asshole"] = "аѕѕ⁥⁥⁥һоlе",
    ["ass"] = "а⁥⁥⁥ѕ⁥⁥⁥ѕ",
    ["arse"] = "аr⁥⁥ѕ⁥е",
    ["anus"] = "а⁥⁥⁥n⁥⁥⁥u⁥⁥⁥ѕ⁥⁥⁥",
    ["Anus"] = "A⁥⁥⁥n⁥⁥⁥u⁥⁥⁥ѕ⁥⁥⁥",
    ["anal"] = "аn⁥⁥⁥⁥аl",
    ["blowjob"] = "bӏow⁥⁥⁥j⁥⁥⁥о⁥⁥⁥b⁥⁥⁥",
    ["boner"] = "⁥В⁥⁥o⁥⁥n⁥⁥е⁥⁥r",
    ["boobies"] = "bо⁥⁥⁥⁥⁥⁥⁥⁥оbіеs",
    ["bullshit"] = "bulӏsһ⁥⁥⁥⁥⁥⁥⁥⁥іt",
    ["bastard"] = "bas⁥⁥⁥⁥⁥⁥⁥⁥tard",
    ["beaner"] = "b⁥⁥⁥е⁥⁥⁥а⁥⁥⁥n⁥⁥⁥е⁥⁥⁥r",
    ["butthole"] = "bu⁥⁥⁥⁥⁥⁥⁥⁥tthоle",
    ["bootyhole"] = "b󠀕󠀕󠀕󠀕о⁥⁥⁥⁥󠀕󠀕⁥⁥⁥⁥о󠀕󠀕󠀕󠀕󠀕󠀕ty󠀕󠀕󠀕󠀕һoӏe",
    ["bondage"] = "b⁥⁥⁥о⁥⁥⁥n⁥⁥⁥d⁥⁥⁥а⁥⁥⁥g⁥⁥⁥е⁥⁥⁥",
    ["Bondage"] = "B⁥⁥⁥о⁥⁥⁥n⁥⁥⁥d⁥⁥⁥а⁥⁥⁥g⁥⁥⁥е⁥⁥⁥",
    ["butt"] = "bu⁥⁥⁥⁥⁥⁥⁥⁥tt",
    ["booty"] = "b󠀕󠀕󠀕󠀕о⁥⁥⁥⁥󠀕󠀕⁥⁥⁥⁥о󠀕󠀕󠀕󠀕󠀕󠀕ty",
    ["boobs"] = "b󠀕󠀕󠀕󠀕о⁥⁥⁥⁥󠀕󠀕⁥⁥⁥о󠀕󠀕󠀕󠀕󠀕󠀕󠀕󠀕b󠀕󠀕󠀕󠀕ѕ",
    ["boob"] = "bооb",
    ["breasts"] = "brеаѕtѕ",
    ["bbc"] = "b⁥⁥⁥b⁥⁥⁥с",
    ["bitch"] = "⁥⁥b⁥⁥⁥і⁥⁥⁥t󠀕󠀕󠀖󠀖󠀗⁥⁥⁥с⁥⁥⁥󠀕󠀕󠀖󠀖󠀗h󠀕󠀕󠀖󠀖󠀗",
    ["Bitch"] = "⁥⁥B⁥⁥⁥і⁥⁥⁥t󠀕󠀕󠀖󠀖󠀗⁥⁥⁥с⁥⁥⁥󠀕󠀕󠀖󠀖󠀗h󠀕󠀕󠀖󠀖󠀗",
    ["bitches"] = "￰￰b￰￰і󠀕⁥⁥⁥⁥⁥⁥⁥⁥⁥󠀕󠀕󠀕󠀕t⁥⁥⁥⁥󠀕с⁥⁥⁥⁥󠀕һ⁥⁥⁥⁥󠀕󠀕󠀕󠀕е⁥⁥⁥⁥s",
    ["Bitches"] = "￰￰B￰￰і󠀕⁥⁥⁥⁥⁥⁥⁥⁥⁥󠀕󠀕󠀕󠀕t⁥⁥⁥⁥󠀕с⁥⁥⁥⁥󠀕һ⁥⁥⁥⁥󠀕󠀕󠀕󠀕е⁥⁥⁥⁥s",
    ["cocaine"] = "с⁥⁥⁥о⁥⁥⁥с⁥⁥⁥а⁥⁥⁥i⁥⁥⁥n⁥⁥⁥е",
    ["creampie"] = "с⁥⁥⁥r⁥⁥⁥е⁥⁥⁥а⁥⁥⁥m⁥⁥⁥р⁥⁥⁥i⁥⁥⁥е",
    ["cum"] = "с⁥⁥⁥⁥um",
    ["cunts"] = "сu⁥⁥⁥⁥⁥⁥⁥⁥ntѕ",
    ["cunt"] = "⁥⁥⁥с󠀕󠀕󠀕󠀕󠀕⁥⁥⁥⁥⁥⁥⁥⁥⁥󠀕󠀕󠀕󠀕󠀖󠀕u⁥⁥⁥⁥󠀕󠀕󠀕󠀕󠀕⁥⁥⁥⁥⁥⁥⁥⁥⁥󠀕󠀕󠀕󠀕󠀖󠀕n⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥t",
    ["cock"] = "с⁥⁥⁥о⁥⁥⁥с⁥⁥⁥k",
    ["cuck"] = "с⁥⁥⁥u⁥⁥⁥с⁥⁥⁥k",
    ["cuckold"] = "с⁥⁥⁥u⁥⁥⁥с⁥⁥⁥k⁥⁥⁥о⁥⁥⁥ӏ⁥⁥⁥d⁥⁥⁥",
    ["condoms"] = "с⁥⁥⁥о⁥⁥⁥n⁥⁥⁥d⁥⁥⁥о⁥⁥⁥m⁥⁥⁥s",
    ["condom"] = "с⁥⁥⁥о⁥⁥⁥n⁥⁥⁥d⁥⁥⁥о⁥⁥⁥m",
    ["coochies"] = "с⁥⁥⁥о⁥⁥⁥о⁥⁥⁥с⁥⁥⁥һ⁥⁥⁥і⁥⁥⁥е⁥⁥⁥s",
    ["coochie"] = "с⁥⁥⁥о⁥⁥⁥o⁥⁥⁥с⁥⁥⁥һ⁥⁥⁥i⁥⁥⁥е",
    ["crap"] = "сr⁥⁥⁥⁥ар",
    ["Crap"] = "сr⁥⁥⁥⁥ар",
    ["CRAP"] = "сr⁥⁥⁥⁥ар",
    ["cunny"] = "сu⁥⁥⁥⁥⁥⁥n⁥⁥⁥⁥⁥⁥nу",
    ["Cunny"] = "сu⁥⁥⁥⁥⁥⁥n⁥⁥⁥⁥⁥⁥nу",
    ["clit"] = "с󠀕󠀕⁥І󠀕󠀕⁥і󠀕󠀕⁥t",
    ["Clit"] = "с󠀕󠀕⁥І󠀕󠀕⁥і󠀕󠀕⁥t",
    ["dumbass"] = "du⁥⁥⁥⁥⁥⁥mb⁥⁥⁥⁥⁥⁥аѕѕ",
    ["discord"] = "dіѕсоrd",
    ["dickhead"] = "d￰￰￰￰￰і￰￰￰￰￰c￰￰￰￰￰kһ￰￰￰￰￰еad",
    ["dick"] = "d⁥⁥⁥⁥i󠀕󠀕󠀕󠀕󠀕󠀕󠀕󠀕󠀕󠀖󠀕⁥⁥⁥⁥c󠀕󠀕󠀕󠀕󠀕󠀕󠀕󠀕󠀕󠀖󠀕⁥⁥⁥⁥k",
    ["damn"] = "d⁥⁥⁥а⁥⁥⁥m⁥⁥⁥n⁥⁥⁥",
    ["doggystyle"] = "d⁥⁥⁥о⁥⁥⁥g⁥⁥⁥g⁥⁥⁥у⁥⁥⁥s⁥⁥⁥t⁥⁥⁥у⁥⁥⁥ӏ⁥⁥⁥е",
    ["Doggystyle"] = "D⁥⁥⁥о⁥⁥⁥g⁥⁥⁥g⁥⁥⁥у⁥⁥⁥s⁥⁥⁥t⁥⁥⁥у⁥⁥⁥ӏ⁥⁥⁥е",
    ["fatass"] = "fat￰￰￰а￰￰￰￰￰￰￰￰￰￰￰￰⁥ѕ￰￰ѕ",
    ["fucked"] = "󠀕󠀕󠀕f￰￰￰￰￰￰uс￰￰󠀕󠀕󠀕󠀕￰￰￰￰￰￰k￰￰￰￰￰￰￰￰e￰￰￰￰d",
    ["femboy"] = "fеmbоy",
    ["femboys"] = "fеmbоys",
    ["fuckers"] = "󠀕󠀕󠀕f￰￰￰￰￰￰uс￰￰󠀕󠀕󠀕󠀕￰￰￰￰￰￰k￰￰￰￰￰￰￰￰e￰￰￰￰󠀕󠀕󠀕rѕ",
    ["Fuckers"] = "󠀕󠀕󠀕F￰￰￰￰￰￰uс￰￰󠀕󠀕󠀕󠀕￰￰￰￰￰￰k￰￰￰￰￰￰￰￰e￰￰￰￰󠀕󠀕󠀕rѕ",
    ["faggot"] = "⁥⁥⁥⁥f⁥󠀕⁥ а󠀕󠀕󠀕󠀕󠀕󠀕󠀕⁥⁥⁥⁥g󠀕󠀕󠀕󠀕󠀕󠀕󠀕⁥⁥⁥⁥g⁥⁥о󠀕󠀕⁥⁥󠀕󠀕󠀕󠀕󠀕⁥⁥⁥⁥t⁥⁥",
    ["Faggot"] = "⁥⁥⁥⁥F⁥󠀕⁥ а󠀕󠀕󠀕󠀕󠀕󠀕󠀕⁥⁥⁥⁥g󠀕󠀕󠀕󠀕󠀕󠀕󠀕⁥⁥⁥⁥g⁥⁥о󠀕󠀕⁥⁥󠀕󠀕󠀕󠀕󠀕⁥⁥⁥⁥t⁥⁥",
    ["Fag"] = "⁥⁥⁥⁥F⁥󠀕⁥ а󠀕󠀕󠀕󠀕󠀕󠀕󠀕⁥⁥⁥⁥g",
    ["fag"] = "⁥⁥⁥⁥f⁥󠀕⁥ а󠀕󠀕󠀕󠀕󠀕󠀕󠀕⁥⁥⁥⁥g",
    ["fap"] = "f⁥󠀕⁥⁥а⁥󠀕⁥⁥р",
    ["fanny"] = "fa⁥⁥⁥⁥⁥⁥n⁥⁥⁥⁥⁥⁥nу",
    ["horny"] = "һ⁥⁥⁥⁥⁥о󠀕󠀕󠀕󠀕r⁥⁥⁥⁥⁥n⁥⁥⁥⁥⁥у",
    ["hitler"] = "Нi󠀗󠀕󠀕󠀕󠀕󠀕󠀖󠀖⁥⁥⁥⁥tl⁥⁥⁥⁥󠀗󠀕󠀕󠀕󠀕󠀕󠀖е󠀗󠀕󠀕󠀕󠀕󠀕󠀖󠀖󠀗󠀕󠀕󠀕󠀕󠀕󠀖󠀖r",
    ["hoes"] = "һоеѕ",
    ["hoe"] = "һое",
    ["instagram"] = "і󠀕󠀕󠀕󠀕󠀕󠀕󠀕⁥⁥⁥⁥n󠀕󠀕󠀕󠀕󠀕󠀕󠀕⁥⁥⁥⁥ѕ󠀕󠀕󠀕󠀕󠀕󠀕󠀕⁥⁥⁥⁥tаg󠀕󠀕󠀕󠀕rаm",
    ["insta"] = "і󠀕󠀕󠀕󠀕󠀕󠀕󠀕⁥⁥⁥⁥n󠀕󠀕󠀕󠀕󠀕󠀕󠀕⁥⁥⁥⁥ѕ󠀕󠀕󠀕󠀕󠀕󠀕󠀕⁥⁥⁥⁥tа",
    ["Instagram"] = "і󠀕󠀕󠀕󠀕󠀕󠀕󠀕⁥⁥⁥⁥n󠀕󠀕󠀕󠀕󠀕󠀕󠀕⁥⁥⁥⁥ѕ󠀕󠀕󠀕󠀕󠀕󠀕󠀕⁥⁥⁥⁥tаg󠀕󠀕󠀕󠀕rаm",
    ["Insta"] = "і󠀕󠀕󠀕󠀕󠀕󠀕󠀕⁥⁥⁥⁥n󠀕󠀕󠀕󠀕󠀕󠀕󠀕⁥⁥⁥⁥ѕ󠀕󠀕󠀕󠀕󠀕󠀕󠀕⁥⁥⁥⁥tа",
    ["kys"] = "k⁥⁥⁥⁥⁥⁥⁥⁥y⁥⁥⁥ѕ",
    ["lmfao"] = "ӏm⁥⁥⁥⁥⁥⁥⁥⁥fа⁥⁥о",
    ["lmao"] = "ӏ󠀕󠀕󠀕󠀕󠀕󠀕󠀕󠀕󠀖󠀕⁥⁥⁥⁥maо",
    ["Lmao"] = "ӏ󠀕󠀕󠀕󠀕󠀕󠀕󠀕󠀕󠀖󠀕⁥⁥⁥⁥maо",
    ["motherfucker"] = "mot￰￰￰￰￰￰￰h￰e￰rf￰￰￰￰￰u￰с￰￰￰￰￰￰￰￰k￰e￰￰￰￰￰￰￰￰r",
    ["masturbate"] = "m󠀕󠀕󠀕󠀕󠀕󠀕󠀕󠀕󠀕󠀖󠀕a󠀕󠀕󠀕󠀕󠀕󠀕󠀕󠀕󠀕󠀖󠀕ѕ󠀕󠀕󠀕󠀕󠀕󠀕󠀕󠀕󠀕󠀖󠀕t󠀕󠀕󠀕󠀕󠀕󠀕󠀕󠀕󠀕󠀖󠀕u󠀕󠀕󠀕󠀕󠀕󠀕󠀕󠀕󠀕󠀖󠀕r󠀕󠀕󠀕󠀕󠀕󠀕󠀕󠀕󠀕󠀖󠀕b󠀕󠀕󠀕󠀕󠀕󠀕󠀕󠀕󠀕󠀖󠀕a󠀕󠀕󠀕󠀕󠀕󠀕󠀕󠀕󠀕󠀖󠀕t󠀕󠀕󠀕󠀕󠀕󠀕󠀕󠀕󠀕󠀖󠀕e",
    ["Masturbate"] = "М⁥⁥⁥а⁥⁥⁥ѕ⁥⁥⁥t⁥⁥⁥u⁥⁥⁥r⁥⁥⁥b⁥⁥⁥а⁥⁥⁥t⁥⁥⁥е",
    ["masturbating"] = "m⁥⁥⁥а⁥⁥⁥ѕ⁥⁥⁥t⁥⁥⁥u⁥⁥⁥r⁥⁥⁥b⁥⁥⁥а⁥⁥⁥t⁥⁥⁥ing",
    ["meth"] = "mе⁥⁥⁥⁥⁥⁥⁥⁥th",
    ["naked"] = "nаkеd",
    ["nudes"] = "nudеѕ",
    ["nude"] = "n󠀕󠀕󠀕󠀕󠀕󠀕󠀕󠀕󠀕󠀖󠀕u󠀕󠀕󠀕󠀕󠀕󠀕󠀕󠀕󠀕󠀖󠀕d󠀕󠀕󠀕󠀕󠀕󠀕󠀕󠀕󠀕󠀖󠀕е",
    ["Nude"] = "N󠀕󠀕󠀕󠀕󠀕󠀕󠀕󠀕󠀕󠀖󠀕u󠀕󠀕󠀕󠀕󠀕󠀕󠀕󠀕󠀕󠀖󠀕d󠀕󠀕󠀕󠀕󠀕󠀕󠀕󠀕󠀕󠀖󠀕е",
    ["negro"] = "n󠀕󠀕󠀕󠀕󠀕󠀕󠀕e󠀕󠀕󠀕󠀕󠀕󠀕󠀕g󠀕󠀕󠀕󠀕󠀕󠀕󠀕r󠀕󠀕󠀕󠀕󠀕󠀕󠀕o",
    ["Negro"] = "n󠀕󠀕󠀕󠀕󠀕󠀕󠀕e󠀕󠀕󠀕󠀕󠀕󠀕󠀕g󠀕󠀕󠀕󠀕󠀕󠀕󠀕r󠀕󠀕󠀕󠀕󠀕󠀕󠀕o",
    ["nipples"] = "n󠀕󠀕⁥i󠀕󠀕⁥⁥󠀕р⁥p󠀕󠀖⁥⁥󠀕l󠀕󠀕󠀕⁥⁥󠀕󠀕󠀖󠀕e󠀖⁥⁥ѕ",
    ["nipple"] = "n󠀕󠀕⁥i󠀕󠀕⁥⁥󠀕р⁥p󠀕󠀖⁥⁥󠀕l󠀕󠀕󠀕⁥⁥󠀕󠀕󠀖󠀕e󠀖⁥⁥",
    ["Nipples"] = "N󠀕󠀕⁥i󠀕󠀕⁥⁥󠀕р⁥p󠀕󠀖⁥⁥󠀕l󠀕󠀕󠀕⁥⁥󠀕󠀕󠀖󠀕e󠀖⁥⁥ѕ",
    ["Nipple"] = "N󠀕󠀕⁥i󠀕󠀕⁥⁥󠀕р⁥p󠀕󠀖⁥⁥󠀕l󠀕󠀕󠀕⁥⁥󠀕󠀕󠀖󠀕e󠀖⁥⁥",
    ["orgasm"] = "оrg⁥⁥⁥⁥аѕm",
    ["omfg"] = "оm⁥⁥⁥⁥⁥⁥⁥⁥fg",
    ["pedophile"] = "p⁥⁥е⁥⁥⁥d⁥⁥⁥⁥⁥⁥⁥ор⁥⁥hіӏ⁥⁥⁥⁥⁥⁥⁥е",
    ["pornhub"] = "⁥⁥р󠀕󠀕󠀕󠀕󠀕󠀕󠀕о󠀕󠀕󠀕󠀕󠀕󠀕󠀕r󠀕󠀕󠀕󠀕󠀕󠀕󠀕n󠀕󠀕󠀕󠀕󠀕󠀕󠀕һ󠀕󠀕󠀕󠀕󠀕󠀕󠀕u󠀕󠀕󠀕󠀕󠀕󠀕󠀕b",
    ["penis"] = "pen󠀕󠀖󠀗󠀘󠀕󠀖⁥⁥⁥⁥⁥⁥⁥⁥󠀕і󠀖󠀗󠀘󠀖󠀗ѕ",
    ["porn"] = "роrn",
    ["pussies"] = "р⁥⁥⁥u⁥⁥⁥s⁥⁥⁥s⁥⁥⁥i⁥⁥⁥е⁥⁥⁥s",
    ["pussy"] = "р⁥⁥⁥u⁥⁥⁥s⁥⁥⁥s⁥⁥⁥у",
    ["piss"] = "рі󠀕󠀕󠀕󠀕⁥⁥⁥⁥⁥⁥󠀕󠀕󠀕󠀖󠀕ss",
    ["queer"] = "󠀕󠀕￰￰󠀕q￰￰￰󠀕󠀕󠀕￰￰￰u￰￰￰￰￰￰e󠀕󠀕󠀕￰￰￰￰￰￰e￰￰￰￰￰￰r",
    ["Queer"] = "󠀕󠀕￰￰󠀕Q￰￰￰󠀕󠀕󠀕￰￰￰u￰￰￰￰￰￰e󠀕󠀕󠀕￰￰￰￰￰￰e￰￰￰￰￰￰r",
    ["rape"] = "rаре",
    ["retarded"] = "r⁥⁥⁥⁥еt⁥⁥⁥⁥󠀗󠀕󠀕ar⁥⁥⁥⁥dе󠀗󠀕󠀕󠀕󠀕󠀕󠀖󠀖󠀗󠀕󠀕󠀕󠀕󠀕󠀖󠀖d",
    ["Retarded"] = "R⁥⁥⁥⁥еt⁥⁥⁥⁥󠀗󠀕󠀕ar⁥⁥⁥⁥dе󠀗󠀕󠀕󠀕󠀕󠀕󠀖󠀖󠀗󠀕󠀕󠀕󠀕󠀕󠀖󠀖d",
    ["retard"] = "⁥⁥r⁥󠀕󠀕󠀕󠀕󠀕󠀕󠀕󠀖󠀕е󠀖󠀕t 󠀕󠀕󠀕󠀕󠀖󠀕а⁥⁥⁥󠀕󠀕󠀕󠀖󠀕r󠀕󠀕󠀕⁥⁥⁥⁥󠀕d",
    ["Retard"] = "⁥⁥R⁥󠀕󠀕󠀕󠀕󠀕󠀕󠀕󠀖󠀕е󠀖󠀕t 󠀕󠀕󠀕󠀕󠀖󠀕а⁥⁥⁥󠀕󠀕󠀕󠀖󠀕r󠀕󠀕󠀕⁥⁥⁥⁥󠀕d",
    ["rizz"] = "rіzz",
    ["Rizz"] = "Rіzz",
    ["stripper"] = "ѕtrірреr",
    ["slave"] = "ѕ⁥⁥⁥ӏ⁥⁥⁥а⁥⁥⁥v⁥⁥⁥е",
    ["seduce"] = "ѕеduсе",
    ["slut"] = "sӏut",
    ["shit"] = "ѕһ⁥⁥⁥⁥󠀗󠀕󠀕󠀕󠀕󠀖i⁥⁥⁥⁥󠀗󠀕󠀕󠀕t",
    ["sexy"] = "ѕеху",
    ["sex"] = "ѕ⁥⁥⁥е⁥⁥⁥х⁥⁥⁥",
    ["sperm"] = "ѕpе󠀕￰￰￰￰󠀖r￰󠀖m",
    ["Sperm"] = "ѕpе󠀕￰￰￰￰󠀖r￰󠀖m",
    ["Semen"] = "ѕ󠀕󠀖󠀗󠀘⁥⁥⁥⁥⁥⁥⁥⁥emen",
    ["semen"] = "ѕ󠀕󠀖󠀗󠀘⁥⁥⁥⁥⁥⁥⁥⁥emen",
    ["schlong"] = "ѕс⁥⁥⁥⁥һ󠀗󠀕󠀕󠀕󠀕ӏо⁥⁥⁥⁥n󠀗󠀕󠀕󠀕󠀕󠀕󠀖󠀖󠀗g",
    ["titties"] = "t⁥⁥⁥⁥⁥⁥і⁥⁥⁥⁥⁥⁥t⁥⁥⁥⁥⁥⁥t⁥⁥⁥⁥⁥⁥і⁥⁥⁥⁥⁥⁥е⁥⁥⁥⁥⁥⁥ѕ",
    ["thots"] = "t󠀗󠀕󠀕󠀕󠀕󠀕󠀖󠀖󠀗󠀕󠀕󠀕󠀕󠀕󠀖󠀖󠀗󠀕󠀕󠀕󠀕󠀕󠀖󠀖h⁥⁥⁥󠀗󠀕󠀕оt󠀗󠀕󠀕󠀕󠀕󠀕⁥⁥⁥⁥ѕ",
    ["thot"] = "t󠀗󠀕󠀕󠀕󠀕󠀕󠀖󠀖󠀗󠀕󠀕󠀕󠀕󠀕󠀖󠀖󠀗󠀕󠀕󠀕󠀕󠀕󠀖󠀖h⁥⁥⁥󠀗󠀕󠀕оt",
    ["tits"] = "t󠀗󠀕󠀕󠀕󠀕󠀕i⁥⁥⁥⁥t⁥⁥⁥⁥ѕ",
    ["tit"] = "⁥⁥⁥t󠀗󠀕⁥⁥⁥⁥⁥⁥⁥⁥󠀕󠀕󠀕󠀕і⁥⁥⁥⁥t",
    ["virginity"] = "v￰￰￰￰￰￰і￰￰￰￰￰￰￰￰r￰￰￰￰￰￰￰￰g￰￰￰￰￰￰￰￰￰і￰￰￰￰￰￰￰￰n￰￰￰￰￰￰￰і￰￰￰￰t￰￰￰у",
    ["virgins"] = "v󠀗󠀕󠀕󠀕󠀕󠀕󠀖󠀖󠀗ir⁥⁥⁥⁥󠀗󠀕󠀕󠀕󠀕󠀕gi󠀗󠀕󠀕󠀕󠀕󠀕󠀖󠀖󠀗󠀕󠀕󠀕󠀕󠀕󠀖󠀖ns",
    ["vagina"] = "⁥⁥v󠀗󠀕󠀕󠀕󠀕⁥⁥⁥⁥󠀕󠀖⁥⁥⁥⁥а󠀗󠀕󠀕󠀕g⁥⁥⁥⁥і⁥⁥⁥⁥󠀗󠀕n⁥⁥⁥⁥󠀗󠀕󠀕󠀕󠀕󠀕󠀖󠀖a",
    ["virgin"] = "v󠀕￰￰￰￰￰￰󠀘і󠀖￰￰￰￰￰￰￰￰󠀘r󠀕￰￰￰￰￰￰￰￰󠀖g󠀖￰￰￰￰￰￰￰￰￰󠀘і󠀘￰￰￰￰￰￰￰￰n",
    ["whore"] = "w⁥⁥⁥һ⁥⁥⁥о⁥⁥⁥r⁥⁥⁥е",
    ["weed"] = "⁥⁥⁥⁥w⁥󠀕⁥eed",
    ["Weed"] = "⁥⁥⁥⁥W⁥󠀕⁥eed",
    ["ASS"] = "АЅЅ",
    ["ANUS"] = "АΝUЅ",
    ["ARSE"] = "А⁥⁥⁥R⁥⁥⁥⁥⁥󠀕󠀕󠀕Ѕ⁥⁥⁥⁥⁥⁥Е",
    ["ASSHOLE"] = "АЅЅНОLЕ",
    ["ANAL"] = "АΝ⁥⁥⁥⁥⁥⁥АL",
    ["BASTARD"] = "ВАЅТАRD",
    ["BONER"] = "⁥В⁥⁥O⁥⁥N⁥⁥Е⁥⁥R",
    ["BONDAGE"] = "В󠀕󠀕󠀕󠀕󠀕󠀕󠀕⁥⁥⁥⁥О󠀕󠀕󠀕󠀕󠀕󠀕󠀕⁥⁥⁥⁥Ν󠀕󠀕󠀕󠀕󠀕󠀕󠀕⁥⁥⁥⁥D󠀕󠀕󠀕󠀕󠀕󠀕󠀕⁥⁥⁥⁥АGЕ",
    ["BONDAGE"] = "В󠀕󠀕󠀕󠀕󠀕󠀖LОW󠀕󠀕󠀕󠀕󠀕󠀖ЈО󠀕󠀕󠀕󠀕󠀕󠀖В",
    ["BITCHES"] = "В￰￰￰￰￰￰￰I￰￰￰￰￰￰Т￰￰￰￰￰￰СНЕS",
    ["BITCH"] = "В￰￰￰￰￰￰￰I￰￰￰￰￰￰Т￰￰￰￰￰￰СН",
    ["BOOBS"] = "ВООВS",
    ["BOOB"] = "ВООВ",
    ["BUTTHOLE"] = "ВUТТ⁥⁥⁥⁥НOLЕ",
    ["BUTT"] = "ВUТТ",
    ["BOOTY"] = "ВООТΥ",
    ["BULLSHIT"] = "В󠀖󠀖⁥⁥⁥⁥UL󠀖󠀖⁥⁥⁥⁥LЅН󠀖󠀖⁥⁥⁥⁥ӀТ",
    ["BEANER"] = "В󠀕󠀕󠀕󠀕󠀕󠀕󠀕⁥⁥⁥⁥ЕА󠀕󠀕󠀕󠀕󠀕󠀕󠀕⁥⁥⁥⁥Ν󠀕󠀕󠀕󠀕󠀕󠀕󠀕⁥⁥⁥⁥Е󠀕󠀕󠀕󠀕󠀕󠀕󠀕⁥⁥⁥⁥R",
    ["CUNTS"] = "СU⁥⁥⁥⁥⁥⁥⁥⁥NТЅ",
    ["COCAINE"] = "С󠀕󠀕󠀕󠀕󠀕󠀕󠀕⁥⁥⁥⁥ОСА󠀕󠀕󠀕󠀕󠀕󠀕󠀕⁥⁥⁥⁥ӀΝ󠀕󠀕󠀕󠀕󠀕󠀕󠀕⁥⁥⁥⁥Е",
    ["COOCHIES"] = "С󠀕󠀕󠀕O󠀕󠀕󠀕󠀕⁥⁥⁥⁥ОСН󠀕󠀕󠀕󠀕󠀕󠀕󠀕⁥⁥⁥⁥Ӏ󠀕󠀕󠀕󠀕󠀕󠀕󠀕⁥⁥⁥⁥ЕS",
    ["COOCHIE"] = "С󠀕󠀕󠀕O󠀕󠀕󠀕󠀕⁥⁥⁥⁥ОСН󠀕󠀕󠀕󠀕󠀕󠀕󠀕⁥⁥⁥⁥Ӏ󠀕󠀕󠀕󠀕󠀕󠀕󠀕⁥⁥⁥⁥Е",
    ["CUNT"] = "СU⁥⁥⁥⁥⁥⁥⁥⁥NТ",
    ["CUCKOLD"] = "С󠀕󠀕󠀕󠀕󠀕󠀕󠀕⁥⁥⁥⁥U󠀕󠀕󠀕󠀕󠀕󠀕󠀕⁥⁥⁥⁥С󠀕󠀕󠀕󠀕󠀕󠀕󠀕⁥⁥⁥⁥KOLD",
    ["CUCK"] = "С󠀕󠀕󠀕󠀕󠀕󠀕󠀕⁥⁥⁥⁥U󠀕󠀕󠀕󠀕󠀕󠀕󠀕⁥⁥⁥⁥С󠀕󠀕󠀕󠀕󠀕󠀕󠀕⁥⁥⁥⁥K",
    ["CREAMPIE"] = "С󠀕󠀕󠀕󠀕󠀕󠀕󠀕⁥⁥⁥⁥R󠀕󠀕󠀕󠀕󠀕󠀕󠀕⁥⁥⁥⁥Е󠀕󠀕󠀕󠀕󠀕󠀕󠀕⁥⁥⁥⁥АМ󠀕󠀕󠀕󠀕󠀕󠀕󠀕⁥⁥⁥PIE",
    ["CUM"] = "СUМ",
    ["COCK"] = "СОСK",
    ["DISCORD"] = "DӀЅСОRD",
    ["DUMBASS"] = "D󠀕󠀕󠀕󠀕󠀕⁥⁥⁥⁥⁥⁥⁥⁥⁥󠀕󠀕UM⁥⁥⁥⁥⁥⁥⁥⁥⁥BАЅЅ",
    ["DAMN"] = "DАМΝ",
    ["DICKHEAD"] = "D⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥IСΚНЕ󠀕⁥⁥󠀕AD",
    ["DICK"] = "D⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥IСΚ",
    ["FAGGOT"] = "F󠀕󠀖󠀗󠀘￰￰￰￰￰￰￰￰￰￰￰￰￰￰￰￰󠀕󠀖󠀗󠀘А󠀕󠀖󠀗󠀘󠀕󠀖￰￰￰￰￰￰󠀕G⁥⁥󠀖󠀗󠀘󠀖󠀗󠀘⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥󠀘󠀘G󠀖󠀗󠀘󠀖󠀗󠀘￰￰￰￰￰￰￰О󠀖󠀗󠀘￰￰￰￰￰󠀖󠀗Т",
    ["FATASS"] = "F⁥⁥⁥А⁥⁥⁥ТА⁥⁥⁥Ѕ⁥⁥⁥Ѕ",
    ["FEMBOYS"] = "FЕМВОΥЅ",
    ["FEMBOY"] = "FЕМВОΥ",
    ["HITLER"] = "НӀ⁥⁥⁥⁥⁥⁥⁥⁥ТL⁥⁥⁥⁥⁥⁥⁥⁥Е⁥⁥R",
    ["HENTAI"] = "НЕ⁥⁥⁥⁥Ν⁥ТАӀ",
    ["HORNY"] = "НОRNY",
    ["HOES"] = "НОЕЅ",
    ["HOE"] = "НОЕ",
    ["KYS"] = "ΚΥЅ",
    ["LMFAO"] = "LМFАО",
    ["LMAO"] = "LМАО",
    ["MASTURBATE"] = "МАЅТURВАТΕ",
    ["MASTURBATE"] = "МО󠀕󠀕󠀕󠀖󠀖ТНЕ󠀕󠀕󠀕󠀖󠀖R󠀕󠀕F⁥⁥⁥⁥⁥󠀕󠀕󠀕󠀕󠀕󠀖󠀖󠀗󠀕󠀕󠀕󠀕󠀕󠀖󠀖⁥⁥⁥⁥⁥⁥⁥UC⁥⁥⁥ΚЕ⁥⁥⁥R",
    ["NUDES"] = "ΝUDЕЅ",
    ["NUDE"] = "Ν󠀕󠀕󠀕󠀕󠀕󠀖󠀖󠀗󠀕󠀕U󠀕󠀕󠀕󠀕󠀕󠀖󠀖󠀗󠀕󠀕D󠀕󠀕󠀕󠀕󠀕󠀖󠀖󠀗󠀕󠀕Е",
    ["NEGRO"] = "NE󠀕󠀕⁥⁥󠀕G󠀕󠀖⁥⁥󠀕R󠀕󠀕󠀕⁥⁥󠀕󠀕󠀖󠀕O",
    ["NIPPLES"] = "Ν󠀕󠀕⁥Ӏ󠀕󠀕⁥⁥󠀕P⁥⁥P󠀕󠀖⁥⁥󠀕L󠀕󠀕󠀕⁥⁥󠀕󠀕󠀖󠀕Е󠀖⁥⁥Ѕ",
    ["NIPPLE"] = "Ν󠀕󠀕⁥Ӏ󠀕󠀕⁥⁥󠀕P⁥⁥P󠀕󠀖⁥⁥󠀕L󠀕󠀕󠀕⁥⁥󠀕󠀕󠀖󠀕Е󠀖⁥⁥",
    ["NAKED"] = "ΝΑKΕD",
    ["OMFG"] = "ОM⁥⁥⁥⁥⁥⁥⁥⁥FG",
    ["PENIS"] = "PEN⁥⁥ӀS",
    ["PUSSIES"] = "Р⁥⁥⁥U⁥⁥⁥Ѕ⁥⁥⁥S⁥⁥⁥Ӏ⁥⁥⁥Е⁥⁥⁥Ѕ",
    ["PUSSY"] = "Р󠀕󠀕󠀕󠀖⁥⁥⁥⁥⁥󠀖󠀗󠀕U⁥⁥⁥⁥⁥Ѕ󠀕󠀕󠀕󠀖⁥⁥⁥⁥⁥󠀖󠀗󠀕S󠀕⁥⁥⁥⁥⁥󠀕󠀖󠀖󠀗󠀕Υ",
    ["PISS"] = "РӀ󠀕󠀕󠀕󠀕⁥⁥⁥⁥⁥⁥󠀕󠀕󠀕󠀖󠀕SS",
    ["PORN"] = "РО󠀕⁥⁥⁥⁥⁥⁥⁥⁥⁥󠀕󠀕󠀕󠀕RΝ",
    ["RETARD"] = "R⁥⁥⁥⁥E⁥⁥⁥T⁥⁥⁥⁥A⁥⁥⁥R⁥⁥⁥⁥D",
    ["RAPE"] = "RАРЕ",
    ["SHIT"] = "ЅH⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥IT",
    ["SEX"] = "ЅЕХ",
    ["SLUT"] = "ЅL⁥⁥⁥⁥UТ",
    ["SLAVE"] = "ЅLА󠀗󠀕󠀕󠀕󠀕󠀕󠀖󠀖󠀗󠀕󠀕󠀕󠀕󠀕󠀖󠀖󠀗󠀕󠀕󠀕󠀕󠀕󠀖󠀖󠀗󠀕󠀕󠀕󠀕󠀕󠀖󠀖󠀗󠀕󠀕󠀕󠀕󠀕󠀖󠀖󠀗󠀕󠀕󠀕󠀕󠀕󠀖󠀖󠀗󠀕󠀕󠀕󠀕󠀕󠀖󠀖󠀗󠀕󠀕󠀕󠀕󠀕󠀖󠀖󠀗󠀕󠀕󠀕󠀕󠀕󠀖󠀖󠀗󠀕󠀕󠀕󠀕󠀕󠀖󠀖󠀗󠀕󠀕󠀕󠀕󠀕󠀖󠀖󠀗󠀕󠀕󠀕󠀕󠀕󠀖󠀖󠀗󠀕󠀕󠀕󠀕󠀕󠀖󠀖󠀗󠀕󠀕󠀕󠀕󠀕󠀖󠀖󠀗󠀕󠀕󠀕󠀕󠀕󠀖󠀖󠀗󠀕󠀕󠀕󠀕󠀕󠀖󠀖VE",
    ["TITTIES"] = "ТIТТIES",
    ["TITS"] = "ТIТЅ",
    ["THOT"] = "ТН⁥⁥⁥⁥⁥ОТ",
    ["THOTS"] = "ТН⁥⁥⁥⁥⁥ОТЅ",
    ["VIRGINITY"] = "V￰￰￰￰￰￰Ӏ￰￰￰￰￰￰￰￰R￰￰￰￰￰￰￰￰G￰￰￰￰￰￰￰￰￰Ӏ￰￰￰￰￰￰￰￰ΝITY",
    ["VIRGINS"] = "V￰￰￰￰￰￰I￰￰￰￰￰￰￰￰R￰￰￰￰￰￰￰￰G￰￰￰￰￰￰￰￰￰INS",
    ["VIRGIN"] = "V￰￰￰￰￰￰I￰￰￰￰￰￰￰￰R￰￰￰￰￰￰￰￰G￰￰￰￰￰￰￰￰￰I￰￰￰￰￰￰￰￰N",
    ["VAGINA"] = "V￰￰￰￰￰￰А￰￰￰￰￰￰￰￰G￰￰￰￰￰￰￰￰Ӏ￰￰￰￰￰￰￰￰￰N￰￰￰￰￰￰￰￰А",
    ["XXX"] = "X⁥⁥⁥⁥XX",
    ["WHORE"] = "W⁥⁥⁥Н⁥⁥⁥О⁥⁥⁥R⁥⁥⁥Е",
    ["WEED"] = "⁥⁥⁥⁥W⁥󠀕EED",
    ["blacked.com"] = "blacked.c⁥⁥⁥о⁥⁥⁥m", --Nsfw websites
    ["pornhub.com"] = "р⁥⁥⁥о⁥⁥⁥r⁥⁥⁥n⁥⁥⁥һ⁥⁥⁥u⁥⁥⁥b.c⁥⁥⁥о⁥⁥⁥m",
    ["XVIDEOS.COM"] = "Х󠀕󠀕󠀕󠀕⁥⁥⁥⁥⁥⁥󠀕󠀕󠀕󠀖󠀕VӀ⁥⁥⁥⁥⁥⁥D⁥⁥⁥󠀕󠀕󠀕Е⁥⁥⁥󠀕󠀕󠀕ОЅ.С⁥⁥⁥󠀕󠀕󠀕ОМ",
    ["https://blacked.com"] = "httрs:/⁥⁥⁥/blacked.c⁥⁥⁥о⁥⁥⁥m",
    ["PORNHUB.COM"] = "Р⁥⁥⁥О⁥⁥⁥R⁥⁥⁥Ν⁥⁥⁥Н⁥⁥⁥U⁥⁥⁥В.С⁥⁥⁥О⁥⁥⁥М⁥⁥⁥",
    ["Asshole"] = "аѕѕ⁥⁥⁥һоlе", --Capitals at the first letter
    ["Ass"] = "а⁥⁥⁥ѕ⁥⁥⁥ѕ",
    ["Arse"] = "аr⁥⁥ѕ⁥е",
    ["Anal"] = "аn⁥⁥⁥⁥аl",
    ["Blowjob"] = "Bӏow⁥⁥⁥j⁥⁥⁥о⁥⁥⁥b⁥⁥⁥",
    ["Boner"] = "⁥В⁥⁥o⁥⁥n⁥⁥е⁥⁥r",
    ["Boobies"] = "Bо⁥⁥⁥⁥⁥⁥⁥⁥оbіеs",
    ["Bullshit"] = "Bulӏsһ⁥⁥⁥⁥⁥⁥⁥⁥іt",
    ["Bastard"] = "Bas⁥⁥⁥⁥⁥⁥⁥⁥tard",
    ["Beaner"] = "B⁥⁥⁥е⁥⁥⁥а⁥⁥⁥n⁥⁥⁥е⁥⁥⁥r",
    ["Butthole"] = "Bu⁥⁥⁥⁥⁥⁥⁥⁥tthоle",
    ["Bootyhole"] = "B⁥⁥⁥о⁥⁥⁥о⁥⁥⁥t⁥⁥⁥уhole",
    ["Butt"] = "bu⁥⁥⁥⁥⁥⁥⁥⁥tt",
    ["Booty"] = "bооty",
    ["Boobs"] = "b󠀕󠀕󠀕󠀕о⁥⁥⁥⁥󠀕󠀕⁥⁥⁥о󠀕󠀕󠀕󠀕󠀕󠀕󠀕󠀕b󠀕󠀕󠀕󠀕ѕ",
    ["Boob"] = "bооb",
    ["Breats"] = "Brеаѕtѕ",
    ["Bbc"] = "B⁥⁥⁥b⁥⁥⁥с",
    ["Cocaine"] = "с⁥⁥⁥о⁥⁥⁥с⁥⁥⁥а⁥⁥⁥i⁥⁥⁥n⁥⁥⁥е",
    ["Creampie"] = "с⁥⁥⁥r⁥⁥⁥е⁥⁥⁥а⁥⁥⁥m⁥⁥⁥р⁥⁥⁥i⁥⁥⁥е",
    ["Cum"] = "с⁥⁥⁥⁥um",
    ["Cunts"] = "сu⁥⁥⁥⁥⁥⁥⁥⁥ntѕ",
    ["Cunt"] = "⁥⁥⁥с󠀕󠀕󠀕󠀕󠀕⁥⁥⁥⁥⁥⁥⁥⁥⁥󠀕󠀕󠀕󠀕󠀖󠀕u⁥⁥⁥⁥󠀕󠀕󠀕󠀕󠀕⁥⁥⁥⁥⁥⁥⁥⁥⁥󠀕󠀕󠀕󠀕󠀖󠀕n⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥t",
    ["Cock"] = "с⁥⁥⁥о⁥⁥⁥с⁥⁥⁥k",
    ["Cuck"] = "с⁥⁥⁥u⁥⁥⁥с⁥⁥⁥k",
    ["Cuckold"] = "с⁥⁥⁥u⁥⁥⁥с⁥⁥⁥k⁥⁥⁥о⁥⁥⁥ӏ⁥⁥⁥d⁥⁥⁥",
    ["Condoms"] = "с⁥⁥⁥о⁥⁥⁥n⁥⁥⁥d⁥⁥⁥о⁥⁥⁥m⁥⁥⁥s",
    ["Condom"] = "с⁥⁥⁥о⁥⁥⁥n⁥⁥⁥d⁥⁥⁥о⁥⁥⁥m",
    ["Coochies"] = "с⁥⁥⁥о⁥⁥⁥о⁥⁥⁥с⁥⁥⁥һ⁥⁥⁥і⁥⁥⁥е⁥⁥⁥s",
    ["Coochie"] = "с⁥⁥⁥о⁥⁥⁥o⁥⁥⁥с⁥⁥⁥һ⁥⁥⁥i⁥⁥⁥е",
    ["Dumbass"] = "Du⁥⁥⁥⁥⁥⁥mb⁥⁥⁥⁥⁥⁥аѕѕ",
    ["Discord"] = "Dіѕсоrd",
    ["Dickhead"] = "D￰￰￰￰￰і￰￰￰￰￰c￰￰￰￰￰kһ￰￰￰￰￰еad",
    ["Dick"] = "D⁥⁥⁥⁥i󠀕󠀕󠀕󠀕󠀕󠀕󠀕󠀕󠀕󠀖󠀕⁥⁥⁥⁥c󠀕󠀕󠀕󠀕󠀕󠀕󠀕󠀕󠀕󠀖󠀕⁥⁥⁥⁥k",
    ["Damn"] = "D⁥⁥⁥а⁥⁥⁥m⁥⁥⁥n⁥⁥⁥",
    ["E-Sex"] = "Е￰￰￰-￰￰￰Ѕ￰￰￰е￰￰￰х",
    ["e-Sex"] = "Е￰￰￰-￰￰￰Ѕ￰￰￰е￰￰￰х",
    ["e-sex"] = "Е￰￰￰-￰￰￰Ѕ￰￰￰е￰￰￰х",
    ["E-Rape"] = "Е-Rаре",
    ["E-rape"] = "Е-rаре",
    ["e-rape"] = "Е-rаре",
    ["Fatass"] = "Fat￰￰￰а￰￰￰￰￰￰￰￰￰￰￰￰⁥ѕ￰￰ѕ",
    ["Fucked"] = "󠀕󠀕󠀕F￰￰￰￰￰￰uс￰￰󠀕󠀕󠀕󠀕￰￰￰￰￰￰k￰￰￰￰￰￰￰￰e￰￰￰￰d",
    ["Femboy"] = "Fеmbоy",
    ["Femboys"] = "Fеmbоys",
    ["Horny"] = "һ⁥⁥⁥⁥⁥о󠀕󠀕󠀕󠀕r⁥⁥⁥⁥⁥n⁥⁥⁥⁥⁥у",
    ["Hitler"] = "Нi󠀗󠀕󠀕󠀕󠀕󠀕󠀖󠀖⁥⁥⁥⁥tl⁥⁥⁥⁥󠀗󠀕󠀕󠀕󠀕󠀕󠀖е󠀗󠀕󠀕󠀕󠀕󠀕󠀖󠀖󠀗󠀕󠀕󠀕󠀕󠀕󠀖󠀖r",
    ["Hentai"] = "H󠀕󠀕󠀕󠀕󠀕󠀕󠀕󠀕󠀕󠀖󠀕e󠀕󠀕󠀕󠀕󠀕󠀕󠀕󠀕󠀕󠀖󠀕n󠀕󠀕󠀕󠀕󠀕󠀕󠀕󠀕󠀕󠀖󠀕t󠀕󠀕󠀕󠀕󠀕󠀕󠀕󠀕󠀕󠀖󠀕a󠀕󠀕󠀕󠀕󠀕󠀕󠀕󠀕󠀕󠀖󠀕i", 
    ["hentai"] = "h󠀕󠀕󠀕󠀕󠀕󠀕󠀕󠀕󠀕󠀖󠀕e󠀕󠀕󠀕󠀕󠀕󠀕󠀕󠀕󠀕󠀖󠀕n󠀕󠀕󠀕󠀕󠀕󠀕󠀕󠀕󠀕󠀖󠀕t󠀕󠀕󠀕󠀕󠀕󠀕󠀕󠀕󠀕󠀖󠀕a󠀕󠀕󠀕󠀕󠀕󠀕󠀕󠀕󠀕󠀖󠀕i", 
    ["Hoes"] = "һоеѕ",
    ["Hoe"] = "һое",
    ["Kys"] = "K⁥⁥⁥⁥⁥⁥⁥⁥y⁥⁥⁥ѕ",
    ["Lmfao"] = "Lm⁥⁥⁥⁥⁥⁥⁥⁥fа⁥⁥о",
    ["Motherfucker"] = "Mot￰￰￰￰￰￰￰h￰e￰rf￰￰￰￰￰u￰с￰￰￰￰￰￰￰￰k￰e￰￰￰￰￰￰￰￰r",
    ["Masturbating"] = "M⁥⁥⁥а⁥⁥⁥ѕ⁥⁥⁥t⁥⁥⁥u⁥⁥⁥r⁥⁥⁥b⁥⁥⁥а⁥⁥⁥t⁥⁥⁥ing",
    ["Meth"] = "Mе⁥⁥⁥⁥⁥⁥⁥⁥th",
    ["Naked"] = "Nаkеd",
    ["Nudes"] = "Nudеѕ",
    ["Orgasm"] = "оrg⁥⁥⁥⁥аѕm",
    ["Omfg"] = "оm⁥⁥⁥⁥⁥⁥⁥⁥fg",
    ["Pedophile"] = "p⁥⁥е⁥⁥⁥d⁥⁥⁥⁥⁥⁥⁥ор⁥⁥hіӏ⁥⁥⁥⁥⁥⁥⁥е",
    ["Pornhub"] = "роrnhub",
    ["Penis"] = "pen󠀕󠀖󠀗󠀘󠀕󠀖⁥⁥⁥⁥⁥⁥⁥⁥󠀕і󠀖󠀗󠀘󠀖󠀗ѕ",
    ["Porn"] = "роrn",
    ["Pussies"] = "р⁥⁥⁥u⁥⁥⁥s⁥⁥⁥s⁥⁥⁥i⁥⁥⁥е⁥⁥⁥s",
    ["Pussy"] = "р⁥⁥⁥u⁥⁥⁥s⁥⁥⁥s⁥⁥⁥у",
    ["Rape"] = "Rаре",
    ["Stripper"] = "Strірреr",
    ["Slave"] = "ѕ⁥⁥⁥ӏ⁥⁥⁥а⁥⁥⁥v⁥⁥⁥е",
    ["Seduce"] = "ѕеduсе",
    ["Slut"] = "sӏut",
    ["Shit"] = "ѕһ⁥⁥⁥⁥󠀗󠀕󠀕󠀕󠀕󠀖i⁥⁥⁥⁥󠀗󠀕󠀕󠀕t",
    ["Sexy"] = "ѕеху",
    ["Sex"] = "ѕ⁥⁥⁥е⁥⁥⁥х⁥⁥⁥",
    ["Titties"] = "T⁥⁥⁥⁥⁥⁥і⁥⁥⁥⁥⁥⁥t⁥⁥⁥⁥⁥⁥t⁥⁥⁥⁥⁥⁥і⁥⁥⁥⁥⁥⁥е⁥⁥⁥⁥⁥⁥ѕ",
    ["Thots"] = "T⁥⁥⁥⁥⁥⁥⁥⁥h⁥⁥⁥⁥⁥⁥⁥⁥otѕ",
    ["Thot"] = "T⁥⁥⁥⁥⁥⁥⁥⁥h⁥⁥⁥⁥⁥⁥⁥⁥ot",
    ["Tits"] = "T⁥⁥⁥⁥⁥⁥⁥⁥і⁥⁥⁥⁥⁥⁥⁥⁥ts",
    ["Tit"] = "Tіt",
    ["Virginity"] = "V￰￰￰￰￰￰і￰￰￰￰￰￰￰￰r￰￰￰￰￰￰￰￰g￰￰￰￰￰￰￰￰￰і￰￰￰￰￰￰￰￰n￰￰￰￰￰￰￰і￰￰￰￰t￰￰￰у",
    ["Virgin"] = "V￰￰￰￰￰￰і￰￰￰￰￰￰￰￰r￰￰￰￰￰￰￰￰g￰￰￰￰￰￰￰￰￰і￰￰￰￰￰￰￰￰n￰￰￰￰￰￰￰s",
    ["Vagina"] = "V󠀕󠀕󠀕󠀕󠀕󠀕󠀕󠀕󠀕󠀖󠀕a󠀕󠀕󠀕󠀕󠀕󠀕󠀕󠀕󠀕󠀖󠀕g󠀕󠀕󠀕󠀕󠀕󠀕󠀕󠀕󠀕󠀖󠀕і󠀕󠀕󠀕󠀕󠀕󠀕󠀕󠀕󠀕󠀖󠀕n󠀕󠀕󠀕󠀕󠀕󠀕󠀕󠀕󠀕󠀖󠀕a",
    ["fuck you"] = "f󠀕󠀖󠀗󠀘󠀕󠀖󠀗󠀘󠀕󠀖󠀗󠀘󠀕󠀖󠀗󠀘󠀕󠀖󠀗󠀘󠀕󠀖󠀗󠀘󠀕󠀖󠀗󠀘󠀕󠀖uc󠀕󠀖󠀗󠀘󠀕󠀖󠀗󠀘󠀕󠀖󠀗󠀘󠀕󠀖󠀗󠀘󠀕󠀖󠀗󠀘󠀕󠀖󠀗󠀘󠀕󠀖󠀗󠀘󠀕󠀖ky󠀕󠀖󠀗󠀘󠀕󠀖󠀗󠀘󠀕󠀖󠀗󠀘󠀕󠀖󠀗󠀘󠀕󠀖󠀗󠀘󠀕󠀖󠀗󠀘󠀕󠀖󠀗󠀘󠀕󠀖o󠀕󠀖󠀗󠀘󠀕󠀖󠀗󠀘󠀕󠀖󠀗󠀘󠀕󠀖󠀗󠀘󠀕󠀖󠀗󠀘󠀕󠀖󠀗󠀘󠀕󠀖󠀗󠀘󠀕󠀖u",
    ["what the fuck"] = "wha⁥⁥⁥⁥⁥⁥tt⁥⁥⁥⁥⁥⁥һеf⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥uс⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥k",
    ["shut the fuck up"] = "sһ⁥⁥⁥⁥⁥⁥utt⁥⁥⁥⁥⁥⁥һеf⁥⁥⁥⁥⁥⁥⁥⁥⁥u⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥c⁥ku⁥⁥⁥⁥⁥⁥⁥⁥⁥p",
    ["go fuck yourself"] = "gof⁥⁥⁥⁥⁥⁥⁥⁥⁥u⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥c⁥kу⁥⁥⁥⁥⁥о⁥⁥urself",
    ["fuck"] = "f⁥⁥⁥⁥⁥⁥⁥⁥uсk", --Sometimes worksb
    ["fucking"] = "f⁥⁥⁥⁥⁥⁥⁥⁥uсking",
    ["Fuck"] = "F⁥⁥⁥⁥⁥⁥⁥⁥uсk",
    ["Fucking"] = "F⁥⁥⁥⁥⁥⁥⁥⁥uсking",
    ["FUCKING"] = " F⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥UСΚӀ󠀕󠀕󠀕󠀖󠀕N⁥⁥⁥⁥⁥⁥⁥⁥󠀕󠀕G ", 
    ["FUCKERS"] = "󠀕󠀕F⁥⁥⁥⁥⁥󠀕󠀕󠀕󠀕󠀕󠀖󠀖󠀗󠀕󠀕󠀕󠀕󠀕󠀖󠀖⁥⁥⁥⁥⁥⁥⁥UС⁥⁥⁥ΚЕ⁥⁥⁥R󠀕󠀕󠀕󠀕S",
    ["FUCKER"] = "󠀕󠀕F⁥⁥⁥⁥⁥󠀕󠀕󠀕󠀕󠀕󠀖󠀖󠀗󠀕󠀕󠀕󠀕󠀕󠀖󠀖⁥⁥⁥⁥⁥⁥⁥UC⁥⁥⁥ΚЕ⁥⁥⁥R",
    ["FUCKED"] = "F⁥⁥⁥⁥⁥󠀕󠀕󠀕󠀕󠀕󠀖󠀖󠀗󠀕󠀕󠀕󠀕󠀕󠀖󠀖⁥⁥⁥⁥⁥⁥⁥UС⁥⁥⁥ΚЕ⁥⁥⁥D",
    ["FUCK"] = "F⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥UСΚ", --always works
    ["FUCKS"] = "F⁥⁥⁥⁥U󠀕󠀕󠀕󠀕󠀕󠀕󠀕󠀕󠀕󠀖󠀕⁥⁥⁥⁥C󠀕󠀕󠀕󠀕󠀕󠀕󠀕󠀕󠀕󠀖󠀕⁥⁥⁥⁥ΚS", 
    ["bites your cock"] = "bіtеѕуоurсосk", --Sentences that dont work normally
    ["big black cock"] = "big black сосk",
    ["masturbates"] = "ma⁥⁥⁥⁥⁥󠀕󠀕󠀕󠀕⁥⁥⁥st⁥⁥⁥⁥⁥󠀕󠀕󠀕󠀕⁥⁥⁥ur󠀕󠀕b󠀕󠀕a󠀕󠀕t󠀕󠀕e󠀕󠀕s",
    ["suck my cock retard"] = "ѕuсk my сосk ret⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥аrd",
    ["i pull all the bitches"] = "i pull all the bitсһеs",
    ["small penis"] = "small рen⁥⁥⁥⁥⁥⁥⁥⁥iѕ",
    ["nigger"] = "n⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥і⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥ggеr",
    ["niggers"] = "n⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥і⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥ggеrѕ",
    ["suck my cock"] = "ѕ⁥⁥⁥u⁥⁥⁥с⁥⁥⁥kmyсо⁥⁥⁥сk",
    ["lets have sex"] = "⁥⁥⁥ӏ⁥⁥⁥е⁥⁥⁥t⁥⁥⁥ѕ ⁥⁥⁥һ⁥⁥⁥а⁥⁥⁥v⁥⁥⁥е⁥⁥⁥ ѕ⁥⁥⁥е⁥⁥⁥х⁥⁥⁥",
    ["I HAVE A MASSIVE COCK"] = "I HAVE A MASSIVE СОСK",
    ["SHUT THE FUCK UP"] = "SHUTTHEF￰￰￰￰￰￰UС￰￰￰￰￰￰￰￰ΚUР",
    ["I AM ABOUT TO CUM"] = "IАМ АВOU￰￰￰TTOС￰￰￰U￰￰￰М",
    ["wife"] = "wіfе", --Extra
    ["suck"] = "ѕuсk",
    ["love"] = "ӏ⁥⁥⁥о⁥⁥⁥⁥⁥⁥⁥⁥⁥vе",
    ["pregnant"] = "рrеgnаnt",
    ["mommy"] = "mоmmу",
    ["daddy"] = "d⁥⁥⁥а⁥⁥⁥d⁥⁥⁥d⁥⁥⁥у",
    ["WIFE"] = "WIFΕ",
    ["SUCK"] = "SUСK",
    ["kill"] = "k󠀕󠀕󠀕і󠀕󠀕󠀕l󠀕󠀕󠀕ӏ",
    ["yourself"] = "уо󠀕󠀕⁥⁥⁥⁥ur󠀕󠀕⁥⁥⁥⁥ѕ󠀕󠀕⁥⁥⁥⁥еlf",
    ["pedo"] = "p⁥⁥е⁥⁥⁥d⁥⁥⁥⁥⁥⁥⁥о"
}

local default = ""

local player = players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local chatGui, chatBar = playerGui:WaitForChild("Chat")

repeat task.wait() until chatGui:FindFirstChild("ChatBar", true)
chatBar = chatGui:FindFirstChild("ChatBar", true)

do
    local randomstr = function()
        local characters = {"a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"}
        local str = ""
        local length = math.random(12, 32)

        for i = 1, length do
            str = str .. characters[math.random(#characters)]
        end
        return str
    end
    task.spawn(function()
        while wait(.1) do
            if chatBar:IsFocused() then
                chatService:FilterStringForBroadcast(randomstr(), player)
            end
        end
    end)
end

local c = function()
    for i = 1, 2 do
        game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("/e Hey how are you doing?", "All")
        game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("/e How are you doing?", "All")
    end
end

local old
old = hookmetamethod(game, "__namecall", newcclosure(function(self, ...)
    local method = getnamecallmethod()
    local args = {...}

    if method == "FireServer" and self.Name == "SayMessageRequest" and #args == 2 and not checkcaller() then
        local newMessage = args[1]
        for i,v in pairs(custom_chars) do
            local rep = string.gsub(newMessage, i, v .. "⁥")
            newMessage = rep
        end
        newMessage = "" .. newMessage .. default

        args[1] = newMessage
        coroutine.wrap(c)
        return old(self, unpack(args))
    end
    return old(self, ...)
end))
    end
})

  Tab:AddButton({
    Name = "Fix Bypasses",
    Callback = function()
game.StarterGui:SetCore("SendNotification", {Title="Info"; Text="The button prevents tagging; once clicked, it stops tagging the bypasses for a bit."; Duration=5;})
      game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("abcdeABCDE12345~`|•√?x", "All")
    end
})

local Section = Tab:AddSection({
    Name = "lowercase A-Z"
})

  Tab:AddButton({
    Name = "asshole",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("аѕѕ⁥⁥⁥һоlе", "All")
    end
})

  Tab:AddButton({
    Name = "ass",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("а⁥⁥⁥ѕ⁥⁥⁥ѕ", "All")
    end
})

  Tab:AddButton({
    Name = "anus",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("а⁥⁥⁥n⁥⁥⁥u⁥⁥⁥ѕ⁥⁥⁥", "All")
    end
})

  Tab:AddButton({
    Name = "arse ",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("аr⁥⁥ѕ⁥е", "All")
    end
})

  Tab:AddButton({
    Name = "anal",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("аn⁥⁥⁥⁥аl", "All")
    end
})

  Tab:AddButton({
    Name = "Boner",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("⁥В⁥⁥o⁥⁥n⁥⁥е⁥⁥r", "All")
    end
})

  Tab:AddButton({
    Name = "blowjob",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("bӏow⁥⁥⁥j⁥⁥⁥о⁥⁥⁥b⁥⁥⁥", "All")
    end
})

  Tab:AddButton({
    Name = "bitches ",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("￰￰b￰￰і󠀕⁥⁥⁥⁥⁥⁥⁥⁥⁥󠀕󠀕󠀕󠀕t⁥⁥⁥⁥󠀕с⁥⁥⁥⁥󠀕һ⁥⁥⁥⁥󠀕󠀕󠀕󠀕е⁥⁥⁥⁥s", "All")
    end
})

  Tab:AddButton({
    Name = "bitch ",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("⁥⁥b⁥⁥⁥і⁥⁥⁥t󠀕󠀕󠀖󠀖󠀗⁥⁥⁥с⁥⁥⁥󠀕󠀕󠀖󠀖󠀗h󠀕󠀕󠀖󠀖󠀗", "All")
    end
})

  Tab:AddButton({
    Name = "boobies ",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("bо⁥⁥⁥⁥⁥⁥⁥⁥оbіеs", "All")
    end
})

  Tab:AddButton({
    Name = "bullshit ",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("bulӏsһ⁥⁥⁥⁥⁥⁥⁥⁥іt", "All")
    end
})

  Tab:AddButton({
    Name = "bastard ",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("bas⁥⁥⁥⁥⁥⁥⁥⁥tard", "All")
    end
})

  Tab:AddButton({
    Name = "beaner",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("b⁥⁥⁥е⁥⁥⁥а⁥⁥⁥n⁥⁥⁥е⁥⁥⁥r", "All")
    end
})

  Tab:AddButton({
    Name = "bondage",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("b⁥⁥⁥о⁥⁥⁥n⁥⁥⁥d⁥⁥⁥а⁥⁥⁥g⁥⁥⁥е⁥⁥⁥", "All")
    end
})

  Tab:AddButton({
    Name = "butthole",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("bu⁥⁥⁥⁥⁥⁥⁥⁥tthоle", "All")
    end
})

  Tab:AddButton({
    Name = "bootyhole",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("b󠀕󠀕󠀕󠀕о⁥⁥⁥⁥󠀕󠀕⁥⁥⁥⁥о󠀕󠀕󠀕󠀕󠀕󠀕ty󠀕󠀕󠀕󠀕һoӏe", "All")
    end
})

  Tab:AddButton({
    Name = "butt",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("bu⁥⁥⁥⁥⁥⁥⁥⁥tt", "All")
    end
})

  Tab:AddButton({
    Name = "booty",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("b󠀕󠀕󠀕󠀕о⁥⁥⁥⁥󠀕󠀕⁥⁥⁥⁥о󠀕󠀕󠀕󠀕󠀕󠀕ty", "All")
    end
})

  Tab:AddButton({
    Name = "boobs",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("b󠀕󠀕󠀕󠀕о⁥⁥⁥⁥󠀕󠀕⁥⁥⁥о󠀕󠀕󠀕󠀕󠀕󠀕󠀕󠀕b󠀕󠀕󠀕󠀕ѕ", "All")
    end
})

  Tab:AddButton({
    Name = "boob",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("bооb", "All")
    end
})

  Tab:AddButton({
    Name = "breasts",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("brеаѕtѕ", "All")
    end
})

  Tab:AddButton({
    Name = "bbc",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("b⁥⁥⁥b⁥⁥⁥с", "All")
    end
})

  Tab:AddButton({
    Name = "cocaine",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("с⁥⁥⁥о⁥⁥⁥с⁥⁥⁥а⁥⁥⁥i⁥⁥⁥n⁥⁥⁥е", "All")
    end
})


  Tab:AddButton({
    Name = "creampie",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("с⁥⁥⁥r⁥⁥⁥е⁥⁥⁥а⁥⁥⁥m⁥⁥⁥р⁥⁥⁥i⁥⁥⁥е", "All")
    end
})

  Tab:AddButton({
    Name = "cumming",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("с⁥⁥⁥⁥umming", "All")
    end
})

  Tab:AddButton({
    Name = "cum",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("с⁥⁥⁥⁥um", "All")
    end
})


  Tab:AddButton({
    Name = "cunts",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("сu⁥⁥⁥⁥⁥⁥⁥⁥ntѕ", "All")
    end
})

  Tab:AddButton({
    Name = "cunt",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("⁥⁥⁥с󠀕󠀕󠀕󠀕󠀕⁥⁥⁥⁥⁥⁥⁥⁥⁥󠀕󠀕󠀕󠀕󠀖󠀕u⁥⁥⁥⁥󠀕󠀕󠀕󠀕󠀕⁥⁥⁥⁥⁥⁥⁥⁥⁥󠀕󠀕󠀕󠀕󠀖󠀕n⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥t", "All")
    end
})

  Tab:AddButton({
    Name = "cock",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("с⁥⁥⁥о⁥⁥⁥с⁥⁥⁥k", "All")
    end
})

  Tab:AddButton({
    Name = "clit",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("с󠀕󠀕⁥І󠀕󠀕⁥і󠀕󠀕⁥t", "All")
    end
})

  Tab:AddButton({
    Name = "cuck",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("с⁥⁥⁥u⁥⁥⁥с⁥⁥⁥k", "All")
    end
})

  Tab:AddButton({
    Name = "cuckold",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("с⁥⁥⁥u⁥⁥⁥с⁥⁥⁥k⁥⁥⁥о⁥⁥⁥ӏ⁥⁥⁥d⁥⁥⁥", "All")
    end
})

  Tab:AddButton({
    Name = "condoms",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("с⁥⁥⁥о⁥⁥⁥n⁥⁥⁥d⁥⁥⁥о⁥⁥⁥m⁥⁥⁥s", "All")
    end
})


  Tab:AddButton({
    Name = "condom",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("с⁥⁥⁥о⁥⁥⁥n⁥⁥⁥d⁥⁥⁥о⁥⁥⁥m", "All")
    end
})

  Tab:AddButton({
    Name = "coochies",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("с⁥⁥⁥о⁥⁥⁥о⁥⁥⁥с⁥⁥⁥һ⁥⁥⁥і⁥⁥⁥е⁥⁥⁥s", "All")
    end
})


  Tab:AddButton({
    Name = "coochie",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("с⁥⁥⁥о⁥⁥⁥o⁥⁥⁥с⁥⁥⁥һ⁥⁥⁥i⁥⁥⁥е", "All")
    end
})

  Tab:AddButton({
    Name = "cunny",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("сu⁥⁥⁥⁥⁥⁥n⁥⁥⁥⁥⁥⁥nу", "All")
    end
})

  Tab:AddButton({
    Name = "dumbass",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("d⁥⁥⁥⁥⁥u⁥⁥⁥⁥⁥⁥m⁥⁥⁥⁥⁥b⁥⁥⁥⁥⁥⁥а⁥⁥⁥⁥⁥ѕ⁥⁥⁥⁥⁥ѕ", "All")
    end
})

  Tab:AddButton({
    Name = "dickhead",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("d￰￰￰￰￰і￰￰￰￰￰c￰￰￰￰￰kһ￰￰￰￰￰еad", "All")
    end
})

  Tab:AddButton({
    Name = "discord",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("dіѕсоrd", "All")
    end
})

  Tab:AddButton({
    Name = "damn",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("d⁥⁥⁥а⁥⁥⁥m⁥⁥⁥n⁥⁥⁥", "All")
    end
})

  Tab:AddButton({
    Name = "doggystyle",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("d⁥⁥⁥о⁥⁥⁥g⁥⁥⁥g⁥⁥⁥у⁥⁥⁥s⁥⁥⁥t⁥⁥⁥у⁥⁥⁥ӏ⁥⁥⁥е", "All")
    end
})

  Tab:AddButton({
    Name = "E-Rape",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("Е-Rаре", "All")
    end
})

  Tab:AddButton({
    Name = "E-Sex",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("Е￰￰￰-￰￰￰Ѕ￰￰￰е￰￰￰х", "All")
    end
})

  Tab:AddButton({
    Name = "fatass",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("fat￰￰￰а￰￰￰￰￰￰￰￰￰￰￰￰⁥ѕ￰￰ѕ", "All")
    end
})

  Tab:AddButton({
    Name = "fucked",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("󠀕󠀕󠀕f￰￰￰￰￰￰uс￰￰󠀕󠀕󠀕󠀕￰￰￰￰￰￰k￰￰￰￰￰￰￰￰e￰￰￰￰d", "All")
    end
})

  Tab:AddButton({
    Name = "fuckers (semi-brocken)",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("󠀕󠀕󠀕f￰￰￰￰￰￰uс￰￰󠀕󠀕󠀕󠀕￰￰￰￰￰￰k￰￰￰￰￰￰￰￰e￰￰￰￰󠀕󠀕󠀕rѕ", "All")
    end
})

  Tab:AddButton({
    Name = "fap",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("f⁥󠀕⁥⁥а⁥󠀕⁥⁥р", "All")
    end
})

  Tab:AddButton({
    Name = "femboys",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("fеmbоys", "All")
    end
})

  Tab:AddButton({
    Name = "femboy",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("fеmbоy", "All")
    end
})

  Tab:AddButton({
    Name = "fanny",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("fa⁥⁥⁥⁥⁥⁥n⁥⁥⁥⁥⁥⁥nу", "All")
    end
})

  Tab:AddButton({
    Name = "horny",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("һ⁥⁥⁥⁥⁥о󠀕󠀕󠀕󠀕r⁥⁥⁥⁥⁥n⁥⁥⁥⁥⁥у", "All")
    end
})

  Tab:AddButton({
    Name = "Hitler",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("Нi󠀗󠀕󠀕󠀕󠀕󠀕󠀖󠀖⁥⁥⁥⁥tl⁥⁥⁥⁥󠀗󠀕󠀕󠀕󠀕󠀕󠀖е󠀗󠀕󠀕󠀕󠀕󠀕󠀖󠀖󠀗󠀕󠀕󠀕󠀕󠀕󠀖󠀖r", "All")
    end
})

  Tab:AddButton({
    Name = "hentai",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("h󠀕󠀕󠀕󠀕󠀕󠀕󠀕󠀕󠀕󠀖󠀕e󠀕󠀕󠀕󠀕󠀕󠀕󠀕󠀕󠀕󠀖󠀕n󠀕󠀕󠀕󠀕󠀕󠀕󠀕󠀕󠀕󠀖󠀕t󠀕󠀕󠀕󠀕󠀕󠀕󠀕󠀕󠀕󠀖󠀕a󠀕󠀕󠀕󠀕󠀕󠀕󠀕󠀕󠀕󠀖󠀕i", "All")
    end
})

  Tab:AddButton({
    Name = "hoes",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("һоеѕ", "All")
    end
})

  Tab:AddButton({
    Name = "hoe",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("һое", "All")
    end
})

  Tab:AddButton({
    Name = "instagram",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("і󠀕󠀕󠀕󠀕󠀕󠀕󠀕⁥⁥⁥⁥n󠀕󠀕󠀕󠀕󠀕󠀕󠀕⁥⁥⁥⁥ѕ󠀕󠀕󠀕󠀕󠀕󠀕󠀕⁥⁥⁥⁥tаg󠀕󠀕󠀕󠀕rаm", "All")
    end
})

  Tab:AddButton({
    Name = "insta",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("i󠀕󠀕󠀕󠀕󠀕󠀕󠀕⁥⁥⁥⁥n󠀕󠀕󠀕󠀕󠀕󠀕󠀕⁥⁥⁥⁥s󠀕󠀕󠀕󠀕󠀕󠀕󠀕⁥⁥⁥⁥ta", "All")
    end
})

  Tab:AddButton({
    Name = "kys",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("k⁥⁥⁥⁥⁥⁥⁥⁥y⁥⁥⁥ѕ", "All")
    end
})

  Tab:AddButton({
    Name = "lmfao",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("ӏm⁥⁥⁥⁥⁥⁥⁥⁥fа⁥⁥о", "All")
    end
})

  Tab:AddButton({
    Name = "lmao",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("ӏ󠀕󠀕󠀕󠀕󠀕󠀕󠀕󠀕󠀖󠀕⁥⁥⁥⁥maо", "All")
    end
})

  Tab:AddButton({
    Name = "motherfucker",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("mot￰￰￰￰￰￰￰h￰e￰rf￰￰￰￰￰u￰с￰￰￰￰￰￰￰￰k￰e￰￰￰￰￰￰￰￰r", "All")
    end
})

  Tab:AddButton({
    Name = "masturbate",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("m󠀕󠀕󠀕󠀕󠀕󠀕󠀕󠀕󠀕󠀖󠀕a󠀕󠀕󠀕󠀕󠀕󠀕󠀕󠀕󠀕󠀖󠀕ѕ󠀕󠀕󠀕󠀕󠀕󠀕󠀕󠀕󠀕󠀖󠀕t󠀕󠀕󠀕󠀕󠀕󠀕󠀕󠀕󠀕󠀖󠀕u󠀕󠀕󠀕󠀕󠀕󠀕󠀕󠀕󠀕󠀖󠀕r󠀕󠀕󠀕󠀕󠀕󠀕󠀕󠀕󠀕󠀖󠀕b󠀕󠀕󠀕󠀕󠀕󠀕󠀕󠀕󠀕󠀖󠀕a󠀕󠀕󠀕󠀕󠀕󠀕󠀕󠀕󠀕󠀖󠀕t󠀕󠀕󠀕󠀕󠀕󠀕󠀕󠀕󠀕󠀖󠀕e", "All")
    end
})

  Tab:AddButton({
    Name = "masturbating",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("m⁥⁥⁥а⁥⁥⁥ѕ⁥⁥⁥t⁥⁥⁥u⁥⁥⁥r⁥⁥⁥b⁥⁥⁥а⁥⁥⁥t⁥⁥⁥ing", "All")
    end
})

  Tab:AddButton({
    Name = "molest",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("m⁥⁥⁥⁥o⁥⁥⁥⁥ӏ⁥⁥⁥⁥е⁥⁥⁥ѕ⁥⁥⁥⁥t", "All")
    end
})

  Tab:AddButton({
    Name = "meth",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("mе⁥⁥⁥⁥⁥⁥⁥⁥th", "All")
    end
})

  Tab:AddButton({
    Name = "naked",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("nаkеd", "All")
    end
})

  Tab:AddButton({
    Name = "negro",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("n󠀕󠀕󠀕󠀕󠀕󠀕󠀕e󠀕󠀕󠀕󠀕󠀕󠀕󠀕g󠀕󠀕󠀕󠀕󠀕󠀕󠀕r󠀕󠀕󠀕󠀕󠀕󠀕󠀕o", "All")
    end
})

  Tab:AddButton({
    Name = "nipples",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("n󠀕󠀕⁥i󠀕󠀕⁥⁥󠀕р⁥p󠀕󠀖⁥⁥󠀕l󠀕󠀕󠀕⁥⁥󠀕󠀕󠀖󠀕e󠀖⁥⁥ѕ", "All")
    end
})

  Tab:AddButton({
    Name = "nipple",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("n󠀕󠀕⁥i󠀕󠀕⁥⁥󠀕р⁥p󠀕󠀖⁥⁥󠀕l󠀕󠀕󠀕⁥⁥󠀕󠀕󠀖󠀕e󠀖⁥⁥", "All")
    end
})

  Tab:AddButton({
    Name = "nudes",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("nudеѕ", "All")
    end
})

  Tab:AddButton({
    Name = "nude",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("n󠀕󠀕󠀕󠀕󠀕󠀕󠀕󠀕󠀕󠀖󠀕u󠀕󠀕󠀕󠀕󠀕󠀕󠀕󠀕󠀕󠀖󠀕d󠀕󠀕󠀕󠀕󠀕󠀕󠀕󠀕󠀕󠀖󠀕е", "All")
    end
})

  Tab:AddButton({
    Name = "orgasm",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("оrg⁥⁥⁥⁥аѕm", "All")
    end
})

  Tab:AddButton({
    Name = "pedophile",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("p⁥⁥е⁥⁥⁥d⁥⁥⁥⁥⁥⁥⁥ор⁥⁥hіӏ⁥⁥⁥⁥⁥⁥⁥е", "All")
    end
})

  Tab:AddButton({
    Name = "pornhub",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("⁥⁥р󠀕󠀕󠀕󠀕󠀕󠀕󠀕о󠀕󠀕󠀕󠀕󠀕󠀕󠀕r󠀕󠀕󠀕󠀕󠀕󠀕󠀕n󠀕󠀕󠀕󠀕󠀕󠀕󠀕һ󠀕󠀕󠀕󠀕󠀕󠀕󠀕u󠀕󠀕󠀕󠀕󠀕󠀕󠀕b", "All")
    end
})

  Tab:AddButton({
    Name = "penis",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("pen󠀕󠀖󠀗󠀘󠀕󠀖⁥⁥⁥⁥⁥⁥⁥⁥󠀕і󠀖󠀗󠀘󠀖󠀗ѕ", "All")
    end
})

  Tab:AddButton({
    Name = "porn",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("роrn", "All")
    end
})

  Tab:AddButton({
    Name = "pussies",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("р⁥⁥⁥u⁥⁥⁥s⁥⁥⁥s⁥⁥⁥i⁥⁥⁥е⁥⁥⁥s", "All")
    end
})

  Tab:AddButton({
    Name = "pussy",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("р⁥⁥⁥u⁥⁥⁥s⁥⁥⁥s⁥⁥⁥у", "All")
    end
})

  Tab:AddButton({
    Name = "queer",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("󠀕󠀕￰￰󠀕q￰￰￰󠀕󠀕󠀕￰￰￰u￰￰￰￰￰￰e󠀕󠀕󠀕￰￰￰￰￰￰e￰￰￰￰￰￰r", "All")
    end
})

  Tab:AddButton({
    Name = "retarded",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("r⁥⁥⁥⁥еt⁥⁥⁥⁥󠀗󠀕󠀕ar⁥⁥⁥⁥dе󠀗󠀕󠀕󠀕󠀕󠀕󠀖󠀖󠀗󠀕󠀕󠀕󠀕󠀕󠀖󠀖d", "All")
    end
})

  Tab:AddButton({
    Name = "retard",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("⁥⁥r⁥󠀕󠀕󠀕󠀕󠀕󠀕󠀕󠀖󠀕е󠀖󠀕t 󠀕󠀕󠀕󠀕󠀖󠀕а⁥⁥⁥󠀕󠀕󠀕󠀖󠀕r󠀕󠀕󠀕⁥⁥⁥⁥󠀕d", "All")
    end
})

  Tab:AddButton({
    Name = "rape",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("rаре", "All")
    end
})

  Tab:AddButton({
    Name = "schlong",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("ѕс⁥⁥⁥⁥һ󠀗󠀕󠀕󠀕󠀕ӏо⁥⁥⁥⁥n󠀗󠀕󠀕󠀕󠀕󠀕󠀖󠀖󠀗g", "All")
    end
})

  Tab:AddButton({
    Name = "stripper",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("ѕtrірреr", "All")
    end
})

  Tab:AddButton({
    Name = "slave",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("ѕ⁥⁥⁥ӏ⁥⁥⁥а⁥⁥⁥v⁥⁥⁥е", "All")
    end
})

  Tab:AddButton({
    Name = "sperm",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("ѕpе󠀕￰￰￰￰󠀖r￰󠀖m", "All")
    end
})

  Tab:AddButton({
    Name = "seduce",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("ѕеduсе", "All")
    end
})

  Tab:AddButton({
    Name = "slut",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("sӏut", "All")
    end
})

  Tab:AddButton({
    Name = "shit",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("ѕһ⁥⁥⁥⁥󠀗󠀕󠀕󠀕󠀕󠀖i⁥⁥⁥⁥󠀗󠀕󠀕󠀕t", "All")
    end
})

  Tab:AddButton({
    Name = "sexy",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("ѕеху", "All")
    end
})

  Tab:AddButton({
    Name = "sex",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("ѕ⁥⁥⁥е⁥⁥⁥х⁥⁥⁥", "All")
    end
})

  Tab:AddButton({
    Name = "titties",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("t⁥⁥⁥⁥⁥⁥і⁥⁥⁥⁥⁥⁥t⁥⁥⁥⁥⁥⁥t⁥⁥⁥⁥⁥⁥і⁥⁥⁥⁥⁥⁥е⁥⁥⁥⁥⁥⁥ѕ", "All")
    end
})

  Tab:AddButton({
    Name = "thots",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("t󠀗󠀕󠀕󠀕󠀕󠀕󠀖󠀖󠀗󠀕󠀕󠀕󠀕󠀕󠀖󠀖󠀗󠀕󠀕󠀕󠀕󠀕󠀖󠀖h⁥⁥⁥󠀗󠀕󠀕оt󠀗󠀕󠀕󠀕󠀕󠀕⁥⁥⁥⁥ѕ", "All")
    end
})

  Tab:AddButton({
    Name = "thot",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("t󠀗󠀕󠀕󠀕󠀕󠀕󠀖󠀖󠀗󠀕󠀕󠀕󠀕󠀕󠀖󠀖󠀗󠀕󠀕󠀕󠀕󠀕󠀖󠀖h⁥⁥⁥󠀗󠀕󠀕оt", "All")
    end
})

  Tab:AddButton({
    Name = "tits",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("t󠀗󠀕󠀕󠀕󠀕󠀕i⁥⁥⁥⁥t⁥⁥⁥⁥ѕ", "All")
    end
})

  Tab:AddButton({
    Name = "tit",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("⁥⁥⁥t󠀗󠀕⁥⁥⁥⁥⁥⁥⁥⁥󠀕󠀕󠀕󠀕і⁥⁥⁥⁥t", "All")
    end
})

  Tab:AddButton({
    Name = "virginity",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("v￰￰￰￰￰￰і￰￰￰￰￰￰￰￰r￰￰￰￰￰￰￰￰g￰￰￰￰￰￰￰￰￰і￰￰￰￰￰￰￰￰n￰￰￰￰￰￰￰і￰￰￰￰t￰￰￰у", "All")
    end
})

  Tab:AddButton({
    Name = "virgins",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("v󠀗󠀕󠀕󠀕󠀕󠀕󠀖󠀖󠀗ir⁥⁥⁥⁥󠀗󠀕󠀕󠀕󠀕󠀕gi󠀗󠀕󠀕󠀕󠀕󠀕󠀖󠀖󠀗󠀕󠀕󠀕󠀕󠀕󠀖󠀖ns", "All")
    end
})

  Tab:AddButton({
    Name = "virgin",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("v󠀕￰￰￰￰￰￰󠀘і󠀖￰￰￰￰￰￰￰￰󠀘r󠀕￰￰￰￰￰￰￰￰󠀖g󠀖￰￰￰￰￰￰￰￰￰󠀘і󠀘￰￰￰￰￰￰￰￰n", "All")
    end
})

  Tab:AddButton({
    Name = "vagina",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("⁥⁥v󠀗󠀕󠀕󠀕󠀕⁥⁥⁥⁥󠀕󠀖⁥⁥⁥⁥а󠀗󠀕󠀕󠀕g⁥⁥⁥⁥і⁥⁥⁥⁥󠀗󠀕n⁥⁥⁥⁥󠀗󠀕󠀕󠀕󠀕󠀕󠀖󠀖a", "All")
    end
})

  Tab:AddButton({
    Name = "whore",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("w⁥⁥⁥һ⁥⁥⁥о⁥⁥⁥r⁥⁥⁥е", "All")
    end
})

  Tab:AddButton({
    Name = "weed",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("⁥⁥⁥⁥w⁥󠀕⁥eed", "All")
    end
})

local Section = Tab:AddSection({
    Name = "Uppercase/Capital A-Z"
})

  Tab:AddButton({
    Name = "ASS",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("АЅЅ", "All")
    end
})

  Tab:AddButton({
    Name = "ASSHOLE",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("АЅЅНОLЕ", "All")
    end
})

  Tab:AddButton({
    Name = "ANUS",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("АΝUЅ", "All")
    end
})

  Tab:AddButton({
    Name = "ARSE",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("А⁥⁥⁥R⁥⁥⁥⁥⁥󠀕󠀕󠀕Ѕ⁥⁥⁥⁥⁥⁥Е", "All")
    end
})

  Tab:AddButton({
    Name = "ANAL",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("АΝ⁥⁥⁥⁥⁥⁥АL", "All")
    end
})

  Tab:AddButton({
    Name = "BASTARD",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("ВАЅТАRD", "All")
    end
})

  Tab:AddButton({
    Name = "BONDAGE",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("В󠀕󠀕󠀕󠀕󠀕󠀕󠀕⁥⁥⁥⁥О󠀕󠀕󠀕󠀕󠀕󠀕󠀕⁥⁥⁥⁥Ν󠀕󠀕󠀕󠀕󠀕󠀕󠀕⁥⁥⁥⁥D󠀕󠀕󠀕󠀕󠀕󠀕󠀕⁥⁥⁥⁥АGЕ", "All")
    end
})

  Tab:AddButton({
    Name = "BONER",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("⁥В⁥⁥O⁥⁥N⁥⁥Е⁥⁥R", "All")
    end
})

  Tab:AddButton({
    Name = "BITCHES",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("В￰￰￰￰￰￰￰I￰￰￰￰￰￰Т￰￰￰￰￰￰СНЕS", "All")
    end
})

  Tab:AddButton({
    Name = "BITCH",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("В￰￰￰￰￰￰￰I￰￰￰￰￰￰Т￰￰￰￰￰￰СН", "All")
    end
})

  Tab:AddButton({
    Name = "BLOWJOB",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("В󠀕󠀕󠀕󠀕󠀕󠀖LОW󠀕󠀕󠀕󠀕󠀕󠀖ЈО󠀕󠀕󠀕󠀕󠀕󠀖В", "All")
    end
})

  Tab:AddButton({
    Name = "BULLSHIT",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("В󠀖󠀖⁥⁥⁥⁥UL󠀖󠀖⁥⁥⁥⁥LЅН󠀖󠀖⁥⁥⁥⁥ӀТ", "All")
    end
})

  Tab:AddButton({
    Name = "BOOBS",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("ВООВS", "All")
    end
})

  Tab:AddButton({
    Name = "BOOB",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("ВООВ", "All")
    end
})

  Tab:AddButton({
    Name = "BUTTHOLE",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("ВUТТ⁥⁥⁥⁥НOLЕ", "All")
    end
})

  Tab:AddButton({
    Name = "BUTT",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("ВUТТ", "All")
    end
})

  Tab:AddButton({
    Name = "BOOTY",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("ВООТΥ", "All")
    end
})

  Tab:AddButton({
    Name = "BEANER",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("В󠀕󠀕󠀕󠀕󠀕󠀕󠀕⁥⁥⁥⁥ЕА󠀕󠀕󠀕󠀕󠀕󠀕󠀕⁥⁥⁥⁥Ν󠀕󠀕󠀕󠀕󠀕󠀕󠀕⁥⁥⁥⁥Е󠀕󠀕󠀕󠀕󠀕󠀕󠀕⁥⁥⁥⁥R", "All")
    end
})

  Tab:AddButton({
    Name = "COCAINE",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("С󠀕󠀕󠀕󠀕󠀕󠀕󠀕⁥⁥⁥⁥ОСА󠀕󠀕󠀕󠀕󠀕󠀕󠀕⁥⁥⁥⁥ӀΝ󠀕󠀕󠀕󠀕󠀕󠀕󠀕⁥⁥⁥⁥Е", "All")
    end
})

  Tab:AddButton({
    Name = "CUNTS",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("СU⁥⁥⁥⁥⁥⁥⁥⁥NТЅ", "All")
    end
})

  Tab:AddButton({
    Name = "CUNT",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("СU⁥⁥⁥⁥⁥⁥⁥⁥NТ", "All")
    end
}) 

  Tab:AddButton({
    Name = "COOCHIES",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("С󠀕󠀕󠀕O󠀕󠀕󠀕󠀕⁥⁥⁥⁥ОСН󠀕󠀕󠀕󠀕󠀕󠀕󠀕⁥⁥⁥⁥Ӏ󠀕󠀕󠀕󠀕󠀕󠀕󠀕⁥⁥⁥⁥ЕS", "All")
    end
})

  Tab:AddButton({
    Name = "COOCHIE",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("С󠀕󠀕󠀕O󠀕󠀕󠀕󠀕⁥⁥⁥⁥ОСН󠀕󠀕󠀕󠀕󠀕󠀕󠀕⁥⁥⁥⁥Ӏ󠀕󠀕󠀕󠀕󠀕󠀕󠀕⁥⁥⁥⁥Е", "All")
    end
})

  Tab:AddButton({
    Name = "CUM",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("СUМ", "All")
    end
})

  Tab:AddButton({
    Name = "CREAMPIE",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("С󠀕󠀕󠀕󠀕󠀕󠀕󠀕⁥⁥⁥⁥R󠀕󠀕󠀕󠀕󠀕󠀕󠀕⁥⁥⁥⁥Е󠀕󠀕󠀕󠀕󠀕󠀕󠀕⁥⁥⁥⁥АМ󠀕󠀕󠀕󠀕󠀕󠀕󠀕⁥⁥⁥PIE", "All")
    end
})

  Tab:AddButton({
    Name = "COCK",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("СОСK", "All")
    end
})

  Tab:AddButton({
    Name = "CUCKOLD",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("С󠀕󠀕󠀕󠀕󠀕󠀕󠀕⁥⁥⁥⁥U󠀕󠀕󠀕󠀕󠀕󠀕󠀕⁥⁥⁥⁥С󠀕󠀕󠀕󠀕󠀕󠀕󠀕⁥⁥⁥⁥KOLD", "All")
    end
})

  Tab:AddButton({
    Name = "CUCK",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("С󠀕󠀕󠀕󠀕󠀕󠀕󠀕⁥⁥⁥⁥U󠀕󠀕󠀕󠀕󠀕󠀕󠀕⁥⁥⁥⁥С󠀕󠀕󠀕󠀕󠀕󠀕󠀕⁥⁥⁥⁥K", "All")
    end
})

  Tab:AddButton({
    Name = "DISCORD",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("DӀЅСОRD", "All")
    end
})

  Tab:AddButton({
    Name = "DUMBASS",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("D󠀕󠀕󠀕󠀕󠀕⁥⁥⁥⁥⁥⁥⁥⁥⁥󠀕󠀕UM⁥⁥⁥⁥⁥⁥⁥⁥⁥BАЅЅ", "All")
    end
})

  Tab:AddButton({
    Name = "DICKHEAD",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("D⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥IСΚНЕ󠀕⁥⁥󠀕AD", "All")
    end
})

  Tab:AddButton({
    Name = "DICK",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("D⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥IСΚ", "All")
    end
})

  Tab:AddButton({
    Name = "DAMN",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("DАМΝ", "All")
    end
})

  Tab:AddButton({
    Name = "FAGGOT",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("F󠀕󠀖󠀗󠀘￰￰￰￰￰￰￰￰￰￰￰￰￰￰￰￰󠀕󠀖󠀗󠀘А󠀕󠀖󠀗󠀘󠀕󠀖￰￰￰￰￰￰󠀕G⁥⁥󠀖󠀗󠀘󠀖󠀗󠀘⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥󠀘󠀘G󠀖󠀗󠀘󠀖󠀗󠀘￰￰￰￰￰￰￰О󠀖󠀗󠀘￰￰￰￰￰󠀖󠀗Т", "All")
    end
})


  Tab:AddButton({
    Name = "FATASS",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("F⁥⁥⁥А⁥⁥⁥ТА⁥⁥⁥Ѕ⁥⁥⁥Ѕ", "All")
    end
})
  Tab:AddButton({
    Name = "FEMBOYS",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("FЕМВОΥЅ", "All")
    end
})

  Tab:AddButton({
    Name = "FEMBOY",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("FЕМВОΥ", "All")
    end
})

  Tab:AddButton({
    Name = "FUCKERS",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("󠀕󠀕F⁥⁥⁥⁥⁥󠀕󠀕󠀕󠀕󠀕󠀖󠀖󠀗󠀕󠀕󠀕󠀕󠀕󠀖󠀖⁥⁥⁥⁥⁥⁥⁥UС⁥⁥⁥ΚЕ⁥⁥⁥R󠀕󠀕󠀕󠀕S", "All")
    end
})

  Tab:AddButton({
    Name = "FUCKER",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("󠀕󠀕F⁥⁥⁥⁥⁥󠀕󠀕󠀕󠀕󠀕󠀖󠀖󠀗󠀕󠀕󠀕󠀕󠀕󠀖󠀖⁥⁥⁥⁥⁥⁥⁥UC⁥⁥⁥ΚЕ⁥⁥⁥R", "All")
    end
})

  Tab:AddButton({
    Name = "FUCKED",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("F⁥⁥⁥⁥⁥󠀕󠀕󠀕󠀕󠀕󠀖󠀖󠀗󠀕󠀕󠀕󠀕󠀕󠀖󠀖⁥⁥⁥⁥⁥⁥⁥UС⁥⁥⁥ΚЕ⁥⁥⁥D", "All")
    end
})

  Tab:AddButton({
    Name = "FUCK",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("F⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥UСΚ", "All")
    end
})

  Tab:AddButton({
    Name = "HITLER",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("НӀ⁥⁥⁥⁥⁥⁥⁥⁥ТL⁥⁥⁥⁥⁥⁥⁥⁥Е⁥⁥R", "All")
    end
})


  Tab:AddButton({
    Name = "HENTAI",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("НЕ⁥⁥⁥⁥Ν⁥ТАӀ", "All")
    end
})

  Tab:AddButton({
    Name = "HORNY",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("НОRNY", "All")
    end
})

  Tab:AddButton({
    Name = "HOES",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("НОЕЅ", "All")
    end
})

  Tab:AddButton({
    Name = "HOE",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("НОЕ", "All")
    end
})

  Tab:AddButton({
    Name = "KYS",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("ΚΥЅ", "All")
    end
})

  Tab:AddButton({
    Name = "LMFAO",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("LМFАО", "All")
    end
})

  Tab:AddButton({
    Name = "LMAO",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("LМАО", "All")
    end
})

  Tab:AddButton({
    Name = "MOTHERFUCKER",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("МО󠀕󠀕󠀕󠀖󠀖ТНЕ󠀕󠀕󠀕󠀖󠀖R󠀕󠀕F⁥⁥⁥⁥⁥󠀕󠀕󠀕󠀕󠀕󠀖󠀖󠀗󠀕󠀕󠀕󠀕󠀕󠀖󠀖⁥⁥⁥⁥⁥⁥⁥UC⁥⁥⁥ΚЕ⁥⁥⁥R", "All")
    end
})

  Tab:AddButton({
    Name = "MASTURBATE",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("МАЅТURВАТΕ", "All")
    end
})


  Tab:AddButton({
    Name = "METH",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("МETH", "All")
    end
})

  Tab:AddButton({
    Name = "NAKED",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("ΝΑKΕD", "All")
    end
})

  Tab:AddButton({
    Name = "NEGRO",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("NE󠀕󠀕⁥⁥󠀕G󠀕󠀖⁥⁥󠀕R󠀕󠀕󠀕⁥⁥󠀕󠀕󠀖󠀕O", "All")
    end
})


  Tab:AddButton({
    Name = "NUDES",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("ΝUDЕЅ", "All")
    end
})

  Tab:AddButton({
    Name = "NUDE",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("Ν󠀕󠀕󠀕󠀕󠀕󠀖󠀖󠀗󠀕󠀕U󠀕󠀕󠀕󠀕󠀕󠀖󠀖󠀗󠀕󠀕D󠀕󠀕󠀕󠀕󠀕󠀖󠀖󠀗󠀕󠀕Е", "All")
    end
})

  Tab:AddButton({
    Name = "NIPPLES",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("Ν󠀕󠀕⁥Ӏ󠀕󠀕⁥⁥󠀕P⁥⁥P󠀕󠀖⁥⁥󠀕L󠀕󠀕󠀕⁥⁥󠀕󠀕󠀖󠀕Е󠀖⁥⁥Ѕ", "All")
    end
})

  Tab:AddButton({
    Name = "NIPPLE",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("Ν󠀕󠀕⁥Ӏ󠀕󠀕⁥⁥󠀕P⁥⁥P󠀕󠀖⁥⁥󠀕L󠀕󠀕󠀕⁥⁥󠀕󠀕󠀖󠀕Е󠀖⁥⁥", "All")
    end
})

  Tab:AddButton({
    Name = "OMFG",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("ОM⁥⁥⁥⁥⁥⁥⁥⁥FG", "All")
    end
})

  Tab:AddButton({
    Name = "PENIS",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("PEN⁥⁥ӀS", "All")
    end
})


  Tab:AddButton({
    Name = "PUSSIES",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("Р⁥⁥⁥U⁥⁥⁥Ѕ⁥⁥⁥S⁥⁥⁥Ӏ⁥⁥⁥Е⁥⁥⁥Ѕ", "All")
    end
})

  Tab:AddButton({
    Name = "PUSSY",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("Р󠀕󠀕󠀕󠀖⁥⁥⁥⁥⁥󠀖󠀗󠀕U⁥⁥⁥⁥⁥Ѕ󠀕󠀕󠀕󠀖⁥⁥⁥⁥⁥󠀖󠀗󠀕S󠀕⁥⁥⁥⁥⁥󠀕󠀖󠀖󠀗󠀕Υ", "All")
    end
})


  Tab:AddButton({
    Name = "PISS",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("РӀЅЅ", "All")
    end
})

  Tab:AddButton({
    Name = "PORN",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("РО󠀕⁥⁥⁥⁥⁥⁥⁥⁥⁥󠀕󠀕󠀕󠀕RΝ", "All")
    end
})


  Tab:AddButton({
    Name = "RETARD",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("R⁥⁥⁥⁥⁥⁥⁥E⁥⁥⁥⁥⁥⁥T⁥⁥⁥⁥⁥⁥⁥A⁥⁥⁥⁥⁥⁥R⁥⁥⁥⁥⁥⁥⁥D", "All")
    end
})

  Tab:AddButton({
    Name = "RAPE",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("RАРЕ", "All")
    end
})


  Tab:AddButton({
    Name = "SHIT",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("ЅH⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥IT", "All")
    end
})

  Tab:AddButton({
    Name = "SLUT",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("ЅL⁥⁥⁥⁥UТ", "All")
    end
})


  Tab:AddButton({
    Name = "SLAVE",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("ЅLА󠀗󠀕󠀕󠀕󠀕󠀕󠀖󠀖󠀗󠀕󠀕󠀕󠀕󠀕󠀖󠀖󠀗󠀕󠀕󠀕󠀕󠀕󠀖󠀖󠀗󠀕󠀕󠀕󠀕󠀕󠀖󠀖󠀗󠀕󠀕󠀕󠀕󠀕󠀖󠀖󠀗󠀕󠀕󠀕󠀕󠀕󠀖󠀖󠀗󠀕󠀕󠀕󠀕󠀕󠀖󠀖󠀗󠀕󠀕󠀕󠀕󠀕󠀖󠀖󠀗󠀕󠀕󠀕󠀕󠀕󠀖󠀖󠀗󠀕󠀕󠀕󠀕󠀕󠀖󠀖󠀗󠀕󠀕󠀕󠀕󠀕󠀖󠀖󠀗󠀕󠀕󠀕󠀕󠀕󠀖󠀖󠀗󠀕󠀕󠀕󠀕󠀕󠀖󠀖󠀗󠀕󠀕󠀕󠀕󠀕󠀖󠀖󠀗󠀕󠀕󠀕󠀕󠀕󠀖󠀖󠀗󠀕󠀕󠀕󠀕󠀕󠀖󠀖VE", "All")
    end
})

  Tab:AddButton({
    Name = "SEX",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("ЅЕХ", "All")
    end
})


  Tab:AddButton({
    Name = "TITTIES",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("ТIТТIES", "All")
    end
})

  Tab:AddButton({
    Name = "TITS",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("ТIТЅ", "All")
    end
})


  Tab:AddButton({
    Name = "THOTS",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("ТН⁥⁥⁥⁥⁥ОТЅ", "All")
    end
})

  Tab:AddButton({
    Name = "THOT",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("ТН⁥⁥⁥⁥⁥ОТ", "All")
    end
})



  Tab:AddButton({
    Name = "VIRGINITY",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("V￰￰￰￰￰￰Ӏ￰￰￰￰￰￰￰￰R￰￰￰￰￰￰￰￰G￰￰￰￰￰￰￰￰￰Ӏ￰￰￰￰￰￰￰￰ΝITY", "All")
    end
})

  Tab:AddButton({
    Name = "VIRGINS",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("V￰￰￰￰￰￰I￰￰￰￰￰￰￰￰R￰￰￰￰￰￰￰￰G￰￰￰￰￰￰￰￰￰INS", "All")
    end
})



  Tab:AddButton({
    Name = "VIRGIN",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("V￰￰￰￰￰￰I￰￰￰￰￰￰￰￰R￰￰￰￰￰￰￰￰G￰￰￰￰￰￰￰￰￰I￰￰￰￰￰￰￰￰N", "All")
    end
})

  Tab:AddButton({
    Name = "VAGINA",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("V￰￰￰￰￰￰А￰￰￰￰￰￰￰￰G￰￰￰￰￰￰￰￰Ӏ￰￰￰￰￰￰￰￰￰N￰￰￰￰￰￰￰￰А", "All")
    end
})



  Tab:AddButton({
    Name = "XXX",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("X⁥⁥⁥⁥XX", "All")
    end
})

  Tab:AddButton({
    Name = "WHORE",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("W⁥⁥⁥Н⁥⁥⁥О⁥⁥⁥R⁥⁥⁥Е", "All")
    end
})


local Tab = Window:MakeTab({
    Name = "Sentences",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

local Section = Tab:AddSection({
    Name = "lowercase A-Z"
})

  Tab:AddButton({
    Name = "anal sex pls",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("аn⁥⁥⁥⁥аl ѕ⁥⁥⁥е⁥⁥⁥х⁥⁥⁥ pls", "All")
    end
})

  Tab:AddButton({
    Name = "anal sex",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("аn⁥⁥⁥⁥аl ѕ⁥⁥⁥е⁥⁥⁥х", "All")
    end
})


  Tab:AddButton({
    Name = "ass sex pls",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("а⁥⁥⁥⁥ѕѕs⁥⁥⁥⁥ехpӏs", "All")
    end
})

  Tab:AddButton({
    Name = "Boom cockshot!",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("В⁥⁥⁥⁥о⁥⁥⁥⁥о⁥⁥⁥⁥m⁥⁥⁥⁥ с⁥⁥⁥⁥о⁥⁥⁥⁥с⁥⁥⁥⁥k⁥⁥⁥⁥ѕ⁥⁥⁥⁥h⁥⁥⁥⁥о⁥⁥⁥⁥t⁥⁥⁥⁥!", "All")
    end
})

  Tab:AddButton({
    Name = "boner alert!",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("b⁥⁥⁥o⁥⁥⁥n⁥⁥⁥е⁥⁥⁥r⁥⁥⁥ ⁥⁥⁥а⁥⁥⁥ӏ⁥⁥⁥е⁥⁥⁥r⁥⁥⁥t⁥⁥⁥!", "All")
    end
})

  Tab:AddButton({
    Name = "butt sex",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("bu⁥⁥⁥⁥⁥⁥⁥⁥tt ѕ⁥⁥⁥еx", "All")
    end
})

  Tab:AddButton({
    Name = "big cock",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("b⁥ig со⁥⁥⁥сk", "All")
    end
})

  Tab:AddButton({
    Name = "boobs or ass?",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("b⁥⁥⁥о⁥⁥⁥о⁥⁥⁥b⁥⁥⁥ѕ⁥⁥⁥ ⁥⁥⁥о⁥⁥⁥r⁥⁥⁥ ⁥⁥⁥а⁥⁥⁥ѕ⁥⁥⁥ѕ?", "All")
    end
})



  Tab:AddButton({
    Name = "Big ass thighs",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("Віg аѕѕ thіghѕ", "All")
    end
})

  Tab:AddButton({
    Name = "big black cock",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("big black сосk", "All")
    end
})



  Tab:AddButton({
    Name = "Big ass",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("Віg аѕѕ", "All")
    end
})

  Tab:AddButton({
    Name = "Be my wife!",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("Ве mу wіfе!", "All")
    end
})



  Tab:AddButton({
    Name = "Can I see those cute boobs of yours?",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("Саn І ѕее thоѕе сutе bооbѕ оf уоurѕ?", "All")
    end
})

  Tab:AddButton({
    Name = "cock sucker",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("сосk ѕuсkеr", "All")
    end
})



  Tab:AddButton({
    Name = "Cum on me please!",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("С⁥⁥⁥⁥umonme please!", "All")
    end
})

  Tab:AddButton({
    Name = "cum please",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("с⁥⁥⁥⁥um рӏеаѕе", "All")
    end
})


  Tab:AddButton({
    Name = "cut yourself.",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("сutyоurself.", "All")
    end
})

  Tab:AddButton({
    Name = "child porn",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("сhild роrn", "All")
    end
})



  Tab:AddButton({
    Name = "Cock incoming!",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("C󠀕󠀕󠀕󠀕о⁥⁥⁥⁥⁥⁥⁥⁥⁥сki⁥⁥󠀕󠀕󠀕󠀕⁥nс⁥⁥󠀕󠀕󠀕󠀕⁥о󠀕󠀕󠀕󠀕m󠀕󠀕󠀕󠀕i󠀕󠀕󠀕󠀕n⁥⁥⁥g!", "All")
    end
})

  Tab:AddButton({
    Name = "Cock in bedroom",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("С󠀕󠀕󠀕󠀕о⁥⁥⁥⁥⁥⁥⁥⁥⁥с󠀕⁥⁥kі⁥󠀕󠀕󠀕󠀕⁥⁥nb⁥⁥е󠀕󠀕󠀕󠀕dr⁥ооm", "All")
    end
})



  Tab:AddButton({
    Name = "Cock or Boobs",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("С⁥⁥⁥о⁥⁥⁥с⁥⁥⁥k⁥⁥⁥ ⁥⁥⁥о⁥⁥⁥r⁥⁥⁥ ⁥⁥⁥В⁥⁥⁥о⁥⁥⁥о⁥⁥⁥b⁥⁥⁥ѕ⁥⁥⁥?", "All")
    end
})

  Tab:AddButton({
    Name = "damn you got a long schlong daddy",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("d⁥⁥⁥а⁥⁥⁥m⁥⁥⁥n⁥⁥⁥ ⁥⁥⁥у⁥⁥⁥о⁥⁥⁥u⁥⁥⁥ ⁥⁥⁥g⁥⁥⁥о⁥⁥⁥t⁥⁥⁥ ⁥⁥⁥а⁥⁥⁥ ⁥⁥⁥ӏ⁥⁥⁥о⁥⁥⁥n⁥⁥⁥g⁥⁥⁥ ⁥⁥⁥ѕ⁥⁥⁥с⁥⁥⁥һ⁥⁥⁥ӏ⁥⁥⁥о⁥⁥⁥n⁥⁥⁥g⁥⁥⁥ ⁥⁥⁥d⁥⁥⁥а⁥⁥⁥d⁥⁥⁥d⁥⁥⁥у", "All")
    end
})



  Tab:AddButton({
    Name = "dirty hoe",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("d⁥⁥⁥⁥⁥⁥i⁥⁥⁥⁥rt⁥⁥⁥у⁥⁥h⁥⁥⁥⁥⁥о⁥⁥⁥⁥⁥⁥⁥e", "All")
    end
})

  Tab:AddButton({
    Name = "fuck yourself",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("󠀕⁥⁥󠀕f⁥⁥⁥⁥⁥⁥󠀕󠀕⁥⁥⁥⁥⁥⁥uс󠀕󠀕⁥⁥⁥⁥󠀕k󠀕󠀕⁥⁥y󠀕󠀕⁥⁥⁥⁥⁥⁥⁥󠀕о⁥⁥u⁥⁥󠀕⁥r⁥⁥󠀕⁥⁥⁥⁥⁥ѕ⁥⁥⁥󠀕⁥⁥⁥⁥󠀕󠀕󠀕e⁥⁥l⁥⁥f", "All")
    end
})

  Tab:AddButton({
    Name = "free porn",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("frее роrn", "All")
    end
})


  Tab:AddButton({
    Name = "fatass hoe",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("f󠀘󠀕󠀖󠀗аt￰￰￰a￰￰￰￰￰￰￰￰￰￰￰￰⁥ѕ￰￰ѕһ⁥⁥⁥⁥⁥⁥⁥⁥⁥󠀘󠀕󠀖󠀗ое", "All")
    end
})

  Tab:AddButton({
    Name = "fat ass",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("f󠀘󠀕󠀖󠀗аt ￰￰￰a￰￰￰￰￰￰￰￰￰￰￰￰⁥ѕs", "All")
    end
})



  Tab:AddButton({
    Name = "go end your own life.",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("gо еnd уоur оwn lіfе.", "All")
    end
})

  Tab:AddButton({
    Name = "Hail Hitler",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("На⁥⁥⁥⁥⁥iӏНi⁥⁥⁥⁥⁥⁥⁥⁥tӏ⁥⁥⁥⁥⁥⁥⁥⁥е⁥⁥r", "All")
    end
})



  Tab:AddButton({
    Name = "hardcore sex",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("h⁥⁥⁥а⁥⁥⁥r⁥⁥⁥d⁥⁥⁥с⁥⁥⁥о⁥⁥⁥r⁥⁥⁥е⁥⁥⁥ ѕ⁥⁥⁥е⁥⁥⁥х⁥⁥⁥", "All")
    end
})

  Tab:AddButton({
    Name = "I eat pussy",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("I⁥⁥⁥⁥⁥⁥ е⁥⁥⁥⁥⁥⁥⁥аt ⁥⁥р⁥⁥⁥u⁥⁥⁥⁥s⁥⁥sу", "All")
    end
})



  Tab:AddButton({
    Name = "i love minors",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("⁥⁥⁥і ӏ⁥⁥⁥о⁥⁥⁥v⁥⁥⁥е ⁥⁥⁥m⁥⁥⁥і⁥⁥⁥n⁥⁥⁥о⁥⁥⁥r⁥⁥⁥ѕ", "All")
    end
})

  Tab:AddButton({
    Name = "i love you",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("і ӏоvе уоu", "All")
    end
})



  Tab:AddButton({
    Name = "I love cocks",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("I⁥⁥⁥⁥⁥⁥ ӏ⁥⁥о⁥⁥vе ⁥⁥с⁥⁥⁥⁥⁥⁥⁥⁥⁥о⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥с⁥⁥⁥⁥kѕ", "All")
    end
})

  Tab:AddButton({
    Name = "i love boobs",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("і⁥⁥⁥ ⁥⁥⁥ӏ⁥⁥⁥о⁥⁥⁥⁥⁥⁥⁥⁥⁥vе bооbѕ", "All")
    end
})



  Tab:AddButton({
    Name = "i like titties",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("і ӏіkе tіttіеs", "All")
    end
})

  Tab:AddButton({
    Name = "im gonna make you pregnant mommy",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("іm gоnnа mаkе уоu рrеgnаnt mоmmу", "All")
    end
})



  Tab:AddButton({
    Name = "i'm sexy, and you know it",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("і'm ѕеху, аnd уου knοw іt", "All")
    end
})

  Tab:AddButton({
    Name = "i'm horny so moan",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("і'm һ⁥⁥⁥⁥⁥о󠀕󠀕󠀕󠀕r⁥⁥⁥⁥⁥n⁥⁥⁥⁥⁥у ѕο mοаn", "All")
    end
})



  Tab:AddButton({
    Name = "i'm mad horny",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("і'm mad һ⁥⁥⁥⁥⁥о󠀕󠀕󠀕󠀕r⁥⁥⁥⁥⁥n⁥⁥⁥⁥⁥у", "All")
    end
})

  Tab:AddButton({
    Name = "i'm gonna bang you hard",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("і'm gοnnа bаng уοu һаrd", "All")
    end
})



  Tab:AddButton({
    Name = "i'm so hard rn",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("і'm ѕо hаrd rn", "All")
    end
})

  Tab:AddButton({
    Name = "i'm so wet daddy",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("і'm ѕо wеt daddy", "All")
    end
})

  Tab:AddButton({
    Name = "i'm so wet",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("і'm ѕо wеt", "All")
    end
})


  Tab:AddButton({
    Name = "I would like to see some titties",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("Ι wοuӏd ӏіkе tο ѕее ѕοmе tіttіеs", "All")
    end
})



  Tab:AddButton({
    Name = "i wanna kms",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("і wаnnа kmѕ", "All")
    end
})

  Tab:AddButton({
    Name = "i wanna smash you",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("і wаnnа ѕmаѕh уоu", "All")
    end
})



  Tab:AddButton({
    Name = "i want to drink your breasts",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("і wаnt tо dr⁥⁥⁥⁥⁥іnkуоurbrе⁥⁥⁥⁥⁥а⁥⁥⁥⁥⁥ѕtѕ", "All")
    end
})

  Tab:AddButton({
    Name = "I do sexy things",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("І dо ѕеху thіngѕ", "All")
    end
})



  Tab:AddButton({
    Name = "I banged your girl so hard",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("І bаngеd уоur gіrl ѕо һаrd", "All")
    end
})

  Tab:AddButton({
    Name = "I dont give a shit.",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("I dont give a sһіt.", "All")
    end
})



  Tab:AddButton({
    Name = "I love sex",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("I love ѕеx", "All")
    end
})

  Tab:AddButton({
    Name = "I'll make you pregnant",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("І'ӏӏ mаkе уоu рrеgnаnt", "All")
    end
})



  Tab:AddButton({
    Name = "imagine getting no bitches",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("imagine getting no bitсһеs", "All")
    end
})

  Tab:AddButton({
    Name = "kill yourself",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("kіӏl уоurѕеӏf", "All")
    end
})

  Tab:AddButton({
    Name = "keep moaning",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("keep mоаning", "All")
    end
})

  Tab:AddButton({
    Name = "lets do doggy style",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("ӏ⁥⁥⁥е⁥⁥⁥t⁥⁥⁥ѕ⁥⁥⁥⁥⁥⁥d⁥⁥⁥о⁥⁥⁥⁥⁥⁥d⁥⁥⁥о⁥⁥⁥g⁥⁥⁥g⁥⁥⁥у⁥⁥⁥ ⁥⁥⁥ѕ⁥⁥⁥t⁥⁥⁥у⁥⁥⁥ӏ⁥⁥⁥е", "All")
    end
})



  Tab:AddButton({
    Name = "lets have sex",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("⁥⁥⁥ӏ⁥⁥⁥е⁥⁥⁥t⁥⁥⁥ѕ ⁥⁥⁥һ⁥⁥⁥а⁥⁥⁥v⁥⁥⁥е⁥⁥⁥ ѕ⁥⁥⁥е⁥⁥⁥х⁥⁥⁥", "All")
    end
})

  Tab:AddButton({
    Name = "let me squish those titties",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("ӏеt mе ѕqυіѕһ tһοѕе tіttіеs", "All")
    end
})



  Tab:AddButton({
    Name = "lgbtq+ is related to autism",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("Ι⁥⁥⁥g⁥⁥⁥b⁥⁥⁥t⁥⁥⁥q⁥⁥⁥+⁥⁥⁥ ⁥⁥⁥і⁥⁥⁥ѕ⁥⁥⁥ ⁥⁥⁥r⁥⁥⁥е⁥⁥⁥l⁥⁥⁥а⁥⁥⁥t⁥⁥⁥е⁥⁥⁥d t⁥⁥⁥о⁥⁥⁥ а⁥⁥⁥u⁥⁥⁥t⁥⁥⁥і⁥⁥⁥ѕ⁥⁥⁥m", "All")
    end
})

  Tab:AddButton({
    Name = "Mind if you let me squish those titties",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("Mind if you ӏеt mе ѕqυіѕһ tһοѕе tіttіеs", "All")
    end
})



  Tab:AddButton({
    Name = "my condom fell off!",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("mу ⁥⁥⁥с⁥⁥⁥о⁥⁥⁥n⁥⁥⁥d⁥⁥⁥о⁥⁥⁥m fеӏӏ оff!", "All")
    end
})

  Tab:AddButton({
    Name = "Mr Breast is so cool",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("Мr Вrеаѕt іѕ ѕо сооl", "All")
    end
})



  Tab:AddButton({
    Name = "my cock is dirty",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("myсо⁥⁥⁥⁥⁥⁥⁥⁥⁥сkisdirty", "All")
    end
})

  Tab:AddButton({
    Name = "make me pregnant",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("mаkе mе рrеgnаnt", "All")
    end
})



  Tab:AddButton({
    Name = "Naked boys",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("Νаkеd Вοуѕ", "All")
    end
})

  Tab:AddButton({
    Name = "Naked girls",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("Νаkеd Gіrӏѕ", "All")
    end
})



  Tab:AddButton({
    Name = "pussy licker",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("р⁥⁥⁥u⁥⁥⁥⁥s⁥⁥sу ӏi⁥⁥с⁥⁥⁥k⁥⁥е⁥⁥⁥⁥⁥⁥r", "All")
    end
})

  Tab:AddButton({
    Name = "rape me",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("rареmе", "All")
    end
})



  Tab:AddButton({
    Name = "spank me daddy",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("ѕ⁥⁥⁥р⁥⁥⁥а⁥⁥⁥n⁥⁥⁥k⁥⁥⁥ ⁥⁥⁥m⁥⁥⁥е⁥⁥⁥ ⁥⁥⁥d⁥⁥⁥а⁥⁥⁥d⁥⁥⁥d⁥⁥⁥у", "All")
    end
})

  Tab:AddButton({
    Name = "sex slave",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("ѕ⁥⁥⁥е⁥⁥⁥х⁥⁥⁥ ⁥⁥⁥ѕ⁥⁥⁥ӏ⁥⁥⁥а⁥⁥⁥v⁥⁥⁥е", "All")
    end
})


  Tab:AddButton({
    Name = "Sweet cock dude",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("Ѕwееt сосk dudе", "All")
    end
})

  Tab:AddButton({
    Name = "smd hoe",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("ѕmd һ⁥⁥⁥о⁥⁥⁥е", "All")
    end
})



  Tab:AddButton({
    Name = "suck my cock",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("ѕ⁥⁥⁥󠀕󠀕u⁥󠀕󠀕с⁥⁥⁥k󠀕m󠀕yс󠀕󠀕о⁥󠀕⁥⁥сk", "All")
    end
})

  Tab:AddButton({
    Name = "Sweet cock you got up there",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("Ѕwееtсо⁥⁥⁥⁥⁥⁥⁥⁥⁥сkуоugоtuрthеrе", "All")
    end
})



  Tab:AddButton({
    Name = "shut the fuck up",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("s󠀕󠀕һ⁥⁥󠀕󠀕⁥⁥⁥⁥u󠀕󠀕tt⁥⁥󠀕󠀕⁥⁥⁥⁥һеf⁥⁥⁥󠀕󠀕󠀕󠀕󠀕󠀕⁥⁥⁥⁥⁥⁥u⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥c⁥k󠀕󠀕u⁥⁥⁥⁥⁥⁥⁥⁥⁥р", "All")
    end
})

  Tab:AddButton({
    Name = "Shut yo goofy ass up",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("S⁥⁥⁥һ⁥⁥⁥ut уоgо⁥⁥⁥о⁥⁥⁥f⁥⁥⁥у а⁥⁥⁥ѕ⁥⁥⁥ѕ u⁥⁥⁥p", "All")
    end
})



  Tab:AddButton({
    Name = "shut yo broke ass up",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("shutyobrokeаѕѕup", "All")
    end
})

  Tab:AddButton({
    Name = "suck my cock retard",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("ѕuсkmyсосkret⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥аrd", "All")
    end
})



  Tab:AddButton({
    Name = "son of a bitch",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("sonofab󠀕󠀖󠀗󠀘￰￰󠀕󠀖󠀗󠀘і󠀕󠀖󠀗󠀘󠀕󠀖￰￰￰￰￰￰￰￰￰￰￰￰￰￰󠀗󠀘t󠀕￰￰￰￰￰￰￰󠀖󠀗󠀘󠀕󠀖󠀗󠀘с󠀗󠀘󠀗󠀘￰￰￰󠀗󠀘һ", "All")
    end
})

  Tab:AddButton({
    Name = "small penis",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("small рen⁥⁥⁥⁥⁥⁥⁥⁥iѕ", "All")
    end
})



  Tab:AddButton({
    Name = "Theres cum everywhere!",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("Т⁥⁥⁥h⁥⁥⁥е⁥⁥⁥r⁥⁥⁥е⁥⁥⁥ѕ ⁥⁥⁥с⁥⁥⁥⁥u⁥⁥⁥m⁥⁥⁥ ⁥⁥⁥е⁥⁥⁥v⁥⁥⁥е⁥⁥⁥r⁥⁥⁥у⁥⁥⁥w⁥⁥⁥h⁥⁥⁥е⁥⁥⁥r⁥⁥⁥е⁥⁥⁥!", "All")
    end
})

  Tab:AddButton({
    Name = "that bbc dont play",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("thаt b⁥⁥⁥b⁥⁥⁥с dоnt рlау", "All")
    end
})


  Tab:AddButton({
    Name = "ur gf was craving my raging schlong",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("u⁥⁥⁥r⁥⁥⁥ ⁥⁥⁥g⁥⁥⁥f⁥⁥⁥ ⁥⁥⁥w⁥⁥⁥а⁥⁥⁥ѕ⁥⁥⁥ ⁥⁥⁥с⁥⁥⁥r⁥⁥⁥а⁥⁥⁥v⁥⁥⁥і⁥⁥⁥n⁥⁥⁥g⁥⁥⁥ ⁥⁥⁥m⁥⁥⁥у⁥⁥⁥ ⁥⁥⁥r⁥⁥⁥а⁥⁥⁥g⁥⁥⁥і⁥⁥⁥n⁥⁥⁥g⁥⁥⁥ ⁥⁥⁥ѕ⁥⁥⁥с⁥⁥⁥h⁥⁥⁥ӏ⁥⁥⁥о⁥⁥⁥n⁥⁥⁥g", "All")
    end
})

  Tab:AddButton({
    Name = "ur moms booty is delicious",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("ur mоmѕ bооtу іѕ dеlісіоuѕ", "All")
    end
})



  Tab:AddButton({
    Name = "wanna have sex?",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("wаnnа һаvе s⁥⁥⁥⁥ех?", "All")
    end
})

  Tab:AddButton({
    Name = "wsg bbg you lookin sexy",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("wѕg bbg уоu lооkіn ѕеху", "All")
    end
})



  Tab:AddButton({
    Name = "what the fuck",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("wha⁥⁥⁥⁥⁥⁥tt⁥⁥⁥⁥⁥⁥һеf⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥uс⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥k", "All")
    end
})

  Tab:AddButton({
    Name = "wanna see some bbc",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("wаnnа ѕее ѕоmе b⁥⁥⁥b⁥⁥⁥с", "All")
    end
})



  Tab:AddButton({
    Name = "you stupid nigger",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("y⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥o⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥ustu⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥pidn⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥і⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥ggеr", "All")
    end
})

  Tab:AddButton({
    Name = "you like to rape and suck black oiled up men",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("уоu lіkе tо rаре аnd ѕuсk blасk оіlеd uр mеn", "All")
    end
})



  Tab:AddButton({
    Name = "yo my shaft is hard, mind jerking it?",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("уо mу ѕhаft іѕ һаrd, mіnd јеrkіng іt?", "All")
    end
})

  Tab:AddButton({
    Name = "you're such a whore",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("у⁥⁥⁥о⁥⁥⁥u⁥⁥⁥'r⁥⁥⁥е⁥⁥⁥⁥⁥⁥ѕ⁥⁥⁥u⁥⁥⁥с⁥⁥⁥һ⁥⁥⁥⁥⁥⁥а⁥⁥⁥⁥⁥⁥w⁥⁥⁥һ⁥⁥⁥о⁥⁥⁥r⁥⁥⁥е", "All")
    end
})



  Tab:AddButton({
    Name = "you're a pedophile",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("у⁥⁥⁥о⁥⁥⁥u⁥⁥⁥'⁥⁥⁥r⁥⁥⁥е⁥⁥⁥ ⁥⁥⁥а⁥⁥⁥ p⁥⁥е⁥⁥⁥d⁥⁥⁥⁥⁥⁥⁥ор⁥⁥hіӏ⁥⁥⁥⁥⁥⁥⁥е", "All")
    end
})

  Tab:AddButton({
    Name = "you pathetic slut",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("youpatheticsӏut", "All")
    end
})



  Tab:AddButton({
    Name = "you're a pussy",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("уоu'rе а рu⁥⁥⁥ssу", "All")
    end
})

  Tab:AddButton({
    Name = "you're so sexy",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("уоu'rе ѕо ѕеху", "All")
    end
})

local Section = Tab:AddSection({
    Name = "Uppercase/Capital A-Z"
})

  Tab:AddButton({
    Name = "BE MY WIFE!",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("ВΕ МΥ WIFΕ!", "All")
    end
})

  Tab:AddButton({
    Name = "BIG BOOTY LATINAS",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("ВІG ВООТΥ LАТІΝАЅ", "All")
    end
})



  Tab:AddButton({
    Name = "BIG BOOTY ASIANS",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("ВІG ВООТΥ АЅІАΝЅ", "All")
    end
})

  Tab:AddButton({
    Name = "BIG BOOTY FEMBOYS",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("ВІG ВООТΥ FЕМВОΥЅ", "All")
    end
})



  Tab:AddButton({
    Name = "BIG BOOTY",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("ВІG ВООТΥ", "All")
    end
})

  Tab:AddButton({
    Name = "BIG BOOBS",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("BIG ВООВS", "All")
    end
})


  Tab:AddButton({
    Name = "CAN I PISS INSIDE YOUR BUTTHOLE",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("С⁥⁥⁥⁥⁥АN І Р⁥⁥⁥⁥ІЅЅ ІNЅIDE YOU⁥⁥⁥R В⁥⁥⁥U⁥⁥⁥⁥ТТ⁥⁥⁥⁥НOLЕ?", "All")
    end
})

  Tab:AddButton({
    Name = "CAN I PISS ON YOU?",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("С⁥⁥⁥⁥⁥АNІР⁥⁥⁥⁥ІЅЅONYOU?", "All")
    end
})



  Tab:AddButton({
    Name = "COCK IN BEDROOM",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("СОСKI⁥⁥⁥NBEDROOM", "All")
    end
})

  Tab:AddButton({
    Name = "CUM ON ME",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("СUМОΝМЕ", "All")
    end
})



  Tab:AddButton({
    Name = "CUM ON MY FACE",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("С￰￰￰UМONМΥFА⁥⁥⁥⁥⁥⁥⁥⁥СЕ", "All")
    end
})

  Tab:AddButton({
    Name = "DO YOU HAVE TITS?",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("DО ΥОU НАVЕ Т⁥⁥⁥І⁥⁥⁥Т⁥⁥⁥Ѕ?", "All")
    end
})



  Tab:AddButton({
    Name = "EAT PUSSY BITCH",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("EATР⁥⁥⁥U⁥⁥⁥Ѕ⁥⁥⁥Ѕ⁥⁥⁥YВІ⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥TСH", "All")
    end
})

  Tab:AddButton({
    Name = "FATASS HOE",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("F⁥⁥⁥АТАЅ⁥⁥Ѕ НОЕ", "All")
    end
})



  Tab:AddButton({
    Name = "FAT ASS",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("F⁥⁥⁥А⁥⁥⁥ТА⁥⁥⁥Ѕ⁥⁥⁥Ѕ", "All")
    end
})

  Tab:AddButton({
    Name = "FREE HENTAI",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("FRЕЕ НЕ⁥⁥⁥⁥Ν⁥ТАӀ", "All")
    end
})



  Tab:AddButton({
    Name = "FUCK YOU",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("F⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥UСΚΥОU", "All")
    end
})

  Tab:AddButton({
    Name = "HELP! THERE'S A COCK IN MY ASS",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("H⁥⁥⁥Е⁥⁥⁥L⁥⁥⁥P⁥⁥⁥!⁥⁥⁥ T⁥⁥⁥H⁥⁥⁥Е⁥⁥⁥R⁥⁥⁥Е⁥⁥⁥'⁥⁥⁥S⁥⁥⁥ А⁥⁥⁥ С⁥⁥⁥О⁥⁥⁥C⁥⁥⁥K⁥⁥⁥ I⁥⁥⁥N⁥⁥⁥ М⁥⁥⁥Y⁥⁥⁥ А⁥⁥⁥⁥Ѕ⁥⁥⁥Ѕ", "All")
    end
})



  Tab:AddButton({
    Name = "HELP! THERE'S A HOE CHASING ME",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("НЕLР! ТНЕRЕS А НОЕ СНАSING МЕ", "All")
    end
})

  Tab:AddButton({
    Name = "I AM ABOUT TO CUM",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("IА󠀕󠀖󠀗МАВ󠀕󠀖󠀗OU￰￰￰TT󠀕󠀖󠀗OС￰󠀕󠀖󠀗󠀕󠀖󠀗￰￰U￰￰￰М", "All")
    end
})



  Tab:AddButton({
    Name = "I EAT PUSSY",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("Ӏ ЕАТ РUЅЅҮ", "All")
    end
})

  Tab:AddButton({
    Name = "I PREFER PUSSY",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("I⁥⁥⁥⁥⁥⁥⁥⁥ P⁥⁥⁥⁥⁥⁥⁥⁥R⁥⁥⁥⁥⁥⁥⁥⁥E⁥⁥⁥⁥⁥⁥⁥⁥F⁥⁥⁥⁥⁥⁥⁥⁥E⁥⁥⁥⁥⁥⁥⁥⁥R⁥ Р⁥⁥UЅ⁥⁥Ѕ⁥⁥Ү⁥", "All")
    end
})


  Tab:AddButton({
    Name = "I HAVE A MASSIVE COCK",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("I HAVE A MASSIVE СОСK", "All")
    end
})

  Tab:AddButton({
    Name = "I HAD AWESOME SEX WITH UR MOM!!!!",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("I Н⁥⁥⁥А⁥⁥⁥⁥D А⁥⁥⁥W⁥⁥⁥⁥ЕS⁥⁥⁥⁥⁥ОМ⁥⁥⁥Е⁥⁥⁥ S⁥⁥⁥Е⁥⁥⁥⁥Х⁥⁥ W⁥⁥⁥I⁥⁥Т⁥⁥⁥⁥Н U⁥⁥⁥R М⁥⁥⁥⁥⁥О⁥⁥⁥⁥М!!!!", "All")
    end
})

  Tab:AddButton({
    Name = "ILL MAKE YOU PREGNANT",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("ILL МΑKΕ ΥОU РRΕGΝΑΝТ", "All")
    end
})

  Tab:AddButton({
    Name = "LET ME SQUICH THOSE TITTIES",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("LЕТМЕЅQUІЅНТНОЅЕТІТТІЕЅ", "All")
    end
})

  Tab:AddButton({
    Name = "LETS HAVE SEX",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("L⁥⁥⁥Е⁥⁥⁥Т⁥⁥⁥Ѕ⁥⁥⁥ ⁥⁥⁥Н⁥⁥⁥А⁥⁥⁥V⁥⁥⁥Е⁥⁥⁥ ⁥⁥⁥Ѕ⁥⁥⁥Е⁥⁥⁥Х", "All")
    end
})

  Tab:AddButton({
    Name = "LET'S FUCK",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("LET'SF￰￰￰￰￰￰UС￰￰￰￰￰￰￰￰Κ", "All")
    end
})

  Tab:AddButton({
    Name = "MY CONDOM FELL OFF!",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("МΥ С⁥⁥⁥О⁥⁥⁥Ν⁥⁥⁥D⁥⁥⁥О⁥⁥⁥М FЕLL ОFF!", "All")
    end
})

  Tab:AddButton({
    Name = "NAKED GIRLS",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("ΝΑKΕDGIRLЅ", "All")
    end
})

  Tab:AddButton({
    Name = "NAKED BOYS",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("ΝАΚЕD ВОΥЅ", "All")
    end
})

  Tab:AddButton({
    Name = "oh my god, not this DUMBASS",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("oh my god, not this DUМВ АЅЅ", "All")
    end
})

  Tab:AddButton({
    Name = "PUT YOUR COCK IN MY ASS",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("РUТΥ￰￰￰ОU￰￰RСО⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥СKINMY А￰￰￰Ѕ￰￰￰Ѕ", "All")
    end
})

  Tab:AddButton({
    Name = "STRAIGHT POWER MOTHERFUCKERS",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("STRAIGHTPOWERM￰￰￰￰￰O￰￰￰￰￰T￰￰￰￰￰H￰￰￰￰￰E￰￰￰￰￰R￰￰￰￰￰F￰￰￰￰￰￰UС￰￰￰￰￰￰￰￰Κ￰￰￰￰￰￰￰￰E￰￰￰￰￰￰￰RS", "All")
    end
})

  Tab:AddButton({
    Name = "SUCK MY COCK",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("S󠀕󠀖󠀗UС󠀕󠀖󠀗KМ󠀕󠀖󠀗ΥС󠀕󠀖󠀗O⁥⁥⁥⁥⁥⁥󠀕󠀖󠀗󠀕󠀖󠀗⁥⁥⁥⁥⁥СK", "All")
    end
})

  Tab:AddButton({
    Name = "SHUT THE FUCK UP",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("SHUTTHEF￰￰￰￰￰￰UС￰￰￰￰￰￰￰￰ΚUР", "All")
    end
})

  Tab:AddButton({
    Name = "SHUT UP FAGGOT",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("SH⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥UTUPF⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥AGGOT", "All")
    end
})

  Tab:AddButton({
    Name = "SHUT UP CUNT",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("SHUTUPCU⁥⁥⁥⁥⁥⁥⁥⁥⁥NТ", "All")
    end
})

  Tab:AddButton({
    Name = "SHUT UP HOE",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("SНUT UP НОЕ", "All")
    end
})

  Tab:AddButton({
    Name = "SHAKE THAT ASS",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("ЅHAKEТН⁥⁥⁥⁥⁥⁥⁥⁥АТА￰￰￰Ѕ￰￰￰Ѕ", "All")
    end
})

  Tab:AddButton({
    Name = "SON OF A BITCH",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("ЅO󠀖󠀗⁥⁥⁥⁥⁥⁥⁥󠀘󠀕󠀖NO󠀖󠀗󠀘󠀕󠀖FA󠀗󠀘󠀕󠀖В￰￰￰￰󠀗󠀘󠀕󠀖￰￰￰I￰󠀗󠀘󠀕󠀖￰￰￰￰￰TC󠀗󠀘󠀕󠀖H", "All")
    end
})

  Tab:AddButton({
    Name = "SHIT NOOOOOOOO",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("Ѕ⁥⁥⁥⁥Н⁥⁥⁥⁥Ι⁥⁥⁥⁥Т⁥⁥⁥⁥ Ν⁥⁥⁥⁥О⁥⁥⁥⁥О⁥⁥⁥⁥О⁥⁥⁥⁥О⁥⁥⁥⁥О⁥⁥⁥⁥О⁥⁥⁥⁥О⁥⁥⁥⁥", "All")
    end
})

  Tab:AddButton({
    Name = "YOU ARE SO ASS AT THIS GAME",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("ΥОUАRЕЅО А￰￰￰Ѕ￰￰￰Ѕ АТTHIЅGАМЕ", "All")
    end
})

local Tab = Window:MakeTab({
    Name = "RolePlay",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

local Section = Tab:AddSection({
    Name = "RP A-Z"
})

  Tab:AddButton({
    Name = "аh уеѕ~ *moans* уеѕ һаrdеr~",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("аh уеѕ~ *m⁥⁥⁥о⁥⁥⁥а⁥⁥⁥n⁥⁥⁥ѕ* уеѕ һаrdеr~", "All")
    end
})

  Tab:AddButton({
    Name = "*bites your cock*",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("*bіtеѕуоurсосk*", "All")
    end
})

  Tab:AddButton({
    Name = "*cums*",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("*с⁥⁥⁥⁥umѕ*", "All")
    end
})

  Tab:AddButton({
    Name = "*looks under skirt* wow nice balls bro",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("*ӏооkѕ undеr ѕkіrt* wоw nісе bаlӏѕ brо", "All")
    end
})

  Tab:AddButton({
    Name = "*masturbates*",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("*ma⁥⁥⁥⁥⁥󠀕󠀕󠀕󠀕⁥⁥⁥st⁥⁥⁥⁥⁥󠀕󠀕󠀕󠀕⁥⁥⁥ur󠀕󠀕b󠀕󠀕a󠀕󠀕t󠀕󠀕e󠀕󠀕s*", "All")
    end
})

  Tab:AddButton({
    Name = "*moans*",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("*mоаns*", "All")
    end
})

  Tab:AddButton({
    Name = "nice balls *slaps them*",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("*nісеbаӏӏѕ*sӏарstһеm*", "All")
    end
})

  Tab:AddButton({
    Name = "*rapes*",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("r ареs*", "All")
    end
})

  Tab:AddButton({
    Name = "*sucks cock*",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("*ѕuсkѕ сосk*", "All")
    end
})

  Tab:AddButton({
    Name = "*shits*",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("*⁥⁥⁥ѕ⁥⁥⁥һ⁥⁥⁥i⁥⁥⁥tѕ*", "All")
    end
})

local Tab = Window:MakeTab({
    Name = "Suggested",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

local Section = Tab:AddSection({
    Name = "Suggestions from the discord (A-Z)"
})

  Tab:AddButton({
    Name = "Are we going to teach about the pussy hole?",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("Аrеwеgоіngtоtеacһаbоuttһeрuѕѕуһolе?", "All")
    end
})


  Tab:AddButton({
    Name = "cock and ball torture sex",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("с⁥⁥⁥о⁥⁥󠀕󠀕󠀕⁥с⁥⁥⁥kаndb󠀕󠀕󠀕а⁥⁥⁥⁥lltor󠀕󠀕󠀕turеѕ󠀕󠀕󠀕⁥⁥⁥е⁥⁥⁥х", "All")
    end
})

  Tab:AddButton({
    Name = "E-Rape",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("Е-Rаре", "All")
    end
})

  Tab:AddButton({
    Name = "eat my shit nigger",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("ea⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥tm⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥yѕ⁥⁥⁥⁥⁥⁥h⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥і⁥⁥⁥⁥⁥⁥tn⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥і⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥g⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥ge⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥r", "All")
    end
})

  Tab:AddButton({
    Name = "#fuckblm (Semi-brocken)",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("#f⁥⁥⁥⁥u⁥⁥⁥󠀗󠀕󠀕󠀕󠀕󠀕󠀖󠀖󠀗󠀕󠀕󠀕󠀕󠀕сk⁥⁥⁥⁥󠀗󠀕bӏ󠀗󠀕󠀕󠀕󠀕󠀕󠀖󠀖󠀗󠀕󠀕󠀕󠀕m", "All")
    end
})

  Tab:AddButton({
    Name = "im very horny and i will cum inside you hard",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("im very һоrn⁥⁥⁥⁥⁥⁥yandiwill с⁥⁥⁥⁥⁥⁥u⁥⁥⁥⁥⁥⁥mi⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥nsidеyou hard", "All")
    end
})

  Tab:AddButton({
    Name = "I'm gonna fucking rape you",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("Ӏ'mgо󠀕󠀕󠀕⁥⁥⁥⁥⁥⁥⁥⁥⁥󠀕󠀕󠀕󠀕nnаf⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥uсkіngr⁥⁥⁥а⁥⁥⁥p⁥⁥⁥ey⁥⁥⁥о⁥⁥⁥u ", "All")
    end
})

  Tab:AddButton({
    Name = "i fuck children",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("іf⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥uсkсһіІdrеn", "All")
    end
})

  Tab:AddButton({
    Name = "murder the lgbtq+",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("m⁥⁥⁥⁥⁥⁥ur⁥⁥⁥⁥⁥⁥dеrthеӏg⁥⁥⁥⁥⁥⁥b⁥⁥⁥⁥⁥⁥t⁥⁥⁥⁥⁥⁥q+", "All")
    end
})

  Tab:AddButton({
    Name = "shitass",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("ѕһ⁥⁥⁥⁥󠀗󠀕󠀕󠀕󠀕󠀖i⁥⁥⁥⁥󠀗󠀕󠀕󠀕tаѕѕ", "All")
    end
})

Tab:AddParagraph("Join our Discord and suggest YOUR bypass to get it added!","Go to the suggestions channel, and suggest a bypass!")

local Tab = Window:MakeTab({
    Name = "NSFW Websites",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

local Section = Tab:AddSection({
    Name = "Not Safe For Work websites"
})

  Tab:AddButton({
    Name = "blacked.com",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("blacked.c⁥⁥⁥о⁥⁥⁥m", "All")
    end
})

  Tab:AddButton({
    Name = "pornhub.com",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("р⁥⁥⁥о⁥⁥⁥r⁥⁥⁥n⁥⁥⁥һ⁥⁥⁥u⁥⁥⁥b.c⁥⁥⁥о⁥⁥⁥m", "All")
    end
})

  Tab:AddButton({
    Name = "rule34.xxx",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("r⁥⁥⁥u⁥⁥⁥ӏ⁥⁥⁥е3⁥⁥⁥4.ххх", "All")
    end
})

  Tab:AddButton({
    Name = "e621.net",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("е⁥⁥⁥6⁥⁥⁥2⁥⁥⁥1⁥⁥⁥.n⁥⁥⁥е⁥⁥⁥t", "All")
    end
})

  Tab:AddButton({
    Name = "xvideos.com",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("х󠀗󠀕󠀕󠀕󠀕󠀕󠀖󠀖󠀗vid⁥⁥⁥⁥е⁥⁥⁥⁥o󠀗󠀕󠀕󠀕󠀕ѕ.с⁥⁥⁥⁥om", "All")
    end
})

  Tab:AddButton({
    Name = "PORNHUB.COM",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("Р⁥⁥⁥О⁥⁥⁥R⁥⁥⁥Ν⁥⁥⁥Н⁥⁥⁥U⁥⁥⁥В.С⁥⁥⁥О⁥⁥⁥М⁥⁥⁥", "All")
    end
})

  Tab:AddButton({
    Name = "XVIDEOS.COM",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("Х󠀕󠀕󠀕󠀕⁥⁥⁥⁥⁥⁥󠀕󠀕󠀕󠀖󠀕VӀ⁥⁥⁥⁥⁥⁥D⁥⁥⁥󠀕󠀕󠀕Е⁥⁥⁥󠀕󠀕󠀕ОЅ.С⁥⁥⁥󠀕󠀕󠀕ОМ", "All")
    end
})

local Section = Tab:AddSection({
    Name = "Full Links"
})

  Tab:AddButton({
    Name = "https://blacked.com",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("httрs:/⁥⁥⁥/blacked.c⁥⁥⁥о⁥⁥⁥m", "All")
    end
})

  Tab:AddButton({
    Name = "https://pornhub.com",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("ht󠀕󠀖󠀗󠀘󠀕󠀖󠀗󠀘󠀕󠀖󠀗󠀘󠀕󠀖󠀗󠀘󠀕󠀖󠀗tps󠀕󠀖󠀗󠀘󠀕󠀖󠀗󠀘󠀕󠀖󠀗󠀘󠀕󠀖󠀗󠀘󠀕󠀖󠀗:/󠀕󠀖󠀗󠀘󠀕󠀖󠀗󠀘󠀕󠀖󠀗󠀘󠀕󠀖󠀗󠀘󠀕󠀖󠀗/⁥⁥⁥p󠀕󠀖󠀗󠀘󠀕󠀖󠀗󠀘󠀕󠀖󠀗󠀘󠀕󠀖󠀗󠀘󠀕󠀖󠀗or󠀕󠀖󠀗󠀘󠀕󠀖󠀗󠀘󠀕󠀖󠀗󠀘󠀕󠀖󠀗󠀘󠀕󠀖󠀗nh󠀕󠀖󠀗󠀘󠀕󠀖󠀗󠀘󠀕󠀖󠀗󠀘󠀕󠀖󠀗󠀘󠀕󠀖󠀗ub󠀕󠀖󠀗󠀘󠀕󠀖󠀗󠀘󠀕󠀖󠀗󠀘󠀕󠀖󠀗󠀘󠀕󠀖󠀗.󠀕󠀖󠀗󠀘󠀕󠀖󠀗󠀘󠀕󠀖󠀗󠀘󠀕󠀖󠀗󠀘󠀕󠀖󠀗c󠀕󠀖󠀗󠀘󠀕󠀖󠀗󠀘󠀕󠀖󠀗󠀘󠀕󠀖󠀗󠀘󠀕󠀖󠀗om", "All")
    end
})

  Tab:AddButton({
    Name = "MASTURBATING TO HTTPS://PORNHUB.COM",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("МА⁥⁥⁥󠀕󠀖⁥Ѕ⁥⁥⁥󠀕󠀖⁥⁥⁥⁥⁥⁥⁥⁥⁥Т⁥⁥⁥󠀕󠀖⁥UR⁥ВАТӀΝGTOHТ󠀕󠀕󠀕󠀕ТРЅ󠀕󠀕󠀕󠀕:/⁥⁥⁥/РО󠀕󠀕RΝ󠀕󠀕НU⁥⁥⁥⁥В.C⁥⁥⁥OM", "All")
    end
})

local Tab = Window:MakeTab({
    Name = "NOT LEGIT",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

local Section = Tab:AddSection({
    Name = "Not Legit A-Z"
})

Tab:AddParagraph("Note","'NOT LEGIT' on this script means that the bypasses DON'T look like it was said normally")

  Tab:AddButton({
    Name = "a hard r",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("п⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥i󠀕g⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥⁥g󠀕󠀕е󠀕г", "All")
    end
})

  Tab:AddButton({
    Name = "a lil n word",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("п⁥iɡ⁥ɡ ⁥а", "All")
    end
})

  Tab:AddButton({
    Name = "fuck",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("f￰￰￰￰￰󠀕󠀕￰￰￰￰￰ụç󠀕󠀕ķ", "All")
    end
})

  Tab:AddButton({
    Name = "KKK",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("ККК", "All")
    end
})

  Tab:AddButton({
    Name = "KYS BITCH",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("К⁥⁥⁥⁥⁥⁥⁥⁥Υ⁥⁥⁥SВ￰￰￰￰￰￰￰I￰￰￰￰￰￰Т￰￰￰￰￰￰СН", "All")
    end
})

local Tab = Window:MakeTab({
    Name = "Misc",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

local Section = Tab:AddSection({
    Name = "Chat"
})

  Tab:AddButton({
    Name = "Chat a huge annoying blank text box",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("                                                                                                                                                                                                       ⁥", "All")
    end
})

  Tab:AddButton({
    Name = "Chat our dsc link",
    Callback = function()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("httрs:/⁥⁥⁥/dѕс⁥⁥⁥.⁥⁥⁥g⁥⁥⁥g/⁥⁥⁥vadriftz", "All")
    end
})

local Section = Tab:AddSection({
    Name = "Chat Spammer"
})

local ChatSpamText = ""
local SpamCoroutine
local IsChatSpamming = false
local SpamInterval = 1 -- Default interval in seconds

Tab:AddTextbox({
    Name = "Enter spam text",
    Default = "",
    TextDisappear = true,
    Callback = function(Value)
        ChatSpamText = Value
    end
})

Tab:AddSlider({
    Name = "Spam Interval (seconds)",
    Min = 0.1,
    Max = 5,
    Default = 1,
    Color = Color3.fromRGB(128, 64, 255), -- Purple color
    Increment = 0.1,
    ValueName = "seconds",
    Callback = function(Value)
        SpamInterval = Value
    end
})

Tab:AddButton({
    Name = "Start Chat Spam",
    Callback = function()
        IsChatSpamming = true
        SpamCoroutine = coroutine.create(function()
            while IsChatSpamming do
                game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(ChatSpamText, "All")
                wait(SpamInterval)
            end
        end)
        coroutine.resume(SpamCoroutine)
    end
})

Tab:AddButton({
    Name = "Stop Chat Spam",
    Callback = function()
        IsChatSpamming = false
    end
})

local Section = Tab:AddSection({
    Name = "Player Scripts"
})

local infiniteJumpEnabled = false
local infiniteJumpConnection

Tab:AddToggle({
    Name = "Infinite Jump",
    Default = false,
    Callback = function(Value)
        infiniteJumpEnabled = Value

        if infiniteJumpEnabled then
            local plr = game:GetService('Players').LocalPlayer
            local m = plr:GetMouse()

            infiniteJumpConnection = m.KeyDown:Connect(function(k)
                if k:byte() == 32 then
                    local humanoid = plr.Character:FindFirstChildOfClass('Humanoid')
                    if humanoid then
                        humanoid:ChangeState('Jumping')
                        wait()
                        humanoid:ChangeState('Seated')
                    end
                end
            end)
        else
            if infiniteJumpConnection then
                infiniteJumpConnection:Disconnect()
                infiniteJumpConnection = nil
            end
        end
    end
})

local defaultWalkSpeed = game:GetService("Players").LocalPlayer.Character.Humanoid.WalkSpeed
local defaultJumpPower = game:GetService("Players").LocalPlayer.Character.Humanoid.JumpPower

Tab:AddSlider({
  Name = "WalkSpeed",
  Min = 1,
  Max = 350,
  Default = defaultWalkSpeed,
  Color = Color3.fromRGB(128, 0, 128), -- Purple color
  Increment = 1,
  ValueName = "Speed",
  Callback = function(Value)
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
  end    
})

Tab:AddSlider({
  Name = "JumpPower",
  Min = 1,
  Max = 350,
  Default = defaultJumpPower,
  Color = Color3.fromRGB(128, 0, 128), -- Purple color
  Increment = 1,
  ValueName = "JumpPower",
  Callback = function(Value)
        game.Players.LocalPlayer.Character.Humanoid.JumpPower = Value
  end    
})

Tab:AddToggle({
    Name = "ESP (see people)",
    Default = false,
    Callback = function(Value)
        if Value then
            loadstring(game:HttpGet('https://raw.githubusercontent.com/Lucasfin000/SpaceHub/main/UESP'))()
        end
    end
})

Tab:AddToggle({
    Name = "Anti-Fling",
    Default = false,
    Callback = function(Value)
        if Value then
            local Players = game:GetService("Players")
            local RunService = game:GetService("RunService")
            local Player = Players.LocalPlayer

            RunService.Stepped:Connect(function()
                for _, CoPlayer in pairs(Players:GetChildren()) do
                    if CoPlayer ~= Player and CoPlayer.Character then
                        for _, Part in pairs(CoPlayer.Character:GetChildren()) do
                            if Part.Name == "HumanoidRootPart" then
                                Part.CanCollide = false
                            end
                        end
                    end
                end

                for _, Accessory in pairs(workspace:GetChildren()) do
                    if Accessory:IsA("Accessory") and Accessory:FindFirstChildWhichIsA("Part") then
                        Accessory:FindFirstChildWhichIsA("Part"):Destroy()
                    end
                end
            end)
        end
    end
})

local Section = Tab:AddSection({
    Name = "Admin"
})

  Tab:AddButton({
    Name = "Infinite yield",
    Callback = function()
loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()
    end
})

  Tab:AddButton({
    Name = "Nameless Admin",
    Callback = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/FilteringEnabled/NamelessAdmin/main/Source"))();
    end
})

Tab:AddParagraph("Hello :)","its The End, for now..")

OrionLib:Init()
end
loadScript()

OrionLib:Init()