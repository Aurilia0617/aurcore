local interfaces = require("aurcore.core.interfaces")
--- @class ResourcesUtils
local t = {}

function t:get_logger(name)
    return interfaces:get_logger_adapter(self, name)
end

function t:test()
    require("aurcore.test.init")(self)
    return require("aurcore.core.test.init")(self)
end

return t
