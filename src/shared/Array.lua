--SimoIlCompagno
return function(PartOriginal, XVal, YVal)
	if XVal == nil or YVal == nil then
		XVal = script:GetAttribute("xval")
		YVal = script:GetAttribute("yval")
	end

	local TableArray = {}

	for x = 1, XVal do
		TableArray[x] = {}

		for y = 1, YVal do
			local PartClone = PartOriginal:Clone()
			PartClone.BrickColor = (math.random(1, 2) == 1) and BrickColor.new("Black") or BrickColor.new("White")
			PartClone.CFrame = CFrame.new(x * PartClone.Size.X, 1, y * PartClone.Size.Z)
			PartClone.Parent = workspace.Grid
			PartClone.Name = tostring(x) .. "/" .. tostring(y)

			if PartClone.BrickColor == BrickColor.new("White") then
				PartClone:SetAttribute("Alive", true)
			else
				PartClone:SetAttribute("Alive", false)
			end

			TableArray[x][y] = PartClone
		end
	end

	return TableArray
end
