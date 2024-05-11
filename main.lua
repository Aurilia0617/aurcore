local Test = require("aurcore.test.init")
local Types = require("aurcore.types.init")
local Resource = require("aurcore.core.resource.init")
local I18n = require("aurcore.core.utils.i18n.init")

local function validate_method(method, name)
    assert(method ~= nil, I18n:get_error_message("frameworkMissingMethod", name))
    assert(type(method) == "function", I18n:get_error_message("notAFunction", name))
end

local function createFrameworkContainer(frameworkList)
    local apiCache = Types.obj:new("apiCache")

    local frameworkContainer = {
        del_cache = function(self, key)
            apiCache[key] = nil
        end,

        get_framework_list = function(self)
            return frameworkList
        end
    }
    frameworkContainer = Types.obj:convert("frameworkContainer", frameworkContainer)

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
    local frameworkList = { {test = function (self)
        return Test(self)
    end},... }
    assert(#frameworkList ~= 0, I18n:get_error_message("noFrameworks"))

    for i, framework in ipairs(frameworkList) do
        assert(type(framework) == "table", I18n:get_error_message("invalidFrameworkTypeForNthFramework", i))
    end

    local frameworkContainer = createFrameworkContainer(frameworkList)
    -- 确保所有关键方法都存在
    local requiredMethods = { "print", "log", "now", "uuid", "shared_map" }
    for _, methodName in ipairs(requiredMethods) do
        validate_method(frameworkContainer[methodName], methodName)
    end

    return Resource:new(frameworkContainer):get_ac()
end


return init