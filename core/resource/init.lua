local Hub = require("aurcore.hub")
local wrapper = require("aurcore.core.wrapper.init")

local types = Hub:get_types()

local resource = types:new_obj("resource")

function resource:set_pre_framework(framework)
    setmetatable(resource, {__index = framework})
    function resource:get_framework()
        return framework
    end
    return resource
end

function resource:get_wrapper()
    local new_wrapper = wrapper:new(self)
    local old_t = getmetatable(new_wrapper)
    return setmetatable(new_wrapper,{__index = function(o, name)
        local value = old_t[name]
        if value ~= nil then
            return value
        else
            return self:get_framework()[name]
        end
    end})
end

return resource