---Role-based access control
---@class RoleManager: Controller
local controller = controller.new("rbac")
  :addService("rolemanager")

local services = controller.services
---@type RoleManagerService
---@diagnostic disable-next-line: assign-type-mismatch
local roleManager = services.rolemanager

roleManager:loadRoles()

---@param player Player
controller:hook("playerJoined", function(player)
  roleManager:restorePlayerRole(pl)
end)

---@param player Player
controller:hook("playerNoclip", function(player)
  return player:hasPermission("noclip")
end)