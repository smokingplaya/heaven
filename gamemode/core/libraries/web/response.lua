---@class ResponseLibrary: Library
response = heaven.lib:new("response")

---@class Response
---@field url string
---@field code string | number reasonOrCode
---@field headers string
---@field body string
local responseClass = {}
responseClass.__index = responseClass

RegisterMetaTable("Response", responseClass)

--- Creates new instance of HTTP response
--- ```lua
--- local callback = function(response)
---   if (response:isError()) then
---     return response:logError()
---   end
--- end
---
--- local httpCallback = function(...)
---   callback(response.new(...))
--- end
---
--- HTTP(
---   url = "https://google.com",
---   method = "GET",
---   success = httpCallback,
---   failed = httpCallback
--- )
--- ```
---@private
---@param url string
---@param reasonOrCode string | number
---@param body string
---@param headers table
---@return Response
function response.new(
  url,
  reasonOrCode,
  body,
  headers
)
  return setmetatable({
    url = url,
    code = reasonOrCode,
    body = body,
    headers = headers
  }, responseClass)
end

/// Class methods

--- Is response status error
---@return boolean
function responseClass:isError()
  return type(self.code) == "string" or (self.code and self.code >= 400)
end

--- Returns the error string if there is an error
---@return string | nil
function responseClass:getError()
  ---@diagnostic disable-next-line: return-type-mismatch
  return (type(self.code) == "string" and self.code) or (self.code and self.code >= 400 and self:getRawBody())
end

--- Returns the body of the response without processing
---@return string
function responseClass:getRawBody()
  return self.body
end

--- Returns the body depending on the Content-Type header: application/json - returns table, any other - returns string
---@return string | table | nil
function responseClass:getBody()
  return
    self.headers["Content-Type"]:find("application/json")
    and util.JSONToTable(self.body)
    or self.body
    -- ;)
end

local defaultMessage = "An error occurred while executing an http request (%s): %s"
--- Prints an http response error using the log library. Does not block the thread
--- @param message? string
function responseClass:logError(message)
  log.error((message or defaultMessage):format(self.url, self:getError()))
end