getgenv().toggle = not getgenv().toggle and true or false;

local GC = getgc(true);
local network;

local Player = game:FindService("Players").LocalPlayer;
local get = rawget;

local BloodRayParams = RaycastParams.new();
BloodRayParams.FilterDescendantsInstances = {Player.Character};
-- BloodRayParams.RespectCanCollide = true

local RunService = game:FindService("RunService");
local StarterGUI = game:FindService("StarterGui");

StarterGUI:SetCore("ResetButtonCallback", true); 

for _,Table in next, GC do
    if type(Table) == 'table' and get(Table, "FireServer") and get(Table, "InvokeServer") then
        network = Table;
        break;
    end;
end;

function Thing(DeltaTime: (number) )
 
  local HumanoidRootPart: (BasePart) = Player.Character:FindFirstChild("HumanoidRootPart");

  if not HumanoidRootPart or not Player.Character or not Player.Character:FindFirstChildWhichIsA("Humanoid") then
    return;
 end;

 Player.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Dead);
 
 local Goober: (RaycastResult?) = workspace:Raycast(HumanoidRootPart.CFrame.Position, (HumanoidRootPart.CFrame.Position - HumanoidRootPart.CFrame.UpVector * 20 - HumanoidRootPart.CFrame.Position).Unit * 20, BloodRayParams);

 --[[if not Goober or not Goober.Instance then
    print("wtf");
    return;
end;]]

if Goober and Goober.Instance then
  --  print("YES I AM R");
    network:FireServer("NewBlood", {
        Goober.Position.X;
        Goober.Position.Y;
        Goober.Position.Z
    });
    end;
end;

if getgenv().toggle then
    RunService:BindToRenderStep("death", Enum.RenderPriority.First.Value, Thing);
else
    RunService:UnbindFromRenderStep("death");
end;
