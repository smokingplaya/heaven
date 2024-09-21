---@class BaseConfigService: Service
local service = service.new()

---@class ConfigStruct
---@field hostname string
---@field maxplayers number

---@async
function service:fetchConfig()
  log.debug("Fetching server config")
  self:fetch(function(response)
    if (response:isError()) then
      return response:logError("Unable to fetch config (%s): %s")
    end

    ---@type ConfigStruct
    ---@diagnostic disable-next-line: assign-type-mismatch
    local config = response:getBody()

    self:applyConfig(config)
  end, "server")
end

local fieldHandlers = {
  hostname = function(value)
    RunConsoleCommand("hostname", value)
  end,
  maxplayers = function(value)
    RunConsoleCommand("maxplayers", value)
  end
}

---@private
---@param config ConfigStruct
function service:applyConfig(config)
  for field, value in pairs(config) do
    local handler = fieldHandlers[field]

    if (!handler) then
      return log.warn("No handler for config field \"" .. field .. "\"")
    end

    handler(value)
  end
end

return service