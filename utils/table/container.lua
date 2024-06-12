--- 将传入的对象表包装成一个对象，访问键时优先从在前面的子对象中获取
--- 使用缓存进行快速访问
--- @param objects_list table[] 对象表
--- @return table 包装后的对象
local function create_container(objects_list)
    local api_cache = { _name_ = "api_cache" }

    local container = {
        _name_ = "container",

        --- 删除缓存中的指定键
        --- @param self table 容器对象自身
        --- @param key string 要删除的缓存键
        del_cache = function(self, key)
            api_cache[key] = nil
        end,

        --- 获取对象表
        --- @return table[] 对象表
        get_objects_list = function()
            return objects_list
        end
    }

    setmetatable(container, {
        __index = function(_, key)
            if not api_cache[key] then
                for _, object in ipairs(objects_list) do
                    local item = type(object) == "table" and object[key]
                    if item then
                        api_cache[key] = item
                        break
                    end
                end
            end
            return api_cache[key]
        end
    })

    return container
end

return {
    new_container = create_container
}