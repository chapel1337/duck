local player = game:GetService("Players").LocalPlayer
local mouse = player:GetMouse()

local tool = script.Parent

local mousePosition
local moveEvent

local selectionPart = Instance.new("Part", workspace)
selectionPart.Size = Vector3.new(15, 0.1, 15)
selectionPart.Anchored = true
selectionPart.CanCollide = false
selectionPart.Color = Color3.fromRGB(0, 100, 0)
selectionPart.Material = Enum.Material.SmoothPlastic
selectionPart.Transparency = 1

tool.Equipped:Connect(function()
	selectionPart.Transparency = 0.7
	
	moveEvent = mouse.Move:Connect(function()
		mousePosition = Vector3.new(mouse.Hit.Position.X, selectionPart.Size.Y / 2, mouse.Hit.Position.Z)
		selectionPart.Position = mousePosition
	end)
end)

tool.Activated:Connect(function()
	script.remote:FireServer(Vector3.new(mouse.Hit.Position.X, selectionPart.Size.Y / 2, mouse.Hit.Position.Z))
end)

tool.Unequipped:Connect(function()
	selectionPart.Transparency = 1
	
	moveEvent:Disconnect()
end)
