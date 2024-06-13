local Hub = require("aurcore.hub")
local LanguageManager = require("aurcore.utils.i18n.language")
local ErrorMessages = require("aurcore.utils.i18n.error")
local TextMessages = require("aurcore.utils.i18n.text")

local I18nClass = Hub:new_class("I18n")

--- 初始化 I18n 类
--- @param config table 配置表，包含 currentLanguage 等配置项
I18nClass:init(function (instance, config)
    LanguageManager:set_language(config.currentLanguage)
end)

--- 集成错误处理和语言管理
I18nClass:include(ErrorMessages, LanguageManager, TextMessages)

return I18nClass
