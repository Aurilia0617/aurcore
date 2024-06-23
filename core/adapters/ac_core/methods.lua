local hub = require("aurcore.core.hub")
local t = hub:new_mixin("ac_core_methods")

function t:new_resources(framework_list)
    return hub:get_adapter(
        "resources",
        hub:new_container({  -- 暴露给resources
            hub:get_adapter( -- 框架适配器
                "frameworks",
                hub:new_container(framework_list)
            ),
            hub:get_adapter("hub_r", hub), -- hub中r部分
            hub:get_adapter("version"),    -- 版本核查器
        })
    )
end

return t
