--SimoIlCompagno
local part = game:GetService("ServerStorage").GridPart
local ArrayModule = require(game:GetService("ReplicatedStorage").Common.Array)
local GridMaker = ArrayModule(part)
local RunService = game:GetService("RunService")
local LoopTime = 0
local CountTime = 1.25
local Event = game:GetService("ReplicatedStorage").ClearGrid
local Fold = workspace.Grid

RunService.Heartbeat:Connect(function(deltaTime)
	LoopTime += deltaTime

	if LoopTime < CountTime then
		return
	end

	LoopTime -= CountTime

	print(LoopTime)

	local ChangeInpt = {}

	for x = 1, #GridMaker do
		local HorizonPart = GridMaker[x]

		for y = 1, #HorizonPart do
			local AttachPart = 0

			if y < #HorizonPart then
				if HorizonPart[y + 1]:GetAttribute("Alive") then
					AttachPart += 1
				end

				if x > 1 and GridMaker[x - 1][y + 1]:GetAttribute("Alive") then
					AttachPart += 1
				end

				if x < #GridMaker and GridMaker[x + 1][y + 1]:GetAttribute("Alive") then
					AttachPart += 1
				end

				if y > 1 then
					if HorizonPart[y - 1]:GetAttribute("Alive") then
						AttachPart += 1
					end

					if x > 1 and GridMaker[x - 1][y - 1]:GetAttribute("Alive") then
						AttachPart += 1
					end

					if x < #GridMaker and GridMaker[x + 1][y - 1]:GetAttribute("Alive") then
						AttachPart += 1
					end
				end

				if x < #GridMaker and GridMaker[x + 1][y]:GetAttribute("Alive") then
					AttachPart += 1
				end

				if x > 1 and GridMaker[x - 1][y]:GetAttribute("Alive") then
					AttachPart += 1
				end

				if
					AttachPart ~= 3
					and not ((AttachPart == 2 or AttachPart == 3) and HorizonPart[y]:GetAttribute("Alive"))
				then
					table.insert(ChangeInpt, {
						x,
						y,
						BrickColor.new("Black"),
						false,
					})
				else
					table.insert(ChangeInpt, {
						x,
						y,
						BrickColor.new("White"),
						true,
					})
				end
			end
		end
	end
	for _, cell in ipairs(ChangeInpt) do
		GridMaker[cell[1]][cell[2]].BrickColor = cell[3]
		GridMaker[cell[1]][cell[2]]:SetAttribute("Alive", cell[4])
	end
end)

for _, GridPart in ipairs(workspace.Grid:GetChildren()) do
	if GridPart:IsA("BasePart") then
		local ClickDetector = GridPart.ClickDetector
		ClickDetector.MouseClick:Connect(function()
			local Value = GridPart:GetAttribute("Alive")
			if not Value then
				GridPart:SetAttribute("Alive", true)
				GridPart.BrickColor = BrickColor.new("White")
			else
				GridPart:SetAttribute("Alive", false)
				GridPart.BrickColor = BrickColor.new("Black")
			end
		end)
	end
end

Event.OnServerEvent:Connect(function()
	for _, FoldChildren in ipairs(Fold:GetChildren()) do
		if FoldChildren:IsA("BasePart") then
			FoldChildren.BrickColor = BrickColor.new("Black")

			FoldChildren:SetAttribute("Alive", false)
		end
	end
end)
