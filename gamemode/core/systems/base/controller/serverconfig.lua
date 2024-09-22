local controller = controller.new("baseconfig")
  :addService("serverconfig")

local services = controller.services
---@type ServerConfigService
---@diagnostic disable-next-line: assign-type-mismatch
local serverconfigService = services.serverconfig

serverconfigService:fetchConfig()