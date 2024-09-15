local system = systems.new("clan")
  :setAuthors({"smokingplaya"})
  :setDescription("A clan system")
  :setVersion("1.0.0")

system:addClientService("service/render")
system:addClientController("controller/player")