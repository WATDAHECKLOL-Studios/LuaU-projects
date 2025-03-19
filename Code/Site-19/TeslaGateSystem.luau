-- Authors @SCPF_RedSky
-- Date:   10/16/24
--!strict
--!native

local TeslaGateService = {}

local Zone = require(game:GetService("ReplicatedStorage").Zone)
local Players = game:GetService("Players")

local TeslaGates = {}
local PlayersInZone = {}

@native function TeslaGateService.HandleZap(PlayerWhoTouched: Player, MainPart: any, Tesla: any)
	if Tesla:GetAttribute("DB") then
		return;
	end;
	
	Tesla:SetAttribute("DB", true)
	
	
	MainPart.Power:Play()
	
	task.delay(MainPart.Power.TimeLength - 0.5, @native function()
		MainPart.Zap:Play()
		MainPart.PointLight.Enabled = true
		MainPart.d1.Transparency = 0

		
		for i = 0, 0.45, 0.05 do
			local d1Transparency = MainPart.d1.Transparency
			local d2Transparency = MainPart.d2.Transparency

			MainPart.d1.Transparency = d1Transparency == 1 and 0 or 1
			MainPart.d2.Transparency = d2Transparency == 1 and 0 or 1
			MainPart.d3.Transparency = d1Transparency == 1 and 0 or 1
			MainPart.d4.Transparency = d2Transparency == 1 and 0 or 1
			
			--[[local Zone = PlayersInZone[self.Detect:GetFullName()]

			local ImpendingDoomPlayerIndex = table.find(Zone, PlayerWhoTouched)

			if ImpendingDoomPlayerIndex then
				local ImpendingDoomPlayer = Zone[ImpendingDoomPlayerIndex]

				if ImpendingDoomPlayer and ImpendingDoomPlayer.Character and ImpendingDoomPlayer.Character:FindFirstChild("Humanoid") then
					local humanoid = ImpendingDoomPlayer.Character.Humanoid
					humanoid.Health = 0  
				end
			end]]
			
			local Zone = PlayersInZone[Tesla.Detect]
			
			for _,v: any in Zone do
				if v and v.Character and v.Character:FindFirstChildWhichIsA("Humanoid") then
					v.Character.Humanoid.Health = 0
					end;
				end;
			
			task.wait(0.02)
		end;
		
		MainPart.d1.Transparency = 1
		MainPart.d2.Transparency = 1
		MainPart.d3.Transparency = 1
		MainPart.d4.Transparency = 1
		MainPart.PointLight.Enabled = false	
		
		
		task.delay(1, function()
			--self:SetAttribute("Shocking", false);
			Tesla:SetAttribute("DB", false);
		end);
	end);
end;


@native function TeslaGateService.GetNearestTeslaGateFromPlayer(Player: any)
	assert(Player, "Attempt to call GetNearestTeslaGate without am invaild player.")
	
	
	local Char = Player.Character or Player.CharacterAdded:Wait() :: Model

	for _,v: any in TeslaGates do
		local Pos = v.Tesla.Position
		local Distance = (Pos - Char.HumanoidRootPart.Position)

		print(Distance.Magnitude)

		if Distance.Magnitude > 17 then
			continue;
		end;

		if Distance.Magnitude <= 17 then
			return v;
		end;
	end;
	return nil;
end;

@native function TeslaGateService.InitTesla(Tesla: any)
	assert(Tesla, "Attempt to call Telsa Init without any tesla")
	
	
	table.insert(TeslaGates, Tesla)
	
	
	local Back = Tesla.Back
	local Front = Tesla.Front
	
	Tesla:SetAttribute("Active", false)
	Tesla:SetAttribute("DB", false)
	
	local MainPart = Tesla.Tesla
	local Black1 = Tesla.Black
	local Black2 = Tesla.Black1
	
	local StatusLight = Tesla.Light
	
	local Triggers = {}
	local Lights = {}
	
	local DetectZone = Zone.new(Tesla.Detect)
	
	PlayersInZone[Tesla.Detect] = {}

	DetectZone.playerEntered:Connect(@native function(Player: Player)
		table.insert(PlayersInZone[Tesla.Detect], Player)
	end)

	DetectZone.playerExited:Connect(@native function(Player: Player)
		local Zone = PlayersInZone[Tesla.Detect]
		local PlrIndex = table.find(Zone, Player)
		
		if PlrIndex then
			table.remove(Zone, PlrIndex)
		end;
	end);

	
	StatusLight.Back.Light.Spot.ImageColor3 = Color3.fromRGB(255, 0, 4)
	StatusLight.Front.Light.Spot.ImageColor3 = Color3.fromRGB(255, 0, 4)

	Back.Screen.Timer.Text = "DISABLED"
	Front.Screen.Timer.Text = "DISABLED"

	for _,v: Attachment in Black1:GetChildren() do
		if v:IsA("Attachment") then
			table.insert(Lights, v)
		end;
	end;

	for _,v:Attachment in Black2:GetChildren() do
		if v:IsA("Attachment") then
			table.insert(Lights, v)
		end;
	end;

	--[[for _,v in Tesla.Activation:GetChildren() do
		table.insert(Triggers, v)
	end;]]

	for _,v in Tesla.Activation:GetChildren() do
		v.Touched:Connect(@native function(OtherPart: BasePart)

			if not Tesla:GetAttribute("Active") then
				return;
			end;

			local PlayerWhoTouched = Players:GetPlayerFromCharacter(OtherPart.Parent) or nil	

			if PlayerWhoTouched and PlayerWhoTouched.Character and PlayerWhoTouched.Character.Humanoid.Health > 0 then
				TeslaGateService.HandleZap(PlayerWhoTouched, MainPart, Tesla)
			end;
		end);
	end;
	
	
	Tesla:GetAttributeChangedSignal("Active"):Connect(@native function()
		if Tesla:GetAttribute("Active") then
			
			MainPart.Active:Play()

			task.delay(MainPart.Active.TimeLength + 0.5, @native function()
				if not Tesla:GetAttribute("Active") then
					return;
				end;

				MainPart.Hum:Play()
			end);

			Back.Screen.Timer.Text = "ENABLED"
			Front.Screen.Timer.Text = "ENABLED"

			StatusLight.Back.Light.Spot.ImageColor3 = Color3.fromRGB(85, 255, 0)
			StatusLight.Front.Light.Spot.ImageColor3 = Color3.fromRGB(85, 255, 0)

			for _,v: any in Lights do
				v.Light.Enabled = not v.Light.Enabled;
			end;
	
			
		else
			if MainPart.Hum.IsPlaying then
				MainPart.Hum:Stop()
			end;

			MainPart.Disabled:Play()
			MainPart.Hum:Stop()

			--repeat task.wait() MainPart.Hum:Stop() until not MainPart.Hum.IsPlaying

			if not Tesla:GetAttribute("MTFDisabled") then
				Back.Screen.Timer.Text = "DISABLED"
				Front.Screen.Timer.Text = "DISABLED"
			end;

			StatusLight.Back.Light.Spot.ImageColor3 = Color3.fromRGB(255, 0, 4)
			StatusLight.Front.Light.Spot.ImageColor3 = Color3.fromRGB(255, 0, 4)

			for _,v: any in Lights do
				v.Light.Enabled = not v.Light.Enabled;
				end;
			end;
	end);
end;


return TeslaGateService;
