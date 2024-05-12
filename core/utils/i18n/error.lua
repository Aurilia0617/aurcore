local Language = require("aurcore.core.utils.i18n.language")
local Types = require("aurcore.types.init")

local errorMessages = {
    en = {
        test = "This is a test message: %s.",
        noFrameworks = "AurCore: No frameworks provided, use 'coromega' if no custom framework is needed.",
        invalidFrameworkTypeForNthFramework = "The %dth framework has an invalid framework type.",
        missingMethod = "Lacks the method: %s",
        notAFunction = "%s is not a function.",
    },
    zh = {
        test = "这是一个测试信息：%s",
        noFrameworks = "AurCore:未传入任何框架，若无自定义框架，可使用coromega",
        invalidFrameworkTypeForNthFramework = " 第 %d 个框架的框架类型不正确",
        missingMethod = "缺少方法: %s",
        notAFunction = "%s 不是一个函数",
    }
}

--- @class ErrorMessages
local ErrorMessages = Types:new_obj("ErrorMessages")

function ErrorMessages:get_error_message(key, ...)
    local messages = errorMessages[Language:get_language()] or errorMessages.en -- 默认为英语
    local messageFormat = messages[key] or error("Unknown error key: " .. tostring(key))
    return string.format(messageFormat, ...)
end

return ErrorMessages
