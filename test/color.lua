local Hub = require("aurcore.hub")
local Test = Hub:get_test_lib()
local I18n = Hub:get_i18n()
local types = Hub:get_types()
local Color = require("aurcore.core.wrapper.mixin.color")

-- 测试用例
local testColor = types:new_obj("testI18n")

-- 在每个测试前执行，用于设置测试环境
-- 如果有需要，可以在这里初始化一些数据或状态
function testColor:setUp()
    -- 伪造一个mixin_color前置资源
    function self:_get_resource()
        return {
            get_color = function(_)
                return Hub:get_color()
            end
        }
    end
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
    Test:error_contains(I18n:error("keyDoesNotExist","hihi"), function ()
        Color.get_fg_color(testColor, "hihi")
    end)
    Test:error_contains(I18n:error("keyDoesNotExist","hihi"), function ()
        Color.get_bg_color(testColor, "hihi")
    end)
    Test:error_contains(I18n:error("keyDoesNotExist","hihi"), function ()
        Color.get_color(testColor, "hihi")
    end)
end

function testColor:test4()
    -- 输入非字符串非数字报错
    Test:error_contains(I18n:error("incorrectKeyTypeForColorTable"), function ()
        Color.get_fg_color(testColor, {})
    end)
    Test:error_contains(I18n:error("incorrectKeyTypeForColorTable"), function ()
        Color.get_bg_color(testColor, {})
    end)
end

function testColor:test5()
    -- 输入负数数字报错
    Test:error_contains(I18n:error("numberOutOfRange",0,255), function ()
        Color.get_fg_color(testColor, -1)
    end)
    Test:error_contains(I18n:error("numberOutOfRange",0,255), function ()
        Color.get_bg_color(testColor, -1)
    end)
end

function testColor:test6()
    -- 输入超限正数报错
    Test:error_contains(I18n:error("numberOutOfRange",0,255), function ()
        Color.get_fg_color(testColor, 256)
    end)
    Test:error_contains(I18n:error("numberOutOfRange",0,255), function ()
        Color.get_bg_color(testColor, 256)
    end)
end

function testColor:test7()
    -- 空输入报错
    Test:error_contains(I18n:error("emptyParameter"), function ()
        Color.get_fg_color(testColor)
    end)
    Test:error_contains(I18n:error("emptyParameter"), function ()
        Color.get_bg_color(testColor)
    end)
    Test:error_contains(I18n:error("emptyParameter"), function ()
        Color.get_color(testColor)
    end)
end

function testColor:test8()
    -- 非字符串输入报错
    Test:error_contains(I18n:error("incorrectKeyTypeStringRequired",type({})), function ()
        Color.get_color(testColor,{})
    end)
end

return testColor
