local Language = require("aurcore.utils.i18n.language")

local errorMessages = {
    en = {
        test_msg = "This is a test message: %s.",
        framework_not_exist = "AurCore: No frameworks provided, use 'coromega' if no custom framework is needed.",
        method_not_exist = "Method not found: %s.",
        key_not_exist = "The key %s does not exist.",
        invalid_type_for_framework = "Invalid type for framework at position %d.",
        invalid_type_for_color = "Invalid key type: the color table key should be a string or numeric type.",
        invalid_range = "Number out of range, it should be between %d and %d.",
        invalid_parameter = "Parameter cannot be empty.",
        incorrect_type_string = "Invalid key type: %s, a string type is required.",
        incorrect_type_table = "Invalid key type: %s, a table type is required.",
        incorrect_type_number = "Invalid key type: %s, a numeric type is required.",
        incorrect_type_function = "Invalid key type: %s, a function type is required.",
    },
    zh = {
        test_msg = "这是一个测试信息：%s。",
        framework_not_exist = "AurCore: 未提供任何框架，若无自定义框架，请使用 'coromega'。",
        method_not_exist = "方法未找到：%s。",
        key_not_exist = "键 %s 不存在。",
        invalid_type_for_framework = "第 %d 个框架的类型无效。",
        invalid_type_for_color = "无效的键类型：颜色表键应为字符串或数字类型。",
        invalid_range = "数字超出范围，应在 %d 到 %d 之间。",
        invalid_parameter = "参数不能为空。",
        incorrect_type_string = "无效的键类型：%s，需要的是字符串类型。",
        incorrect_type_table = "无效的键类型：%s，需要的是表类型。",
        incorrect_type_number = "无效的键类型：%s，需要的是数字类型。",
        incorrect_type_function = "无效的键类型：%s，需要的是函数类型。",
    }
}


--- @class ErrorMessages
local ErrorMessages = {}

--- 获取错误消息
--- @param key string 错误消息的键
--- @param ... any 可变参数，用于格式化消息
--- @return string 格式化后的错误消息
function ErrorMessages:get_error_message(key, ...)
    local currentLanguage = Language:get_language()
    local messages = errorMessages[currentLanguage] or errorMessages.en -- 默认为英语
    local messageFormat = messages[key]

    if not messageFormat then
        error(string.format("Unknown error key: '%s'.", tostring(key)))
    end

    return string.format(messageFormat, ...)
end

return ErrorMessages
