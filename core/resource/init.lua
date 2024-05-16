local Hub = require("aurcore.hub")
local wrapper = require("aurcore.core.wrapper.init")
local color = Hub:get_color()

local types = Hub:get_types()

local resource = types:new_obj("resource")

function resource:set_pre_framework(framework)
    function resource:test()
        return framework:test(resource)
    end
end

function resource:get_wrapper()
    return wrapper:new(self)
end

function resource:get_color()
    return color
end

return resource