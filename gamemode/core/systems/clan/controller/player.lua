local controller = controller.new()
  :addService("render")

local services = controller.services
local renderService = services.render

controller:hook("playerJoined", function(client)

end)

controller:command(function(executor, arguments)

end, "god", "player.god", {
  controller.command.argument.new("player", "Player", true)
})