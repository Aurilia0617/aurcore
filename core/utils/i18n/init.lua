local Types = require("aurcore.types.init")

local I18nClass = Types.class:new("I18n")
I18nClass:include(require("aurcore.core.utils.i18n.date_time_formats"),
    require("aurcore.core.utils.i18n.error_msg"), require("aurcore.core.utils.i18n.ui_texts"),
    require("aurcore.core.utils.i18n.language"))

return I18nClass:new()
