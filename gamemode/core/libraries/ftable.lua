--- Syntax sugar library
--- @class ftableLibrary: Library
ftable = heaven.lib:new("ftable")

---@class ftable
local ftable_mt = {}
ftable_mt.__index = tab

---@param tab table
---@return ftable
function ftable.new(tab)
  return setmetatable(tab, ftable)
end

---Enumerates the entire numbered table and returns a pair of values in the callback arguments (see foreach in javascript)
---@param callback fun(v: any, k: number): boolean | nil
function ftable_mt:foreach(callback)
  for k, v in ipairs(self) do
    if (callback(v, k)) then
      break
    end
  end
end