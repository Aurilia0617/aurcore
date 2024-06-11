--- @class I18nClass
local i18n_class_interface = {}

--- 创建新的I18n实例
--- @param config table 配置表
--- @return I18n 新创建的I18n实例
function i18n_class_interface:new(config) return {} end

--- @class I18n : ErrorMessages, LanguageManager
local i18n_interface = {}

--- 获取错误信息
--- @param key string 错误信息的键
--- @param ... any 传递给错误信息的参数
function i18n_interface:error_msg(key, ...) end

--- 设置当前语言
--- @param lang string 语言代码
function i18n_interface:set_language(lang) end

--- 获取当前语言
--- @return string 当前语言代码
function i18n_interface:get_language() return "" end

--- 获取支持的语言列表
--- @return table 支持的语言列表
function i18n_interface:get_supported_languages() return {} end

return {
    i18nClassInterface = i18n_class_interface,
    i18nInterface = i18n_interface
}
