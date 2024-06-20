local Language = require("aurcore.lib.i18n.language")

local errorMessages = {
    ---@class ErrorMsg
    en = {
        test_msg = "This is a test message: %s.",
        framework_not_exist = "AurCore: No frameworks provided, use 'coromega' if no custom framework is needed.",
        method_not_exist = "Method not found: %s.",
        key_not_exist = "The key %s does not exist.",
        lock_key_not_exist = "The lock key %s does not exist.",
        invalid_type_for_framework = "Invalid type for framework at position %d.",
        invalid_type_for_color = "Invalid key type: the color table key should be a string or numeric type.",
        invalid_range = "Number out of range, it should be between %d and %d.",
        invalid_parameter = "Parameter cannot be empty.",
        incorrect_type_string = "Invalid key type: %s, a string type is required.",
        incorrect_type_table = "Invalid key type: %s, a table type is required.",
        incorrect_type_number = "Invalid key type: %s, a numeric type is required.",
        incorrect_type_function = "Invalid key type: %s, a function type is required.",
        incorrect_version = "Incompatible library version, required version is %s, current version is %s.",
        not_initialized = "Not initialized:%s"
    },
    zh = {
        test_msg = "这是一个测试信息：%s。",
        framework_not_exist = "AurCore: 未提供任何框架，若无自定义框架，请使用 'coromega'。",
        method_not_exist = "方法未找到：%s。",
        key_not_exist = "键 %s 不存在。",
        lock_key_not_exist = "锁键 %s 不存在。",
        invalid_type_for_framework = "第 %d 个框架的类型无效。",
        invalid_type_for_color = "无效的键类型：颜色表键应为字符串或数字类型。",
        invalid_range = "数字超出范围，应在 %d 到 %d 之间。",
        invalid_parameter = "参数不能为空。",
        incorrect_type_string = "无效的键类型：%s，需要的是字符串类型。",
        incorrect_type_table = "无效的键类型：%s，需要的是表类型。",
        incorrect_type_number = "无效的键类型：%s，需要的是数字类型。",
        incorrect_type_function = "无效的键类型：%s，需要的是函数类型。",
        incorrect_version = "不兼容的库版本, 所需版本为 %s, 当前版本为 %s。",
        not_initialized = "未初始化:%s"
    }
}

local function get_error_message_table()
    local currentLanguage = Language:get_language()
    return errorMessages[currentLanguage] or errorMessages.en -- 默认为英语
end

local function create_message_handler(messages)
    return setmetatable({}, {
        __index = function(_, key)
            local message = messages[key]
            if not message then
                error(string.format("Error message key '%s' not found", key))
            end
            return setmetatable({}, {
                __call = function(_, ...)
                    return string.format(message, ...)
                end,
                __tostring = function()
                    return message
                end
            })
        end
    })
end

return function ()
    return create_message_handler(get_error_message_table())
end
