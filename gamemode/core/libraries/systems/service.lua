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

--- Sends request to url
---@param callback fun(response: Response)
---@param url string
---@param method? string
---@param query? table<string, string | number>
function serviceClass:fetch(callback, url, method, query)
  web.fetch(callback, web.baseUrl .. "/" .. url, method, query)
end