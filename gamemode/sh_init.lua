GM.Title = "Heaven"
GM.Author = "smokingplaya"
GM.Website = "https://github.com/smokingplaya/heaven"

-- with comments this piece of code doesn't look so awful
-- we're going to start timing
local startTime = SysTime()

-- add sh_load.lua on serverside for clientside
if (SERVER) then
  AddCSLuaFile("core/sh_load.lua")
end

-- including sh_load
-- it's like entry-point of our framework
include("core/sh_load.lua")

-- calculate how long it took to download
local elapsedTime = math.Round(SysTime()-startTime, 4)

-- display elapsed time
log.debug("😲 Gamemode loaded for " .. elapsedTime .. "s")