---@class RoleManagerService: Service
local service = service.new()

---@type table<string, Role>
service.roles = {}
service.defaultRole = ""

---@class Role
---@field id string
---@field localizedName string
---@field isAdmin? boolean
---@field isSuperAdmin? boolean
---@field isDefault? boolean
---@field permissions MetaMap MetaMap<number, string>
---@field weight number
local roleClass = {}
roleClass.__index = roleClass

RegisterMetaTable("Role", roleClass)

--- Makes role table metatable
---@private
---@param role Role
---@return Role
function service:registerRole(role)
  local roleObject = setmetatable(role, roleClass)
  roleObject.permissions = metamap.new(roleObject.permissions)

  self.roles[role.id] = roleObject

  log.trace(("[+] The role 👨 %s (%s) has been registered"):format(role.id, role.localizedName))

  return roleObject
end

---@async
function service:loadRoles()
  self:fetch(function(response)
    if (response:isError()) then
      return response:logError()
    end

    ---@diagnostic disable-next-line: param-type-mismatch
    local roles = metamap.new(response:getBody())

    roles:foreach(function(role)
      if (role.isDefault) then
        self.defaultRole = role.id
      end

      self:registerRole(role)
    end)

    log.trace("👨 Registred " .. #roles .. " roles.")
  end, "server/roles")
end

---@async
---@param player Player
function service:restorePlayerRole(player)
  print(">", player:SteamID64())
  self:fetch(function(response)
    if (response:isError()) then
      player:setRole(service.defaultRole)
      return response:logError()
    end

    local role = response:getBody()

    if (!IsValid(player)) then
      return
    end

    player:setRole(role)
  end, "server/role", "GET", {
    id = player:SteamID64()
  })
end

-- Player metatable functions
-- todo @ Fields cannot be injected into the reference of `Player` for `getRole`. To do so, use `---@class` for `playerClass`.

---@type Player
local playerClass = FindMetaTable("Player")

playerClass.getRole = playerClass.GetUserGroup

function playerClass:setRole(role)
  if (!service.roles[role]) then
    return log.error("Failed to assign player role \"" .. role .. "\" - role does not exist.")
  end

  self:SetUserGroup(role)

  service:fetch(emptyFunction, "server/role", "PATCH", {
    id = self:SteamID64(),
    new = role
  })
end

---@return Role
function playerClass:getRoleTable()
  return service.roles[self:getRole()]
end

---@param permission string
---@return boolean
function playerClass:hasPermission(permission)
  local role = self:getRoleTable()
  local permissions = role.permissions

  return role.isSuperAdmin or permissions:contains(permission)
end

return service