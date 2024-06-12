local parse_version_string = require("aurcore.utils.version.parse")
local hub = require("aurcore.hub")
local ut = hub:get_test()

local test_version_utils = {_name_ = "test_version_utils"}

function test_version_utils:test1()
    ut:equals(parse_version_string("v1.0.0-Alpha.3"),{
        type = "Alpha",
        version = "1.0.0",
        build = "3"
    })
end

function test_version_utils:test2()
    ut:equals(parse_version_string("v2.1.0"),{
        version = "2.1.0"
    })
end

function test_version_utils:test3()
    ut:equals(parse_version_string("Release v0.0.1"),{
        type = "Release",
        version = "0.0.1"
    })
end

function test_version_utils:test4()
    ut:equals(parse_version_string("v0.0.1-Release"),{
        type = "Release",
        version = "0.0.1"
    })
end

function test_version_utils:test5()
    ut:equals(parse_version_string("v0.0.1 Release"),{
        type = "Release",
        version = "0.0.1"
    })
end

function test_version_utils:test6()
    ut:equals(parse_version_string("Release-v0.0.1"),{
        type = "Release",
        version = "0.0.1"
    })
end

function test_version_utils:test7()
    ut:error_contains(function ()
        parse_version_string("invalid_version_string")
    end,"invalid version string")
end

return test_version_utils