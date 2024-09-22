local service = service.new()

local realisticFallDamage = CreateConVar("sv_realfalldamage", "0", {FCVAR_PROTECTED, FCVAR_UNLOGGED}, "Enables realistic fall damage", 0, 1)
--- Falco's DarkRP uses 15, but i think 30 is better
local realisticFallDamageMultiplier = CreateConVar("sv_realfalldamagemultiplier", "30", {FCVAR_PROTECTED, FCVAR_UNLOGGED}, "Multiplier for real fall damage", 1, 100)

local defaultFallDamage = 10

local fallDamage = realisticFallDamage:GetBool()
cvars.AddChangeCallback(realisticFallDamage:GetName(), function(_, _, value)
  fallDamage = tobool(value)
end, "heaven")

local fallMultiplier = realisticFallDamageMultiplier:GetInt()
cvars.AddChangeCallback(realisticFallDamageMultiplier:GetName(), function(_, _, value)
  ---@diagnostic disable-next-line: cast-local-type
  fallMultiplier = tonumber(value)
end, "heaven")

---@param player Player
---@param fallSpeed number
function GM:GetFallDamage(player, fallSpeed)
  ---@diagnostic disable-next-line: undefined-field
  return player.immunityFallDamage and 0 or (fallDamage and fallSpeed/fallMultiplier or defaultFallDamage)
end

return service