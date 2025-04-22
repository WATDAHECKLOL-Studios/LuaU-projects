local network;
local gc = getgc(true);


for _,Table: {any} in next, gc do
    if type(Table) == 'table' and rawget(Table, "FireServer") and rawget(Table, "InvokeServer") then
        network = Table;
        break;
    end;
end;

network:InvokeServer("createCupOf", "LIFE")
