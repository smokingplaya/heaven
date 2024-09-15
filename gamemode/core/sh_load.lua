heaven = heaven or {
  authors = {"smokingplaya"},
  repository = "https://github.com/smokingplaya/heaven"
}

// Loading loader library
IncludeCS("libraries/library.lua")
IncludeCS("libraries/loader.lua")

// Именно такой порядок загрузки должен быть
loader.loadShared("libraries/util.lua")
loader.loadShared("libraries/log.lua")

// Other libraries
loader.loadShared("libraries/metamap.lua")

// System: Controller, Service
loader.loadShared("libraries/systems/system.lua")
loader.loadShared("libraries/systems/controller.lua")
loader.loadShared("libraries/systems/service.lua")