---@class HttpLibrary: Library
web = heaven.lib:new("web")
---@private
web.baseUrl = "http://localhost:3000"

if (SERVER) then
  utils.loadBinaryModule("chttp")

  if (CHTTP) then
    HTTP = CHTTP
  end
end

loader.loadShared("response.lua")

---@private
---@param query table<string | number>
---@return string
function web.convertQuery(query)
  local result = {}

  for key, value in pairs(query) do
    result[#result+1] = key .. "=" .. tostring(value)
  end

  return table.concat(result, "&")
end

--- Sends request to url
---@param callback fun(response: Response)
---@param url string
---@param method? string
---@param query? table<string, string | number>
function web.fetch(callback, url, method, query)
  local callback = function(...)
    callback(response.new(url, ...))
  end

  if (query) then
    url = url .. "?" .. web.convertQuery(query)
  end

  HTTP({
    url = url,
    method = method or "GET",
    success = callback,
    failed = callback
  })
end

--- Sets base url for service's HTTP requests
---@param url string BaseUrl
function web:setBaseUrl(url)
  self.baseUrl = url
end