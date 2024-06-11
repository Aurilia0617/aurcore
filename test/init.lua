local hub = require("aurcore.hub")
local test = hub:get_test()
--TestVersion = require("aurcore.test.version_utils")
--TestFlattener = require("aurcore.test.table_flattener")
return function (o)
    test:run()
end