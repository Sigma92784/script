-- AEZY Short Loader Script
local S=game:GetService
local CG,Plr,Wk,RS,PP=S(game,"CoreGui"),S(game,"Players"),S(game,"Workspace"),S(game,"RunService"),S(game,"ProximityPromptService")
local LP=Plr.LocalPlayer

pcall(function() CG.AezyScriptUI:Destroy() end)
local g=Instance.new("ScreenGui",CG) g.Name="AezyScriptUI" g.ResetOnSpawn=false
local f=Instance.new("Frame",g)
f.Size=UDim2.new(0,170,0,120) f.Position=UDim2.new(.5,-170,.5,-60)
f.BackgroundColor3=Color3.fromRGB(10,10,10) f.BorderSizePixel=0 f.Active=true f.Draggable=true
Instance.new("UICorner",f).CornerRadius=UDim.new(0,16)
local s=Instance.new("UIStroke",f) s.Color=Color3.fromRGB(0,255,255) s.Thickness=3 s.Transparency=.2
local t=Instance.new("TextLabel",f)
t.Size=UDim2.fromScale(1,1) t.BackgroundTransparency=1
t.Text="AEZY\nINSTANT STEAL" t.Font=Enum.Font.GothamBold t.TextSize=18
t.TextColor3=Color3.fromRGB(0,255,255) t.TextWrapped=true

PP.PromptButtonHoldEnded:Connect(function(_,p)
 if p==LP and LP.Character then
  LP.Character:MoveTo(Vector3.new(-363.87,-2.71,104.71))
 end
end)

local suf={K=1e3,M=1e6,B=1e9,T=1e12}
local function val(x)
 x=(x or ""):gsub("[%$,/S,]","")
 local n=tonumber(x:match("[%d%.]+")) or 0
 local s=x:match("%a+") return n*(suf[s] or 1)
end
local function eq(a,b) return a and b and a:lower()==b:lower() end

local function scan()
 local best,v=nil,-1
 local plots=Wk:FindFirstChild("Plots") if not plots then return end
 for _,p in ipairs(plots:GetChildren()) do
  for _,o in ipairs(p:GetDescendants()) do
   if o:IsA("BillboardGui") and o.Name=="AnimalOverhead" then
    local g=o:FindFirstChild("Generation")
    if g and val(g.Text)>v then
     local ps=p:FindFirstChild("PlotSign",true)
     local l=ps and ps:FindFirstChildWhichIsA("TextLabel",true)
     if l and not eq(l.Text:gsub("['’]s$",""),LP.Name) then
      v=val(g.Text) best=o
     end
    end
   end
  end
 end
 if best then
  pcall(function()
   Instance.new("Highlight",best.Parent).Adornee=best.Parent
  end)
 end
end

task.spawn(function() while task.wait(2) do scan() end end)

local function esp(p)
 local function h(c)
  local H=Instance.new("Highlight",c)
  H.FillColor=Color3.fromRGB(173,216,230) H.FillTransparency=.75
 end
 if p.Character then h(p.Character) end
 p.CharacterAdded:Connect(h)
end
for _,p in ipairs(Plr:GetPlayers()) do if p~=LP then esp(p) end end
Plr.PlayerAdded:Connect(function(p) if p~=LP then esp(p) end end)

RS.RenderStepped:Connect(function()
 for _,p in ipairs(Plr:GetPlayers()) do
  if p~=LP then
   local c=Wk:FindFirstChild(p.Name)
   if c then
    for _,d in ipairs(c:GetDescendants()) do
     if d:IsA("BasePart") then d.LocalTransparencyModifier=(d.Name=="HumanoidRootPart" and 1 or 0) end
    end
   end
  end
 end
end)
