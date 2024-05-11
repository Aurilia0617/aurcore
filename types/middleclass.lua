local MixinTable = require("aurcore.utils.class.mixin_table")
-- 修改：添加了混入白名单_CONST
local middleclass = {
    _VERSION     = 'middleclass v4.1.1',
    _DESCRIPTION = 'Object Orientation for Lua',
    _URL         = 'https://github.com/kikito/middleclass',
    _LICENSE     = [[
      MIT LICENSE

      Copyright (c) 2011 Enrique García Cota

      Permission is hereby granted, free of charge, to any person obtaining a
      copy of this software and associated documentation files (the
      "Software"), to deal in the Software without restriction, including
      without limitation the rights to use, copy, modify, merge, publish,
      distribute, sublicense, and/or sell copies of the Software, and to
      permit persons to whom the Software is furnished to do so, subject to
      the following conditions:

      The above copyright notice and this permission notice shall be included
      in all copies or substantial portions of the Software.

      THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
      OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
      MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
      IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
      CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
      TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
      SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
    ]]
}

-- 根据传入的f类型添加到实例方法检索中，作为原方法不命中后的备选(table)或兜底(function)
local function _createIndexWrapper(aClass, f)
    if f == nil then
        return aClass.__instanceDict
    elseif type(f) == "function" then
        return function(self, name)
            local value = aClass.__instanceDict[name]

            if value ~= nil then
                return value
            else
                return (f(self, name))
            end
        end
    else -- if  type(f) == "table" then
        return function(self, name)
            local value = aClass.__instanceDict[name]

            if value ~= nil then
                return value
            else
                return f[name]
            end
        end
    end
end

local function _propagateInstanceMethod(aClass, name, f)
    -- 如果是添加__index方法则合并新方法为备选
    f = name == "__index" and _createIndexWrapper(aClass, f) or f
    aClass.__instanceDict[name] = f
    -- 传播到子类
    for subclass in pairs(aClass.subclasses) do
        if rawget(subclass.__declaredMethods, name) == nil then
            _propagateInstanceMethod(subclass, name, f)
        end
    end
end

-- 新键赋值时，使用这个声明函数放入，可以传播到子类，如果使用未定义过的新方法，则尝试从父类中获取
local function _declareInstanceMethod(aClass, name, f)
    aClass.__declaredMethods[name] = f

    if f == nil and aClass.super then
        f = aClass.super.__instanceDict[name]
    end

    _propagateInstanceMethod(aClass, name, f)
end

local function _tostring(self) return "class " .. self.name end
local function _call(self, ...) return self:new(...) end

local function _createClass(name, super)
    local dict = {}
    dict.__index = dict

    local aClass = {
        name = name,
        super = super,
        static = {},
        __instanceDict = dict,
        __declaredMethods = {},
        subclasses = setmetatable({}, { __mode = 'k' })
    }

    if super then
        setmetatable(aClass.static, {
            __index = function(_, k)
                local result = rawget(dict, k)
                if result == nil then
                    return super.static[k]
                end
                return result
            end
        })
    else
        setmetatable(aClass.static, { __index = function(_, k) return rawget(dict, k) end })
    end

    setmetatable(aClass, {
        __index = aClass.static,
        __tostring = _tostring,
        __call = _call,
        __newindex = _declareInstanceMethod
    })

    return aClass
end

local function _includeMixin(aClass, mixin)
    assert(type(mixin) == 'table', "mixin must be a table")

    for name, method in pairs(mixin) do
        if name ~= "included" and name ~= "static" and name ~= "_CONST" then aClass[name] = method end
    end

    for name, method in pairs(mixin.static or {}) do aClass.static[name] = method end

    if type(mixin.included) == "function" then mixin:included(aClass) end
    return aClass
end

local DefaultMixin = {
    -- 被覆盖也相同
    __tostring   = function(self) return "instance of " .. tostring(self.class) end,
    -- 在覆盖之前就运行了，无影响
    initialize   = function(self, ...) end,
    -- 被覆盖也相同
    isInstanceOf = function(self, aClass)
        return type(aClass) == 'table'
            and type(self) == 'table'
            and (self.class == aClass
                or type(self.class) == 'table'
                and type(self.class.isSubclassOf) == 'function'
                and self.class:isSubclassOf(aClass))
    end,

    static       = {
        allocate = function(self)
            assert(type(self) == 'table', "Make sure that you are using 'Class:allocate' instead of 'Class.allocate'")
            return setmetatable(MixinTable(self.name .. "Instance", { class = self }), self.__instanceDict)
        end,

        new = function(self, ...)
            assert(type(self) == 'table', "Make sure that you are using 'Class:new' instead of 'Class.new'")
            local instance = self:allocate()
            instance:initialize(...)
            return instance
        end,

        subclass = function(self, name)
            assert(type(self) == 'table', "Make sure that you are using 'Class:subclass' instead of 'Class.subclass'")
            assert(type(name) == "string", "You must provide a name(string) for your class")

            local subclass = _createClass(name, self)

            for methodName, f in pairs(self.__instanceDict) do
                if not (methodName == "__index" and type(f) == "table") then
                    _propagateInstanceMethod(subclass, methodName, f)
                end
            end
            subclass.initialize = function(instance, ...) return self.initialize(instance, ...) end

            self.subclasses[subclass] = true
            self:subclassed(subclass)

            return subclass
        end,

        subclassed = function(self, other) end,

        isSubclassOf = function(self, other)
            return type(other) == 'table' and
                type(self.super) == 'table' and
                (self.super == other or self.super:isSubclassOf(other))
        end,

        include = function(self, ...)
            assert(type(self) == 'table', "Make sure you that you are using 'Class:include' instead of 'Class.include'")
            for _, mixin in ipairs({ ... }) do _includeMixin(self, mixin) end
            return self
        end
    }
}

function middleclass.class(name, super)
    assert(type(name) == 'string', "A name (string) is needed for the new class")
    return super and super:subclass(name) or _includeMixin(_createClass(name), DefaultMixin)
end

setmetatable(middleclass, { __call = function(_, ...) return middleclass.class(...) end })

return middleclass
