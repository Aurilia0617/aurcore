local Hub = require("aurcore.core.hub")
local Test = Hub:get_adapter("test")
local I18n = Hub:get_i18n()
local Color = Hub:get_adapter("color")

-- 测试用例
local testColor = {_name_ = "testColor"}

-- 在每个测试前执行，用于设置测试环境
-- 如果有需要，可以在这里初始化一些数据或状态
function testColor:setUp()
end

-- 在每个测试后执行，用于清理测试环境
-- 如果有需要，可以在这里清理或重置状态
function testColor:tearDown()
end

function testColor:test1()
    -- 输入数字合法
    Test:equals(type(Color.get_fg_color(testColor, 1)), "string")
    Test:equals(type(Color.get_fg_color(testColor, "1")), "string")
    Test:equals(type(Color.get_bg_color(testColor, 1)), "string")
    Test:equals(type(Color.get_bg_color(testColor, "1")), "string")
end

function testColor:test2()
    -- 输入规定字符串合法
    Test:equals(type(Color.get_fg_color(testColor, "black")), "string")
    Test:equals(type(Color.get_fg_color(testColor, "BLACK")), "string")
    Test:equals(type(Color.get_bg_color(testColor, "black")), "string")
    Test:equals(type(Color.get_bg_color(testColor, "BLACK")), "string")
    Test:equals(type(Color.get_color(testColor, "reset")), "string")
end

function testColor:test3()
    -- 输入非规定字符串报错
    Test:error_contains(function ()
        Color.get_fg_color(testColor, "hihi")
    end, I18n.error_msg.key_not_exist("hihi"))
    Test:error_contains(function ()
        Color.get_bg_color(testColor, "hihi")
    end, I18n.error_msg.key_not_exist("hihi"))
    Test:error_contains(function ()
        Color.get_color(testColor, "hihi")
    end, I18n.error_msg.key_not_exist("hihi"))
end

function testColor:test4()
    -- 输入负数数字报错
    Test:error_contains(function ()
        Color.get_fg_color(testColor, -1)
    end, I18n.error_msg.invalid_range(0,255))
    Test:error_contains(function ()
        Color.get_bg_color(testColor, -1)
    end, I18n.error_msg.invalid_range(0,255))
end

function testColor:test5()
    -- 输入超限正数报错
    Test:error_contains(function ()
        Color.get_fg_color(testColor, 256)
    end, I18n.error_msg.invalid_range(0,255))
    Test:error_contains(function ()
        Color.get_bg_color(testColor, 256)
    end, I18n.error_msg.invalid_range(0,255))
end

return testColor
