local hub = require("aurcore.hub")
--- @class acWrapper:class
local acWrapperClass = hub:new_class("acWrapper")
-- acWrapperClass:include(require("aurcore.core.wrapper.mixin.color"), require("aurcore.core.wrapper.mixin.logger"))

acWrapperClass:init(function (resource)
    hub:check_resource(resource)
    function acWrapperClass:_get_resource()
        return resource
    end
end)

return acWrapperClass
