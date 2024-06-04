local Hub = require("aurcore.hub")
local Test = Hub:get_unit_test()
TestVersion = require("aurcore.test.version_utils")
TestFlattener = require("aurcore.test.table_flattener")
return function (o)
    Test:run()
end