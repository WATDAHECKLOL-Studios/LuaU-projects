--[[
	Name: ElevatorClass.luau
	Author(s): @WATDAHECKLOL32
	Date: 2025-01-06 03:15:17
	RunTimeContext: Shared
	Information: moves n shit
]]

--!nocheck
--!native



local Import = require
local require = shared.import("require")

local ElevatorClass = {};
ElevatorClass.__index = ElevatorClass

local Zone = require("Zone")

local KeycardMesh = "rbxassetid://433020731";
local Players = game:FindService("Players");

local wait, insert, remove = task.wait, table.insert, table.remove;
export type Elevator = {
	_Model : (Model?);
	_Floor : (number?);
	_IsMoving : (boolean?);
	_PlayersOnFloor1 : {Player?};
	_PlayersOnFloor2 : {Player?};
	_Speed : (number?)
}

local function HandleTouch(Door:{ Config: { Card: { Value: number } } }, OtherPartThatTouched: any)
    local Plr = Players:GetPlayerFromCharacter(OtherPartThatTouched.Parent)

    if Plr and Plr.Character and Plr.Character.Humanoid.Health > 0 then
        local Tool = Plr.Character:FindFirstChildWhichIsA("Tool")
        if Tool then
            local RequiredLevel = Door.Config.Card.Value
            local CardLevel = tonumber(string.match(tostring(Tool), "^Level (%d+)"))

            if CardLevel then
                if CardLevel >= RequiredLevel then
                    return true;
                else
                    return false;
                end;
            end;
        end;
    end;
end;


@native function ElevatorClass.new(Elevator: (any) )
	local self: (Elevator) = setmetatable({
		_Model = Elevator;
		_Floor = 1;
		_IsMoving = false;
		_PlayersOnFloor1 = {};
		_PlayersOnFloor2 = {};
		_Speed = 1.4
	}, ElevatorClass)
	
	local Door1Animator = Elevator.Elevator1.Door.Model.Tween.Animator :: (Animator)
	local Door2Animator = Elevator.Elevator2.Door.Model.Tween.Animator :: (Animator)

	self._Door1Animation = Door1Animator:LoadAnimation(Elevator.Elevator1.Door.Model.Open) :: (AnimationTrack)
	self._Door2Animation = Door2Animator:LoadAnimation(Elevator.Elevator2.Door.Model.Open) :: (AnimationTrack)

	
	
	local Loaded = self._Door1Animation
	local Loaded2 = self._Door2Animation

	
	Loaded:Play(0.100000001, 1, 1.4) 
	
	Loaded.KeyframeReached:Connect(function(keyframeName: string) 
		if keyframeName == "Closing" then
			Loaded:AdjustSpeed(0)			
		end;
	end);
	
	local Floor1Zone = Zone.new(Elevator.Elevator1.Zone1)
	local Floor2Zone = Zone.new(Elevator.Elevator2.Zone2)
	
	Floor1Zone.playerEntered:Connect(@native function(Player: (Player) )
		if Player and Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
			insert(self._PlayersOnFloor1, Player)
		end;
	end);
	
	Floor1Zone.playerExited:Connect(@native function(Player: (Player) )
		if Player and Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
			local Index = table.find(self._PlayersOnFloor1, Player)
			
			if Index then
				remove(self._PlayersOnFloor1, Index)	
			end;
		end;
	end);
	

	Floor2Zone.playerEntered:Connect(@native function(Player: (Player) )
		if Player and Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
			insert(self._PlayersOnFloor2, Player)
		end;
	end);

	Floor2Zone.playerExited:Connect(@native function(Player: (Player) )
		if Player and Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
			local Index = table.find(self._PlayersOnFloor2, Player)

			if Index then
				remove(self._PlayersOnFloor2, Index)	
			end;
		end;
	end);
    
    
    self._Model.Elevator1.Door.Buttons.Back.Touched:Connect(function(OtherPart: (BasePart))
        if self._Model.Elevator1.Door.Buttons.Back.Mesh.MeshId ~= KeycardMesh then
            return;
        end;
        
        local isAllowed = HandleTouch(self._Model, OtherPart);
        
        if isAllowed then
            if not self._Model.Elevator1.Door.Buttons.Back.Valid.IsPlaying then
                self._Model.Elevator1.Door.Buttons.Back.Valid:Play()
            end;
            
            self:Interaction()
        elseif isAllowed == false then
            if not self._Model.Elevator1.Door.Buttons.Back.Invalid.IsPlaying then
                self._Model.Elevator1.Door.Buttons.Back.Invalid:Play()
            end;
            
        end;
    end);
    
    self._Model.Elevator1.Door.Buttons.Front.Touched:Connect(function(OtherPart: (BasePart))
        if self._Model.Elevator1.Door.Buttons.Front.Mesh.MeshId ~= KeycardMesh then
            return;
        end;

        local isAllowed = HandleTouch(self._Model, OtherPart);

        if isAllowed then
            if not self._Model.Elevator1.Door.Buttons.Front.Valid.IsPlaying then
                self._Model.Elevator1.Door.Buttons.Front.Valid:Play()
            end;

            self:Interaction()
        elseif isAllowed == false then
            if not self._Model.Elevator1.Door.Buttons.Front.Invalid.IsPlaying then
                self._Model.Elevator1.Door.Buttons.Front.Invalid:Play()
            end;

        end;
    end);
    
    self._Model.Elevator2.Door.Buttons.Back.Touched:Connect(function(OtherPart: (BasePart))
        if self._Model.Elevator2.Door.Buttons.Back.Mesh.MeshId ~= KeycardMesh then
            return;
        end;

        local isAllowed = HandleTouch(self._Model, OtherPart);

        if isAllowed then
            if not self._Model.Elevator2.Door.Buttons.Back.Valid.IsPlaying then
                self._Model.Elevator2.Door.Buttons.Back.Valid:Play()
            end;

            self:Interaction()
        elseif isAllowed == false then
            if not self._Model.Elevator2.Door.Buttons.Back.Invalid.IsPlaying then
                self._Model.Elevator2.Door.Buttons.Back.Invalid:Play()
            end;
        end;
    end);
    
    
    self._Model.Elevator2.Door.Buttons.Front.Touched:Connect(function(OtherPart: (BasePart))
        if self._Model.Elevator2.Door.Buttons.Front.Mesh.MeshId ~= KeycardMesh then
            return;
        end;

        local isAllowed = HandleTouch(self._Model, OtherPart);

        if isAllowed then
            if not self._Model.Elevator2.Door.Buttons.Front.Valid.IsPlaying then
                self._Model.Elevator2.Door.Buttons.Front.Valid:Play()
            end;

            self:Interaction()
        elseif isAllowed == false then
            if not self._Model.Elevator2.Door.Buttons.Front.Invalid.IsPlaying then
                self._Model.Elevator2.Door.Buttons.Front.Invalid:Play()
            end;
        end;
    end);
	-- table.insert(shared.Elevators, Elevator)
	
	--[[Loaded.KeyframeReached:Connect(@native function(keyframeName: string) 
		if keyframeName == "KF10" then
			
		end;
	end);]]
    
	return self;
end;

function ElevatorClass:Interaction(Prompt: (any) )
	if self._Floor == 1 then
		if self._IsMoving then
			return;
		end;

		self._Door1Animation:AdjustSpeed(self._Speed)
		self._IsMoving = true
		
		self._Model.Elevator1.Door.Model.Frame.Close:Play()
		wait(0.6)
		self._Model.Elevator1.Floor.Moving:Play()
		self._Model.Elevator2.Floor.Moving:Play()

		self._Model.Elevator1.Floor.Moving.Ended:Wait();
		for _, Player in self._PlayersOnFloor1 do
			if Player.Character and Player.Character.Humanoid.Health > 0 then
				Player.Character:PivotTo(self._Model.Elevator2.Zone2.CFrame)
			end;
		end;

		if self._Door2Animation.IsPlaying then
			self._Door2Animation:AdjustSpeed(0)
		end;

		self._Model.Elevator2.Door.Model.Frame.Beep:Play()
		self._Door2Animation:Play(0.1, 1, self._Speed)

		local connection
		connection = self._Door2Animation.KeyframeReached:Connect(function(Frame: string)
			if Frame == "Closing" then
				self._Door2Animation:AdjustSpeed(0)
				self._IsMoving = false
				self._Floor = 2
				connection:Disconnect()
			end;
		end);
	elseif self._Floor == 2 then
		if self._IsMoving then
			return;
		end;

		self._IsMoving = true
		if self._Door2Animation.IsPlaying then
			self._Door2Animation:AdjustSpeed(2)
		end;

		self._Model.Elevator2.Door.Model.Frame.Close:Play()
		wait(0.6)
		self._Model.Elevator2.Floor.Moving:Play()
		self._Model.Elevator1.Floor.Moving:Play()

		self._Model.Elevator2.Floor.Moving.Ended:Wait();
		
		for _, Player in self._PlayersOnFloor2 do
			if Player.Character and Player.Character.Humanoid.Health > 0 then
				Player.Character:PivotTo(self._Model.Elevator1.Zone1.CFrame)
			end;
		end;

		if self._Door1Animation.IsPlaying then
			self._Door1Animation:AdjustSpeed(0)
		end;

		self._Model.Elevator1.Door.Model.Frame.Beep:Play()
		self._Door1Animation:Play(0.1, 1, self._Speed)

		local connection
		connection = self._Door1Animation.KeyframeReached:Connect(function(Frame: string)
			-- print(Frame)
			if Frame == "Closing" then
				self._Door2Animation:AdjustSpeed(0) 
				self._IsMoving = false
				self._Floor = 1
				connection:Disconnect() 
			end;
		end);
	end;
end;


return ElevatorClass;

--              ░░   ░ ░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▒ ░░      ░░░ ░░░░░░     
--           ░░░░░    ░░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░░░░     ░    ▒▓░░ ░    
--    ░░    ░░░░░   ░ ░▒▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▓▓▓▓░░░░░      ░   ░▒░░     
--░░          ░░░     ░▓▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▓▓▓▓▒░▒▒░░░░    ░░ ░░░░     
--  ░░       ░░░░░ ░ ░▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▓▓▓▒▒▓▓▒░░░       ░░░░░    
--         ░░░░   ░  ░▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░▒▒▒▒░       ░ ░░░░░   
--          ░░░░     ░▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░▓▓▓▓░        ░▓▒░░   
--          ░     ░ ░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░▓▓▓▒░░        ▒▓▒░░  
--     ░░░     ░░   ░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░▒▓▒▒░░░  ░    ░▓▓░   
--     ░░░░░░░ ░  ░ ░▒▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░▒▓▒░          ▒▒░   
--    ░░░░░░░░  ░░░░░░░░░░░░░░░░░░░░░░░░░▒░░░░░░░            ░▓▒░░        ░▒▒░░  
--    ░░░░░ ░  ░    ░░░          ░░░░░░░░░░░░                ▒▓▒░░░░      ░▒▒░░  
--    ░░░░     ░░░░ ░░░░░░         ░░░░░░░░                  ░▓▒░░░   ░ ░  ░▓▓▒  
--    ░░░░    ░░░░░  ░░░░            ░░░░░░       ░          ░▒▒░░      ░  ░▒▓▒  
--    ░░░░    ░░░░░  ░░░░░░░░       ░░░▒▓▒░░        ░░░░░░░░ ░▒▓▒░░ ░ ░  ░░░▓▓▒  
--   ░░░░░    ░░░░░  ░░░▒░▒░       ░░▒▓▓▓▓▓▒░       ░░░░▒▒░ ░░▒▓▒░░ ░  ░   ░▓▓░  
--  ░░░░░░░  ░░░░░░  ░░░░░░░░     ░░▒▓▓▓▓▓▓▓▒░░    ░░░░░░░░░ ░▒▓▒░░ ░░      ▒▒░  
--  ░░░░░░  ░░░░░ ░░░░░░░░░░░░░░░░▒▓▓▓▓▓▓▓▓▓▓▓▒░░░░░░░░░    ░░▓▓▓░░░        ░░░  
-- ░░░░░░░ ░░░░░░░  ░░░░░░░░░░▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒░░░░░░░░░░░▓▓▓░ ░░       ░▒▒  
--  ░░░░░░░░░░░░░  ░░░▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒░░░░░░▒▓▓░░░░        ▒▒  
--  ░░░░░░░░░░░░░░░░░▒▒▒▒▒▓▓▓▓▓▓▒▓▒▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▓▒▒▒▒▒▒▒▒░▓▓▓▒░░░░       ▒▒  
-- ░░░░░░░░░▒░░░░░  ░▒▒▒▒▓▓▓▓▓▓▓▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▓▓▓▓▓▓▓▒▒░▒▓▓▒░░░░░░     ░▒  
--  ░░░░░░░░▒░░░ ░   ░▒▓▓▓▓▓▓▓▓▒░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░▒▓▓▓▓▓▓▓▓▓▒░▒▓▓▒░░░░░      ░░  
--  ░░░░░░░▓▒░░      ░▒▒▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒░▓▓▒░░░░░░░     ░▒  
--  ░░░░░░▒▒▒░░░   ░░░░▒▒▒▓▓▓▓▓▒▒▒░░░░░▒▒▒▒░░░░░░░░▒▓▓▓▓▒▒░░░░▒▓▓░░░░░  ░░    ░  
--  ░░░░░░▒▓▓░░ ░ ░ ░░░░▒▒▒▓▓▓▓▓░░    ░░░░░░    ░░░▓▓▓▓▒▒▒░░░░▓▓▒░░  ░░       ░  
--░░░░░░ ▒▓▓▒░░   ░░░░░░▒▒▓▓▓▓▓▓░                 ░▓▓▓▓▓▒░░░░░▓▓▒░ ░░            
--  ░░░░░▒▓▓▒░░░░░░ ░░ ░░▒▓▓▓▓▓▓▒░               ░░▒▓▓▓▓▒▒░░░░▓▓▒░░░             
--  ░░░░░▒▒▒░░ ░░    ░░ ░▓▓▓▓▓▓▓▓▒▒░░░      ░░░░░░▒▓▓▓▓▓▒▒░░░▓▓▓▓░░░  ░░░░       
-- ░░░░░░▓▓░░  ░░     ░░░▒▒▒▓▓▓▓▓▓▓▓▒▓▓▓▒▓▓▓▒▒▒▒▓▓▒▒▒▒▓▒▒▒░░░▒▓▓░ ░░   ░         
-- ░░░░░░▓▓▒░            ░▒▒▒▓▓▒░░░▒░░░▒▒▓▓▒▒░░░░░▒▓▓▒▒▒▒░░░░▒▓▓▒░░░  ░░         
-- ░░░░░▓▓▓▒░░░░░      ░░░░░░░░░░░░░░░░░░░░░░░░░░   ░░░░░░░░░▒▓▓▓░░░░  ░░        
--░░░░░░▓▓▓░░░    ░    ░░░░          ░  ░░             ░░░░ ░░▓▓▒░░░░   ░        
-- ░░░░░▓▓▓░░░  ░ ░      ░░░░  ░░░░░      ░  ░░░░░░  ░░░░   ░▒▓▓▒░░░    ░░       
--░░░░░░▓▓▓░░    ░         ░░░▒▒▓▓▓▓▓▒░░░░▒▓▓▓▓▓▓▒░░░░░     ░▒▓▓▓░░░░   ░░       
--░░░░░░▓▓▒░░   ░░░      ░░░░░░░░▓▓▓▓▓▓▓▒▓▓▓▓▓▓▒░░░░░        ░▓▓▓░░░░    ░       
--░░░░░░▓▓▓░░    ░░         ░  ░░░░░▒▒░░░░░░░░░░            ░▒▓▓▒░       ░░      
--░░░░░▓▓▓▓░░░  ░         ░░        ░░░░░░░░░░              ░░▒▓▒░       ░░      
--░░░░░▓▓▓▒░                                               ░░▒▓▓▒░       ░░░     
--░░░░░▓▓▓▓░░                                               ░▒▓▓▒░░        ░     
-- ░░░░▒▓▓▒░░                                               ░░▓▓▒░      ░░░░░    
--░░░░░▓▓▒▒░                                                ░░▓▓▒░░░░   ░░░░░░   
--░░░░░▒▓▓▒░░                                             ░ ░░▒▒▒░░     ░░░░▒░░  
