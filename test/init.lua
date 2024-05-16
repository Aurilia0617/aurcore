local Hub = require("aurcore.hub")
local Test = Hub:get_test_lib()
TestI18n = require("aurcore.test.i18n")
TestColor = require("aurcore.test.color")
return function (o)
    Test:run()
end