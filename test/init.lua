local Test = require("aurcore.lib.init"):get_luaunit()
TestI18n = require("aurcore.test.i18n")
return function (o)
    Test:run()
end