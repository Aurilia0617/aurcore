local Types = require("aurcore.types.init")
local I18n = require("aurcore.core.utils.i18n.init")

local unitTestInterface = Types.class:new("unitTestInterface")

function unitTestInterface:equals()
    error(I18n:get_error_message("interfaceMissingMethod","equals"))
end

function unitTestInterface:error_contains()
    error(I18n:get_error_message("interfaceMissingMethod", "error_contains"))
end

function unitTestInterface:run()
    error(I18n:get_error_message("interfaceMissingMethod", "run"))
end

local function check_method(module, methodName)
    local method = module[methodName]
    assert(method, I18n:get_error_message("interfaceMissingMethod", methodName))
    assert(type(method) == "function", I18n:get_error_message("notAFunction", methodName))
    assert(method ~= unitTestInterface[methodName], I18n:get_error_message("interfaceMissingMethod", methodName))
end

function unitTestInterface:check(module)
    check_method(module, "equals")
    check_method(module, "error_contains")
    check_method(module, "run")
    return true
end

return unitTestInterface
