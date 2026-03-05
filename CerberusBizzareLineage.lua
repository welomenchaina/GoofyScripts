local key = getgenv().Key
local CustomTime = getgenv().CustomTime
if not CustomTime then
  CustomTime = 10.6
end

if key then
task.wait(CustomTime)

script_key=key;
loadstring(game:HttpGet("https://www.getcerberus.com/loader.lua"))()
end
