local hub = require("aurcore.hub")
--- @class resource:Class
local ResourceClass = hub:new_class("ResourceClass")

ResourceClass:init(function (instance,container)
    instance.class:include({
        __index = container
    })
end)

return ResourceClass