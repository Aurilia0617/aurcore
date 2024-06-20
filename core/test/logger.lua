local Hub = require("aurcore.core.hub")
local Test = Hub:get_test()
local I18n = Hub:get_i18n()

-- 测试用例
local testLogger = { _name_ = "testLogger" }

function testLogger:init(resource)
    ---@type Resources
    self.resource = resource
    return self
end

-- 在每个测试前执行，用于设置测试环境
-- 如果有需要，可以在这里初始化一些数据或状态
function testLogger:setUp()
    local logger = self.resource:get_logger("Test0617")
    function self:_get_logger()
        return logger
    end
end

function testLogger:test1()
    -- 日志名成功设置
    Test:equals(self:_get_logger():get_log_name(), "Test0617")
end

function testLogger:test2()
    -- 日志名更改测试
    self:_get_logger():set_log_name("Test0618")
    Test:equals(self:_get_logger():get_log_name(), "Test0618")
    self:_get_logger():get_log_name("Test0617")
end

function testLogger:test3()
    -- 不合法日志名更改测试
    Test:error_contains(function()
        self:_get_logger():set_log_name(233)
    end, I18n.error_msg.incorrect_type_string("number"))
    Test:error_contains(function()
        self:_get_logger():set_log_name({})
    end, I18n.error_msg.incorrect_type_string("table"))
end

function testLogger:test4()
    -- 不合法日志名更改测试
    Test:error_contains(function()
        self:_get_logger():set_debug_stack_depth("233")
    end, I18n.error_msg.incorrect_type_number("string"))
    Test:error_contains(function()
        self:_get_logger():set_debug_stack_depth({})
    end, I18n.error_msg.incorrect_type_number("table"))
end

return testLogger
