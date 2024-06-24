local hub = require("aurcore.core.hub")
local i18n = hub:get_i18n()
--- @class PlayerManagerClass:Class
local player_manager_class = hub:new_class("player_manager_class")
local player_class = require("aurcore.core.adapters.player_manager.player.init")

player_manager_class:on_init(function (instance, resources)
    function instance:get_resources()
        return resources
    end
end)

function player_manager_class:get_resources()
    error(i18n.error_msg.method_not_exist("get_resources"))
end

function player_manager_class:get_player(player)
    if type(player) == "string" then
        player = self:get_resources():get_neomega_player(player)
    end
    return player_class:new(player)
end

return player_manager_class