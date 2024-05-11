local LuaUnit = require("aurcore.vendor.luaunit.luaunit")
return function (o)
    LuaUnit.LuaUnit.run()
end