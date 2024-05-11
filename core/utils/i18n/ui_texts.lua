local Language = require("aurcore.core.utils.i18n.language")
local Types = require("aurcore.types.init")
local uiTexts = {
    en = {
        test = "This is a test message: %s.",
        welcomeMessage = "Welcome to our app!",
        buttonLabel = "Click Me",
        errorMessage = "An error occurred: %s",
        successMessage = "Operation completed successfully!",
        exitConfirmation = "Are you sure you want to exit?",
        goodbyeMessage = "Thank you for using our app. Goodbye!"
    },
    zh = {
        test = "这是一个测试信息：%s",
        welcomeMessage = "欢迎来到我们的应用！",
        buttonLabel = "点击我",
        errorMessage = "发生错误：%s",
        successMessage = "操作成功完成！",
        exitConfirmation = "您确定要退出吗？",
        goodbyeMessage = "感谢您使用我们的应用。再见！"
    }
}

local function get_ui_text(key, ...)
    local texts = uiTexts[Language:get_language()] or uiTexts.en -- 默认为英语
    local textFormat = texts[key] or error("Unknown text key: " .. tostring(key))
    return string.format(textFormat, ...)
end

local UITexts = Types.obj:new("UITexts")

function UITexts:get_ui_text(key, ...)
    return get_ui_text(key, ...)
end

return UITexts
