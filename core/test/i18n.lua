local Hub = require("aurcore.core.hub")
local Test = Hub:get_test()
local I18n = Hub:get_i18n()

-- 测试用例
local testI18n = {_name_ = "testI18n"}

-- 在每个测试前执行，用于设置测试环境
-- 如果有需要，可以在这里初始化一些数据或状态
function testI18n:setUp()
end

-- 在每个测试后执行，用于清理测试环境
-- 如果有需要，可以在这里清理或重置状态
function testI18n:tearDown()
end

function testI18n:test1()
    -- 测试合法语言更改
    local oldLang = I18n:get_language()
    if oldLang == "zh" then
        I18n:set_language("en")
        I18n = Hub:get_i18n()
        Test:equals(I18n:get_language(), "en")
    else
        I18n:set_language("zh")
        I18n = Hub:get_i18n()
        Test:equals(I18n:get_language(), "zh")
    end
    I18n:set_language(oldLang)
    I18n = Hub:get_i18n()
end

function testI18n:test5()
    -- 测试合法错误文本打印
    local oldLang = I18n:get_language()
    I18n:set_language("zh")
    I18n = Hub:get_i18n()
    Test:equals(I18n.error_msg.test_msg("hihi"), "这是一个测试信息：hihi。")
    I18n:set_language(oldLang)
    I18n = Hub:get_i18n()
end

return testI18n
