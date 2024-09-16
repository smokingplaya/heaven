---@class ClanServiceData: Service
local service = service.new()

---@class ClanServiceDataProfile

--- todo
---@async
---@param steamid string
function service:loadProfile(steamid)
  web.fetch(function(response)
    if (response:isError()) then
      response:logError()
    end

    ---@type ClanServiceDataProfile
    ---@diagnostic disable-next-line: assign-type-mismatch
    local body = response:getBody()
  end, "clan/profile", "GET", {
    id = steamid
  })
end

return service