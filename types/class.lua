local MixinTable = require("aurcore.types.mixin_table")
local Class = require("aurcore.lib.class")

return function(name)
    -- 将类实例转为混入表类型以同一对象格式
    local newClass = Class:new_class(name,{
        new_fun = function(self)
            assert(type(self) == 'table', "Make sure that you are using 'Class:allocate' instead of 'Class.allocate'")
            return setmetatable(MixinTable("Class", { class = self }), self.__instanceDict)
        end
    })
    return newClass
end
