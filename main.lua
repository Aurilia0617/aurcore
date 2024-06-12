local hub = require("aurcore.hub")
local i18n = hub:get_i18n()

--- 初始化框架列表并进行必要的检查和设置
--- @param ... table 各个框架
--- @return table
local function init(...)
    local frameworks = { {
        test = hub.get_run_test
    }, ... }
    assert(#frameworks > 0, i18n:error_msg("framework_not_exist"))

    for i, framework in ipairs(frameworks) do
        assert(type(framework) == "table", i18n:error_msg("invalid_type_for_framework", i))
    end

    local framework_container = hub:new_container(frameworks)

    -- 确保所有关键方法都存在
    local required_methods = { "print", "log", "now", "uuid", "shared_map", "get_plugin_name", "log_without_print",
        "start_new" }
    hub:get_adapter_checker():new("frame", framework_container, required_methods, true):get_adapter()

    --- @type resoueceM
    local resource_m = hub:new_resource(framework_container)

    -- 添加模块
    hub:add_modules(resource_m)

    return resource_m
end

return {
    from = function(...)
        return init(...):new_ac()
    end,
    custom = init
}