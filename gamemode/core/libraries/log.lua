--- Log library
--- The idea was taken from the rust crate log (https://docs.rs/log/latest/log/enum.Level.html)
---@class LogLibrary: Library
log = heaven.lib:new("log")

---@protected
function log.getTime()
  return os.date("%H:%M:%S %d.%m.%Y", os.time())
end

---@protected
---@param level string
---@param message string
function log.message(level, message)
  MsgC("[" .. log.getTime() .. " " .. level .. "] ", message, "\n")
end

--- Low-priority information, often verbose.
---@param message string
function log.trace(message)
  log.message("TRACE", message)
end

--- Low-priority information
---@param message string
function log.debug(message)
  log.message("DEBUG", message)
end

--- Useful information
---@param message string
function log.info(message)
  log.message("INFO", message)
end

--- Indicates dangerous situations.
---@param message string
function log.warn(message)
  log.message("WARN", message)
end

--- Indicates very serious errors.
---@param message string
function log.error(message)
  log.message("ERROR", message)
end