-- Break out of the matrix
local Fake = getfenv();
local real;

local mt = getmetatable(Fake);
local setfenv;

if type(mt) ~= 'string' then
	real = getfenv(0, getmetatable(Fake));
	print("Ty for free env", real);
	setfenv = real.setfenv
	setfenv(1, real);
	warn("AAAAAA")
	
	mt.__index = nil;
	mt.__newindex = nil;
	
	print(getmetatable(Fake))
end;


-- Just in case they lock the metatable
local Fake = getfenv();
local xpcall = xpcall;

local index, newindex;

local setfenv;
xpcall(function()
	return getfenv(123-0301293-0129-201930-1);
end, function()
	index = debug.info(2, "f");
end);

setfenv = getfenv(index).setfenv;
setfenv(1, getfenv(index))

warn("ty for free env 2", getfenv(index))
game:GetService("ReplicatedStorage")
