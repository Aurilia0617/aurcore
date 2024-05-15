local Hub = require("aurcore.hub")
local types = Hub:get_types()
local i18n = Hub:get_i18n()
local test = Hub:get_test()
-- local logger = Hub:get_logger()
-- 用于压缩时提前注册模块名
require("aurcore.define.class")
require("aurcore.define.init")

local function validate_method(method, name)
    assert(method ~= nil, i18n:error("missingMethod", name))
    assert(type(method) == "function", i18n:error("notAFunction", name))
end

local function createFrameworkContainer(frameworkList)
    local apiCache = types:new_obj("apiCache")

    local frameworkContainer = {
        del_cache = function(_, key)
            apiCache[key] = nil
        end,

        get_framework_list = function(_)
            return frameworkList
        end
    }
    frameworkContainer = types:convert2obj("frameworkContainer", frameworkContainer)

    setmetatable(frameworkContainer, {
        __index = function(_, key)
            if not apiCache[key] then
                for _, object in ipairs(frameworkList) do
                    local item = type(object) == "table" and object[key]
                    if item then
                        apiCache[key] = item
                        break
                    end
                end
            end
            return apiCache[key]
        end
    })

    return frameworkContainer
end

local function init(...)
    local frameworkList = { {
        test = function(self)
            return test(self)
        end
    }, ... }
    assert(#frameworkList ~= 0, i18n:error("noFrameworks"))

    for i, framework in ipairs(frameworkList) do
        assert(type(framework) == "table", i18n:error("invalidFrameworkTypeForNthFramework", i))
    end

    local frameworkContainer = createFrameworkContainer(frameworkList)
    -- 确保所有关键方法都存在
    local requiredMethods = { "print", "log", "now", "uuid", "shared_map" }
    for _, methodName in ipairs(requiredMethods) do
        validate_method(frameworkContainer[methodName], methodName)
    end

    return Hub:inject({
        framework = frameworkContainer
    })
end

return {
    from = function (...)
        return init(...):new_ac()
    end,
    custom = init
}