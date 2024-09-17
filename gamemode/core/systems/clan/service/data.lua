---@class ClanServiceData: Service
local service = service.new()

---@class ClanServiceDataProfile
---@field username string

--- todo
---@async
---@param steamid string
function service:loadProfile(steamid)
  self:fetch(function(response)
    if (response:isError()) then
      return response:logError()
    end

    ---@type ClanServiceDataProfile
    ---@diagnostic disable-next-line: assign-type-mismatch
    local body = response:getBody()
    print("Here is body", body)
  end, "clan/profile", "GET", {
    id = steamid
  })
end

return service