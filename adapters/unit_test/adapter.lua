local LuaUnit = require("aurcore.vendor.luaunit.luaunit")
local unitTestClass = require("aurcore.types.init").class:new("unitTestClass")

function unitTestClass:equals(...)
    return LuaUnit.assertEquals(...)
end

function unitTestClass:error_contains(...)
    return LuaUnit.assertErrorMsgContains(...)
end

function unitTestClass:run(...)
    return LuaUnit.LuaUnit.run(...)
end

return unitTestClass
