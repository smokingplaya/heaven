local system = systems.new("clan")
  :setAuthors({"smokingplaya"})
  :setDescription("A clan system")
  :setVersion("1.0")

system:addClientService("service/render.lua")
system:includeSharedController("controller/player")