local hub = require("aurcore.core.hub")
local test = hub:get_test()

TestColor = require("aurcore.core.test.color")
TestI18n = require("aurcore.core.test.i18n")

return function (o)
    TestLogger = require("aurcore.core.test.logger"):init(o)
    return test:run()
end