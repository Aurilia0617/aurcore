local middleclass = require("aurcore.class.middleclass")

local ClassAdapter = {__tostring = "Class adapter"}

--- 创建新类
--- @param name string 类名
--- @param super table|nil 父类
--- @param config table|nil 配置选项
--- @return table 新创建的类
function ClassAdapter:new_class(name, super, config)
    assert(type(name) == "string", "The class name should be of string type")
    local NewClass = middleclass(name, super)

    if config then
        -- 类实例的创建函数，不用包括初始化函数调用流程
        if config.new_fun and type(config.new_fun) == "function" then
            NewClass.static.allocate = config.new_fun
        end
    end

    --- 设置静态变量值
    --- @param o table 类对象
    --- @param key string 静态变量名
    --- @param val any 静态变量值
    NewClass.static.set_static_val = function (o, key, val)
        o.static[key] = val
    end

    --- 获取静态变量值
    --- @param o table 类对象
    --- @param key string 静态变量名
    --- @return any 静态变量值
    NewClass.static.get_static_val = function (o, key)
        return o.static[key]
    end

    --- 注册初始化函数
    --- @param fun function 初始化函数
    NewClass.static.init = function(_, fun)
        NewClass.initialize = fun
    end

    return NewClass
end

return ClassAdapter
