--!nocheck

local xpcall: <E, A..., R1..., R2...>((A...) -> (R1...), (E) -> (R2...), A...) -> (boolean, R1...) = xpcall;
local debug = debug;

local getrawmetatable = function(Object: Object?) : {any}
	local Methods = {};

	xpcall(function()
		return Object:___();
	end, function()
		Methods.__namecall = debug.info(2, "f");
	end);

	xpcall(function()
		return Object.helloworld;
	end, function()
		Methods.__index = debug.info(2, "f");
	end);

	xpcall(function()
		Object.Name = newproxy();
	end, function()
		Methods.__newindex = debug.info(2, "f");
	end);

	xpcall(function()
		Object();
	end, function()
		Methods.__call = debug.info(2, "f")
	end);

	xpcall(function()
		return Object .. Object
	end, function()
		Methods.__concat = debug.info(2, "f");
	end)

	xpcall(function()
		return Object - {};
	end, function()
		Methods.__unm = debug.info(2, "f")
	end);

	xpcall(function()
		return Object + Object;
	end, function()
		Methods.__add = debug.info(2, "f");
	end);

	xpcall(function()
		return Object - Object;
	end, function()
		Methods.__sub = debug.info(2, "f");
	end);

	xpcall(function()
		return Object * Object;
	end, function()
		Methods.__mul = debug.info(2, "f")
	end);


	xpcall(function()
		return Object / Object;
	end, function()
		Methods.__div = debug.info(2, "f")
	end);

	xpcall(function()
		return Object // Object;
	end, function()
		Methods.__idiv = debug.info(2, "f");
	end);

	xpcall(function()
		return Object % Object;
	end, function()
		Methods.__mod = debug.info(2, "f");    
	end);

	xpcall(function()
		return Object ^ Object;
	end, function()
		Methods.__pow = debug.info(2, "f");
	end);

	xpcall(function()
		return tostring(Object.__namecall);
	end, function()
		Methods.__tostring = debug.info(2, "f");
	end);

	Methods.__metatable = getmetatable(Object);

	xpcall(function()
		return Object == true
	end, function()
		Methods.__eq = debug.info(2, "f");
	end);

	xpcall(function()
		return Object < true;
	end, function()
		Methods.__lt = debug.info(2, "f");
	end);

	xpcall(function()
		return Object <= true;
	end, function()
		Methods.__le = debug.info(2, "f");
	end);

	xpcall(function()
		return #Object;    
	end, function()
		Methods.__len = debug.info(2, "f");
	end);

	xpcall(function()
		for _,v in Object do

		end    
	end, function()
		Methods.__iter = debug.info(2, "f");
	end);

	return Methods;
end;

print(getrawmetatable(game))
