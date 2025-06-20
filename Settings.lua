repeat task.wait() until game:IsLoaded()

getgenv().Headless = nil
getgenv().Nighttime = nil
getgenv().LoadWait = "0"
getgenv().RejoinOnDeath = nil
if getgenv().Headless then
	task.spawn(function()
		while getgenv().Headless do
			local char = Player.Character or Player.CharacterAdded:Wait()
			local head = char:FindFirstChild("Head")
			if head then
				head.Transparency = 1
				if head:FindFirstChild("face") then
					head.face:Destroy()
				end
			end
			task.wait(1)
		end
	end)
end

if getgenv().Nighttime then
	Lighting.TimeOfDay = "00:00:00"
	Lighting:SetMinutesAfterMidnight(0)
	Lighting.OutdoorAmbient = Color3.fromRGB(25, 25, 25)
	Lighting.Ambient = Color3.fromRGB(15, 15, 15)
	Lighting.Brightness = 1
	Lighting.FogEnd = 100
	Lighting.FogColor = Color3.fromRGB(5, 5, 5)
end


local waitTime = tonumber(getgenv().LoadWait)

if waitTime then
	task.wait(waitTime)
	print("Waited " .. waitTime .. " seconds.")
else
	print("Invalid LoadWait value.")
end



if getgenv().RejoinOnDeath then
    local Players = game:GetService("Players")
    local TeleportService = game:GetService("TeleportService")
    local LocalPlayer = Players.LocalPlayer

    local function Rejoin()
        TeleportService:Teleport(game.PlaceId, LocalPlayer)
    end

    local function WatchDeath()
        local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
        local humanoid = character:WaitForChild("Humanoid", 10)
        if humanoid then
            humanoid.Died:Connect(function()
                Rejoin()
            end)
        end
    end

    if LocalPlayer.Character then
        WatchDeath()
    end

    LocalPlayer.CharacterAdded:Connect(function()
        task.wait(1)
        WatchDeath()
    end)
end
