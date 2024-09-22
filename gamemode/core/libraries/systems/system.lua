---@class SystemLibrary: Library
---@field items table<string, System>
systems = systems or {}
systems.items = systems.items or {}

---@class System
---@field name string Name of the system
---@field authors table<number, string>
---@field description string
---@field version string
---@field path string
local systemClass = {}
systemClass.__index = systemClass

RegisterMetaTable("System", systemClass)

---@param name string Name of the system
---@return System
function systems.new(name)
  local cached = systems.items[name]

  if (cached) then
    log.warn("Spotted an attempt to create an existing system (" .. name .. "), returning the system from the cache.")
    return cached
  end

  local system = setmetatable({
    name = name,
    authors = {},
    description = "No description provided",
    version = "1.0.0",
    path = debug.getinfo(2).short_src:GetPathFromFilename()
  }, systemClass)

  systems.items[name] = system

  return system
end

---@param path string
---@return System | nil
function systems.getByPath(path)
  for _, system in pairs(systems.items) do
    if (system.path:find(path)) then
      return system
    end
  end
end

local systemsFolder = GM.FolderName .. "/gamemode/core/systems/"
function systems.load()
  metamap.fs.getDirs(systemsFolder .. "*")
    :foreach(function(system)
      local path = systemsFolder .. system .. "/sh_init.lua"

      if (!file.Exists(path, "LUA")) then
        return logger.error("System '" .. system .. "' doesn't provide sh_init.lua file!")
      end

      loader.loadShared(path)
    end)
end
/// Metadata

--- Sets authors of the system
---@param ... string List of authors
---@return System
function systemClass:setAuthors(...)
  self.authors = {...}

  return self
end

--- Sets description of the system
---@param description string
---@return System
function systemClass:setDescription(description)
  self.description = description

  return self
end

--- Sets version of the system
---@param version string
---@return System
function systemClass:setVersion(version)
  self.version = version

  return self
end

/// Services

--- Do AddCSLuaFile relative to side
---@protected
---@param side ScriptSide
---@param servicePath string
---@return System
function systemClass:addService(side, servicePath)
  if ((side == "client" or side == "shared") and SERVER) then
    AddCSLuaFile(self.path .. servicePath)
  end

  return self
end

---@param servicePath string
---@return System
function systemClass:addClientService(servicePath)
  return self:addService("client", servicePath)
end

---@param servicePath string
---@return System
function systemClass:addSharedService(servicePath)
  return self:addService("shared", servicePath)
end

--- You shouldn't use this method - it doesn't do anything.
---@deprecated
---@param servicePath string
---@return System
function systemClass:addServerService(servicePath)
  return self
end

/// Controllers

local loaderSide = {
  client = loader.loadClient,
  shared = loader.loadShared,
  server = loader.loadServer
}

---@param side ScriptSide
---@param controllerPath string
---@return System
function systemClass:addController(side, controllerPath)
  local load = loaderSide[side]

  load(controllerPath)

  return self
end

---@param controllerPath string
---@return System
function systemClass:addClientController(controllerPath)
  return self:addController("client", controllerPath)
end

---@param controllerPath string
---@return System
function systemClass:addSharedController(controllerPath)
  return self:addController("shared", controllerPath)
end

---@param controllerPath string
---@return System
function systemClass:addServerController(controllerPath)
  return self:addController("server", controllerPath)
end