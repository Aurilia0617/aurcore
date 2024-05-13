local Types = require("aurcore.types.init")
local I18n = require("aurcore.core.utils.i18n.init")
local Cofig = require("aurcore.core.config.init")
local color = require("aurcore.lib.vendor.color.ansicolors")
print(color.chart())
require("aurcore.apis.init") -- 引入套壳emmylua以压缩成单文件时导入

local resource = Types:new_obj("resource")
---@class I18nClass
local _i18n = I18n:new(Cofig)

function resource:get_i18n()
    return _i18n
end

function resource:init(frameworkContainer)
    function resource:get_test_fun()
        return function(o)
            frameworkContainer.test(o)
        end
    end
end

return resource
