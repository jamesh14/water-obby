local mainGame = game.Workspace:WaitForChild("MainGame")
local gates = mainGame:WaitForChild("Gates")
local buttons = mainGame:WaitForChild("Buttons")
local killBricks = mainGame:WaitForChild("KillBricks")

local function activateButton(button, touched)
	touched.Value = true
	local gate = gates:FindFirstChild(button.Name)
	if gate then
		gate.Transparency = 0.5
		gate.CanCollide = false
	end
	
	local duration = button:findFirstChild("Duration")
	while duration.Value > 0 do
		print("The door will close in", duration.Value)
		task.wait(1)
		duration.Value -= 1	
	end
	
	gate.Transparency = 0
	gate.CanCollide = true
	touched.Value = false
end

for _, button in pairs(buttons:GetChildren()) do
	button.Touched:Connect(function(otherPart)
		local humanoid = otherPart.Parent:FindFirstChild("Humanoid")
		local touched = button:FindFirstChild("Touched")
		if humanoid and touched and touched.Value == false then
			activateButton(button, touched)
		end
	end)
end


for _, killBrick in pairs(killBricks: GetChildren()) do
	killBrick.Touched:Connect(function(otherPart)
		local humanoid = otherPart.Parent:FindFirstChild("Humanoid")
		local touched = killBrick:FindFirstChild("Touched")
		
		if humanoid and touched and touched.Value == false then
			humanoid.Health = 0
			touched.Value = true
			task.wait(0.5)
			touched.Value = false
		end
	end)
end


