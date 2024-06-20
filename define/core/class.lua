--- @class Class
local class_interface = {}

--- 混入模块到类
--- @param ... table<string, any>[] 模块列表（其中的included函数不会被混入，只会被触发，static属性会混入到类的静态方法）
function class_interface:mixin(...) end

--- 设置创建实例时执行的初始化函数
--- @param fun function 初始化函数（函数执行时获得类实例和传入的参数）
function class_interface:on_init(fun) end

--- 创建子类
--- @param subclass_name string 子类名称
function class_interface:subclass(subclass_name) end

--- 创建子类
--- @param fun function 创建子类时执行的函数（获得类和子类）
function class_interface:on_subclassed(fun) end

--- 设置类方法(字段或函数，函数执行时获得类和传入的参数)
--- @param key string 静态变量名
--- @param method any 静态变量值
function class_interface:set_class_method(key, method) end

--- 是否是传入的类的子类
function class_interface:is_subclass_of(check_class) end

--- 创建实例并调用初始化函数
--- @param ... any 传递给初始化函数的参数
--- @return table 实例
function class_interface:new(...) return {} end

--- @class ClassManager
local class_manager_interface = {}

--- 创建新类
--- @param name string 类名
--- @param super Class|nil 父类
--- @param ... any 其他参数
--- @return Class 新创建的类
function class_manager_interface:new_class(name, super, ...) return {} end

--- 新建混入表
---@param name string 混入表标识
---@param fun function|nil 被混入时执行的函数（获得混入后的类）
---@return table
function class_manager_interface:new_mixin(name, fun) return {} end

--- @class ClassInstance
local class_instance_interface = {}

function class_instance_interface:is_instance_of(class) end

return {
    class_interface = class_interface,
    class_manager_interface = class_manager_interface,
    class_instance_interface = class_instance_interface
}
