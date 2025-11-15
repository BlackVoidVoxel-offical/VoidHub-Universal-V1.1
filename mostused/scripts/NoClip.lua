local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

local noclipping = false
local steppedConnection
local screenGui
local mainFrame
local toggleButton
local statusLabel
local closeButton

local Colors = {
	Color3.fromRGB(147, 255, 239),
	Color3.fromRGB(201, 211, 233),
	Color3.fromRGB(255, 167, 227)
}

local function makeDraggable(frame, dragHandle)
	local dragging = false
	local dragInput, mousePos, framePos
	local function update(input)
		local delta = input.Position - mousePos
		frame.Position = UDim2.new(
			framePos.X.Scale,
			framePos.X.Offset + delta.X,
			framePos.Y.Scale,
			framePos.Y.Offset + delta.Y
		)
	end
	dragHandle.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = true
			mousePos = input.Position
			framePos = frame.Position
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
				end
			end)
		end
	end)
	dragHandle.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement then
			dragInput = input
		end
	end)
	UserInputService.InputChanged:Connect(function(input)
		if input == dragInput and dragging then
			update(input)
		end
	end)
end

local function createGui()
	if screenGui then screenGui:Destroy() end

	screenGui = Instance.new("ScreenGui")
	screenGui.Name = "NoClipGUI"
	screenGui.ResetOnSpawn = false
	screenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

	mainFrame = Instance.new("Frame", screenGui)
	mainFrame.Size = UDim2.new(0, 280, 0, 160)
	mainFrame.Position = UDim2.new(0.5,0,0.75,0)
	mainFrame.AnchorPoint = Vector2.new(0.5,0.5)
	mainFrame.BackgroundColor3 = Color3.fromRGB(20,20,25)
	mainFrame.BorderSizePixel = 0
	Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0,12)

	local gradient = Instance.new("UIGradient", mainFrame)
	gradient.Color = ColorSequence.new({
		ColorSequenceKeypoint.new(0, Colors[1]),
		ColorSequenceKeypoint.new(0.5, Colors[2]),
		ColorSequenceKeypoint.new(1, Colors[3])
	})
	gradient.Rotation = 45

	local title = Instance.new("TextLabel", mainFrame)
	title.Text = "NoClip GUI"
	title.Size = UDim2.new(1,0,0,30)
	title.Position = UDim2.new(0,0,0,0)
	title.BackgroundTransparency = 1
	title.TextColor3 = Color3.fromRGB(240,240,240)
	title.TextScaled = true
	title.Font = Enum.Font.GothamBold

	closeButton = Instance.new("TextButton", mainFrame)
	closeButton.Text = "X"
	closeButton.Size = UDim2.new(0,30,0,30)
	closeButton.Position = UDim2.new(1,-35,0,5)
	closeButton.BackgroundColor3 = Color3.fromRGB(200,50,50)
	closeButton.TextColor3 = Color3.fromRGB(255,255,255)
	closeButton.Font = Enum.Font.GothamBold
	closeButton.TextScaled = true
	Instance.new("UICorner", closeButton).CornerRadius = UDim.new(0,6)
	closeButton.MouseButton1Click:Connect(function()
		noclipping = false
		if steppedConnection then
			steppedConnection:Disconnect()
			steppedConnection = nil
		end
		screenGui:Destroy()
	end)

	toggleButton = Instance.new("TextButton", mainFrame)
	toggleButton.Text = "Toggle NoClip"
	toggleButton.Size = UDim2.new(0.6,0,0,40)
	toggleButton.Position = UDim2.new(0.2,0,0.35,0)
	toggleButton.BackgroundColor3 = Color3.fromRGB(40,40,50)
	toggleButton.TextColor3 = Color3.fromRGB(255,255,255)
	toggleButton.Font = Enum.Font.Gotham
	toggleButton.TextScaled = true
	Instance.new("UICorner", toggleButton).CornerRadius = UDim.new(0,8)

	statusLabel = Instance.new("TextLabel", mainFrame)
	statusLabel.Text = "Status: OFF"
	statusLabel.Size = UDim2.new(1,0,0,20)
	statusLabel.Position = UDim2.new(0,0,0.8,0)
	statusLabel.BackgroundTransparency = 1
	statusLabel.TextColor3 = Color3.fromRGB(200,0,0)
	statusLabel.TextScaled = true
	statusLabel.Font = Enum.Font.GothamBold

	local function toggleNoClip()
		noclipping = not noclipping
		if noclipping then
			statusLabel.Text = "Status: ON"
			statusLabel.TextColor3 = Color3.fromRGB(0,200,0)
			steppedConnection = RunService.Stepped:Connect(function()
				if noclipping and LocalPlayer.Character then
					for _, part in pairs(LocalPlayer.Character:GetChildren()) do
						if part:IsA("BasePart") then
							part.CanCollide = false
						end
					end
				end
			end)
		else
			statusLabel.Text = "Status: OFF"
			statusLabel.TextColor3 = Color3.fromRGB(200,0,0)
			if steppedConnection then
				steppedConnection:Disconnect()
				steppedConnection = nil
			end
		end
	end

	toggleButton.MouseButton1Click:Connect(toggleNoClip)
	UserInputService.InputBegan:Connect(function(input, processed)
		if not processed and input.KeyCode == Enum.KeyCode.R then
			toggleNoClip()
		end
	end)

	makeDraggable(mainFrame, title)
end

createGui()
