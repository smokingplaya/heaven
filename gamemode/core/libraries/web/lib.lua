---@class HttpLibrary: Library
web = heaven.lib:new("web")

if (SERVER) then
  utils.loadBinaryModule("chttp")

  if (CHTTP) then
    HTTP = CHTTP
  end
end

loader.loadShared("response.lua")

--- Sends request to url
---@param callback fun(response: Response)
---@param url string
---@param method? string
---@param query? table<string, string | number>
function web.fetch(callback, url, method, query)
  local callback = function(...)
    callback(response.new(...))
  end

  HTTP({
    url = url,
    method = method or "GET",
    success = callback,
    failed = callback
  })
end