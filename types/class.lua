local MixinTable = require("aurcore.types.mixin_table")
local Middleclass = require("aurcore.vendor.middleclass.middleclass")

return function(name)
    local newClass = Middleclass(name)
    newClass.static.allocate = function(self)
        assert(type(self) == 'table', "Make sure that you are using 'Class:allocate' instead of 'Class.allocate'")
        return setmetatable(MixinTable("Class", { class = self }), self.__instanceDict)
    end
    return newClass
end
