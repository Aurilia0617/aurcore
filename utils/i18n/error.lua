local Language = require("aurcore.utils.i18n.language")
local types = require("aurcore.hub"):get_types()

local errorMessages = {
    en = {
        test = "This is a test message: %s.",
        noFrameworks = "AurCore: No frameworks provided, use 'coromega' if no custom framework is needed.",
        invalidFrameworkTypeForNthFramework = "The %dth framework has an invalid framework type.",
        missingMethod = "Lacks the method: %s",
        incorrectKeyTypeForColorTable = "Incorrect key type, the color table key should be a string or numeric type",
        incorrectKeyTypeStringRequired = "Incorrect key type:%s, a string type is required.",
        incorrectKeyTypeTableRequired = "Incorrect key type:%s, a table type is required.",
        incorrectKeyTypeNumberRequired = "Incorrect key type:%s, a number type is required.",
        numberOutOfRange = "Number out of range, it should be between %d and %d.",
        keyDoesNotExist = "Key %s does not exist.",
        emptyParameter = "The parameter cannot be empty",
        notAFunction = "%s is not a function.",
    },
    zh = {
        test = "这是一个测试信息：%s",
        noFrameworks = "AurCore:未传入任何框架，若无自定义框架，可使用coromega",
        invalidFrameworkTypeForNthFramework = " 第 %d 个框架的框架类型不正确",
        missingMethod = "缺少方法: %s",
        keyDoesNotExist = "键 %s 不存在",
        emptyParameter = "参数不能为空",
        numberOutOfRange = "数字范围超出，应在 %d 至 %d 之间",
        incorrectKeyTypeStringRequired = "错误的键类型：%s，需要的是字符串类型",
        incorrectKeyTypeTableRequired = "错误的键类型：%s，需要的是表类型",
        incorrectKeyTypeNumberRequired = "错误的键类型：%s，需要的是数字类型",
        incorrectKeyTypeForColorTable = "错误的键类型:%s，颜色表键应为字符串或数字类型",
        notAFunction = "%s 不是一个函数",
    }
}

local ErrorMessages = types:new_obj("ErrorMessages")

function ErrorMessages:get_error_message(key, ...)
    local messages = errorMessages[Language:get_language()] or errorMessages.en -- 默认为英语
    local messageFormat = messages[key] or error("Unknown error key: " .. tostring(key))
    return string.format(messageFormat, ...)
end

return ErrorMessages
