local Types = require("aurcore.types.init")

local core = Types:new_obj("core")

function core:get_i18n()
    return require("aurcore.core.resource.init"):get_i18n()
end

function core:get_aurcore(...)
    ---@class AurCore
    return require("aurcore.core.modules.aurcore.init")(...)
end

return core