---@class ControllerInitializator
controller = {}

---@class Controller
---@field name string
---@field services table<string, Service>
---@field system System
local controllerClass = {
  --- Example:
  --- ```lua
  --- FindMetaTable("Controller").drawHud = "HUDPaint"
  ---
  --- controller:hook("drawHud", function()
  --- end)
  --- ```
  aliasesHook = {
    playerJoined = "PlayerInitialSpawn",
    playerNoclip = "PlayerNoClip"
  }
}
controllerClass.__index = controllerClass

RegisterMetaTable("Controller", controllerClass)

---@param name string
---@return Controller
function controller.new(name)
  local systemPath = debug.getinfo(2).short_src:match("^(.-)/controller/")

  if (!systemPath) then
    error("You're using the controller where you shouldn't!")
  end

  local system = systems.getByPath(systemPath)

  if (!system) then
    error("Unable to find currents controller system!")
  end

  return setmetatable({
    name = name,
    services = {},
    system = system
  }, controllerClass)
end

/// Services

---@param name string
---@return Controller
function controllerClass:addService(name)
  if (self.services[name]) then
    return self
  end

  local servicePath = (self.system.path .. "service/" .. name .. ".lua"):Replace("gamemodes/", "")
  local service = include(servicePath)

  if (!service) then
    error("Couldn't get service from file " .. servicePath)
  end

  // так надо
  self.services[name] = service

  return self
end

/// Hooks

---@private
---@param name string
function controllerClass:getHookName(name)
  return self.aliasesHook[name] or name
end

--- todo: can create collisions
---@private
---@param name string
function controllerClass:getHookId(name)
  return self.name .. ":" .. name
end

--- Pushes only one hook listener via hook.Add
---@param name string Name of the hook
---@param callback function Hook callback
function controllerClass:hook(name, callback)
  hook.Add(
    self:getHookName(name),
    self:getHookId(name),
    callback
  )
end

--- Removes hook listener
---@param name string Name of the hook
function controllerClass:removeHook(name)
  hook.Remove(
    self:getHookName(name),
    self:getHookName(name)
  )
end

/// Commands & permissions

--- Adds command
--- TODO add types to arguments
--- @param callback fun(executor: Entity, arguments: table)
--- @param name string Name of the command
--- @param permission string
--- @param arguments table
function controllerClass:command(callback, name, permission, arguments)
end

--- Registers permission
--- @param permission string
function controllerClass:registerPermission(permission)
end