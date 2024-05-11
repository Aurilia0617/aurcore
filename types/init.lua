local MixinTable = require("aurcore.types.mixin_table")
local MiddleClass = require("aurcore.types.class")
local obj = {
    new = function(self, name)
        assert(type(name) == "string", "The object name should be of string type")
        return MixinTable(name)
    end,
    convert = function(self, name, old)
        assert(type(name) == "string", "The object name should be of string type")
        assert(type(old) == "table", "The object should be of table type")
        return MixinTable(name, old)
    end
}
local class = {
    new = function(self, name)
        assert(type(name) == "string", "The object name should be of string type")
        return MiddleClass(name)
    end
}
return {
    obj = obj,
    class = class
}
