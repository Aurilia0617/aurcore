local I18nInterface = require("aurcore.define.internal.utils.i18n.interfaces")

local function check_method(module, methodName)
    local method = module[methodName]
    assert(type(method) == "function", methodName.." is not a function")
    assert(method and method ~= I18nInterface[methodName], "The interface is missing the method "..methodName)
end

local function check(module)
    check_method(module, "get_error_message")
    return true
end

return check