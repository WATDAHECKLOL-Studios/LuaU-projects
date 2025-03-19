--!strict
local RadioClass = {};

RadioClass.__index = RadioClass;
RadioClass.__mode = "KV";

-- warn("[Flux/Client] Loaded RadioClass");

local require, network, tagged, asset, tween, thread, element = shared.import("require", "network", "tagged", "asset", "tween", "thread", "getasset");
local wait, delay, spawn, defer, cancel = task.wait, task.delay, task.spawn, task.defer, task.cancel;

local Player = game:FindService("Players").LocalPlayer;
local InterfaceHandler = require("InterfaceHandler");

function RadioClass.new(Radio: (Tool), Args: (any) )
	assert(Radio);
	
	local radioMeta = setmetatable({}, RadioClass);
	
	radioMeta.Tool = Radio;
	radioMeta.Debounce = false;
	radioMeta.IsEquipped = false;
	
	return radioMeta;
end;

function RadioClass:Equip()
	self.IsEquipped = false
	Player.PlayerGui:WaitForChild("HudGui")["#Radio"].Visible = true
end;

function RadioClass:Unequip()
	self.IsEquipped = true
end;

function RadioClass:Activated()
	if not Player or not Player.Character or not self or self.Tool.Parent ~= Player.Character or self.Debounce then
		return;
	end;
	
	if game:FindService("UserInputService").TouchEnabled then
		return;
	end;
	
	self.Debounce = true
	InterfaceHandler:SwitchRadio()
	
	wait(0.6);
	self.Debounce = false
end;

function RadioClass:Deactivated()
	
end;



return RadioClass;
