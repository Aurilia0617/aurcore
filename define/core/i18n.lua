--- @class I18nClass
local i18n_class_interface = {}

--- 创建新的I18n实例
--- @return I18n 新创建的I18n实例
function i18n_class_interface:new() return {} end

--- @class I18n 
--- @field error_msg ErrorMsg
local i18n_interface = {}

--- 设置当前语言
--- @param lang string 语言名称
function i18n_interface:set_language(lang) end

--- 获取当前语言
--- @return string 当前语言名称
function i18n_interface:get_language() return "" end

--- 获取支持的语言名列表
function i18n_interface:get_supported_languages()
    ---@type string[]
    local t =  {}
    return t
end

--- 错误信息
--- @type ErrorMsg
i18n_interface.error_msg = {}

--- 验证传入的语言是否被支持
--- @param lang string
--- @return boolean
function i18n_interface:is_language_supported(lang) return true end

return {
    i18n_class_interface = i18n_class_interface,
    i18n_interface = i18n_interface
}
