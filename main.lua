--[[
    Repository: https://github.com/Aurilia0617/aurcore

    Copyright (c) 2024 by Aurilia0617.

    Licensed under the GNU Lesser General Public License v2.1 (LGPL-2.1),
    with the option to upgrade to any later version as permitted by the license.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. For more
    details, see the GNU Lesser General Public License at
    <http://www.gnu.org/licenses/>.

    A copy of the LGPL-2.1 should have been provided with this program.
    If not, please refer to the URL above for details.

    该协议下，如果你修改了这个库且任何形式的发布，那么你必须开源修改后的库，同时提供
    修改后的库替换原版的引导，版权声明、许可证文本以及任何相关的免责声明不可被删除。
]]--
local Test = require("aurcore.test.init")
local Types = require("aurcore.types.init")
local Core = require("aurcore.core.init")

local i18n = Core:get_i18n()

local function validate_method(method, name)
    assert(method ~= nil, i18n:get_error_message("missingMethod", name))
    assert(type(method) == "function", i18n:get_error_message("notAFunction", name))
end

local function createFrameworkContainer(frameworkList)
    local apiCache = Types:new_obj("apiCache")

    local frameworkContainer = {
        del_cache = function(_, key)
            apiCache[key] = nil
        end,

        get_framework_list = function(_)
            return frameworkList
        end
    }
    frameworkContainer = Types:convert2obj("frameworkContainer", frameworkContainer)

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

--- @return AurCore
local function init(...)
    local frameworkList = { {test = function (self)
        return Test(self)
    end},... }
    assert(#frameworkList ~= 0, i18n:get_error_message("noFrameworks"))

    for i, framework in ipairs(frameworkList) do
        assert(type(framework) == "table", i18n:get_error_message("invalidFrameworkTypeForNthFramework", i))
    end

    local frameworkContainer = createFrameworkContainer(frameworkList)
    -- 确保所有关键方法都存在
    local requiredMethods = { "print", "log", "now", "uuid", "shared_map" }
    for _, methodName in ipairs(requiredMethods) do
        validate_method(frameworkContainer[methodName], methodName)
    end

    return Core:get_aurcore(frameworkContainer)
end

--- @class From
local from =  {
    from = init
}

return from