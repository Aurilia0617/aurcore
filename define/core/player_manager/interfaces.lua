local sub_interfaces = {
    require("aurcore.define.core.player_manager.expose_r"),
    require("aurcore.define.core.player_manager.main"),
}
---@class PlayerManager:PlayerManagerExposeR, PlayerManagerMain
local t = {}

for _, value in pairs(sub_interfaces) do
    for name, i in pairs(value) do
        if t[name] == nil then
            t[name] = i
        end
    end
end

return {
    player_manager_interface = t,
    player_interface = require("aurcore.define.core.player_manager.player.interfaces")
}