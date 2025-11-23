local Luna = loadstring(game:HttpGet("https://raw.nebulasoftworks.xyz/luna", true))()

local Window = Luna:CreateWindow({
    Name = "VoidHub | Universal",
    Subtitle = "V1.1 | Free Version", 
    LogoID = "89878385069217", 
    LoadingEnabled = true, 
    LoadingTitle = "VoidHub | Universal", 
    LoadingSubtitle = "by @Voidoffical on Discord", 

    ConfigSettings = {
        RootFolder = "VoidHubUniversalV1-1", 
        ConfigFolder = "VoidUniversal" 
    },

    KeySystem = true,
    KeySettings = {
        Title = "VoidHub key system",
        Subtitle = " Get key by joining our discord server",
        Note = "If you have any problems please DM @Voidoffical on Discord!",
        SaveInRoot = true, 
        SaveKey = true, 
        Key = {"omg_release"}, 
        SecondAction = {
            Enabled = true, 
            Type = "Discord", -- Link / Discord.
            Parameter = "QqD97eeaRG" 
        }
    }
})

Window:CreateHomeTab({
    SupportedExecutors = {" "}, 
    DiscordInvite = "QqD97eeaRG", 
    Icon = 1, 
})

local NewsTab = Window:CreateTab({
    Name = "News",
    Icon = "campaign",  
    ImageSource = "Material",
    ShowTitle = true 
})

local UpdateParagraph = NewsTab:CreateParagraph({
    Title = "Update V1.1",
    Text = "Soon"})


---------------------------------------------------------------------------------------------------------------
-------------------------------------Most Used Tab-------------------------------------
--------------------------------------------------------------------------------------------------------------

local MostTab = Window:CreateTab({
    Name = "Most Used",
    Icon = "star",  
    ImageSource = "Material",
    ShowTitle = true 
})

--------------------------------------------------------------------------

-- Parts removed

--------------------------------------------------------------------------

local player = game.Players.LocalPlayer -- WalkSpeed

local WalkSpeedInput = MostTab:CreateInput({
    Name = "Walk Speed (Default is 16)",
    PlaceholderText = "1-300",
    CurrentValue = "16",
    Numeric = true,
    MaxCharacters = 3,
    Callback = function(Text)
        local humanoid = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
        if not humanoid then return end

        local value = tonumber(Text)
        if not value then return end

        if player.UserId ~= 3361952380 then
            if value > 300 then value = 300 end
            if value < 1 then value = 1 end
        else
            if value < 1 then value = 1 end
        end

        humanoid.WalkSpeed = value
        WalkSpeedInput:Set(tostring(value))
    end
})

player.CharacterAdded:Connect(function(char)
    wait(1)
    local humanoid = char:FindFirstChildOfClass("Humanoid")
    if humanoid then
        humanoid.WalkSpeed = 16
        WalkSpeedInput:Set("16")
    end
end)

local Label = MostTab:CreateLabel({
    Text = "If speed changer says callback error but works you have to do nothing",
    Style = 2 
})
---------------------------------------------------------------------------------------------------------------
-------------------------------------Movement Tab-------------------------------------
---------------------------------------------------------------------------------------------------------------

local MoveTab = Window:CreateTab({
    Name = "Movement",
    Icon = "directions_run",  
    ImageSource = "Material",
    ShowTitle = true 
})

---------------------------------------------------------------------------------------------------------------

local player = game.Players.LocalPlayer -- WalkSpeed

local WalkSpeedInput = MoveTab:CreateInput({
    Name = "Walk Speed (Default is 16)",
    PlaceholderText = "1-300",
    CurrentValue = "16",
    Numeric = true,
    MaxCharacters = 3,
    Callback = function(Text)
        local humanoid = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
        if not humanoid then return end

        local value = tonumber(Text)
        if not value then return end

        if player.UserId ~= 3361952380 then
            if value > 300 then value = 300 end
            if value < 1 then value = 1 end
        else
            if value < 1 then value = 1 end
        end

        humanoid.WalkSpeed = value
        WalkSpeedInput:Set(tostring(value))
    end
})

player.CharacterAdded:Connect(function(char)
    wait(1)
    local humanoid = char:FindFirstChildOfClass("Humanoid")
    if humanoid then
        humanoid.WalkSpeed = 16
        WalkSpeedInput:Set("16")
    end
end)

local Label = MoveTab:CreateLabel({
    Text = "If speed changer says callback error but works you have to do nothing",
    Style = 2 
})

---------------------------------------------------------------------------------------------------------------

local player = game.Players.LocalPlayer -- JumpPower

local JumpPowerInput = MoveTab:CreateInput({
    Name = "Jump Power (Default is 50)",
    PlaceholderText = "1-200",
    CurrentValue = "50",
    Numeric = true,
    MaxCharacters = 3,
    Callback = function(Text)
        local humanoid = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
        if not humanoid then return end

        local value = tonumber(Text)
        if not value then return end

        if player.UserId ~= 3361952380 then
            if value > 200 then value = 200 end
            if value < 1 then value = 1 end
        else
            if value < 1 then value = 1 end
        end

        humanoid.JumpPower = value
        JumpPowerInput:Set(tostring(value))
    end
})

player.CharacterAdded:Connect(function(char)
    wait(1)
    local humanoid = char:FindFirstChildOfClass("Humanoid")
    if humanoid then
        humanoid.JumpPower = 50
        JumpPowerInput:Set("50")
    end
end)

local Label = MoveTab:CreateLabel({
    Text = "If jump power says callback error but works you have to do nothing",
    Style = 2
})

---------------------------------------------------------------------------------------------------------------

local player = game.Players.LocalPlayer -- Infinite jump
local UIS = game:GetService("UserInputService")

local InfiniteJumpEnabled = false

local InfiniteJumpToggle = MoveTab:CreateToggle({
    Name = "Infinite Jump",
    CurrentValue = false,
    Callback = function(Value)
        InfiniteJumpEnabled = Value
    end
})

UIS.JumpRequest:Connect(function()
    if InfiniteJumpEnabled then
        local char = player.Character
        if not char then return end
        
        local humanoid = char:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end
end)

---------------------------------------------------------------------------------------------------------------

local GravityInput = MoveTab:CreateInput({
    Name = "Gravity (Default is 196.2)",
    CurrentValue = tostring(workspace.Gravity),
    PlaceholderText = "0 - 500",
    RemoveTextAfterFocusLost = false,
    Flag = "gravityinput",
    Callback = function(text)
        local value = tonumber(text)


        if not value then
            warn("Gravity: not a number")
            return
        end

        
        value = math.clamp(value, 0, 500)

        workspace.Gravity = value
    end,
})



local Label = MoveTab:CreateLabel({
    Text = "⬇ Tool Loaders ⬇",
    Style = 1
})

---------------------------------------------------------------------------------------------------------------

-- I removed parts here

---------------------------------------------------------------------------------------------------------------
-------------------------------------Player Tab-------------------------------------
---------------------------------------------------------------------------------------------------------------

local PlayerTab = Window:CreateTab({
    Name = "Player",
    Icon = "person",  
    ImageSource = "Material",
    ShowTitle = true 
})

---------------------------------------------------------------------------------------------------------------

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local invis_on = false
local savedpos = nil

local sound = Instance.new("Sound", workspace)
sound.SoundId = "rbxassetid://6760564637"

local function setTransparency(character, transparency)
    for _, part in pairs(character:GetDescendants()) do
        if part:IsA("BasePart") or part:IsA("Decal") then
            part.Transparency = transparency
        end
    end
end

local function toggleInvisibility()
    local char = LocalPlayer.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end

    invis_on = not invis_on
    sound:Play()

    if invis_on then
        savedpos = char.HumanoidRootPart.CFrame
        char:MoveTo(Vector3.new(-25.95, 84, 3537.55))
        task.wait(0.15)

        local Seat = Instance.new("Seat")
        Seat.Anchored = false
        Seat.CanCollide = false
        Seat.Transparency = 1
        Seat.Name = "invischair"
        Seat.Parent = workspace
        Seat.Position = Vector3.new(-25.95, 84, 3537.55)

        local torso = char:FindFirstChild("Torso") or char:FindFirstChild("UpperTorso")
        if torso then
            local Weld = Instance.new("Weld")
            Weld.Part0 = Seat
            Weld.Part1 = torso
            Weld.Parent = Seat
        end

        task.wait()
        Seat.CFrame = savedpos
        setTransparency(char, 0.5)

    else
        local invisChair = workspace:FindFirstChild("invischair")
        if invisChair then invisChair:Destroy() end
        if char then setTransparency(char, 0) end
    end
end

local InvisToggle = PlayerTab:CreateToggle({
    Name = "Invisible",
    CurrentValue = false,
    Description = "May kick you in some games!",
    Callback = function(value)
        toggleInvisibility()
    end
})

---------------------------------------------------------------------------------------------------------------

local Button = PlayerTab:CreateButton({ -- Reset
    Name = "Reset",
    Description = nil,
    Callback = function()
        local player = game.Players.LocalPlayer
        local humanoid = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid.Health = 0
        end
    end
})



local Button = PlayerTab:CreateButton({ -- Sit
    Name = "Sit",
    Description = nil,
    Callback = function()
        local Players = game:GetService("Players")
        local LocalPlayer = Players.LocalPlayer
        local character = LocalPlayer.Character
        if character then
            local humanoid = character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                humanoid.Sit = true
            end
        end
    end
})

---------------------------------------------------------------------------------------------------------------

local Players = game:GetService("Players") -- Godmode
local LocalPlayer = Players.LocalPlayer

local oldHealth

local GodmodeToggle = PlayerTab:CreateToggle({
    Name = "Godmode",
    Icon = "shield_person",
    ImageSource = "Material",
    CurrentValue = false,
    Callback = function(v)
        local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
        local hum = char:FindFirstChildWhichIsA("Humanoid")
        if hum then
            if v then
                oldHealth = hum.MaxHealth
                hum.MaxHealth = math.huge
                hum.Health = math.huge
            else
                if oldHealth then
                    hum.MaxHealth = oldHealth
                    hum.Health = oldHealth
                end
            end
        end
    end
})

---------------------------------------------------------------------------------------------------------------

local RemoveFallDamageButton = PlayerTab:CreateButton({
    Name = "Remove Fall Damage",
    Icon = "height",
    ImageSource = "Material",
    Description = "Did you know? I didn't test this function",
    Callback = function()
        local char = game:GetService("Players").LocalPlayer.Character
        if char and char:FindFirstChild("FallDamage") then
            char.FallDamage:Destroy()
            
        else
            Luna:Notification({
                Title = "No FallDamage Found",
                Icon = "error",
                ImageSource = "Material",
                Content = "Can't find 'FallDamage' in character. Game uses ServerSide Fall Damage system or already deleted Fall Damage."
            })
        end
    end
})

---------------------------------------------------------------------------------------------------------------
-------------------------------------TpTab-------------------------------------
---------------------------------------------------------------------------------------------------------------

local TpTab = Window:CreateTab({
    Name = "Teleport",
    Icon = "location_on",  
    ImageSource = "Material",
    ShowTitle = true 
})

---------------------------------------------------------------------------------------------------------------

local ClickTPEnabled = false
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

local ClickTPToggle = TpTab:CreateToggle({
    Name = "Click TP (CTRL+LMB)",
    CurrentValue = false,
    Callback = function(v)
        ClickTPEnabled = v
    end,
})

Mouse.Button1Down:Connect(function()
    if ClickTPEnabled and UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then
        local char = LocalPlayer.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            local targetPos = Mouse.Hit.Position
            char.HumanoidRootPart.CFrame = CFrame.new(targetPos + Vector3.new(0, 3, 0))
        end
    end
end)

---------------------------------------------------------------------------------------------------------------

local TPInput = TpTab:CreateInput({
    Name = "TP to Player",
    CurrentValue = "",
    PlaceholderText = "Enter player name",
    RemoveTextAfterFocusLost = false,
    Flag = "tpinput",
    Callback = function(Value)
    end,
})

local TPButton = TpTab:CreateButton({
    Name = "Teleport",
    Icon = "send",
    ImageSource = "Material",
    Callback = function()
        local input = TPInput.CurrentValue
        if input == "" then return end

        local localPlayer = game.Players.LocalPlayer
        local targetPlayer = nil

        for _, player in pairs(game.Players:GetPlayers()) do
            if string.find(string.lower(player.DisplayName), string.lower(input), 1, true)
            or string.find(string.lower(player.Name), string.lower(input), 1, true) then
                targetPlayer = player
                break
            end
        end

        if not targetPlayer or not targetPlayer.Character then return end

        local character = localPlayer.Character
        if not character then return end

        local hrp = character:FindFirstChild("HumanoidRootPart")
        local targetHRP = targetPlayer.Character:FindFirstChild("HumanoidRootPart")

        if hrp and targetHRP then
            hrp.CFrame = targetHRP.CFrame + Vector3.new(0, 5, 0)
        end
    end,
})

---------------------------------------------------------------------------------------------------------------
-------------------------------------VisualTab-------------------------------------
---------------------------------------------------------------------------------------------------------------

local VisualTab = Window:CreateTab({
    Name = "Visual",
    Icon = "visibility",  
    ImageSource = "Material",
    ShowTitle = true 
})

---------------------------------------------------------------------------------------------------------------

local FullbrightEnabled = false
local Lighting = game:GetService("Lighting")

local oldLighting = {
    ClockTime = Lighting.ClockTime,
    Brightness = Lighting.Brightness,
    FogEnd = Lighting.FogEnd,
    GlobalShadows = Lighting.GlobalShadows,
    Ambient = Lighting.Ambient
}

local FullbrightToggle = VisualTab:CreateToggle({
    Name = "Fullbright",
    Icon = "wb_sunny",
    ImageSource = "Material",
    CurrentValue = false,
    Callback = function(v)
        FullbrightEnabled = v
        if FullbrightEnabled then
            Lighting.ClockTime = 14
            Lighting.Brightness = 2
            Lighting.FogEnd = 100000
            Lighting.GlobalShadows = false
            Lighting.Ambient = Color3.fromRGB(255, 255, 255)
        else
            for k, val in pairs(oldLighting) do
                Lighting[k] = val
            end
        end
    end
})

---------------------------------------------------------------------------------------------------------------

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

_G.ESPEnabled = false
local ESPColor = Color3.fromRGB(255, 0, 0)

local function toggleESP(value)
    _G.ESPEnabled = value

    if value then
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character then
                local highlight = player.Character:FindFirstChildOfClass("Highlight") or Instance.new("Highlight")
                highlight.Parent = player.Character
                highlight.FillColor = ESPColor
                highlight.FillTransparency = 0.5
                highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
                highlight.OutlineTransparency = 0
            end
        end
    else
        for _, player in pairs(Players:GetPlayers()) do
            if player.Character then
                local highlight = player.Character:FindFirstChildOfClass("Highlight")
                if highlight then
                    highlight:Destroy()
                end
            end
        end
    end
end

local ESPToggle = VisualTab:CreateToggle({
    Name = "ESP",
    Icon = "visibility",
    ImageSource = "Material",
    CurrentValue = false,
    Callback = function(v)
        toggleESP(v)
    end
})

local ESPColorPicker = VisualTab:CreateColorPicker({
    Name = "ESP Color",
    Color = ESPColor,
    Flag = "ESPColorPicker",
    Callback = function(value)
        ESPColor = value
        if _G.ESPEnabled then
            for _, player in pairs(Players:GetPlayers()) do
                if player ~= LocalPlayer and player.Character then
                    local highlight = player.Character:FindFirstChildOfClass("Highlight")
                    if highlight then
                        highlight.FillColor = ESPColor
                    end
                end
            end
        end
    end
})



local FOVSlider = VisualTab:CreateSlider({   -- FOV
    Name = "Field of View (Default is 70)",
    Range = {20, 120}, 
    Increment = 1,     
    Suffix = "°",      
    CurrentValue = 70, 
    Flag = "FOVSlider",
    Callback = function(value)
        Workspace.CurrentCamera.FieldOfView = value
    end,
})

---------------------------------------------------------------------------------------------------------------
-------------------------------------MiscTab-------------------------------------
---------------------------------------------------------------------------------------------------------------

local MiscTab = Window:CreateTab({
    Name = "Misc",
    Icon = "more",  
    ImageSource = "Material",
    ShowTitle = true 
})

---------------------------------------------------------------------------------------------------------------
