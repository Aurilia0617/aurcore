--- @class HubOther
local t = {}

--- 获取配置模块
--- @return Config 返回配置表
function t:get_config()
    return {}
end

function t:get_core()
    return {}
end

function t:is_windows()
    return true
end

function t:is_unix()
    return true
end

return t