--SimoIlCompagno
local part = game:GetService("ServerStorage").GridPart
local ArrayModule = require(game:GetService("ReplicatedStorage").Common.Array)
local GridMaker = ArrayModule(part)
local RunService = game:GetService("RunService")
local LoopTime = 0
local CountTime = 1.25
local Event = game:GetService("ReplicatedStorage").ClearGrid
local Fold = workspace.Grid

RunService.Heartbeat:Connect(function(DeltaTime)
	LoopTime += DeltaTime
	if LoopTime < CountTime then
		return
	end
	LoopTime -= CountTime
	local ChangeInpt = {}
	for X = 1, #GridMaker do
		local HorizonPart = GridMaker[X]
		for Y = 1, #HorizonPart do
			local AttachPart = 0
			if Y < #HorizonPart then
				if HorizonPart[Y + 1]:GetAttribute("Alive") then
					AttachPart += 1
				end
				if X > 1 and GridMaker[X - 1][Y + 1]:GetAttribute("Alive") then
					AttachPart += 1
				end
				if X < #GridMaker and GridMaker[X + 1][Y + 1]:GetAttribute("Alive") then
					AttachPart += 1
				end
				if Y > 1 then
					if HorizonPart[Y - 1]:GetAttribute("Alive") then
						AttachPart += 1
					end
					if X > 1 and GridMaker[X - 1][Y - 1]:GetAttribute("Alive") then
						AttachPart += 1
					end
					if X < #GridMaker and GridMaker[X + 1][Y - 1]:GetAttribute("Alive") then
						AttachPart += 1
					end
				end
				if X < #GridMaker and GridMaker[X + 1][Y]:GetAttribute("Alive") then
					AttachPart += 1
				end
				if X > 1 and GridMaker[X - 1][Y]:GetAttribute("Alive") then
					AttachPart += 1
				end
				if
					AttachPart ~= 3
					and not ((AttachPart == 2 or AttachPart == 3) and HorizonPart[Y]:GetAttribute("Alive"))
				then
					table.insert(ChangeInpt, {
						X,
						Y,
						BrickColor.new("Black"),
						false,
					})
				else
					table.insert(ChangeInpt, {
						X,
						Y,
						BrickColor.new("White"),
						true,
					})
				end
			end
		end
	end
	for _, CellPart in ipairs(ChangeInpt) do
		GridMaker[CellPart[1]][CellPart[2]].BrickColor = CellPart[3]
		GridMaker[CellPart[1]][CellPart[2]]:SetAttribute("Alive", CellPart[4])
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
