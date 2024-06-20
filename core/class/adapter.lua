local middleclass = require("aurcore.lib.middleclass.main")
local static_methods = require("aurcore.core.class.static_methods")

local ClassAdapter = {_name_ = "Class adapter"}

function ClassAdapter:new_class(name, super, config)
    assert(type(name) == "string", "The class name should be of string type")
    local NewClass = middleclass(name, super)

    if config then
        -- 类实例的创建函数，不用包括初始化函数调用流程
        if config.new_fun and type(config.new_fun) == "function" then
            NewClass.static.allocate = config.new_fun
        end
    end

    for key, value in pairs(static_methods) do
        NewClass.static[key] = value
    end
    return NewClass
end

function ClassAdapter:new_mixin(name, fun)
    assert(type(fun) == "function" or fun == nil, ("Invalid key type: %s, a function type is required."):format(type(fun)))
    return {
        _name_ = name,
        included = fun
    }
end

return ClassAdapter
