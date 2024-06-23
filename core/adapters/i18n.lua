local hub = require("aurcore.core.hub")
local get_error_message_table = require("aurcore.lib.i18n.error_msg")
local LanguageManager = require("aurcore.lib.i18n.language")
---@class NI_I18n:Class
local i18n = hub:new_class("i18n")
local language_init
i18n:on_init(function (instance, config)
    i18n.error_msg = get_error_message_table()
    if not language_init then
        LanguageManager:set_language(config.currentLanguage)
        language_init = true
    end
end)

i18n:mixin(LanguageManager)

return i18n