-- this is glua btw

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
