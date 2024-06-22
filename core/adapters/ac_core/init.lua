local hub = require("aurcore.core.hub")
local core_class = hub:new_class("ac_core")
core_class:mixin(
    require("aurcore.core.adapters.ac_core.methods")
)

return hub:new_container({core_class, hub:get_adapter("hub_c", hub)})