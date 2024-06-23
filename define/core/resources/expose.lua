--- @class ResourceExpose:Frameworks
local t = {}

local sub_interfaces = {
    require("aurcore.define.frameworks")
}

-- TODO 这里直接暴露到API，如果要Wrapper专属请更改结构

function t:test() end

--- @return Logger
function t:new_logger(...)
    return {}
end

--- 低版本兼容性验证
---@param version_str string 版本字符串
function t:check_version(version_str) end

for _, value in pairs(sub_interfaces) do
    for name, i in pairs(value) do
        if t[name] == nil then
            t[name] = i
        end
    end
end

return t