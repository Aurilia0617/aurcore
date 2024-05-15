local Resource = require("aurcore.core.resource.init")

return {
    inject = function (_, dep)
        for key, value in pairs(dep) do
            if key == "framework" then
                Resource:set_pre_framework(value)
            end
        end
        return {
            new_ac = function ()
                return Resource:get_wrapper()
            end
        }
    end
}