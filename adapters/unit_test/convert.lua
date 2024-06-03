local LuaUint = require("aurcore.lib.luaunit.main")

local luauint = {_name_ = "luauint"}

function luauint:run()
    return LuaUint.LuaUnit.run()
end

function luauint:equals(actual, expected, ...)
    return LuaUint.assertEquals(actual, expected, ...)
end

function luauint:error_contains(fun, msg, ...)
    return LuaUint.assertErrorMsgContains(msg, fun, ...)
end

return luauint