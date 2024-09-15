---@class ServiceInitializator
service = {}

---@class Service
local serviceClass = {}
serviceClass.__index = serviceClass

RegisterMetaTable("Service", serviceClass)

---@return Service
function service.new()
  return setmetatable({}, serviceClass)
end