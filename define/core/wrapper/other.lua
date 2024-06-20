---@class WrapperOther
local t = {}

function t:test()
    return {}
end

---@return Logger
function t:get_logger(name)
    return {}
end

return t