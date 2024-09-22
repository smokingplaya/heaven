---@class LanguageLibrary: Library
lang = heaven.lib:new("lang")
  :setAuthors("smokingplaya")

---@private
---@type table<string, table<string, string>>
lang.items = {}

---
---@return string | nil
function lang:get(language, phrase)
  return self.items[language][phrase]
end

--- Registers the language table
---@param language string Name of language
---@param phrasesTable table<string, string>
function lang:register(language, phrasesTable)
  self.items[language] = phrasesTable
end

---@param language? string Name of language
---@return table | nil
function lang:getTable(language)
  return language and lang.items[language] or lang.items
end