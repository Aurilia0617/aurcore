local middleclass = require("aurcore.class.main.middleclass")

local class = {__tostring = "Class adapter"}

function class:new_class(name, super, config)
    assert(type(name) == "string", "The class name should be of string type")
    local newClass = middleclass(name, super)
    if config then
        -- 创建新实例的函数
        if config.new_fun and type(config.new_fun) == "function" then
            newClass.static.allocate = config.new_fun
        end
    end

    newClass.static.set_static_val = function (o, key, val)
        o.static[key] = val
    end

    newClass.static.get_static_val = function (o, key)
        return o.static[key]
    end

    newClass.static.init = function(_, fun)
        newClass.initialize = fun
    end

    return newClass
end

return class
