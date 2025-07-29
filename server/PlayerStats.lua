
game.Players.PlayerAdded:Connect(function(player)
	local leaderstats = Instance.new("Folder")
	leaderstats.Name = "leaderstats"
	leaderstats.Parent = player
	
	--local coins = Instance.new("IntValue")
	--coins.Name = "Coins"
	--coins.Parent = leaderstats
	--coins.Value = 0
	
	local stages = Instance.new("IntValue")
	stages.Name = "Stages"
	stages.Parent = leaderstats
	stages.Value = 1
	
	local rebirths = Instance.new("IntValue")
	rebirths.Name = "Rebirths"
	rebirths.Parent = leaderstats
	rebirths.Value = 0
	
	local mainGame = game.Workspace:WaitForChild("MainGame")
	local checkpoints = mainGame:WaitForChild("Checkpoints")
	local final = mainGame:WaitForChild("Final")
	
	
	player.CharacterAdded:Connect(function(character)
		for _, checkpoint in pairs(checkpoints:GetChildren()) do
			if player.leaderstats.Stages.Value == tonumber(checkpoint.Name) then
				character:MoveTo(checkpoint.Position)
			end
		end	
	end)
	
	for _, rebirthPart in pairs(final:GetChildren()) do
		rebirthPart.Touched:Connect(function(otherPart)
			local character = otherPart:FindFirstAncestorOfClass("Model")
			local humanoid = character and character:FindFirstChildWhichIsA("Humanoid")
			local player = game.Players:GetPlayerFromCharacter(character)
			local touched = rebirthPart:FindFirstChild("Touched")

			if humanoid and touched and touched.Value == false then
				rebirths.Value += 1
				stages.Value = 1
				character:MoveTo(checkpoints:FindFirstChild("1").Position)
				
				touched.Value = true
				task.wait(30)
				touched.Value = false
			end
		end)
	end
end)

--local mainGame = game.Workspace:WaitForChild("MainGame")
--local coins = mainGame:WaitForChild("Coins")

--for _, coin in pairs(coins:GetChildren()) do
--	coin.Touched:Connect(function(otherPart)
--		local humanoid = otherPart.Parent:FindFirstChild("Humanoid")
--		local player = game.Players:GetPlayerFromCharacter(otherPart.Parent)
--		local touched = coin:FindFirstChild("Touched")
		
--		if humanoid and player and touched and touched.Value == false then
--			touched.Value = true
--			player.leaderstats.Coins.Value += math.random(5, 10)
--			coin.Transparency = 0.75
--		end

--	end)
--end
