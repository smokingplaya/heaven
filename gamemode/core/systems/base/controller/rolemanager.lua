---Role-based access control
---@class RoleManager: Controller
local controller = controller.new("rbac")
  :addService("rolemanager")

local services = controller.services
---@type RoleManagerService
---@diagnostic disable-next-line: assign-type-mismatch
local roleManager = services.rolemanager

roleManager:loadRoles()

controller:hook("playerJoined", function(pl)
  roleManager:restorePlayerRole(pl)
end)