--- Syntax sugar library
--- @class MetamapLibrary: Library
metamap = heaven.lib:new("metamap")
  :setAuthors("smokingplaya")

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

--- Allows you to interact with the file library
---@class MetamapFilesystem
metamap.fs = metamap.fs or {}

--- Returns numbered metamap with files
--- @param path string Path to folder
--- @param searchIn? string (https://wiki.facepunch.com/gmod/File_Search_Paths)
--- @return MetaMap Files
function metamap.fs.getFiles(path, searchIn)
  local files = file.Find(path, searchIn or "LUA")
  return metamap.new(files)
end

--- Returns numbered metamap with directories
--- @param path string Path to folder
--- @param searchIn? string (https://wiki.facepunch.com/gmod/File_Search_Paths)
--- @return MetaMap Directories
function metamap.fs.getDirs(path, searchIn)
  local _, dirs = file.Find(path, searchIn or "LUA")
  return metamap.new(dirs)
end

--- Returns numbered metamap with all childrens in folder
--- @param path string Path to folder
--- @param searchIn? string (https://wiki.facepunch.com/gmod/File_Search_Paths)
--- @return MetaMap Files, MetaMap Directories
function metamap.fs.get(path, searchIn)
  local files, dirs = file.Find(path, searchIn or "LUA")
  return metamap.new(files), metamap.new(dirs)
end

--- Enumerates the entire numbered table and returns a pair of values in the callback arguments (see foreach in javascript)
---@param callback fun(v: any, k: number): boolean | nil
function metamapClass:foreach(callback)
  for k, v in ipairs(self) do
    if (callback(v, k)) then
      break
    end
  end
end

--- Adds an element to the end of the metamap
---@param value any
function metamapClass:push(value)
  self[#self+1] = value
end

--- Removes the last element from the metamap and returns it.
--- @return any
function metamapClass:pop()
  return table.remove(self, #self)
end


---@param value any
---@return boolean
function metamapClass:contains(value)
  for _, v in ipairs(self) do
    if (v == value) then
      return true
    end
  end

  return false
end