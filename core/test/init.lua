TestColor = require("aurcore.core.test.color")
TestI18n = require("aurcore.core.test.i18n")

-- 注册需要Resources的测试实例
return function (o)
    TestLogger = require("aurcore.core.test.logger"):init(o)
end