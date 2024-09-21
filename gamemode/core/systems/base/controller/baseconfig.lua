local controller = controller.new("baseconfig")
  :addService("baseconfig")

local services = controller.services
---@type BaseConfigService
---@diagnostic disable-next-line: assign-type-mismatch
local baseconfigService = services.baseconfig

baseconfigService:fetchConfig()