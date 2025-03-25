local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local MarketplaceService = game:GetService("MarketplaceService")
local DataStoreService = game:GetService("DataStoreService")
local Lighting = game:GetService("Lighting")
local MessagingService = game:GetService("MessagingService")
local StarterGui = game:GetService("StarterGui")
local StarterPlayer = game:GetService("StarterPlayer")
local StarterPack = game:GetService("StarterPack")
local SoundService = game:GetService("SoundService")
local Chat = game:GetService("Chat")
local PathfindingService = game:GetService("PathfindingService")
local ProximityPromptService = game:GetService("ProximityPromptService")
local PolicyService = game:GetService("PolicyService")
local LogService = game:GetService("LogService")
local PhysicsService = game:GetService("PhysicsService")
local BadgeService = game:GetService("BadgeService")
local InsertService = game:GetService("InsertService")
local HapticService = game:GetService("HapticService")
local TextService = game:GetService("TextService")
local TeleportService = game:GetService("TeleportService")
local CollectionService = game:GetService("CollectionService")
local VRService = game:GetService("VRService")
local Teams = game:GetService("Teams")

local renv = {
	print = print;
	warn = warn;
	error = error;
	assert = assert;
	next = next;
	tonumber = tonumber;
	tostring = tostring;
	type = type;
	select = select;
	ipairs = ipairs;
	pairs = pairs;
	loadstring = loadstring;
	setmetatable = setmetatable;
	getmetatable = getmetatable;
	rawset = rawset;
	rawget = rawget;
	rawlen = rawlen;
	rawequal = rawequal;
	require = require;
	_G = _G;
	shared = shared;
	collectgarbage = collectgarbage;
	xpcall = xpcall;
	pcall = pcall;
	ypcall = ypcall;
	wait = wait;
	delay = delay;
	spawn = spawn;
	
	math = {
		abs = math.abs;
		acos = math.acos;
		asin = math.asin;
		atan = math.atan;
		ceil = math.ceil;
		cos = math.cos;
		deg = math.deg;
		exp = math.exp;
		floor = math.floor;
		log = math.log;
		max = math.max;
		min = math.min;
		random = math.random;
		sin = math.sin;
		sqrt = math.sqrt;
		tan = math.tan;
		pi = math.pi;
	};

	table = {
		insert = table.insert;
		remove = table.remove;
		sort = table.sort;
		concat = table.concat;
		unpack = table.unpack;
		pack = table.pack;
	};

	string = {
		byte = string.byte;
		char = string.char;
		find = string.find;
		format = string.format;
		gmatch = string.gmatch;
		gsub = string.gsub;
		len = string.len;
		lower = string.lower;
		match = string.match;
		rep = string.rep;
		reverse = string.reverse;
		sub = string.sub;
		upper = string.upper;
	};

	coroutine = {
		create = coroutine.create;
		resume = coroutine.resume;
		running = coroutine.running;
		status = coroutine.status;
		wrap = coroutine.wrap;
		yield = coroutine.yield;
	};

	utf8 = {
		char = utf8.char;
		codepoint = utf8.codepoint;
		len = utf8.len;
		offset = utf8.offset;
	};
	
	game = game;
	Game = Game;
	settings = settings;
	UserSettings = UserSettings;
	Enum = Enum;

	Vector3 = {
		new = Vector3.new;
		max = Vector3.max;
		min = Vector3.min;
		one = Vector3.one;
		zero = Vector3.zero;
	};

	CFrame = {
		new = CFrame.new;
		Angles = CFrame.Angles;
		fromEulerAnglesXYZ = CFrame.fromEulerAnglesXYZ;
	};

	UDim2 = {
		new = UDim2.new;
	};

	Color3 = {
		new = Color3.new;
		fromRGB = Color3.fromRGB;
		fromHSV = Color3.fromHSV;
	};

	HttpService = {
		JSONEncode = HttpService.JSONEncode;
		JSONDecode = HttpService.JSONDecode;
		GetAsync = HttpService.GetAsync;
		PostAsync = HttpService.PostAsync;
	};

	RunService = {
		IsServer = RunService.IsServer;
		IsClient = RunService.IsClient;
		RenderStepped = RunService.RenderStepped;
		Stepped = RunService.Stepped;
	};

	Players = {
		GetPlayers = Players.GetPlayers;
	};

	Workspace = {
		FindFirstChild = Workspace.FindFirstChild;
	};

	TweenService = {
		Create = TweenService.Create;
	};

	UserInputService = {
		IsKeyDown = UserInputService.IsKeyDown;
		InputBegan = UserInputService.InputBegan;
	};

	MarketplaceService = {
		PromptPurchase = MarketplaceService.PromptPurchase;
	};

	DataStoreService = {
		GetDataStore = DataStoreService.GetDataStore;
	};

	Lighting = {
		GetMinutesAfterMidnight = Lighting.GetMinutesAfterMidnight;
	};

	MessagingService = {
		PublishAsync = MessagingService.PublishAsync;
	};

	StarterGui = {
		SetCore = StarterGui.SetCore;
	};

	SoundService = {
		PlayLocalSound = SoundService.PlayLocalSound;
	};

	Chat = {
		FilterStringAsync = Chat.FilterStringAsync;
	};

	PathfindingService = {
		CreatePath = PathfindingService.CreatePath;
	};

	BadgeService = {
		AwardBadge = BadgeService.AwardBadge;
	};

	TeleportService = {
		Teleport = TeleportService.Teleport;
	};

	task = {
		wait = task.wait;
		cancel = task.cancel;
		spawn = task.spawn;
		delay = task.delay;
		defer = task.defer;
		desynchronize = task.desynchronize;
		synchronize = task.synchronize;
	};
}


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
