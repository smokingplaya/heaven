---@alias ScriptSide '"client"' | '"shared"' | '"server"'

---@class UtilsLibrary: Library
utils = heaven.lib:new("utils")
  :setAuthors("smokingplaya")

---@param value any
---@return boolean
local function isEmpty(value)
  if (type(value) == "string") then
    return #value == 0
  elseif (type(value) == "table") then
    return next(value) == nil
  end

  return false
end

-- todo: rewrite
if (!printBackup) then
  printBackup = print

  ---@param ... any
  function print(...)
    local args = {...}

    if (#args == 0) then
      return printBackup("nil value")
    end

    if (#args == 1 and (isEmpty(args[1]))) then
      return printBackup("empty " .. type(args[1]))
    end

    for _, value in ipairs(args) do
      if type(value) == "table" then
        PrintTable(value)
      else
        printBackup(value)
      end
    end
  end
end

--- Uses "require" lua function to load binary modules to server
---
--- ```lua
--- if (SERVER) then
---   util.loadBinaryModule("chttp")
--- end
--- ```
---@param name string Name of the binary module
function utils.loadBinaryModule(name)
  if (!util.IsBinaryModuleInstalled(name)) then
    log.error("Unable to find dynamic library \"" .. name .. "\"")
    return
  end

  require(name)
end