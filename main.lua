local core = require("aurcore.core.init")
local i18n = core:get_i18n()

--- 初始化框架列表并进行必要的检查和设置
--- @param ... table 各个框架
--- @return Resources
local function init(...)
    local frameworks = { ... }
    assert(#frameworks > 0, i18n.error_msg.framework_not_exist)

    for i, framework in ipairs(frameworks) do
        assert(type(framework) == "table", i18n.error_msg.invalid_type_for_framework(i))
    end
    --- @type Resources
    local resource = core:new_resources(frameworks)

    return resource
end

return {
    from = function(...)
        return init(...):new_ac()
    end,
    custom = init
}