local Hub = require("aurcore.hub")
local types = Hub:get_types()
local acWrapperClass = types:new_class("acWrapper")
acWrapperClass:include(require("aurcore.core.wrapper.mixin.color"))

function acWrapperClass:test()
    acWrapperClass:_get_resource():test()
end

function acWrapperClass:initialize(resource)
    function acWrapperClass:_get_resource()
        return resource
    end
end

return acWrapperClass