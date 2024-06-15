local Language = require("aurcore.utils.i18n.language")

local textMessages = {
    en = {
        test_msg = "This is a test message: %s.",
        ac_collaborator_initialized = "AurCore Collaboration Center initialization completed.",
        ac_collaborator_add_plugin = "Collaboration Center plugin added: %s"
    },
    zh = {
        test_msg = "这是一个测试信息：%s。",
        ac_collaborator_initialized = "AC库协作中心初始化已完成",
        ac_collaborator_add_plugin = "协作中心已加入插件：%s"
    }
}


--- @class TextMessages
local TextMessages = {}

--- 获取错误消息
--- @param key string 错误消息的键
--- @param ... any 可变参数，用于格式化消息
--- @return string 格式化后的错误消息
function TextMessages:get_text_message(key, ...)
    local currentLanguage = Language:get_language()
    local messages = textMessages[currentLanguage] or textMessages.en -- 默认为英语
    local messageFormat = messages[key]

    if not messageFormat then
        error(string.format("Unknown error key: '%s'.", tostring(key)))
    end

    return string.format(messageFormat, ...)
end

return TextMessages
