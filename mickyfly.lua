-- MicKyFly
local p=game.Players.LocalPlayer
local c=p.Character or p.CharacterAdded:Wait()
local h=c:WaitForChild("HumanoidRootPart")
local u=game:GetService("UserInputService")
local r=game:GetService("RunService")

local f=false
local s=70
local ctrl={}

-- GUI
local g=Instance.new("ScreenGui",game.CoreGui)
local fr=Instance.new("Frame",g)
fr.Size=UDim2.new(0,150,0,120)
fr.Position=UDim2.new(0,20,0,100)

local title=Instance.new("TextLabel",fr)
title.Size=UDim2.new(1,0,0,25)
title.Text="MicKyFly"
title.BackgroundTransparency=1
title.TextColor3=Color3.new(1,1,1)

local t=Instance.new("TextButton",fr)
t.Size=UDim2.new(1,0,0,35)
t.Position=UDim2.new(0,0,0,25)
t.Text="FLY: OFF"

local txt=Instance.new("TextLabel",fr)
txt.Size=UDim2.new(1,0,0,25)
txt.Position=UDim2.new(0,0,0,60)
txt.Text="Speed: "..s
txt.BackgroundTransparency=1
txt.TextColor3=Color3.new(1,1,1)

local add=Instance.new("TextButton",fr)
add.Size=UDim2.new(0.5,0,0,35)
add.Position=UDim2.new(0,0,0,85)
add.Text="+"

local sub=Instance.new("TextButton",fr)
sub.Size=UDim2.new(0.5,0,0,35)
sub.Position=UDim2.new(0.5,0,0,85)
sub.Text="-"

t.MouseButton1Click:Connect(function()
	f=not f
	t.Text=f and "FLY: ON" or "FLY: OFF"
end)

add.MouseButton1Click:Connect(function()
	s=math.min(s+5,100)
	txt.Text="Speed: "..s
end)

sub.MouseButton1Click:Connect(function()
	s=math.max(s-5,10)
	txt.Text="Speed: "..s
end)

u.InputBegan:Connect(function(i) ctrl[i.KeyCode]=true end)
u.InputEnded:Connect(function(i) ctrl[i.KeyCode]=false end)

r.RenderStepped:Connect(function()
	if f then
		local cam=workspace.CurrentCamera
		local mv=Vector3.new()

		if ctrl[Enum.KeyCode.W] then mv+=cam.CFrame.LookVector end
		if ctrl[Enum.KeyCode.S] then mv-=cam.CFrame.LookVector end
		if ctrl[Enum.KeyCode.A] then mv-=cam.CFrame.RightVector end
		if ctrl[Enum.KeyCode.D] then mv+=cam.CFrame.RightVector end
		if ctrl[Enum.KeyCode.Space] then mv+=Vector3.new(0,1,0) end
		if ctrl[Enum.KeyCode.LeftShift] then mv-=Vector3.new(0,1,0) end

		-- 👇 nếu không bấm gì → đứng im
		if mv.Magnitude == 0 then
			h.AssemblyLinearVelocity = Vector3.new(0,0,0)
		else
			h.AssemblyLinearVelocity = h.AssemblyLinearVelocity:Lerp(mv*s,0.25)
		end
	end
end)
