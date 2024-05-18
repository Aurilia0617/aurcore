local LuaUint = require("aurcore.lib.luaunit.luaunit")
local Types = require("aurcore.hub"):get_types()

local luauint = Types:new_obj("luauint")

function luauint:run()
    return LuaUint.LuaUnit.run()
end

function luauint:equals(actual, expected, ...)
    return LuaUint.assertEquals(actual, expected, ...)
end

function luauint:error_contains(msg, fun, ...)
    return LuaUint.assertErrorMsgContains(msg, fun, ...)
end

return luauint