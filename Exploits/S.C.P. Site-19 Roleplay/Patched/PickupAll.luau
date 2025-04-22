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


for _,v in workspace.Ignore.Pickups:GetDescendants() do
    if not v:FindFirstChild("Config") then
      continue;
    end;
    network:FireServer("interactWith", "Pickup", v.Config.Id.Value)
  end;
