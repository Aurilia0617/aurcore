local Test = require("aurcore.core.utils.unit_test.init")
local Types = require("aurcore.types.init")
local UITexts = require("aurcore.core.utils.i18n.ui_texts")
local Language = require("aurcore.core.utils.i18n.language")
local ErrorMsg = require("aurcore.core.utils.i18n.error_msg")
local TimeFormat = require("aurcore.core.utils.i18n.date_time_formats")

-- 测试用例
local testI18n = Types.obj:new("testI18n")

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
    local oldLang = Language:get_language()
    if oldLang == "zh" then
        Language:set_language("en")
        Test:equals(Language:get_language(), "en")
    else
        Language:set_language("zh")
        Test:equals(Language:get_language(), "zh")
    end
    Language:set_language(oldLang)
end

function testI18n:test2()
    -- 测试不合法语言更改
    local oldLang = Language:get_language()
    Test:error_contains("Unsupported language code 'hihi'", function() Language:set_language("hihi") end)
    Language:set_language(oldLang)
end

function testI18n:test3()
    -- 测试合法UI文本打印
    local oldLang = Language:get_language()
    Language:set_language("zh")
    Test:equals(UITexts:get_ui_text("test", "hihi"), "这是一个测试信息：hihi")
    Language:set_language(oldLang)
end

function testI18n:test4()
    -- 测试不合法UI文本打印
    Test:error_contains("Unknown text key: __noExistTest", function() UITexts:get_ui_text("__noExistTest") end)
end

function testI18n:test5()
    -- 测试合法错误文本打印
    local oldLang = Language:get_language()
    Language:set_language("zh")
    Test:equals(ErrorMsg:get_error_message("test", "hihi"), "这是一个测试信息：hihi")
    Language:set_language(oldLang)
end

function testI18n:test6()
    -- 测试不合法错误文本打印
    Test:error_contains("Unknown error key: __noExistTest",
        function() ErrorMsg:get_error_message("__noExistTest") end)
end

function testI18n:test7()
    -- 测试合法日期文本打印
    local oldLang = Language:get_language()
    Language:set_language("zh")
    Test:equals(TimeFormat:get_date_format(), "%Y年%m月%d日")
    Language:set_language(oldLang)
end

function testI18n:test8()
    -- 测试合法时间文本打印
    local oldLang = Language:get_language()
    Language:set_language("zh")
    Test:equals(TimeFormat:get_time_format(), "%H:%M")
    Language:set_language(oldLang)
end

function testI18n:test9()
    -- 测试合法日期加时间文本打印
    local oldLang = Language:get_language()
    Language:set_language("zh")
    Test:equals(TimeFormat:get_date_time_format(), "%Y年%m月%d日 %H:%M")
    Language:set_language(oldLang)
end

function testI18n:test10()
    -- 测试合法指定语言日期文本打印
    Test:equals(TimeFormat:get_date_format("de"), "%d.%m.%Y")
end

function testI18n:test11()
    -- 测试合法指定语言时间文本打印
    Test:equals(TimeFormat:get_time_format("de"), "%H:%M")
end

function testI18n:test12()
    -- 测试合法指定语言日期加时间文本打印
    Test:equals(TimeFormat:get_date_time_format("de"), "%d.%m.%Y %H:%M")
end

function testI18n:test13()
    -- 测试不合法日期文本打印
    Test:error_contains("Unknown language key: __noExistTest",
        function() TimeFormat:get_date_format("__noExistTest") end)
end

function testI18n:test14()
    -- 测试不合法时间文本打印
    Test:error_contains("Unknown language key: __noExistTest",
        function() TimeFormat:get_time_format("__noExistTest") end)
end

function testI18n:test15()
    -- 测试不合法日期加时间文本打印
    Test:error_contains("Unknown language key: __noExistTest",
        function() TimeFormat:get_date_time_format("__noExistTest") end)
end

return testI18n
