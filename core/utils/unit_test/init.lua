local UnitTestAdapter = require("aurcore.adapters.unit_test.adapter")
local Types = require("aurcore.types.init")

local UnitTest = Types.class:new("UnitTest")

function UnitTest:equals(actual, expected, extraMsg)
    return UnitTestAdapter:equals(actual, expected, extraMsg)
end

function UnitTest:error_contains(msg, fun, ...)
    return UnitTestAdapter:error_contains(msg, fun, ...)
end

function UnitTest:run()
    return UnitTestAdapter:run()
end

return UnitTest