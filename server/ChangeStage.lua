

local mainGame = game.Workspace:WaitForChild("MainGame")
local checkpoints = mainGame:WaitForChild("Checkpoints")

for _, checkpoint in pairs(checkpoints:GetChildren()) do
	checkpoint.Touched:Connect(function(otherPart)
		local player = game.Players:GetPlayerFromCharacter(otherPart.Parent)
		local touched = checkpoint:FindFirstChild("Touched")
		
		if player and touched and touched.Value == false and player.leaderstats.Stages.Value == tonumber(checkpoint.Name) - 1 then
			player.leaderstats.Stages.Value += 1
			touched.Value = true
		end
	end)
end