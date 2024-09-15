local controller = controller.new("player")
  :addService("render")

local services = controller.services
---@type RenderService
---@diagnostic disable-next-line: assign-type-mismatch
local renderService = services.render

controller:hook("playerJoined", function(client)
  log.trace(client:GetName() .. " joined to the server")
end)

controller:command(function(executor, arguments)

end, "god", "player.god", {
  -- controller.command.argument.new("player", "Player", true)
})