local function create_container(objects_list)
    -- 使用弱表来避免内存泄漏，缓存的值在没有其他引用时会被自动回收
    local api_cache = setmetatable({ _name_ = "api_cache" }, { __mode = "v" })

    ---@class Container
    local container = {
        _name_ = "container",
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
        end,
        __newindex = function(o, key, val)
            rawset(o, key, val)
            api_cache[key] = nil
        end
    })

    return container
end

return {
    new_container = create_container
}
