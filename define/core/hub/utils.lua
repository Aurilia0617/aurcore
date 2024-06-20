---@class HubUtils
local t = {}

--- 获取国际化适配器实例
--- @return I18n 国际化适配器实例
function t:get_i18n()
    return {}
end

--- 将传入的对象表包装成一个对象，访问键时优先从在前面的子对象中获取
--- 使用缓存进行快速访问
--- @param objects_list table[] 对象表
--- @return table 包装后的对象
function t:new_container(objects_list)
    return {}
end

function t:get_test(...)
    return {}
end

---@return Color
function t:get_color()
    return {}
end

return t