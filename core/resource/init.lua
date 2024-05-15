local Hub = require("aurcore.hub")
local wrapper = require("aurcore.core.wrapper.init")

local types = Hub:get_types()

local resource = types:new_class("resource")

function resource:set_pre_framework(framework)
    function resource:test()
        return framework:test(resource)
    end
end

function resource:get_wrapper()
    return wrapper:new(self)
end

return resource