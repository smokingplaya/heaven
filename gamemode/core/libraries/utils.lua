---@alias ScriptSide '"client"' | '"shared"' | '"server"'

---@class UtilsLibrary: Library
utils = heaven.lib:new("utils")
  :setAuthors({"smokingplaya"})

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

--- Pulls through the debug library the path to the file that calls the current function
---@deprecated
---@return string
function utils.getStackSource()
  local level = 1
  local caller;

  while (true) do
    local info = debug.getinfo(level)
    if (!info) then
      break
    end

    caller = info
    level = level+1
  end

  return caller.short_src
end