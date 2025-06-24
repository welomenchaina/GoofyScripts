local plr = game.Players.LocalPlayer
local players = game.Players
local env = getgenv()
local Lighting = game:GetService("Lighting")
local workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")


if not game:IsLoaded then
repeat
    task.wait()
until game:IsLoaded()
end

local function GetExecutor()
    return identifyexecutor()
end

env.NightTime = nil

local originalSettings = {
    ClockTime = Lighting.ClockTime,
    Brightness = Lighting.Brightness,
    Ambient = Lighting.Ambient,
    OutdoorAmbient = Lighting.OutdoorAmbient,
    FogColor = Lighting.FogColor,
    FogStart = Lighting.FogStart,
    FogEnd = Lighting.FogEnd
}

local lightningCoroutine

if env.NightTime == true then
    Lighting.ClockTime = 22
    Lighting.Brightness = 0.4
    Lighting.Ambient = Color3.fromRGB(50, 50, 70)
    Lighting.OutdoorAmbient = Color3.fromRGB(30, 30, 50)
    Lighting.FogColor = Color3.fromRGB(40, 40, 60)
    Lighting.FogStart = 30
    Lighting.FogEnd = 150

    lightningCoroutine = coroutine.create(function()
        while true do
            wait(0.1)
            Lighting.Brightness = 2
            wait(0.2)
            Lighting.Brightness = 0.4
        end
    end)
    coroutine.resume(lightningCoroutine)
else
    if lightningCoroutine and coroutine.status(lightningCoroutine) ~= "dead" then
        coroutine.close(lightningCoroutine)
    end
    Lighting.ClockTime = originalSettings.ClockTime
    Lighting.Brightness = originalSettings.Brightness
    Lighting.Ambient = originalSettings.Ambient
    Lighting.OutdoorAmbient = originalSettings.OutdoorAmbient
    Lighting.FogColor = originalSettings.FogColor
    Lighting.FogStart = originalSettings.FogStart
    Lighting.FogEnd = originalSettings.FogEnd
end


