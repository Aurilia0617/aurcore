local I18nClass = require("aurcore.hub"):new_class("I18n")
local LanguageManager = require("aurcore.lib.i18n.language")

I18nClass:include(require("aurcore.lib.i18n.error"), LanguageManager)

I18nClass:init(function (_,config)
    LanguageManager:set_language(config.currentLanguage)
end)

return I18nClass