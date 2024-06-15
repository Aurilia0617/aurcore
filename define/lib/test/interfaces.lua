--- @class UnitTest
local unit_test_interface = {}

--- 运行所有测试
function unit_test_interface:run() end

--- 比较实际值和预期值
--- @param actual any 实际值
--- @param expected any 预期值
--- @return boolean 是否相等
function unit_test_interface:equals(actual, expected) return true end

--- 检查函数的错误信息
--- @param fun function 被调用的函数
--- @param errorMsg string 预期的错误信息
--- @return boolean 错误信息是否包含预期内容
function unit_test_interface:error_contains(fun, errorMsg) return true end

return unit_test_interface
