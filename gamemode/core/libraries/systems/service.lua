---@class ServiceInitializator
service = {}

---@class Service
local service_mt = {}
service_mt.__index = service_mt

RegisterMetaTable("Service", service_mt)

---@return Service
function service.new()
  return setmetatable({}, service_mt)
end