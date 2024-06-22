local sub_interfaces = {
    require("aurcore.define.core.class").class_manager_interface,
}
---@class HubMain:ClassManager
local t = {}

for _, value in pairs(sub_interfaces) do
    for name, i in pairs(value) do
        if t[name] == nil then
            t[name] = i
        end
    end
end

--- @param func function
function t:do_once(func)
end

---@return boolean
function t:is_array(...)
    return true
end

---@return boolean
function t:is_windows()
    return true
end

---@return boolean
function t:is_unix()
    return true
end

--- @param o table[]
--- @return Container
function t:new_container(o)
    return {}
end

--- @return Config
function t:get_config()
    return {}
end

--- @return AdapterManager
function t:get_adapter_manager()
    return {}
end

function t:get_adapter(tag, ...)
    return {}
end

return t