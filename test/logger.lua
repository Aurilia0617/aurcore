local Hub = require("aurcore.hub")
local Test = Hub:get_test_lib()
local I18n = Hub:get_i18n()
local types = Hub:get_types()
local loggerLib = require("aurcore.adapters.init"):get_logger()

-- 测试用例
local testLogger = types:new_obj("testLogger")

-- 在每个测试前执行，用于设置测试环境
-- 如果有需要，可以在这里初始化一些数据或状态
function testLogger:setUp()
    local _logger = loggerLib:new({
        print = function(...) end
    },"Test0617")
    function self:_get_logger()
        return _logger
    end
end

function testLogger:test1()
    -- 日志名成功设置
    Test:equals(self:_get_logger():get_log_name(),"Test0617")
end

function testLogger:test2()
    -- 日志名更改测试
    self:_get_logger():set_log_name("Test0618")
    Test:equals(self:_get_logger():get_log_name(),"Test0618")
    self:_get_logger():get_log_name("Test0617")
end

function testLogger:test3()
    -- 不合法日志名更改测试
    Test:error_contains(I18n:error("incorrectKeyTypeStringRequired","number"),function ()
        self:_get_logger():set_log_name(233)
    end)
    Test:error_contains(I18n:error("incorrectKeyTypeStringRequired","table"),function ()
        self:_get_logger():set_log_name({})
    end)
end

function testLogger:test4()
    -- debug栈深更改测试
    self:_get_logger():set_debug_stack_depth(3)
    Test:equals(self:_get_logger():get_debug_stack_depth(),3)
end

function testLogger:test5()
    -- 不合法日志名更改测试
    Test:error_contains(I18n:error("incorrectKeyTypeNumberRequired","string"),function ()
        self:_get_logger():set_debug_stack_depth("233")
    end)
    Test:error_contains(I18n:error("incorrectKeyTypeNumberRequired","table"),function ()
        self:_get_logger():set_debug_stack_depth({})
    end)
end

return testLogger