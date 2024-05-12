local MixinTable = require("aurcore.types.mixin_table")
local MiddleClass = require("aurcore.types.class")
-- 让调用的代码更易懂
local t = {
    new_obj = function(_, name)
        assert(type(name) == "string", "The object name should be of string type")
        return MixinTable(name)
    end,
    convert2obj = function(_, name, old)
        assert(type(name) == "string", "The object name should be of string type")
        assert(type(old) == "table", "The object should be of table type")
        return MixinTable(name, old)
    end,
    new_class = function(_, name)
        assert(type(name) == "string", "The object name should be of string type")
        return MiddleClass(name)
    end
}
return setmetatable(MixinTable("TypesInit"), { __index = t })
