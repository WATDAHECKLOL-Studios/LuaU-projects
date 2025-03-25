--!nocheck
--!native

-- @Author: @WATDAHECKLOL32.
-- @Date:  3/24/25

-- Some common exploit functions you see made in luau, getsenv and getrawmetable and cheap getnilinstances, and some made up ones like hookscriptfunction and getfunction.
-- Made for fun.


local xpcall: <E, A..., R1..., R2...>((A...) -> (R1...), (E) -> (R2...), A...) -> (boolean, R1...) = xpcall;
local info: ((number, string) -> (...any)) & ((thread, number, string) -> (...any)) & (<A..., R1...>((A...) -> (R1...), string) -> (...any)) = debug.info;

local getfenv: (any) -> { [string]: any } = getfenv;
local rawset: <K, V>({ [K]: V }, K, V) -> { [K]: V } = rawset;

local cheap: {Instance?} = {};
local game: DataModel = game;

local insert: (<V>({V}, V) -> ()) & (<V>({V}, number, V) -> ()) = table.insert;
local delay: <A..., R...>(number?, ((A...) -> (R...)) | thread, A...) -> thread = task.delay;

local assert: <T>(T, string?) -> T = assert;
local getmetatable = getmetatable;

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


local getsenv = function(TargetScript: LuaSourceContainer?) : {}
	assert(TargetScript);
	-- local env = get(info(2, "s"));
	return getfenv(info(2, "f"));
end;

local getfunction = function(Script: LuaSourceContainer, targetFunction: string) : RBXScriptSignal?
	local targetEnv = getfenv(2, script);
	local global = targetEnv._G;

	local shared = targetEnv.shared;

	local actualFunction;
	for Index, Value in targetEnv do
		if Index == targetFunction then
			actualFunction = Value;
			break;	
		end;
	end;

	for Index, Value in global do
		if Index == targetFunction then
			actualFunction = Value;
			break;	
		end;
	end;

	for Index, Value in shared do
		if Index == targetFunction then
			actualFunction = Value;
			break;	
		end;
	end;


	if not actualFunction then
		error("i didnt get find dat.", 2);
		return nil;
	end;

	return actualFunction;
end;

local hookscriptfunction = function(script: LuaSourceContainer, targetFunction: string, newFunction: any) : RBXScriptConnection?
	assert(script);
	assert(targetFunction);

	local targetEnv = getfenv(2, script);
	local global = targetEnv._G;

	local shared = targetEnv.shared;

	warn("TargetENV", targetEnv, "Gloals", global, "shared", shared);
	local omg;

	for Index, Value in targetEnv do
		if Index == targetFunction then
			omg = Value;
			rawset(targetEnv, Index, newFunction);
			break;	
		end;
	end;

	for Index, Value in global do
		if Index == targetFunction then
			omg = Value;
			rawset(global, Index, newFunction);
			break;	
		end;
	end;

	for Index, Value in shared do
		if Index == targetFunction then
			omg = Value;
			rawset(shared, Index, newFunction);
			break;	
		end;
	end;


	if not omg then
		error("i didnt get find.", 2);
		return nil;
	end;

	return omg;
end;

local getnilinstances = function() : {Instance?}
	return cheap;
end;

local newcclosure = function(Function: any) : ()
	-- stolen below from some devfourm :3

	return coroutine.wrap(function(...)
		while true do
			coroutine.yield(Function(...));
		end;
	end);
end;

local getrawmetatable = function(Object: Object?): any
	assert(Object, "lol");

	if type(getmetatable(Object)) == 'string' then
		local realMethods: {(string) -> RBXScriptSignal?} = {};

		realMethods.__tostring = function()
			return tostring(Object);
		end;

		realMethods.__tonumber = function()
			return tonumber(Object);
		end;

		xpcall(function()
			return Object == #game;
		end, function()
			realMethods.__eq = info(2, "f");
		end);

		xpcall(function()
			return #Object;	
		end, function()
			realMethods.__len = info(2, "f");
		end);

		xpcall(function()
			return Object + "no";	
		end, function()
			realMethods.__add = info(2, "f");
		end);

		xpcall(function()
			return Object - "no2";
		end, function()
			realMethods.__sub = info(2, "f");
		end);


		xpcall(function()
			for ____ in Object do

			end;
		end, function()
			realMethods.__iter = info(2, "f")
		end);

		xpcall(function()
			Object.Name = newproxy();
		end, function()
			realMethods.__newindex = info(2, "f");
		end);

		xpcall(function()
			return Object.idonotexist;
		end, function()
			realMethods.__index = info(2, "f");
		end);

		xpcall(function()
			return Object:bfekjvferkljfrlkerf();
		end, function()
			realMethods.__namecall = info(2, "f");
		end);

		xpcall(function()
			Object();
		end, function()
			realMethods.__call = info(2, "f");
		end);

		xpcall(function()
			return Object * "h";
		end, function()
			realMethods.__mul = info(2, "f");
		end);

		xpcall(function()
			return Object / "dklowqjkdwqkdwq";	
		end, function()
			realMethods.__div = info(2, "f");
		end);

		xpcall(function()
			return Object .. 5;
		end, function()
			realMethods.__concat = info(2, "f");
		end);

		xpcall(function()
			return Object < game;	
		end,function()
			realMethods.__lt = info(2, "f")
		end);

		xpcall(function()
			return Object <= game;
		end, function()
			realMethods.__le = info(2, "f");
		end);

		--realMethods.__metatable = getmetatable(Object);

		local proxy = newproxy(true);
		for Index, Value in realMethods do
			rawset(getmetatable(proxy), Index, Value);
		end;

		return getmetatable(proxy);
	else
		return getmetatable(Object);
	end;
end;

game.DescendantRemoving:Connect(function(Instance: Instance) -- LAG MAKER 99999.
	delay(8, function()
		insert(cheap, Instance);
	end);
end);

wait(2);

--[[local oldFunction = getfunction(workspace.Script, "troll");
local hook;

print("Old function before we do sus things to it", oldFunction);
hook = hookscriptfunction(workspace.Script, "troll", newcclosure(function(Message: string)
	return hook("enjoy.");
end));]]


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
