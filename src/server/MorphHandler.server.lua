--SimoIlCompagno
local PlayerService = game:GetService("Players")
local Morph = game:GetService("ServerStorage").Morph

function RemoveCloth(Character)
	for _, Children in ipairs(Character:GetChildren()) do
		if Children:IsA("Shirt") or Children:IsA("Pants") then
			Children:Destroy()
		end
	end
	Character.Humanoid:RemoveAccessories()
end

function UpdatePlayer(Character, MorphVar)
	for _, clones in ipairs(MorphVar:GetChildren()) do
		local CloneMorph = clones:Clone()
		CloneMorph.Parent = Character
	end
end

function PlayerEnter(Player)
	Player.CharacterAppearanceLoaded:Connect(function(Character)
		RemoveCloth(Character)
		UpdatePlayer(Character, Morph)
	end)
end

PlayerService.PlayerAdded:Connect(function(Player)
	PlayerEnter(Player)
end)

for _, player in ipairs(PlayerService:GetChildren()) do
	PlayerService(player)
end
