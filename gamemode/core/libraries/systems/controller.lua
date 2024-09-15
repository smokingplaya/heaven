---@class ControllerInitializator
controller = {}

---@class Controller
---@field name string
---@field services table<string, Service>
local controllerClass = {
  aliasesHook = {
    playerJoin = "PlayerInitialSpawn"
  }
}
controllerClass.__index = controllerClass

RegisterMetaTable("Controller", controllerClass)

---@param name string
---@return Controller
function controller.new(name)
  return setmetatable({
    name = name,
    services = {},
  }, controllerClass)
end

/// Services

---@param name string
---@return Controller
function controllerClass:addService(name)
  if (self.services[name]) then
    return self
  end

  // todo @
  self.services[name] = include("")

  return self
end

/// Hooks

---@private
---@param name string
function controllerClass:getHookName(name)
  return self.aliasesHook[name] or name
end

---@private
---@param name string
function controllerClass:getHookId(name)
  return self.name + ":" + name
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