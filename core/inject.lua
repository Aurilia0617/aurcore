local LoggerLib = require("aurcore.define.init"):check_logger(require("aurcore.adapters.init"):get_logger())
return {
    inject = function (_, dep)
        local Resource
        if dep.framework then
            Resource = require("aurcore.core.resource.export"):set_pre_framework(dep.framework)
            Resource:set_logger_lib(LoggerLib)
        else
            Resource = require("aurcore.core.resource.export").resource
        end
        return {
            new_ac = function ()
                return Resource:get_wrapper()
            end
        }
    end
}