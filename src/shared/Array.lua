--SimoIlCompagno
return function(PartOriginal, XVal, YVal)
	if XVal == nil or YVal == nil then
		XVal = script:GetAttribute("XVal")
		YVal = script:GetAttribute("YVal")
	end

	local TableArray = {}

	for X = 1, XVal do
		TableArray[X] = {}

		for Y = 1, YVal do
			local PartClone = PartOriginal:Clone()
			PartClone.BrickColor = (math.random(1, 2) == 1) and BrickColor.new("Black") or BrickColor.new("White")
			PartClone.CFrame = CFrame.new(X * PartClone.Size.X, 1, Y * PartClone.Size.Z)
			PartClone.Parent = workspace.Grid
			PartClone.Name = tostring(X) .. "/" .. tostring(Y)

			if PartClone.BrickColor == BrickColor.new("White") then
				PartClone:SetAttribute("Alive", true)
			else
				PartClone:SetAttribute("Alive", false)
			end

			TableArray[X][Y] = PartClone
		end
	end

	return TableArray
end
