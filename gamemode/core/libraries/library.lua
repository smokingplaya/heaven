---@class Library
---@field name string
---@field authors table<number, string>
local library = {}
library.__index = library

---@param ... string List of authors
---@return Library
function library:setAuthors(...)
  self.authors = {...};

  return self
end

RegisterMetaTable("Library", library)

heaven.lib = heaven.lib or {}
---@type table<string, Library | nil>
heaven.lib.items = heaven.lib.items or {}

---@param name string
---@return Library
function heaven.lib:new(name)
  local lib = setmetatable({
    name = name,
    authors = {}
  }, library)

  self.items[name] = lib

  return lib
end

---@param name string
---@return Library | nil
function heaven.lib:get(name)
  return self.items[name]
end