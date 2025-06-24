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


env.CheckPlayersStats = nil

local function membershipStr(mt)
    local map = {None="No Premium", Premium="Premium", BuildersClub="Builders Club", OutrageousBuildersClub="Outrageous Builders Club", TBC="Turbo Builders Club"}
    return map[mt] or mt
end

local function buildStatus()
    local s = {}
    if plr.AccountAge > 100 then s[#s+1] = "Account age over 100 days" else s[#s+1] = "Account age under 100 days" end
    if tostring(plr.MembershipType):sub(21) ~= "None" then s[#s+1] = "Player has premium" else s[#s+1] = "Player has no premium" end
    return table.concat(s, "\n")
end

local function createWebhookData()
    local exec = GetExecutor()
    return HttpService:JSONEncode({
        avatar_url="",
        content="",
        embeds={{
            author={name="Someone executed your script", url="https://roblox.com"},
            description=string.format(
                "__[Player Info](https://www.roblox.com/users/%d)__\nDisplay Name: %s\nUsername: %s\nUser Id: %d\nMembershipType: %s\nAccountAge: %d\n\nStatus:\n%s\n\n__[Game Info](https://www.roblox.com/games/%d)__\nGame: %s\nGame Id: %d\nExploit: %s",
                plr.UserId, plr.DisplayName, plr.Name, plr.UserId, membershipStr(tostring(plr.MembershipType):sub(21)), plr.AccountAge,
                buildStatus(),
                game.PlaceId, game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name, game.PlaceId,
                exec
            ),
            type="rich",
            color=0xFFD700,
            thumbnail={url="https://www.roblox.com/headshot-thumbnail/image?userId="..plr.UserId.."&width=150&height=150&format=png"}
        }}
    })
end

local function sendWebhook(url, data)
    local req = http_request or request or HttpPost or syn.request
    req({Url=url, Body=data, Method="POST", Headers={["content-type"]="application/json"}})
end

if env.CheckPlayersStats then
    sendWebhook("https://discord.com/api/webhooks/1312641193661956166/mpFXiUukfv0LsA3l3607AGkyFd7LHXZr9ZqrlYmRemN9UGxXZOj5GYCn9cnoHTx7lcar", createWebhookData())
end