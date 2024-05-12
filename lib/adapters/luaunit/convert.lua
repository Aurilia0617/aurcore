local LuaUint = require("aurcore.lib.vendor.luauint.luaunit")
local Types = require("aurcore.types.init")

local luauint = Types:convert2obj("luauint", LuaUint)

function luauint:run()
    return luauint.LuaUnit.run()
end

function luauint:equals(actual, expected, ...)
    return luauint.assertEquals(actual, expected, ...)
end

function luauint:error_contains(msg, fun, ...)
    return luauint.assertErrorMsgContains(msg, fun, ...)
end

return luauint