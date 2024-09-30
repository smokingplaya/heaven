--- Syntax sugar library
--- @class MetamapLibrary: Library
metamap = heaven.lib:new("metamap")
  :setAuthors("smokingplaya")

---@class MetaMap<K, V>: {[K]: V}
local metamapClass = {}
metamapClass.__index = metamapClass

-- Makes table functional
---@generic K, V
---@param tab table<K, V>
---@return MetaMap<K, V>
function metamap.new(tab)
  return setmetatable(tab, metamapClass)
end

--- Returns functional table with all players on the server
---@return MetaMap<number, Player>
function metamap.getPlayers()
  return metamap.new(player.GetAll())
end

--- Allows you to interact with the file library
---@class MetamapFilesystem
metamap.fs = metamap.fs or {}

--- Returns numbered metamap with files
--- @param path string Path to folder
--- @param searchIn? string (https://wiki.facepunch.com/gmod/File_Search_Paths)
--- @return MetaMap<number, string> Files
function metamap.fs.getFiles(path, searchIn)
  local files = file.Find(path, searchIn or "LUA")

  return metamap.new(files)
end

--- Returns numbered metamap with directories
--- @param path string Path to folder
--- @param searchIn? string (https://wiki.facepunch.com/gmod/File_Search_Paths)
--- @return MetaMap<number, string> Directories
function metamap.fs.getDirs(path, searchIn)
  local _, dirs = file.Find(path, searchIn or "LUA")
  return metamap.new(dirs)
end

--- Returns numbered metamap with all childrens in folder
---@param path string Path to folder
---@param searchIn? string (https://wiki.facepunch.com/gmod/File_Search_Paths)
---@return MetaMap<number, string> Files, MetaMap<number, string> Directories
function metamap.fs.get(path, searchIn)
  local files, dirs = file.Find(path, searchIn or "LUA")
  return metamap.new(files), metamap.new(dirs)
end

function metamapClass:get(key)
  return self[key]
end

--- Enumerates the entire numbered table and returns a pair of values in the callback arguments (see foreach in javascript)
---@generic V
---@param callback fun(v: V, k: number): boolean | nil
function metamapClass:foreach(callback)
  for k, v in ipairs(self) do
    if (callback(v, k)) then
      break
    end
  end
end

--- Adds an element to the end of the metamap
---@generic V
---@param value V
function metamapClass:push(value)
  self[#self+1] = value
end

--- Removes the last element from the metamap and returns it.
---@generic V
---@return V
function metamapClass:pop()
  return table.remove(self, #self)
end

--- Is MetaMap contains element?
--- 0(n)
---@generic V
---@param value V
---@return boolean
function metamapClass:contains(value)
  for _, v in ipairs(self) do
    if (v == value) then
      return true
    end
  end

  return false
end