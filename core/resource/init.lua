local utils = require("aurcore.utils.table.init")

return {
    inject = function (_, dep)
        local new = require("aurcore.core.resource.new")
        if dep.framework ~= nil then
            -- 获得框架，执行初始化流程
            new.init(dep.framework)
            return new.resource
        end
        local resource = new.resource
        for key, module in pairs(dep) do
            if key ~= "framework" then
                -- 直接注入
                if key == "logger" then
                    -- 日志模块
                    resource = utils:add_to_module_container(resource, key, module)
                end
            end
        end
        return {
            new_ac = function ()
                return new:new_wrapper()
            end
        }
    end
}