local hub = require("aurcore.core.hub")
local i18n = hub:get_i18n()
local t = hub:new_mixin("resource_methods")

function t:get_name()
    local name, found = self:get_raw_player():name()
    assert(found, i18n.error_msg.key_not_exist("player's name"))
    return name
end

return t