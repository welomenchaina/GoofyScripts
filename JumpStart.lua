local Player = game.Players.LocalPlayer
local workspace = game:GetService("Workspace")
local Players = game.Players
local Humanoid = game.Players.LocalPlayer.Character.Humanoid
local Hrp = game.Players.LocalPlayer.Character.HumanoidRootPart
local char = game.Players.LocalPlayer.Character
local HttpService = game:GetService("HttpService")
local Lighting = game:GetService("Lighting")
local inputservice = game:GetService("UserInputService")
local tweenservice = game:GetService("TweenService")
local startergui = game:GetService("StarterGui")
local guiservice = game:GetService("GuiService")
local coregui = game:GetService("CoreGui")
local pathfinding = game:GetService("PathfindingService")
local chatservice = game:GetService("TextChatService")
local InputManager = game:GetService("VirtualInputManager")
local RunService = game:GetService("RunService")
local TpService = game:GetService("TeleportService")
local Hwid = game:GetService("RbxAnalyticsService"):GetClientId()
local userid = game.Players.LocalPlayer.UserId

repeat
task.wait()
until game:IsLoaded()

local function getexecutor()
return identifyexecutor()
end

local function getHwid()
return Hwid
end

getgenv().LoadWait = "5"

local waitTime = tonumber(getgenv().LoadWait)
if waitTime then
    task.wait(waitTime)
    print("Waited" .. waitTime .. " seconds.")
else
    print("Invalid LoadWait value.")
end

getgenv().Nighttime = nil
if getgenv().Nighttime then
Lighting.TimeOfDay = "00:00:00"
Lighting:SetMinutesAfterMidnight(0)
Lighting.OutdoorAmbient = Color3.fromRGB(25, 25, 25)
Lighting.Ambient = Color3.fromRGB(15, 15, 15)
Lighting.Brightness = 1
Lighting.FogEnd = 100
Lighting.FogColor = Color3.fromRGB(5, 5, 5)
end

getgenv().Headless = nil

if getgenv().Headless then
    task.spawn(function()
        while getgenv().Headless do
            local head = char:FindFirstChild("Head")
            if head then
                head:Destroy()
            end
            task.wait(1)
        end
    end)
end


local function getGameName()

local gameName = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name

return gameName
end

