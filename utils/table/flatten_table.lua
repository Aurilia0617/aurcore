--[[
    规则：
    数据保存时指定数据名；

    键类型：
    1、纯uuid字符串：代表这是一个单独存储单元，其值是数据名；
    2、不含uuid的字符串：代表这是一个数据名，其值是该数据uuid;
    3、uuid-type型：这是数据类型标识符，用于标识这是一个键值表(map)、数组(arr)或非表类型(val)
    4、uuid-val型：这是初始非表数据的值
    5、uuid-len型：这是表类数据的元素个数标记
        5.1、uuid-elem-x-type（x是元素次序，不会超过相应的uuid-len）：这是表元素类型标识符，用于标识这是一个键值表(map)、数组(arr)或非表类型(val)
        5.2、uuid-elem-x-val：非表时这是数据值，是表时，这是表uuid
        5.3、uuid-elem-x-key：仅为map类型时存在，代表对应键值
]]

local tableFlattener = {}

function tableFlattener:init(uuid_generator)
    function self:get_uuid()
        return uuid_generator()
    end
    return self
end

function tableFlattener:flatten(t, dataName, prefix, flat)
    prefix = prefix or "root"
    flat = flat or {}
    local uuid
    if prefix == "root" then
        uuid = self:get_uuid()
        flat[dataName] = uuid
        flat[uuid] = dataName
    else
        uuid = prefix
    end

    if type(t) == "table" then
        local is_array = #t > 0
        flat[uuid .. "-type"] = is_array and "arr" or "map"
        local i = 0
        for k, v in pairs(t) do
            i = i + 1
            local elem_prefix = uuid .. "-elem-" .. i
            if not is_array then
                flat[elem_prefix .. "-key"] = k
            end
            if type(v) == "table" then
                local nested_uuid = self:get_uuid()
                flat[elem_prefix .. "-type"] = type(v) == "table" and (#v > 0 and "arr" or "map") or "val"
                flat[elem_prefix .. "-val"] = nested_uuid
                self:flatten(v, dataName, nested_uuid, flat)
            else
                flat[elem_prefix .. "-type"] = "val"
                flat[elem_prefix .. "-val"] = v
            end
        end
        flat[uuid .. "-len"] = i
    else
        flat[uuid .. "-type"] = "val"
        flat[uuid .. "-val"] = t
    end
    return flat
end

function tableFlattener:unflatten(flat, dataName, uuid)
    uuid = uuid or flat[dataName]
    local t_type = flat[uuid .. "-type"]
    if t_type == "arr" or t_type == "map" then
        local t = {}
        local len = flat[uuid .. "-len"]
        for i = 1, len do
            local elem_prefix = uuid .. "-elem-" .. i
            local key = t_type == "map" and flat[elem_prefix .. "-key"] or i
            local elem_type = flat[elem_prefix .. "-type"]
            if elem_type == "map" or elem_type == "arr" then
                t[key] = self:unflatten(flat, dataName, flat[elem_prefix .. "-val"])
            else
                t[key] = flat[elem_prefix .. "-val"]
            end
        end
        return t
    else
        return flat[uuid .. "-val"]
    end
end

return tableFlattener
