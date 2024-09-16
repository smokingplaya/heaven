/// This is just test service

local system = systems.new("clan")
  :setAuthors({"smokingplaya"})
  :setDescription("A clan system")
  :setVersion("1.0.0")

  :addClientService("service/render.lua")
  :addClientController("controller/player.lua")

  :addServerController("controller/data.lua")