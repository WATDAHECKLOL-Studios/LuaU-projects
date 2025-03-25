local HttpService = game:GetService("HttpService");
local RunService = game:GetService("RunService");

local renv = {
	print = print;
	warn = warn;
	
	error = error;
	game = game;
	
	Game = Game;
	getmetatable = getmetatable;

	getfenv = getfenv;
	rawset = rawset;
	
	rawget = rawget;
	rawlen = rawlen;
	
	rawequal = rawequal;
	require = require;
	
	setfenv = setfenv;
	_G = _G;
	
	shared = shared;
	spawn = spawn;
	
	settings = settings;
	UserSettings = UserSettings;
	
	gcinfo = gcinfo;
	ypcall = ypcall;
	
	xpcall = xpcall;
	pcall = pcall;
	
	wait = wait;
	delay = delay;
	
	Spawn = Spawn;
	string = string;
	
	tostring = tostring;
	tonumber = tonumber;
	
	Delay = Delay;
	Wait = Wait;
	
	wrap = coroutine.wrap; yield = coroutine.yield;
	
	Vector3 = {
		Vector3 = Vector3, new = Vector3.new, max = Vector3.max, min = Vector3.min, one = Vector3.one, zero = Vector3.zero
	};
	
	new = Instance.new;
	fromExisting = Instance.fromExisting;
	
	JSONEncode = HttpService.JSONEncode;
	JSONDecode = HttpService.JSONDecode;

	GenerateGUID = HttpService.GenerateGUID;
	GetSecret = HttpService.GetSecret;

	UrlEncode = HttpService.UrlEncode;
	GetAsync = HttpService.GetAsync;

	PostAsync = HttpService.PostAsync;
	RequestAsync = HttpService.RequestAsync;
	
	RunService = {
		IsServer = RunService.IsServer;
		IsClient = RunService.IsClient;
		
		BindToRenderStep = RunService.BindToRenderStep;
		IsEdit = RunService.IsEdit;
		
		IsRunMode = RunService.IsRunMode;
		IsRunning = RunService.IsRunning;
		
		Pause = RunService.Pause;
		Run = RunService.Run;
		
		Stop = RunService.Stop;
		UnbindFromRenderStep = RunService.UnbindFromRenderStep;
		
		PreRender = RunService.PreRender;
		RenderStepped = RunService.RenderStepped;
		
		Stepped = RunService.Stepped;
		PreSimulation = RunService.PreSimulation;
	};
	
	task = {
		wait = task.wait;
		cancel = task.cancel;
		
		spawn = task.spawn;
		delay = task.delay;
		
		defer = task.defer;
		desynchronize = task.desynchronize;
		
		synchronize = task.synchronize
	}
};

table.freeze(renv);

local getrenv = function()
	return renv;	
end;

local hookfunction = function(OldFunction, NewFunction)	
	for Index, Function in renv do
		if Function == OldFunction then
			print("found in RENV")
			getfenv()[Index] = NewFunction;
			break;
		end; 
	end;
	
	
	for Index,Function in  getfenv(2, debug.info(2, 'f')) do
		if Function == OldFunction then
			getfenv(2, debug.info(2, 'f'))[Index] = NewFunction;
			break;
		end;
	end;

	
	return OldFunction;
end;




local hook;
hook = hookfunction(getrenv().spawn, function(thread)
	return coroutine.yield(coroutine.running())
end)


spawn(function()
	while task.wait() do
		print("spawn is broken :(");
	end;
end);

print('oh no')
