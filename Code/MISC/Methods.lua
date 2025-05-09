-- this is glua not luau btw

local getrawmetatable = debug.getmetatable;
local newcclosure = function(func)
	return coroutine.wrap(function(...)
		local params = {...};
		local nuhuh = function()
			params = nil;
		end;
		while 1 do
			params = {coroutine.yield(func(unpack(params)), coroutine.wrap(nuhuh)())};
		end;
	end);
end;

local hookmetamethod = newcclosure(function(Object, Metamethod, Closure)
	local Metatable = getrawmetatable(Object);
	local Old = rawget(Metatable, Metamethod);

	assert(Old, Metamethod.. " Is not a valid metamethod of ".. tostring(Object));
	rawset(Metatable, Metamethod, Closure);

	return Old;
end);

local getnamecallmethod;

local namecallatom = newcclosure(function(self, index, ...)
	assert(self);


	getnamecallmethod = newcclosure(function()
		return index
	end);

	if getrawmetatable(self) and getrawmetatable(self).__namecall then
		getrawmetatable(self).__namecall(self, ...);
	end;

	getnamecallmethod = newcclosure(function() 
		return nil;
	end);

end);

local typeof = newcclosure(function(Object)
	if getrawmetatable(Object) and getrawmetatable(Object).__type then
		return getrawmetatable(Object).__type;
	end;

	return type(Object);
end);

local mine = setmetatable({}, {
	__index = function(Self, Index, ...)
		return rawget(Self, Index) or function(...)
			namecallatom(Self, Index, ...);
		end;
	end;

	__namecall = function(Self, ...)
		print("namecall metamethod invoked with", getnamecallmethod(), "with arugments of", ...);
	end;


	__metatable = "The metatable is locked";
	__type = "Instance";
});

print(mine:hi("b"))


local old = debug;


local function info(FuncOrLevel, Params)
    local Result = debug.getinfo(FuncOrLevel, "Slnf");
    local New = {};

    if Params:find("s") then
        if Result.what == "C" then
            New[1] = "[C]";
        else
            New[1] = Result.what;
        end;
    end;

    if Params:find("l") then
         New[2] = Result.linedefined;
    end;

    if Params:find("n") then
        if Result.name == nil then
            New[3] = "";
        else
            New[3] = Result.name;
        end;
    end;

    if Params:find("a") then -- return true for C functions, return false for lua functions
        if Result.what == "C" then
            New[4] = "0 true";
        else
            New[4] = "0 false";
        end;
    end;

    if Params:find("f") then
        New[5] = Result.func;
    end;


    return unpack(New);
end;

local debug = {
    ["info"] = info;
};

for Index, Value in next, debug do
    debug[Index] = Value
end;

local test = function()
end;

print(debug.info(test, "slnaf"));
