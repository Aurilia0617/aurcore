local interfaces = require("aurcore.modules.interfaces")
local t = {}
-- 直接混入无依赖关系的模块到资源
function t:mixin()
    return {
        interfaces:get_version_adapter()
    }
end

-- 仅需要使用资源初始化的模块

-- 需要指定模块作为前置的模块

return t