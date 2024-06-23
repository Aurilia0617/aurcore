local hub = require("aurcore.core.hub")
local core_class = hub:new_class("ac_core")
core_class:mixin(
    require("aurcore.core.adapters.ac_core.methods")
)
-- 暴露给ac_core的方法
return hub:new_container({
    core_class, -- 类方法
    hub:get_adapter("hub_c", hub)   -- hub中c部分
})