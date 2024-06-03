--- @class class
local classInterface = {}

--- @class classLib
local classLibInterface = {}

--- @return class
--- @param name string
--- @param super class|nil
--- @param ... any
function classLibInterface:new_class(name, super, ...) return {} end
function classInterface:include(...) end
function classInterface:init(fun) end
function classInterface:subclass() end
function classInterface:set_static_val() end
function classInterface:get_static_val() end
function classInterface:new(...) return {} end    -- 创建实例时传给init中注册的fun
return {
    classInterface = classInterface,
    classLibInterface = classLibInterface
}