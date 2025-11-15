local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local flingActive = false
local flingConnection
local flingButton
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

local function createFlingGui()
	if game.CoreGui:FindFirstChild("TouchFlingGUI") then
		game.CoreGui.TouchFlingGUI:Destroy()
	end

	local screenGui = Instance.new("ScreenGui")
	screenGui.Name = "TouchFlingGUI"
	screenGui.Parent = game.CoreGui
	screenGui.ResetOnSpawn = false

	local mainFrame = Instance.new("Frame", screenGui)
	mainFrame.Size = UDim2.new(0, 280, 0, 180)
	mainFrame.Position = UDim2.new(0.5,0,0.6,0)
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
	title.Text = "Touch Fling"
	title.Size = UDim2.new(1,0,0,30)
	title.Position = UDim2.new(0,0,0,0)
	title.BackgroundTransparency = 1
	title.TextColor3 = Color3.fromRGB(240,240,240)
	title.TextScaled = true
	title.Font = Enum.Font.GothamBold

	local closeButton = Instance.new("TextButton", mainFrame)
	closeButton.Text = "X"
	closeButton.Size = UDim2.new(0,30,0,30)
	closeButton.Position = UDim2.new(1,-35,0,5)
	closeButton.BackgroundColor3 = Color3.fromRGB(200,50,50)
	closeButton.TextColor3 = Color3.fromRGB(255,255,255)
	closeButton.Font = Enum.Font.GothamBold
	closeButton.TextScaled = true
	Instance.new("UICorner", closeButton).CornerRadius = UDim.new(0,6)
	closeButton.MouseButton1Click:Connect(function()
		flingActive = false
		if flingConnection then
			flingConnection:Disconnect()
			flingConnection = nil
		end
		screenGui:Destroy()
	end)

	flingButton = Instance.new("TextButton", mainFrame)
	flingButton.Size = UDim2.new(0.6,0,0,40)
	flingButton.Position = UDim2.new(0.2,0,0.35,0)
	flingButton.BackgroundColor3 = Color3.fromRGB(40,40,50)
	flingButton.TextColor3 = Color3.fromRGB(255,255,255)
	flingButton.Font = Enum.Font.Gotham
	flingButton.TextScaled = true
	flingButton.Text = "Status: OFF"
	Instance.new("UICorner", flingButton).CornerRadius = UDim.new(0,8)

	local function toggleFling()
		flingActive = not flingActive
		flingButton.Text = flingActive and "Status: ON" or "Status: OFF"
		if flingActive and not flingConnection then
			flingConnection = RunService.Heartbeat:Connect(function()
				local char = LocalPlayer.Character
				local hrp = char and char:FindFirstChild("HumanoidRootPart")
				if hrp then
					local vel = hrp.Velocity
					hrp.Velocity = vel * 10000 + Vector3.new(0,10000,0)
					RunService.RenderStepped:Wait()
					hrp.Velocity = vel
				end
			end)
		elseif not flingActive and flingConnection then
			flingConnection:Disconnect()
			flingConnection = nil
		end
	end

	flingButton.MouseButton1Click:Connect(toggleFling)
	UserInputService.InputBegan:Connect(function(input, processed)
		if processed then return end
		if input.KeyCode == Enum.KeyCode.T then
			toggleFling()
		end
	end)

	makeDraggable(mainFrame, title)
end

createFlingGui()
