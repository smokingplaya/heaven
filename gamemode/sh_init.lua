GM.Title = "Heaven"
GM.Author = "smokingplaya"
GM.Website = "https://github.com/smokingplaya/heaven"

if (SERVER) then
  AddCSLuaFile("core/sh_load.lua")
end

-- todo: rewrite; looks terrible
local startTime = SysTime()

include("core/sh_load.lua")

log.debug("Loaded for " .. math.Round(SysTime()-startTime, 4) .. "s")