local Hub = require("aurcore.hub")
local types = Hub:get_types()

local acWrapper = types:new_class("acWrapper")

function acWrapper:test()
    acWrapper:get_static_val("resource"):test()
end

function acWrapper:initialize(resource)
    acWrapper:set_static_val("resource", resource)
end

return acWrapper