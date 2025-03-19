--[[
	AmbientClient.Luau
	--------------------
	Author(s): @SCPF_RedSky
	Date: 10-24-24
	Runtime: Shared
	Information: Ambience system using Zone
--]]
--!native
--!strict
print("[CLIENT] Ambient Module Loaded")
local Ambient = {}
local Zone = require(game.ReplicatedStorage["Atlas/Replicated"].Shared.Zone)
local Parts = {}
local CurrentAmbient = {}
local Players = game:GetService("Players")
for _, v in pairs(workspace.AmbientParts:GetChildren()) do
	if v:IsA("BasePart") then
		table.insert(Parts, v)
	end;
end;
local Index = {
	["CDC"] = {
		Text = "CDC",
		Audio = "rbxassetid://16743118199",
		PlaybackSpeed = 1.24
	},
	["Sector-1"] = {
		Text = "Sector-1",
		Audio = "rbxassetid://1838665862"
	},
	["Sector-2"] = {
		Text = "Sector-2",
		Audio = "rbxassetid://18670370207"
	},
	["Sector-3"] = {
		Text = "Sector-3",
		Audio = "rbxassetid://1848201397"
	},
	["Outside"] = {
		Text = "Outside",
		Audio = "rbxassetid://273398061"
	},
	["MD"] = {
		Text = "Medical Department",
		Audio = "rbxassetid://15293995246"
	}
}
@native local function ApplyAmbient(player, ZoneName)
	if CurrentAmbient[player] then
		CurrentAmbient[player]:Stop()
		CurrentAmbient[player]:Destroy()
		CurrentAmbient[player] = nil
	end;
	local AmbientData = Index[ZoneName]
	if AmbientData then
		player:FindFirstChild("PlayerGui").ZoneSFX:Play()
		local sound = Instance.new("Sound")
		sound.SoundId = AmbientData.Audio
		sound.PlaybackSpeed = AmbientData.PlaybackSpeed or 1
		sound.Looped = true
		sound.Volume = 0.5
		sound.Parent = player:FindFirstChild("PlayerGui") 
		player:FindFirstChild("PlayerGui").CurrentSector.SectorStatus.Status.Text = AmbientData.Text
		sound:Play()
		CurrentAmbient[player] = sound
	end;
end;
for zoneName, _ in pairs(Index) do
	local ZoneParts = {}
	for _, part in pairs(Parts) do
		if part.Name == zoneName then
			table.insert(ZoneParts, part)
		end;
	end;
	if #ZoneParts > 0 then
		local zone = Zone.new(ZoneParts)
		zone.localPlayerEntered:Connect(function(player)
			ApplyAmbient(player, zoneName)
		end)
		zone.localPlayerExited:Connect(function(player)
			if CurrentAmbient[player] then
				CurrentAmbient[player]:Stop()
				CurrentAmbient[player]:Destroy()
				CurrentAmbient[player] = nil
			end;
		end);
	end;
end;
return Ambient
