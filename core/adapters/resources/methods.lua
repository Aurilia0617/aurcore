local hub = require("aurcore.core.hub")
local t = hub:new_mixin("resource_methods")

function t:new_ac()
    return hub:get_adapter("wrapper", hub:new_container({self, hub:get_adapter("hub_w", hub)}))
end

function t:test()
    require("aurcore.core.test.init")(self)
    hub:get_adapter("test"):run()
end

return t
