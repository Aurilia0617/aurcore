local sub_triggers = {
    require("aurcore.core.adapters.resources.triggers.player_status")
}

local t = {}

for _, value in pairs(sub_triggers) do
    for name, i in pairs(value) do
        if t[name] == nil then
            t[name] = i
        end
    end
end

return t