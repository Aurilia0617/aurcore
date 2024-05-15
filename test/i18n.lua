local Hub = require("aurcore.hub")
local Test = Hub:get_test_lib()
local I18n = Hub:get_i18n()
local types = Hub:get_types()

-- 测试用例
local testI18n = types:new_obj("testI18n")

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
        Test:equals(I18n:get_language(), "en")
    else
        I18n:set_language("zh")
        Test:equals(I18n:get_language(), "zh")
    end
    I18n:set_language(oldLang)
end

function testI18n:test2()
    -- 测试不合法语言更改
    local oldLang = I18n:get_language()
    Test:error_contains("Unsupported language code 'hihi'", function() I18n:set_language("hihi") end)
    I18n:set_language(oldLang)
end

function testI18n:test5()
    -- 测试合法错误文本打印
    local oldLang = I18n:get_language()
    I18n:set_language("zh")
    Test:equals(I18n:error("test", "hihi"), "这是一个测试信息：hihi")
    I18n:set_language(oldLang)
end

function testI18n:test6()
    -- 测试不合法错误文本打印
    Test:error_contains("Unknown error key: __noExistTest",
        function() I18n:error("__noExistTest") end)
end

return testI18n
