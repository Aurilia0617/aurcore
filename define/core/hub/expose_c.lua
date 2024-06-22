--- @class HubExposeC
local t = {}

local sub_interfaces = {
}

--- @return I18n
function t:get_i18n()
    return {}
end

for _, value in pairs(sub_interfaces) do
    for name, i in pairs(value) do
        if t[name] == nil then
            t[name] = i
        end
    end
end

return t