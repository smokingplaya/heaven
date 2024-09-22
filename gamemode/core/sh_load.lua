heaven = heaven or {
  authors = {"smokingplaya"},
  repository = "https://github.com/smokingplaya/heaven"
}

log.info("🚀 Heaven framework is loading...")

// Loading loader library
IncludeCS("libraries/library.lua")
IncludeCS("libraries/loader.lua")

// That's the order in which it should be loaded
loader.loadShared("libraries/utils.lua")
loader.loadShared("libraries/log.lua")
loader.loadShared("libraries/language.lua")

// Other libraries
loader.loadShared("libraries/metamap.lua")

// System: Controller, Service
loader.loadShared("libraries/systems/system.lua")
loader.loadShared("libraries/systems/controller.lua")
loader.loadShared("libraries/systems/service.lua")
// HTTP
loader.loadShared("libraries/web/lib.lua")

systems.load()