--- @class HubExposeR
local t = {}

local sub_interfaces = {
}

for _, value in pairs(sub_interfaces) do
    for name, i in pairs(value) do
        if t[name] == nil then
            t[name] = i
        end
    end
end

return t