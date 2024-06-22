local hub = require("aurcore.core.hub")
local t = hub:new_mixin("resource_methods")

function t:new_ac()
    return hub:get_adapter("wrapper", hub:new_container({self, hub:get_adapter("hub_w", hub)}))
end

return t
