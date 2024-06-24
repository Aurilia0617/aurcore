local hub = require("aurcore.core.hub")
local i18n = hub:get_i18n()
--- @class PlayerClass:Class
local player_class = hub:new_class("player_class")

player_class:mixin(
    require("aurcore.core.adapters.player_manager.player.info")
)

player_class:on_init(function (instance, neomega_player)
    function instance:get_raw_player()
        return neomega_player
    end
    function instance:name()    -- 因为name字段已经在class中存在，无法混入，使用get_name替代并在此重写为name
        return self:get_name()
    end
end)

function player_class:get_raw_player()
    error(i18n.error_msg.method_not_exist("get_raw_player"))
end

return player_class