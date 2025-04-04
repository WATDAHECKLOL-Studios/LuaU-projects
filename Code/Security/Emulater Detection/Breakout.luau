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
