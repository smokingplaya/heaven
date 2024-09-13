heaven = heaven or {
  authors = {"smokingplaya"},
  repository = "https://github.com/smokingplaya/heaven"
}

---@param path string
---@return ...
local function loadShared(path)
  if (SERVER) then
    AddCSLuaFile(path)
  end

  return include(path)
end

loadShared("libraries/library.lua")