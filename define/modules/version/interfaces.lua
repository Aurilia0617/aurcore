--- @class VersionLib
local t = {}

---@class versionChecker
local versionCheckerInterface = {}
--- @class versionRange
local versionRange = {}

local version_module_interface = require("aurcore.define.modules.version.module")

-- 转化为可比较、可tostring打印（版本号|nil, err）的对象
function versionCheckerInterface:convert2version(versionStr) end

-- 同上，但是要求versionStr必须符合x.x.x的格式
function versionCheckerInterface:strict_check_version(versionStr) end

-- 获得一个范围对象
--- @return versionRange
function versionCheckerInterface:range(start, tail) return {} end

for key, value in pairs(version_module_interface) do
    versionCheckerInterface[key] = value
end

-- 从范围中添加某个版本或者范围
function versionRange:add(...) end

-- 从范围中减去某个版本或者范围
function versionRange:del(...) end

function versionRange:matches(...) end

return {
    version_checker_interface = versionCheckerInterface,
    version_range = versionRange,
}