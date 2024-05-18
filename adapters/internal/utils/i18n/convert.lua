local types = require("aurcore.hub"):get_types()
local I18nLib = require("aurcore.utils.i18n.init")

local function new(_, config)
    local i18n = I18nLib:new(config)
    local converter = types:new_obj("i18n")

    function converter:error(key, ...)
        return i18n:get_error_message(key, ...)
    end
    function converter:set_language(lang)
        return i18n:set_language(lang)
    end
    function converter:get_language()
        return i18n:get_language()
    end
    function converter:get_supported_languages()
        return i18n:get_supported_languages()
    end
    return converter
end

return {
    new = new
}
