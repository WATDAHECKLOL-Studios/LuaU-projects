local GC = getgc(true);
local network;

for _,v in next, GC do
    if type(v) == 'table' and rawget(v, "FireServer") then
        network = v;
        break;
    end;
end;

for _,v in workspace.Special.Doors:GetChildren() do
    if not v:FindFirstChild("Config") then
        continue;
    end;
    network:FireServer("interactWith", "Door", v.Config.Id.Value);
end;
