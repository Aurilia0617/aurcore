local hub = require("aurcore.hub")
--- @class wrapper:Class
local WarpperClass = hub:new_class("WarpperClass")

WarpperClass:init(function (instance,resource)
    instance.class:include({
        __index = resource  -- 每次获得实例将覆盖一次类，不会获得上一个实例的resource
    })
end)

return WarpperClass