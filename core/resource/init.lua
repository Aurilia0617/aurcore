local resource_m = require("aurcore.core.resource.manager")
local new_resource = require("aurcore.core.resource.resource")

local function init(container)
    return resource_m:new(new_resource:new(container))
end

return init