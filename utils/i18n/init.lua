local types = require("aurcore.hub"):get_types()
local I18nClass = types:new_class("I18n")
local LanguageManager = require("aurcore.utils.i18n.language")

I18nClass:include(require("aurcore.utils.i18n.error"), LanguageManager)

function I18nClass:initialize(config)
    LanguageManager:set_language(config.currentLanguage)
end

return I18nClass