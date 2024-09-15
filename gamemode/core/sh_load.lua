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

// Именно такой порядок загрузки должен быть
loadShared("libraries/library.lua")
loadShared("libraries/util.lua")
loadShared("libraries/log.lua")

// Остальные либы
loadShared("libraries/metamap.lua")