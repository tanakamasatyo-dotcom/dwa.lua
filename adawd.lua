local running = true

task.spawn(function()
	while running do
		local args = {
			{
				count = 1000000
			}
		}

		game:GetService("ReplicatedStorage")
			:WaitForChild("GameEvents")
			:WaitForChild("BaseFoamHarvestRequest")
			:FireServer(unpack(args))

		task.wait(0.1)
	end
end)
