local I18nLib = require("aurcore.utils.i18n.init")

--- 创建新的I18n实例
--- @param _ any 占位符参数
--- @param config table 配置表
--- @return I18n 新创建的I18n实例
local function new(_, config)
    local i18n = I18nLib:new(config)
    local adapter = {_name_ = "i18nAdapter"}

    --- 获取错误信息
    --- @param key string 错误信息的键
    --- @param ... any 传递给错误信息的参数
    --- @return string 错误信息
    function adapter:error_msg(key, ...)
        return i18n:get_error_message(key, ...)
    end

    --- 设置当前语言
    --- @param lang string 语言代码
    function adapter:set_language(lang)
        return i18n:set_language(lang)
    end

    --- 获取当前语言
    --- @return string 当前语言代码
    function adapter:get_language()
        return i18n:get_language()
    end

    --- 获取支持的语言列表
    --- @return table 支持的语言列表
    function adapter:get_supported_languages()
        return i18n:get_supported_languages()
    end

    return adapter
end

return {
    new = new
}
