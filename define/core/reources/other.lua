---@class ResourcesOther
local t = {}

--- @class API:Wrapper
local t2 = {}

--- @return API
function t:new_ac(o)
    return {}
end

---@return Logger
function t:get_logger(name)
    return {}
end

---@return Logger
function t:get_raw_logger()
    return {}
end

---@return Resources
function t:get_framework()
    return {}
end

function t:test() end

return t