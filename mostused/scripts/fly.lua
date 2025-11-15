local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

local flying = false
local flySpeed = 200
local speedIncrement = 50
local minSpeed = 50
local maxSpeed = 1000
local bodyGyro
local bodyVelocity

local screenGui
local mainFrame
local flyButton
local plusButton
local minusButton
local speedLabel
local closeButton

local Colors = {
	Color3.fromRGB(147, 255, 239),
	Color3.fromRGB(201, 211, 233),
	Color3.fromRGB(255, 167, 227)
}

local function stopFly()
	local char = LocalPlayer.Character
	if not char then return end
	local hrp = char:FindFirstChild("HumanoidRootPart")
	local humanoid = char:FindFirstChildWhichIsA("Humanoid")
	if not hrp or not humanoid then return end
	humanoid.PlatformStand = false
	if bodyGyro then bodyGyro:Destroy() end
	if bodyVelocity then bodyVelocity:Destroy() end
	flying = false
end

local function startFly()
	local char = LocalPlayer.Character
	if not char then return end
	local hrp = char:FindFirstChild("HumanoidRootPart")
	local humanoid = char:FindFirstChildWhichIsA("Humanoid")
	if not hrp or not humanoid then return end
	humanoid.PlatformStand = true
	bodyGyro = Instance.new("BodyGyro", hrp)
	bodyGyro.MaxTorque = Vector3.new(1e5,1e5,1e5)
	bodyGyro.P = 1e4
	bodyGyro.CFrame = hrp.CFrame
	bodyVelocity = Instance.new("BodyVelocity", hrp)
	bodyVelocity.MaxForce = Vector3.new(1e5,1e5,1e5)
	bodyVelocity.Velocity = Vector3.new(0,0,0)
	flying = true
end

local function makeDraggable(frame)
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

	frame.InputBegan:Connect(function(input)
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

	frame.InputChanged:Connect(function(input)
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
	screenGui.Name = "FlyGUI_LunaStyle"
	screenGui.ResetOnSpawn = false
	screenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

	mainFrame = Instance.new("Frame", screenGui)
	mainFrame.Size = UDim2.new(0, 280, 0, 180)
	mainFrame.Position = UDim2.new(0.5,0,0.5,0)
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
	title.Text = "OP Fly"
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
		stopFly()
		screenGui:Destroy()
	end)

	flyButton = Instance.new("TextButton", mainFrame)
	flyButton.Text = "Toggle Fly"
	flyButton.Size = UDim2.new(0.6,0,0,35)
	flyButton.Position = UDim2.new(0.2,0,0.25,0)
	flyButton.BackgroundColor3 = Color3.fromRGB(40,40,50)
	flyButton.TextColor3 = Color3.fromRGB(255,255,255)
	flyButton.Font = Enum.Font.Gotham
	flyButton.TextScaled = true
	Instance.new("UICorner", flyButton).CornerRadius = UDim.new(0,8)
	flyButton.MouseButton1Click:Connect(function()
		if flying then stopFly() else startFly() end
	end)

	plusButton = Instance.new("TextButton", mainFrame)
	plusButton.Text = "+"
	plusButton.Size = UDim2.new(0.2,0,0,30)
	plusButton.Position = UDim2.new(0.1,0,0.55,0)
	plusButton.BackgroundColor3 = Color3.fromRGB(40,40,50)
	plusButton.TextColor3 = Color3.fromRGB(255,255,255)
	plusButton.Font = Enum.Font.Gotham
	plusButton.TextScaled = true
	Instance.new("UICorner", plusButton).CornerRadius = UDim.new(0,6)
	plusButton.MouseButton1Click:Connect(function()
		flySpeed = math.min(flySpeed + speedIncrement, maxSpeed)
		speedLabel.Text = "Speed: "..flySpeed
	end)

	minusButton = Instance.new("TextButton", mainFrame)
	minusButton.Text = "-"
	minusButton.Size = UDim2.new(0.2,0,0,30)
	minusButton.Position = UDim2.new(0.7,0,0.55,0)
	minusButton.BackgroundColor3 = Color3.fromRGB(40,40,50)
	minusButton.TextColor3 = Color3.fromRGB(255,255,255)
	minusButton.Font = Enum.Font.Gotham
	minusButton.TextScaled = true
	Instance.new("UICorner", minusButton).CornerRadius = UDim.new(0,6)
	minusButton.MouseButton1Click:Connect(function()
		flySpeed = math.max(flySpeed - speedIncrement, minSpeed)
		speedLabel.Text = "Speed: "..flySpeed
	end)

	speedLabel = Instance.new("TextLabel", mainFrame)
	speedLabel.Text = "Speed: "..flySpeed
	speedLabel.Size = UDim2.new(1,0,0,20)
	speedLabel.Position = UDim2.new(0,0,0.85,0)
	speedLabel.BackgroundTransparency = 1
	speedLabel.TextColor3 = Color3.fromRGB(230,230,230)
	speedLabel.TextScaled = true
	speedLabel.Font = Enum.Font.GothamBold

	makeDraggable(mainFrame)
end

RunService.RenderStepped:Connect(function()
	if flying then
		local char = LocalPlayer.Character
		if not char then return end
		local hrp = char:FindFirstChild("HumanoidRootPart")
		if not hrp then return end
		local moveDir = Vector3.new(0,0,0)
		local camLook = Camera.CFrame.LookVector
		local camRight = Camera.CFrame.RightVector
		if UserInputService:IsKeyDown(Enum.KeyCode.W) then moveDir += camLook end
		if UserInputService:IsKeyDown(Enum.KeyCode.S) then moveDir -= camLook end
		if UserInputService:IsKeyDown(Enum.KeyCode.A) then moveDir -= camRight end
		if UserInputService:IsKeyDown(Enum.KeyCode.D) then moveDir += camRight end
		if UserInputService:IsKeyDown(Enum.KeyCode.Space) then moveDir += Vector3.new(0,1,0) end
		if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then moveDir -= Vector3.new(0,1,0) end
		if moveDir.Magnitude > 0 then
			bodyVelocity.Velocity = moveDir.Unit * flySpeed
		else
			bodyVelocity.Velocity = Vector3.new(0,0,0)
		end
		bodyGyro.CFrame = CFrame.new(hrp.Position, hrp.Position + Camera.CFrame.LookVector)
	end
end)

UserInputService.InputBegan:Connect(function(input, processed)
	if processed then return end
	if input.KeyCode == Enum.KeyCode.E then
		if flying then stopFly() else startFly() end
	end
end)

createGui()
