local t = {}

function t:set_class_method(key, val)
    self.static[key] = val
end

function t:on_init(fun)
    self.initialize = fun
end

function t:on_subclassed(fun)
    self.static.subclassed = fun
end

function t:is_subclass_of(class)
    return self:isSubclassOf(class)
end

function t:mixin(list)
    self:include(list)
    self._name_ = nil
    return self
end

return t