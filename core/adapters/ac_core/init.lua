local hub = require("aurcore.core.hub")
local core_class = hub:new_class("core")
core_class:mixin(
    require("aurcore.core.adapters.ac_core.utils")
)

return core_class:new()