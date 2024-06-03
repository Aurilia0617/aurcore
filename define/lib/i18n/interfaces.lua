---@class I18nClass
local i18nClassInterface = {}
---@class I18n:ErrorMessages, LanguageManager
local i18nInterface = {}

---@return I18n
---@param resource table
---@param logname string|nil
function i18nClassInterface:new(resource,logname) return {} end   -- new函数要可以接受初始化配置

---@param key string
---@param ... any
function i18nInterface:error(key,...) end

---@param lang string
function i18nInterface:set_language(lang) end
function i18nInterface:get_language() end
function i18nInterface:get_supported_languages() end

return i18nClassInterface