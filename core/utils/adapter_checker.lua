--- AdapterManager 管理适配器的模块
--- @class AdapterManager
local AdapterManager = {
    _adapters = {}
}

--- 创建一个新的适配器实例
--- @param tag string 适配器的标签
--- @param object table 实现接口的对象
--- @param interface table 适配器接口规范
--- @param checkNonFunction boolean|nil 是否检查非函数类型的方法
--- @param respawn boolean|nil 是否每次重新生成
--- @return adapterIstance 适配器实例
function AdapterManager:new(tag, object, interface, checkNonFunction, respawn)
    if self._adapters[tag] ~= nil and not self._adapters[tag]._respawn then
        return self._adapters[tag]
    end
    checkNonFunction = checkNonFunction or false
    --- @class adapterIstance
    local instance = {
        _tag = tag,
        _methods = {},
        _interface = interface,
        _checkNonFunction = checkNonFunction,
        _manager = self,
        _respawn = respawn
    }

    self:_validateAdapter(object, interface, tag, checkNonFunction)

    for key in pairs(interface) do
        if type(object[key]) == "function" then
            instance._methods[key] = function (_, ...)
                return object[key](object, ...)
            end
        else
            instance._methods[key] = object[key]
        end
    end

    function instance:get_adapter()
        return setmetatable({}, { __index = instance._methods })
    end

    self._adapters[tag] = instance

    return instance
end

--- 替换现有的适配器对象
--- @param tag string 适配器的标签
--- @param newObject table 新的实现接口的对象
function AdapterManager:replace_adapter(tag, newObject)
    local instance = self._adapters[tag]
    assert(instance ~= nil, "The adapter " .. tag .. " does not exist.")
    self:_validateAdapter(newObject, instance._interface, tag, instance._checkNonFunction)

    for key in pairs(instance._interface) do
        if type(newObject[key]) == "function" then
            instance._methods[key] = function (_, ...)
                return newObject[key](newObject, ...)
            end
        else
            instance._methods[key] = newObject[key]
        end
    end
end

--- 验证适配器是否实现了接口中的所有方法
--- @param object table 要验证的适配器
--- @param interface table 接口规范
--- @param tag string 适配器的标签
--- @param checkNonFunction boolean 是否检查非函数类型的方法
function AdapterManager:_validateAdapter(object, interface, tag, checkNonFunction)
    for k, v in pairs(interface) do
        if not checkNonFunction then
            assert(type(v) ~= "function" or (type(v) == "function" and type(object[k]) == "function"), tag .. " object does not implement function: " .. k)
        else
            assert(type(object[k]) == type(v), tag .. " object does not implement: " .. k.. ",require: "..type(v)..", provided:"..type(object[k]))
        end
    end
end

return AdapterManager
