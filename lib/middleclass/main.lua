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

-- 获得新的__instanceDict作为实例元表__index，不与原来的表冲突并作为保底
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

-- 如果是__index则添加保底到实例，传播方法到子类中
local function _propagateInstanceMethod(aClass, name, f)
    f = name == "__index" and _createIndexWrapper(aClass, f) or f
    aClass.__instanceDict[name] = f

    for subclass in pairs(aClass.subclasses) do
        if rawget(subclass.__declaredMethods, name) == nil then
            _propagateInstanceMethod(subclass, name, f)
        end
    end
end

-- 声明防止被父类传播覆盖，如果删除值（nil）,则尝试复原为父类（重新继承）
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
        __instanceDict = dict,  -- 将被用作实例元表
        __declaredMethods = {}, -- 如果方法被声明了则不会被父类传播时覆盖
        subclasses = setmetatable({}, { __mode = 'k' }) -- 弱引用键（即子类本身）的子类列表
    }

    if super then
        setmetatable(aClass.static, {
            __index = function(_, k)
                local result = rawget(dict, k)  -- 即允许子类实例方法可以重载父类静态方法同时作为子类静态方法的备选,同时类也可以直接访问实例方法
                if result == nil then
                    return super.static[k]  -- 静态方法可以继承
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
        if name ~= "included" and name ~= "static" then aClass[name] = method end
    end
    if mixin.static and type(mixin.static) == "table" then
        for name, method in pairs(mixin.static) do
            aClass.static[name] = method
        end
    end

    if type(mixin.included) == "function" then mixin:included(aClass) end
    return aClass
end

local DefaultMixin = {
    __tostring   = function(self) return "instance of " .. tostring(self.class) end,

    initialize   = function(self, ...) end,

    is_instance_of = function(self, aClass)
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
            return setmetatable({ class = self }, self.__instanceDict)
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
