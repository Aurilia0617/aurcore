--- @class Class
local class_interface = {}

--- 包含模块到类
--- @param ... any 模块列表
function class_interface:include(...) end

--- 初始化类
--- @param fun function 初始化函数
function class_interface:init(fun) end

--- 创建子类
function class_interface:subclass() end

--- 设置静态变量值
--- @param key string 静态变量名
--- @param val any 静态变量值
function class_interface:set_static_val(key, val) end

--- 获取静态变量值
--- @param key string 静态变量名
--- @return any 静态变量值
function class_interface:get_static_val(key) end

--- 创建实例并调用初始化函数
--- @param ... any 传递给初始化函数的参数
--- @return Class 实例
function class_interface:new(...) return {} end

--- @class ClassLib
local class_lib_interface = {}

--- 创建新类
--- @param name string 类名
--- @param super Class|nil 父类
--- @param ... any 其他参数
--- @return Class 新创建的类
function class_lib_interface:new_class(name, super, ...) return {} end

return {
    classInterface = class_interface,
    classLibInterface = class_lib_interface
}
