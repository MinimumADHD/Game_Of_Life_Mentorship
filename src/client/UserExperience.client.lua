local Event = game:GetService("ReplicatedStorage").ClearGrid
local Player = game.Players.LocalPlayer
local Folder = workspace.Grid
local TweenService = game:GetService("TweenService")
local TweenInfoI = TweenInfo.new(0.5)
local Gui = Player.PlayerGui:WaitForChild("ScreenGui")
local Button = Gui.ClearBTN

Button.MouseButton1Click:Connect(function()
	Event:FireServer()
end)

for _, Part in ipairs(Folder:GetChildren()) do
	local ClickDetect = Part.ClickDetector
	local FadeIn = TweenService:Create(Part, TweenInfoI, {
		Transparency = 0.5,
	})
	local FadeOut = TweenService:Create(Part, TweenInfoI, {
		Transparency = 0,
	})
	ClickDetect.MouseHoverEnter:Connect(function()
		FadeIn:Play()
		ClickDetect.MouseHoverLeave:Connect(function()
			FadeOut:Play()
		end)
	end)
end
