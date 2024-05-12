local Interface = require("aurcore.define.third_party.class.interfaces")
local function check_method(module, methodName)
    local method = module[methodName]
    assert(method, "The interface is missing the method "..methodName)
    assert(type(method) == "function", methodName.." is not a function")
end

return function (classLib)
    for key, _ in pairs(Interface.classLibInterface) do
        check_method(classLib, key)
    end
    for key, _ in pairs(Interface.classInterface) do
        check_method(classLib:new_class("checkTest"), key)
    end
    return true
end