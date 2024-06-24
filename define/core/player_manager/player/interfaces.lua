local sub_interfaces = {
    require("aurcore.define.core.player_manager.player.info")
}
---@class Player:PlayerInfo
local t = {}

for _, value in pairs(sub_interfaces) do
    for name, i in pairs(value) do
        if t[name] == nil then
            t[name] = i
        end
    end
end

return t