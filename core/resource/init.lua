local resource_m = require("aurcore.core.resource.manager")

local function init(container)
    --- @class resource
    local resource = {_name_ = "resource"}
    return resource_m:new(setmetatable(resource, {__index = container}))
end

return init