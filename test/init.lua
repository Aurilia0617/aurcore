local hub = require("aurcore.hub")
local test = hub:get_test()
TestVersion = require("aurcore.test.version_utils")
TestFlattener = require("aurcore.test.table_flattener")

local logger_test = require("aurcore.test.logger")
return function (o)
    TestLogger = logger_test:init(o)
    return test:run()
end