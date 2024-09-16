heaven = heaven or {
  authors = {"smokingplaya"},
  repository = "https://github.com/smokingplaya/heaven"
}

// Loading loader library
IncludeCS("libraries/library.lua")
IncludeCS("libraries/loader.lua")

// Именно такой порядок загрузки должен быть
loader.loadShared("libraries/utils.lua")
loader.loadShared("libraries/log.lua")

log.info("🚀 Heaven is loading...")

// Other libraries
loader.loadShared("libraries/metamap.lua")

// System: Controller, Service
loader.loadShared("libraries/systems/system.lua")
loader.loadShared("libraries/systems/controller.lua")
loader.loadShared("libraries/systems/service.lua")
// HTTP
loader.loadShared("libraries/web/lib.lua")

systems.load()