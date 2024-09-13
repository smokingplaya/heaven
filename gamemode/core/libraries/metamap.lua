--- Syntax sugar library
--- @class metamapLibrary: Library
metamap = heaven.lib:new("metamap")
  :setAuthors({
    key = "smokingplaya"
  })

---@class metamap
local metamap_mt = {}
metamap_mt.__index = metamap_mt

-- Makes table functional
---@param tab table
---@return metamap
function metamap.new(tab)
  return setmetatable(tab, metamap_mt)
end

--- Returns functional table with all players on the server
---@return metamap
function metamap.GetPlayers()
  return metamap.new(player.GetAll())
end

---Enumerates the entire numbered table and returns a pair of values in the callback arguments (see foreach in javascript)
---@param callback fun(v: any, k: number): boolean | nil
function metamap_mt:foreach(callback)
  for k, v in ipairs(self) do
    if (callback(v, k)) then
      break
    end
  end
end