---@class ControllerInitializator
controller = {}

---@class Controller
---@field services table<string, Service>
local controller_mt = {}
controller_mt.__index = controller_mt

function controller.new()
  return setmetatable({
    services = {},
  }, controller_mt)
end

---@param name string
function controller_mt:addService(name)
  if (self.services[name]) then
    return
  end

  self.services[name] = include()
end