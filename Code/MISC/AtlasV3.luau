--!nonstrict
--!native
--[[
	Name: AtlasV3.luau
	Author(s): @WATDAHECKLOL32
	Date: 2025-01-16-25 4:05:43 AM
	RunTimeContext: Shared
	Information: a Framework designed for developers to make development easy. Provides a libairy of functions.
	
	Contributors(s): @WATDAHECKLOL32
	Copyright: (C) 2025 WATDAHECKLOL32 All rights reserved.
	Licence: MIT
	Version: 1.0.0
	
	Documentation: https://scpfbluesky.github.io/Atlas-API/
	Source: https://github.com/SCPFBluesky/Atlas_FrameworkV3
	Issues: https://github.com/SCPFBluesky/Atlas_FrameworkV3/issues
]]
--[=[
	@class Atlas
	The Atlas Framework.
]=]
--// Localize globals for more speed
local game, setmetatable, type, assert, tostring = game, setmetatable, type, assert, tostring;
local Atlas = {};
local Players = game:FindService("Players");
local ReplicatedStorage = game:FindService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local ColllectionService = game:GetService("CollectionService");
local AtlasRemoteEvent: (RemoteEvent) = ReplicatedStorage.Atlas_Remote;
local AtlasRemoteFunction: (RemoteFunction) = ReplicatedStorage.Atlas_RemoteFunction;
local Corepackages = ReplicatedStorage["Atlas/CoreModules"]:GetChildren();
export type Modules =  {
	[string]: {ModuleScript?};
};
export type Objects = {
	[string]: {Instance?};
};
export type Link = {
	FireServer: (self: (any), EventName: (string) , ...(any) ) -> (RBXScriptConnection)?;
	FireAllClients: (self: (any), EventName: string, ...(any) )  -> (RBXScriptConnection)?;
	FireAllClientsExpect: (self: (any) ,EventName: (string) , Expect: (Player), ...(any) ) -> (RBXScriptConnection)?;
	FireClient: (self: (any), Player: (Player), EventName: (string), ...(any) ) -> (RBXScriptConnection)?;
	InvokeServer: (self: (any), EventName: (string), ...(any) ) -> (RBXScriptConnection)?;
	InvokeClient: (self: (any), Player: (Player), EventName: (string), ...(any) ) -> (RBXScriptConnection)?
};
local Modules: (Modules) = {};
local Objects: (Objects) = {};
local MuteInstanceWarn: (boolean) = false;
local IsClient: (boolean) = RunService:IsClient();
local IsServer: (boolean) = RunService:IsServer();
local print = function(...)
	print("[ATLAS/OUTPUT]: ", ...);
end;
local warn = function(...)
	warn("[ATLAS/OUTPUT]: ", ...);
end;
--[=[
	@within Atlas
	@method Atlas.GetCoreModule
	@tag Instance Related
	@param Name String -- Name of the module.
	@return Module -- Returns the required module
	
	Allows you to quickly get modules inside Atlas/CoreModules (kinda how flux is).
]=]
function Atlas.GetCoreModule(Name: (string) )
	assert(Name, "Attempt to call Atlas.GetCoreModule with missing name.");
	
	local found = false;	
	for _,Module: (ModuleScript?) in next, Corepackages do
		if Module and Module:IsA("ModuleScript") and tostring(Module) == Name then
			found = true;
			return require(Module);
		end;
	end;
	
	if not found then
		warn("GetCoreModule called with invaild (missing or nil) module name", Name)
	end;
end;
--[=[
	@within Atlas
	@method Atlas:Import
	@tag Instance Related
	@param ModuleName String -- The module you wish to require.
	@return Module -- Returns the required module.
	@yields
	
	A neater and slower verison of require, taking a string. And then looks up in the modules table, remember if you wish to require this way the target module must have the "Atlas_Module" Tag.
]=]
function Atlas:Import(ModuleName: (any) )
	assert(ModuleName, "Attempt to call Atlas:Import, but no module was provided.");
	local ModuleFound = false;
	for _,ModuleScript: (ModuleScript?) in next, ColllectionService:GetTagged("Atlas_Module") do
		if ModuleScript and ModuleScript:IsA("ModuleScript") and ModuleName == tostring(ModuleScript) then
			ModuleFound = true
			
			local Succ, Result = pcall(function()
				return require(ModuleScript);
			end);
			if Succ then
				Modules[ModuleName] = Result
				return Result;
			else
				return warn("[ATLAS:IMPORT]: Failed to load Module: ", ModuleName, Result);
			end;
		end;
	end;
	
	if not ModuleFound then
		warn("The provided Module Name was not found in CollectionService: ", ModuleName);
		return nil;
	end;
end;
--[=[
	@within Atlas
	@method Atlas:RecursiveImport
	@tag Instance Related
	@param ModuleName String -- The module you wish to require.
	@param InstanceToSearch Instance -- The Instance that the target module is parented too.
	@return Module -- Returns the required module.
	@yields
	
	Allows you to require modules parented to instances that do not have the Atlas_Module tag.
]=]
function Atlas:RecursiveImport(ModuleName: (string), InstanceToSearch: (Instance))
	assert(ModuleName, "Attempt to call Atlas:RecursiveImport, but no Module name was provided.");
	assert(InstanceToSearch, "Attempt to call Atlas:RecursiveImport, but no Instance was provided.");
	local Stuff = {} :: {Instance?}
	Stuff = InstanceToSearch:GetDescendants()
	for _,Instances: (ModuleScript?) in Stuff do
		if Instances and Instances:IsA("ModuleScript") and tostring(Instances) == ModuleName then
			return require(Instances);
		end;
	end;
end;
--[=[
	@within Atlas
	@method Atlas:GetObject
	@tag Instance Related
	@param ObjectName String -- The instance you wish to find.
	@return Instance -- Returns the target instance.
	@yields
	
	Allows you to get any object that has the Atlas_Object tag.
]=]
function Atlas:GetObject(ObjectName: (string) )
	assert(ObjectName, "Attempt to call Atlas:GetObject, but no ObjectName was provided.");
	local ObjectFound = false;
	if Objects[ObjectName] then
		return Objects[ObjectName];	
	end;
	for _,Object: (Instance?) in next, ColllectionService:GetTagged("Atlas_Object") do
		if Object and tostring(Object) == ObjectName then
			ObjectFound = true
			Objects[ObjectName] = Object;
			return Object;
		end;
	end;
	if not ObjectFound then
		warn("The provided Object Name was not found in CollectionService: ", ObjectName);
		return nil;
	end;
end;
--[=[
	@within Atlas
	@method Atlas:BindToRemoteEvent
	@tag Networking
	@param EventName String -- The name of the event you wish to bind the remote too.
	@param Callback  RBXScriptConnection -- The function that will be called for that specific event.
	Allows you to bind functions to the Atlas_RemoteEvent.
]=]
function Atlas:BindToRemoteEvent(EventName: (string), CallBack)
	assert(EventName, "Attempt to call Atlas:BindToEvent but no eventname was provided.");
	assert(CallBack, "Attempt to call Atlas:BindToEvent but no function was provided.");
	if IsServer then
		AtlasRemoteEvent.OnServerEvent:Connect(function(Player: (Player), Event: (string), ...)
			if Event == EventName then
				CallBack(Player, ...)
			end;
		end);
	elseif IsClient then
		AtlasRemoteEvent.OnClientEvent:Connect(function(Event: (string), ...)
			if Event == EventName then
				CallBack(...)
			end;
		end);
	end;
end;
--[=[
	@within Atlas
	@method Atlas:BindToRemoteFunction
	@tag Networking
	@param EventName String -- The name of the event you wish to bind the remote function too.
	@param Callback  RBXScriptConnection -- The function that will be called for that specific event
	Allows you to bind functions to the Atlas_RemoteFunction.
]=]
function Atlas:BindToRemoteFunction(EventName: (string), CallBack: (Instance) -> ()): RBXScriptConnection
	assert(EventName, "Attempt to call BindToRemoteFunction but no EventName was provided");
	assert(CallBack, "Attempt to call BindToRemoteFunction but no function was provided.");
	if IsServer then
		AtlasRemoteFunction.OnServerInvoke = function(Player: (Player), Event: (string), ...)
			if Event == EventName then
				return CallBack(Player, ...)
			end;
		end;
	elseif IsClient then
		AtlasRemoteFunction.OnClientInvoke = function(Event: (string), ...)
			return CallBack(...)
		end;
	end;
end;
do
--[=[
	@class link
	The Atlas Networking.
]=]
	
	local link: (Link) = setmetatable({
    --[=[
    @within link
    @method link:FireServer
    @tag Networking
    @client
    @param EventName String -- The event you wish to trigger.
    @return Event  RBXScriptConnection -- Returns.
    Allows you to FireServer the AtlasRemoteEvent.
    ]=]
		FireServer = function(self, EventName, ...)
			if IsClient then
				return AtlasRemoteEvent:FireServer(EventName, ...);
			else
				return nil;
			end;
		end,
    --[=[
    @within link
    @method link:FireAllClients
    @tag Networking
    @server
    @param EventName String -- The event you wish to trigger.
    @return Event  RBXScriptConnection -- Returns.
    Allows you to fire the remote to all clients.
    ]=]
		FireAllClients = function(self, EventName, ...)
			if IsServer then
				return AtlasRemoteEvent:FireAllClients(EventName, ...);
			else
				return nil;
			end;
		end,
    --[=[
    @within link
    @method link:FireAllClientsExpect
    @tag Networking
    @server
    @param EventName String -- The event you wish to trigger.
    @param Expect Player -- The exception (Remote will not be fired for this player.)
    @return Event  RBXScriptConnection -- Returns.
    Allows you to fire the remote to all clients except for one specific client.
    ]=]
		FireAllClientsExpect = function(self, EventName, Expect, ...)
			if IsServer then
				for _, Player: (Player) in next, Players:GetPlayers() do
					if Player ~= Expect then
						AtlasRemoteEvent:FireClient(Player, EventName, ...)
					end;
				end;
			else
				return nil;
			end;
		end,
    --[=[
    @within link
    @method link:FireClient
    @tag Networking
    @server
    @param Player Player -- The client you wish to trigger the remote for.
    @param EventName String -- The event you wish to trigger.
    @return Event  RBXScriptConnection -- Returns.
    Allows you to fire the remote to one specific client.
    ]=]
		FireClient = function(self, Player, EventName, ...)
			if IsServer then
				return AtlasRemoteEvent:FireClient(Player, EventName, ...);
			else
				return nil;
			end;
		end,
    --[=[
    @within link
    @method link:InvokeServer
    @tag Networking
    @client
    @param EventName String -- The event you wish to trigger.
    @return Event  RBXScriptConnection -- Returns.
    Allows you to invoke the remote function on the server.
    ]=]
		InvokeServer = function(self, EventName, ...)
			if IsClient then
				return AtlasRemoteFunction:InvokeServer(EventName, ...);
			else
				return nil;
			end;
		end,
    --[=[
    @within link
    @method link:InvokeClient
    @tag Networking
    @server
    @param Player Player - The target player
    @param EventName String -- The event you wish to trigger.
    @return Event  RBXScriptConnection -- Returns.
    Allows you to invoke the remote function for one specific player.
    ]=]
		InvokeClient = function(self, Player, EventName, ...)
			if IsServer then
				return AtlasRemoteFunction:InvokeClient(Player, EventName, ...);
			else
				return nil;
			end;
		end,
	}, { __index = Atlas });
	Atlas.network = link
end;
--[=[
	@within Atlas
	@method Atlas.Create
	@tag Instance Related
	@param Name String -  The name of the new instance
	@param Class String -  The class the new instance will be
	@param ... Any -  The properities of the new instance.
	@return New  Instance --  mReturns the new instance.
	ALlows you to create any instance with any class.
]=]
function Atlas.Create(Name: (string?), Class: (string), ...)
	assert(Class, "Attempt to call Atlas:NewInstance() but no Class was provided")
	if not Name and not MuteInstanceWarn then
		warn("No name was provided in Atlas:NewInstance, defaulting name to instance's class. Enable MuteInstanceWarn to silence.")
	end;
	local ObjectProperties = {...}
	local Instance = Instance.new(Class) 
	Instance.Name = Name or Class
	for key, value in ObjectProperties[1] or {} do
		Instance[key] = value
	end;
	local New = setmetatable({
		Instance = Instance, 
	}, { __index = Atlas });
	return New;
end;
return Atlas;
