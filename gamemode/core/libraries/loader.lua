---@class LoaderLibrary: Library
loader = heaven.lib:new("loader")
  :setAuthors({"smokingplaya"})

---@param filename string
---@return any ...
function loader.loadClient(filename)
  if (SERVER) then
    return AddCSLuaFile(filename)
  end

  return include(filename)
end

---@param filename string
---@return any ...
function loader.loadShared(filename)
  if (SERVER) then
    AddCSLuaFile(filename)
  end

  return include(filename)
end

---@param filename string
---@return any ...
function loader.loadServer(filename)
  if (SERVER) then
    include(filename)
  end
end