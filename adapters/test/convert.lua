local LuaUnit = require("aurcore.lib.luaunit.main")

local lua_unit = {_name_ = "lua_unit"}

--- 运行测试集
--- @return number, number 返回总测试数和失败的测试数
function lua_unit:run()
    return LuaUnit.LuaUnit.run()
end

--- 断言实际值和预期值相等
--- @param actual any 实际值
--- @param expected any 预期值
--- @vararg any 可选的额外参数，用于提供更详细的错误信息
function lua_unit:equals(actual, expected, ...)
    return LuaUnit.assertEquals(actual, expected, ...)
end

--- 断言函数抛出的错误信息包含特定文本
--- @param fun function 需要执行的函数，期待其抛出错误
--- @param msg string 预期错误信息中应包含的文本
--- @vararg any 可选的额外参数，用于提供更详细的错误信息
function lua_unit:error_contains(fun, msg, ...)
    return LuaUnit.assertErrorMsgContains(msg, fun, ...)
end

return lua_unit
