local Types = require("aurcore.types.init")
local i18nInterface = Types.class:new("i18nInterface")

function i18nInterface:get_error_message()
    error("The i18n module is missing the get_error_message function.")
end

return i18nInterface