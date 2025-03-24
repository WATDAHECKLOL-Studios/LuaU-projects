--!nonstrict
--!native

-- @Author: @WATDAHECKLOL32.
-- @Date:  3/14/25

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

local oldFunction = getfunction(workspace.Script, "troll");
local hook;

print("Old function before we do sus things to it", oldFunction);
hook = hookscriptfunction(workspace.Script, "troll", function(Message: string)
	return hook("enjoy.");
end);
