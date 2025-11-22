---------------------------------------------------------------------------------------------------------------
-------------------------------------Most Used Tab-------------------------------------
---------------------------------------------------------------------------------------------------------------

return function(Window)

local MostTab = Window:CreateTab({
    Name = "Most Used",
    Icon = "star",  
    ImageSource = "Material",
    ShowTitle = true 
})

--------------------------------------------------------------------------

local FlyButton = MostTab:CreateButton({ -- Fly
    Name = "Fly GUI",
    Description = nil,
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/BlackVoidVoxel-offical/VoidHub-Universal-V1.1/refs/heads/main/mostused/scripts/fly.lua"))()
    end
})

--------------------------------------------------------------------------

local FlingButton = MostTab:CreateButton({ -- Fling
    Name = "Touch Fling GUI",
    Description = nil,
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/BlackVoidVoxel-offical/VoidHub-Universal-V1.1/refs/heads/main/mostused/scripts/fling.lua"))()
    end
})

--------------------------------------------------------------------------

local NoclipButton = MostTab:CreateButton({ -- NoClip
    Name = "NoClip GUI",
    Description = nil,
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/BlackVoidVoxel-offical/VoidHub-Universal-V1.1/refs/heads/main/mostused/scripts/NoClip.lua"))()
    end
})

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
