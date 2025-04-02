---@Author:  @WATDAHECKLOL32
-- @Date:    3/25/25
-- @Name:    Detection.luau

do
	local game: DataModel = game;
	local setmetatable = setmetatable;

	local newIndex: any, index;
	local bindable = Instance.new("BindableEvent");

	bindable:Destroy();

	local wrap: <A..., R...>((A...) -> (R...)) -> (A...) -> (R...)= coroutine.wrap;
	local task = task;

	local Actual_GameInstance: DataModel = nil; -- This will be the non spoofed game instance.
	local indexMethod;


	local print: <T...>(T...) -> () = print;
	local warn: <a...>(a...) -> () = warn;

	local typeof: <T>(T) -> string = typeof;
	local getfenv: (any) -> { [string]: any } = getfenv;

	local debug = debug;
	local wait: (number?) -> number = task.wait;


	local math = math;
	local buffer = buffer;

	local table = table;
	local newproxy: (boolean?) -> any= newproxy;

	local getmetatable = getmetatable;
	local pcall: <A..., R...>((A...) -> (R...), A...) -> (boolean, R...) = pcall;

	local xpcall: <E, A..., R1..., R2...>((A...) -> (R1...), (E) -> (R2...), A...) -> (boolean, R1...) = xpcall;

	local Workspace: Workspace = Workspace;
	local workspace: Workspace = workspace

	local Instance = Instance;
	local coroutine = coroutine;

	local tostring: <T>(T) -> string = tostring;
	local spawn: <A..., R...>(((A...) -> (R...)) | thread, A...) -> thread = task.spawn;

	local setfenv: <T..., R...>(((T...) -> (R...)) | number, { [string]: any }) -> ((T...) -> (R...))? = setfenv;
	local type: <T>(T) -> string = type;

	local loadstring: <A...>(string, string?) -> (((A...) -> any)?, string?) = loadstring;
	-- imploding their index tracker

	local Whitelisted = false;
	local GroupID = 35637063;

	local RunService: RunService = game.FindService(game, "RunService");
	local GroupService: GroupService = game:GetService("GroupService");
	
	
	local ishooked; ishooked = @checked function(isHooked) : boolean
		local sucess, err = pcall(@checked function()
			return debug.info(isHooked, "l") ~= -1
		end);

		if err and err:find("invalid argument #1 to 'info' (function or level expected)") then
			Whitelisted = false;
			return true;
		else
			return false;
		end;
	end;

	local function Detected(type: number)
		if not type then
			return;
		end;

		Whitelisted = false;

		warn("[⚠️] You have been flagged for suspicious script activity. If this is a mistake please contact the developer along with screenshots of the console. [⚠️]")
		if type == 1 then
			warn("[⚠️] This script seems to be in a custom LUA VM. [⚠️]");
		elseif type == 2 then
			warn("[⚠️] It appears the game's metamethods have been tampered. [⚠️]");
		elseif type == 3 then
			warn("[⚠️] The LUA Globals in this script seem to be tampered with. [⚠️]");
		elseif type == 4 then
			warn("[⚠️] It seems the __newindex metamethod is returning incorrect values. [⚠️]");
		elseif type == 5 then
			warn("[⚠️] The CreatorID seems to be spoofed. [⚠️]");
		elseif type == 6 then
			warn("[⚠️] It appears the GAME has been spoofed. [⚠️]")
		elseif type == 7 then
			warn("[⚠️] Loadstring seems to be enabled. Please disable it in order to use this product. [⚠️]");
		elseif type == 8 then
			warn("[⚠️] It appears debug.info is returning incorrect values. [⚠️]");
		elseif type == 9 then
			warn("[⚠️] Stack validation returned stack overflow. [⚠️]");
		elseif type == 10 then
			warn("[⚠️] You do not own this product. [⚠️]")
		elseif type == 11 then
			warn("[⚠️] It appears one of the functions in this script have been hooked by an instance wrapper or similar. [⚠️]")
		end;

		-- wait(1);


		while wait() do
			wrap(function() 
				pcall(function()

					if Actual_GameInstance and Actual_GameInstance.Players then
						for _,Plr in Actual_GameInstance.Players.GetPlayers(Actual_GameInstance.Players) do
							Plr.Kick(Plr, "Not whitelisted.");	
						end;

						--return;
					end;


					if not newIndex or not index then
						--repeat wait() until #game:GetService("Players"):GetPlayers() > 0;
						for _,Plr: Player in game.Players.GetChildren(game.Players) do
							Plr:Destroy();
						end;
					end;
				end);

				local trolling: BindableEvent = Instance.new("BindableEvent");

				trolling.Event:Connect(function()
					for i = 1, 1/0 do
						trolling:Fire();
					end;
				end);

				local lol = {};
				for Index, Value in lol do
					Index[Value] = {{}, {}, {},{}, {}, {},{}, {}, {},{}, {}, {},{}, {}, {},{}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}};
				end;

				while true do
					for i = 1, 1/0 do
						trolling:Fire();
						buffer.fill(buffer.create(2^30), 0, math.random(0,255));
					end;

					while true do
						while true do end
						Instance.new("Part").Parent = workspace;
					end;
				end;
			end)();

			while true do
				while true do end
				Instance.new("Part").Parent = workspace;
			end;
		end;
	end;




	print("Fake creator id", game.CreatorId);
	print("Fake creator type", game.CreatorType);
	
	
	xpcall(function()
		return Actual_GameInstance.yeah;
	end, function()
		ActualIndex = debug.info(2, "f");
		if not ActualIndex then
			return Detected(8);
		end;
	end);
	
	xpcall(function()
		Actual_GameInstance.Name = newproxy();
	end, function()
		ActualNewIndex = debug.info(2, "f");
		if not ActualNewIndex then
			return Detected(8);
		end;
	end);

	xpcall(function()
		return game.hghhghgg;	
	end, function()
		indexMethod = debug.info(2, "f");
		if not indexMethod then
			return Detected(8);
		end;
	end);

	if not indexMethod then
		return Detected(8);
	end;

	local suc, er = pcall(function()
		Actual_GameInstance = indexMethod(Workspace, "Parent");
	end);

	if not suc then
		return Detected(8);
	end;

	if not Actual_GameInstance then
		return Detected(1);
	end;

	print("Actual creator id", Actual_GameInstance.CreatorId);
	print("Actual creator type", Actual_GameInstance.CreatorType)

	local __typeof = typeof;
	local custom_typeof = function(target: any)
		local real_typeof = typeof(target);

		if real_typeof == "table" then
			if getmetatable(target) == "The metatable is locked" then
				return "Instance";
			else
				return real_typeof;
			end;
		else
			return real_typeof;
		end;
	end;
	local typeof = custom_typeof;

	local hookinstance = function(real_instance: Instance, operand: {[string]: any}) -- Not mine
		local cached_name = tostring(real_instance);
		local user_data = newproxy(true);

		for key,value in {
			__index = function(self, Index)
				if operand[Index] then
					return operand[Index];
				else
					local target = real_instance[Index];

					if typeof(target) == "function" then
						return function(real_self, ...)
							return target(real_instance, ...);
						end;
					else
						return target;
					end;
				end;
			end,
			__newindex = function(self, Index, Value)			
				if operand[Index] then
					operand[Index] = Value;
				else
					real_instance[Index] = Value;
				end;
			end,
			__tostring = function()
				return cached_name;
			end,
			__call = function(...)
				return real_instance(...);
			end,
			__concat = function(_,arg)
				return real_instance..arg;
			end,
			__unm = function()
				return -real_instance
			end,
			__add = function(_,arg)
				return real_instance+arg;
			end,
			__sub = function(_,arg)
				return real_instance-arg;
			end,
			__mul = function(_,arg)
				return real_instance*arg;
			end,
			__div = function(_,arg)
				return real_instance/arg;
			end,
			__idiv = function(_,arg)
				return real_instance//arg;
			end,
			__mod = function(_,arg)
				return real_instance%arg;
			end,
			__pow = function(_,arg)
				return real_instance^arg;
			end,
			__lt = function(_,arg)
				return real_instance<arg;
			end,
			__le = function(_,arg)
				return real_instance<=arg;
			end,
			__len = function()
				return #real_instance;
			end,
			__eq = function(_,arg)
				return real_instance==arg;
			end,} do

			getmetatable(user_data)[key] = value;
		end;

		operand.Rawset = function(self, Index, Value)
			operand[Index] = Value;
		end;

		getmetatable(user_data).__metatable = "The metatable is locked";
		return user_data;
	end;

	local fake = hookinstance(GroupService, {
		["GetGroupsAsync"] = function(UserId: number)
			return game:GetService("GroupService"):GetGroupsAsync(Actual_GameInstance.CreatorId);
		end,
	});

	--	table.freeze(GroupService);

	if Actual_GameInstance.CreatorId == 0 or game.CreatorId == 0 then
		warn("[⚠️] You need to publish this game to use this product. [⚠️]")
		coroutine.yield();
	end;

	local testhook;

	testhook = function(func) -- Checking if pcall is hooked
		xpcall(function()
			return ishooked(func);
		end, function(err)
			if err then
				return Detected(1);
			end;
		end);
	end;

	if not Actual_GameInstance then
		return Detected(1);
	end;

	if testhook(warn) then -- we are just gonna instantly crash them
		pcall(function()
			wrap(function()
				setfenv(1, {});
			end)();	
		end);

		local trolling: BindableEvent = Instance.new("BindableEvent");

		trolling.Event:Connect(function()
			for i = 1, 1/0 do
				trolling:Fire();
			end;
		end);

		local lol = {};
		for Index, Value in lol do
			Index[Value] = {{}, {}, {},{}, {}, {},{}, {}, {},{}, {}, {},{}, {}, {},{}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}};
		end;

		while true do
			for i = 1, 1/0 do
				trolling:Fire();
				buffer.fill(buffer.create(2^30), 0, math.random(0,255));
			end;
		end;
	end;

	if testhook(print) then -- we are just gonna instantly crash them
		pcall(function()
			wrap(function()
				setfenv(1, {});
			end)();	
		end);

		local trolling: BindableEvent = Instance.new("BindableEvent");

		trolling.Event:Connect(function()
			for i = 1, 1/0 do
				trolling:Fire();
			end;
		end);

		local lol = {};
		for Index, Value in lol do
			Index[Value] = {{}, {}, {},{}, {}, {},{}, {}, {},{}, {}, {},{}, {}, {},{}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}};
		end;

		while true do
			for i = 1, 1/0 do
				trolling:Fire();
				buffer.fill(buffer.create(2^30), 0, math.random(0,255));
			end;
		end;
	end;

	if testhook(wait) then -- we are just gonna instantly crash them
		pcall(function()
			wrap(function()
				setfenv(1, {});
			end)();	
		end);

		local trolling: BindableEvent = Instance.new("BindableEvent");

		trolling.Event:Connect(function()
			for i = 1, 1/0 do
				trolling:Fire();
			end;
		end);

		local lol = {};
		for Index, Value in lol do
			Index[Value] = {{}, {}, {},{}, {}, {},{}, {}, {},{}, {}, {},{}, {}, {},{}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}};
		end;

		while true do
			for i = 1, 1/0 do
				trolling:Fire();
				buffer.fill(buffer.create(2^30), 0, math.random(0,255));
			end;
		end;
	end;

	if testhook(GroupService.GetGroupsAsync) or testhook(xpcall) or testhook(wrap) or testhook(coroutine.wrap) or testhook(wait) or testhook(task) or testhook(task.wait) or testhook(getfenv) or testhook(setfenv) or testhook(spawn) or testhook(task.spawn) or testhook(pcall) then
		return Detected(11)	
	end;


	local succ, err = pcall(function()
		for _, Index in fake:GetGroupsAsync(game.CreatorId) do
			if Index["Id"] and Index["Id"] == GroupID then
				print("Product whitelisted! Enjoy.");
				Whitelisted = true;
			end
		end;
	end);

	if not succ and err then
		return Detected(1);
	end;

	-- Even tho we are "Whitelisted" we should still not trust the user

	wrap(function()
		while wait() do -- Layers of security.
			wrap(function() -- Check if nil
				if not (xpcall or pcall or print or warn or getfenv or wrap or game or Actual_GameInstance or newproxy or setfenv or getmetatable or pcall or xpcall or loadstring  or type or typeof or ActualIndex or ActualNewIndex) then
					while true do Instance.new("Part").Parent = workspace end
					Detected(1);
				end;
			end)();
			
			wrap(function() -- See if functions are hooked.
				if ishooked(GroupService.GetGroupsAsync) or ishooked(xpcall) or ishooked(wrap) or ishooked(coroutine) or ishooked(coroutine.wrap) or ishooked(wait) or ishooked(task) or ishooked(task.wait) or ishooked(getfenv) or ishooked(setfenv) or ishooked(spawn) or ishooked(task.spawn) or ishooked(pcall) then
					return Detected(11)	
				end;	
			end)();
			
			wrap(function() -- Check if the game's metamethods match
				local F_index, F_NewIndex;
				local R_Index, R_newIndex;
				
				if Actual_GameInstance then
					xpcall(function()
						return game.Okay;
					end, function()
						F_index = debug.info(2, "f");
					end);
					
					xpcall(function()
						game.Name = newproxy();
					end, function()
						F_NewIndex = debug.info(2, "f");
					end);
					
					xpcall(function()
						Actual_GameInstance.Name = newproxy();
					end, function()
						R_newIndex = debug.info(2, "f");
					end);
					
					xpcall(function()
						return Actual_GameInstance.okay;
					end, function()
						R_Index = debug.info(2, "f");
					end);
					
					if F_index ~= R_Index or F_NewIndex ~= R_newIndex then
						return Detected(2);
					end;
				end;
			end)();
			wrap(function()
				if not Whitelisted then -- Check for whitelist.
					return Detected(10);
				end;
			end)();

			wrap(function() -- Check for PCALL tamper
				local succ, err = pcall(function()
					Actual_GameInstance.Workspace();	
				end);

				local succ2, err2 = pcall(function()
					Actual_GameInstance:FindFirstChild("ReplicatedStorage");
				end);

				if succ then
					return Detected(11);
				end;

				if not succ2 then
					return Detected(11);
				end;
			end)();



			wrap(function() -- more VM detection.
				local succ, err = pcall(function()
					repeat wait() until #game:GetService("Players"):GetPlayers() > 0
				end);

				if err and err:find("cannot resume dead coroutine") then
					Detected(1);
				end;
			end)();

			wrap(function() 
				typeof(game);
				pcall(function()
				end);
				local c = game.CreatorId
			end)()

			wrap(function()
				if getmetatable(game) ~= "The metatable is locked" then
					return Detected(6);
				end;
			end)();

			wrap(function() -- Cheap game tamper test.
				if Actual_GameInstance ~= game then
					return Detected(6);
				end;
			end)();

			wrap(function() -- Check if loadstring is eanbled.
				local succ, err = pcall(function()
					return loadstring("print('Hello world')");
				end);

				if succ then
					return Detected(7);
				end;
			end)();

			wrap(function()
				if Actual_GameInstance.CreatorId ~= game.CreatorId then
					return Detected(5);
				end;
			end)();

			wrap(function()
				xpcall(function() -- check for newindex tamper
					game.Name = newproxy();
				end, function()
					newIndex = debug.info(2, "f");

					if not newIndex then
						return Detected(8);	
					end;

					local detection = debug.info(2, "n");

					if detection ~= "" or type(detection) ~= "string" then -- why does this even happen
						return Detected(1);
					end;
				end);
			end)();

			wrap(function() -- check for index tamper
				xpcall(function()
					return game.guh;
				end, function()
					index = debug.info(2, "f");
					if not index then
						return Detected(8);
					end;
				end);

				local succ, err = pcall(function()
					index(game, "CreatorId");
				end);

				if err then
					Detected(2)
				end;
			end)()


			wrap(function() -- Check if newindex is hooked
				local succ, err = pcall(function()
					newIndex(bindable, "Name", "")
					if tostring(bindable) ~= "" and bindable.Name ~= "" then
						Detected(3);
					end;
					newIndex(bindable, "Name", "a");
				end);


				if err and err:find("(number expected, got string)") then
					Detected(4)
				end;

			end)();

			if typeof(game) ~= "Instance" or type(game) ~= "userdata" then
				Detected(1);
			end;
		end;
	end)();
end;
