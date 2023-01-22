-- written by chapel1337
-- started on 1/20/2023, finished on 1/21/2023

local player = script.Parent.Parent.Parent

local tool = script.Parent
local localMain = tool.localMain

tool.ToolTip = "duck (made by chapel1337)"

local duckHandle = tool.Handle
local quack = tool.quack

local cooldown = false

tool.Equipped:Connect(function()
	if cooldown then
		return
	end
	
	quack.Playing = true
end)

tool.Unequipped:Connect(function()
	quack.Playing = false
	quack.TimePosition = 0
end)

tool.Activated:Connect(function()
	-- thanks romahkao
	if cooldown then
		return
	end
	
	task.spawn(function()
		local mousePosition
		
		local connection = localMain.remote.OnServerEvent:Connect(function(player, position)
			mousePosition = position
		end)
		connection:Disconnect()
		
		local duck = duckHandle:Clone()
		duck.Parent = workspace
		duck.Name = "duck"
		duck.Anchored = true
		duck.Size = duck.Size * 7
		duck.Position = Vector3.new(mousePosition.X, mousePosition.Y + 35, mousePosition.Z)

		local alpha = 0.05

		while task.wait(0.01) do
			if alpha > 1 then
				break
			end

			if #duck:GetTouchingParts() > 0 then
				break
			end

			duck.Position = duck.Position:Lerp(Vector3.new(mousePosition.X, mousePosition.Y + (duck.Size.Y / 2), mousePosition.Z), alpha)

			alpha += 0.05
		end

		duck:Destroy()

		local explosion = Instance.new("Explosion", workspace)
		explosion.Position = duck.Position
		explosion.BlastRadius = 10
		explosion.BlastPressure = 10
		explosion.ExplosionType = Enum.ExplosionType.NoCraters
	end)
	
	duckHandle.Transparency = 1
	cooldown = true
	
	task.wait(2)
	
	cooldown = false
	duckHandle.Transparency = 0
end)
