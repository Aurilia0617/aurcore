local hub = require("aurcore.core.hub")
local t = hub:new_mixin("ac_core_methods")

function t:new_resources(framework_list)
    return hub:get_adapter(
        "resources",
        hub:new_container({
            hub:get_adapter(
                "frameworks",
                hub:new_container(framework_list)
            ),
            hub:get_adapter("hub_r", hub)
        })
    )
end

return t