local hub = require("aurcore.core.hub")
local get_error_message_table = require("aurcore.lib.i18n.error_msg")
local LanguageManager = require("aurcore.lib.i18n.language")
---@class i18nAdapter:Class
local i18n = hub:new_class("i18n")
local language_init
i18n:on_init(function (instance, config)
    i18n.error_msg = get_error_message_table()
    if not language_init then
        i18n:set_class_method("language_init", true)
        LanguageManager:set_language(config.currentLanguage)
        language_init = true
    else

    end
end)

i18n:mixin(LanguageManager)

return i18n