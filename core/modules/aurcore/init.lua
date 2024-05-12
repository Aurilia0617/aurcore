local Types = require("aurcore.types.init")
local resource = require("aurcore.core.resource.init")

local aurcoreClass = Types:new_class("aurcore")
assert(type(resource.get_i18n) == "function", "Initialization is missing the get_i18n method.")
local i18n = resource:get_i18n()
function aurcoreClass:test()
    assert(type(resource.get_test_fun) == "function", i18n:get_error_message("missingMethod", "get_test_fun"))
    return resource:get_test_fun()(self)
end

return function (frameworkContainer)
    resource:init(frameworkContainer)
    return aurcoreClass:new()
end