--- Syntax sugar library
--- @class MetamapLibrary: Library
metamap = heaven.lib:new("metamap")
  :setAuthors({"smokingplaya"})

---@class MetaMap
local metamapClass = {}
metamapClass.__index = metamapClass

-- Makes table functional
---@param tab table
---@return MetaMap
function metamap.new(tab)
  return setmetatable(tab, metamapClass)
end

--- Returns functional table with all players on the server
---@return MetaMap
function metamap.getPlayers()
  return metamap.new(player.GetAll())
end

---Enumerates the entire numbered table and returns a pair of values in the callback arguments (see foreach in javascript)
---@param callback fun(v: any, k: number): boolean | nil
function metamapClass:foreach(callback)
  for k, v in ipairs(self) do
    if (callback(v, k)) then
      break
    end
  end
end