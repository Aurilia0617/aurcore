local function check_method(module, methodName)
    local method = module[methodName]
    assert(method, "The interface is missing the method "..methodName)
    assert(type(method) == "function", methodName.." is not a function")
end

return function (unitTestLib,Interface)
    for key, _ in pairs(Interface) do
        check_method(unitTestLib, key)
    end
    return true
end