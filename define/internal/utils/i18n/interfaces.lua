local check_method = require("aurcore.define.check")

---@class I18nClass
local i18nClassInterface = {}
---@class I18n
local i18nInterface = {}

function i18nClassInterface:new() end   -- new函数要可以接受初始化配置
function i18nInterface:error() end
function i18nInterface:set_language() end
function i18nInterface:get_language() end
function i18nInterface:get_supported_languages() end

return function (i18nLib)
    check_method(i18nLib,i18nClassInterface)
    check_method(i18nLib:new({currentLanguage = "en"}),i18nInterface)
    return i18nLib
end