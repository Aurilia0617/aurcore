local is_array = require("aurcore.core.utils.type").is_array
---@class AdapterManager
local adapter_manager = {
    _adapters = {}
}

function adapter_manager:add(config)
    self:_validateAdapter(config)
    return self
end

function adapter_manager:_validateAdapter(config, get_super_fun, is_replace)
    if is_array(config) then
        for _, value in ipairs(config) do
            self:_validateAdapter(value, get_super_fun)
        end
        return
    end
    if get_super_fun then
        config.object = get_super_fun()
        if not is_replace then
            config.get_super_fun = get_super_fun
        end
    end
    assert(is_replace or self._adapters[config.tag] == nil, ("Adapter %s already exists"):format(config.tag))
    for k, v in pairs(config.interface) do
        assert(type(config.object[k]) == type(v),
            config.tag ..
            " object does not implement: " .. k .. ",require: " .. type(v) .. ", provided:" .. type(config.object[k]))
    end
    self:add_to_adapters(config)
    if config.sub_adapter ~= nil then
        if is_array(config.sub_adapter) then
            for _, value in ipairs(config.sub_adapter) do
                self:_validateAdapter(value, function()
                    return config.object[value.fun](config.object, unpack(value.args or {}))
                end)
            end
            return
        else
            self:_validateAdapter(config.sub_adapter, function()
                return config.object[config.sub_adapter.fun](config.object, unpack(config.sub_adapter.args or {}))
            end)
        end
    end
end

function adapter_manager:add_to_adapters(config)
    --- @class AdapterIstance
    local instance = {
        _config = config,
        _methods = {}
    }
    for key in pairs(config.interface) do
        if type(config.object[key]) == "function" then
            instance._methods[key] = function(_, ...)
                return config.object[key](config.object, ...)
            end
        else
            instance._methods[key] = config.object[key]
        end
    end

    self._adapters[config.tag] = setmetatable({ _raw_adapter = instance }, { __index = instance._methods })

    return self
end

function adapter_manager:get_adapter(tag)
    local instance = self._adapters[tag]
    assert(instance ~= nil, "The adapter " .. tag .. " does not exist.")
    if instance._raw_adapter._config.regenerate then
        if instance._raw_adapter._config.get_super_fun then
            instance._raw_adapter._config.object = instance._raw_adapter._config.get_super_fun()
        end
        self:replace_adapter(tag, instance._raw_adapter._config.object)
    end
    return self._adapters[tag]
end

-- 如果设置重新生成，该函数将不会生效
function adapter_manager:replace_adapter(tag, object)
    local instance = self._adapters[tag]
    assert(instance ~= nil, "The adapter " .. tag .. " does not exist.")
    return self:_validateAdapter(instance._raw_adapter._config, function ()
        return object
    end, true)
end

return adapter_manager
