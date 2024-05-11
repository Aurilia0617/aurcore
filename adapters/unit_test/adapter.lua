local TargetPk = require("aurcore.vendor.luaunit.luaunit")
local RequireInterface = require("aurcore.core.interfaces.third_party.unit_test.unit_test")

local unitTestClass = require("aurcore.types.init").class:new("unitTestClass")

function unitTestClass:equals(...)
    return TargetPk.assertEquals(...)
end

function unitTestClass:error_contains(...)
    return TargetPk.assertErrorMsgContains(...)
end

function unitTestClass:run(...)
    return TargetPk.LuaUnit.run(...)
end

RequireInterface:check(unitTestClass)
return unitTestClass
