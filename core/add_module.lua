local mixin = require("aurcore.core.modules.mixin.mixin")

return function (resource_m)
    mixin(resource_m.resource)
    return resource_m
end