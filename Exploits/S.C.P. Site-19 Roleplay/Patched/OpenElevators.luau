local network;

local GC = getgc(true);
local CollectionService = game:FindService("CollectionService");

for _,table in GC do
    if typeof(table) == 'table' and rawget(table, "InvokeServer") and rawget(table, "FireServer") then
        network = table;
        break;
    end;
end;

for _,Elevators in CollectionService:GetTagged("Elevator") do
    local Doors = Elevators:GetChildren()
    network:FireServer("interactWith", "Elevator", Elevators.Config.Id.Value, Doors[1].Door.Buttons.Back.CallNumber.Value);
    network:FireServer("interactWith", "Elevator", Elevators.Config.Id.Value, Doors[2].Door.Buttons.Back.CallNumber.Value);
end;
