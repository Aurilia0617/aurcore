local MixinTable = require("aurcore.types.mixin_table")
local MiddleClass = require("aurcore.types.middleclass")
local obj = {
    new = function(name)
        assert(type(name) == "string", "The object name should be of string type")
        return MixinTable(name)
    end,
    convert = function(name, old)
        assert(type(name) == "string", "The object name should be of string type")
        assert(type(old) == "string", "The object should be of table type")
        return MixinTable(name, old)
    end
}
local class = {
    new = function(name)
        assert(type(name) == "string", "The object name should be of string type")
        return MiddleClass(name)
    end
}
return {
    obj = obj,
    class = class
}
