systems.new("base")
  :setAuthors({"smokingplaya"})
  :setDescription("Basic gamemode functionality.")
  :setVersion("1.0.0")

  // rbac
  :addSharedController("controller/rolemanager.lua")
  :addSharedService("service/rolemanager.lua")