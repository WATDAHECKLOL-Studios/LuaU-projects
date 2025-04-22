local network;
local gc = getgc(true);

--[[local hook;

hook = hookmetamethod(game, "__namecall", function(Self]]

for _,Table: {any} in next, gc do
    if type(Table) == 'table' and rawget(Table, "FireServer") and rawget(Table, "InvokeServer") then
        network = Table;
        break;
    end;
end;


network:FireServer('interactWith', "DoorControl")
network:FireServer('interactWith', "Magnet")
network:FireServer("interactWith", "LockdownAlarm")
