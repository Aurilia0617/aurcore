return function(name, pre)
    local const_t = { _name = name } -- 该表中的值不会混入和被混入，因为目标类的相应位置也属于const
    if pre then
        pre._CONST = pre._CONST or {}
        pre._CONST._name = pre._CONST._name or name
    end
    local t = pre or {
        _CONST = const_t
    }
    if t.get_const == nil and t.set_const == nil then
        function t:set_const(key, val)
            assert(const_t[key] == nil, ("key %s already exists"):format(key))
            const_t[key] = val
        end

        function t:get_const(key)
            return const_t[key]
        end
    end
    return t
end
