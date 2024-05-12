local middleclass = require("aurcore.lib.vendor.middleclass.middleclass")

local class = {
    -- 适配混入表类型
    _CONST = {
        _name = "middleclassConvert"
    }
}

function class:new_class(name, config)
    local newClass = middleclass(name)
    if config then
        if config.new_fun and type(config.new_fun) == "function" then
            newClass.static.allocate = config.new_fun
        end
    end
    return newClass
end

return class