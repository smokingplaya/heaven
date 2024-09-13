local library = {}
library.__index = library

RegisterMetaTable("Library", library)

---@class Library
---@field name string

heaven.lib = heaven.lib or {}
---@type table<string, Library | nil>
heaven.lib.items = heaven.lib.items or {}

---@param name string
---@return Library
function heaven.lib:new(name)
  local lib = setmetatable({
    name = name
  }, library)

  self.items[name] = lib

  return lib
end

---@param name string
---@return Library | nil
function heaven.lib:get(name)
  return self.items[name]
end