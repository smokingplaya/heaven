local controller = controller.new("data")
  :addService("data")

local services = controller.services
---@type ClanServiceData
local dataService = services.data

---@param player Player
controller:hook("playerJoined", function(player)
  dataService:loadProfile(player:SteamID64())
end)