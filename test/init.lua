local Hub = require("aurcore.hub")
local Test = Hub:get_test_lib()
TestI18n = require("aurcore.test.i18n")
return function (o)
    Test:run()
end