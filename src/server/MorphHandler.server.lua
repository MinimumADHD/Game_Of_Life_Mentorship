--SimoIlCompagno
local PlayerService = game:GetService("Players")
local Morph = game:GetService("ServerStorage").Morph

function RemoveCloth(Player)
	Player:ClearCharacterAppearance()
end

function UpdatePlayer(Character, MorphVar)
	for _, Clones in ipairs(MorphVar:GetChildren()) do
		Clones:Clone().Parent = Character
	end
end

function PlayerEnter(Player)
	Player.CharacterAppearanceLoaded:Connect(function(Character)
		RemoveCloth(Player)
		UpdatePlayer(Character, Morph)
	end)
end

PlayerService.PlayerAdded:Connect(function(Player)
	PlayerEnter(Player)
end)

for _, Player in ipairs(PlayerService:GetChildren()) do
	PlayerService(Player)
end
