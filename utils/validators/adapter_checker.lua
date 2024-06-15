--- @class Adapter
--- @field _tag string
--- @field _adapter table
--- @field _interface table
--- @field _check_non_function boolean
local Adapter = {}

--- 创建一个新的 Adapter 实例
--- @param tag string 适配器的标签
--- @param adapter table 适配器实例
--- @param interface table 接口规范
--- @param check_non_function boolean|nil 同时检查非函数类型的
--- @return Adapter @新的 Adapter 实例
function Adapter:new(tag, adapter, interface, check_non_function)
    local instance = {
        _tag = tag,
        _adapter = adapter,
        _interface = interface,
        _check_non_function = check_non_function or false
    }

    setmetatable(instance, self)
    self.__index = self

    self:_validate_adapter(adapter, interface, tag, instance._check_non_function)

    return instance
end

--- 获取当前适配器
--- @return table 当前的适配器
function Adapter:get_adapter()
    return self._adapter
end

--- 替换适配器并进行接口核查
--- @param new_adapter table 新的适配器实例
function Adapter:replace_adapter(new_adapter)
    self:_validate_adapter(new_adapter, self._interface, self._tag, self._check_non_function)
    self._adapter = new_adapter
end

--- 验证适配器是否实现了接口中的所有方法
--- @param adapter table 要验证的适配器
--- @param interface table 接口规范
--- @param tag string 适配器的标签
--- @param check_non_function boolean 同时检查非函数类型的
function Adapter:_validate_adapter(adapter, interface, tag, check_non_function)
    for k, v in pairs(interface) do
        if not check_non_function then
            if type(v) == "function" and type(adapter[k]) ~= "function" then
                error(tag .. " Adapter does not implement function: " .. k)
            end
        else
            if type(adapter[v]) ~= "function" then
                error(tag .. " Adapter does not implement function: " .. k)
            end
        end
    end
end

return Adapter
