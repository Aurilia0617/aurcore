local Types = require("aurcore.types.init")
local I18nClass = Types:new_class("I18n")
local LanguageManager = require("aurcore.core.utils.i18n.language")
I18nClass:include(require("aurcore.core.utils.i18n.error"), LanguageManager)

function I18nClass:initialize(config)
    LanguageManager:set_language(config.currentLanguage)
end

--- @class I18nClass:ErrorMessages, LanguageManager
return I18nClass