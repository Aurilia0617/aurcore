--- @class MapProcessor:ModuleInterface
local MapProcessor = { _cname = "MapProcessor" }

-- 将嵌套的map结构扁平化
function MapProcessor:flattened_map(map_name, map, is_root, ...)
    local args = {...}
    local function is_array(t)
        local max = 0
        local count = 0
        for k, v in pairs(t) do
            if type(k) == "number" then
                if k > max then max = k end
                count = count + 1
            else
                return false
            end
        end
        if max == count then
            return true
        else
            return false
        end
    end
    local result = {}
    local uuid = args[1] or self:get_apis():uuid()
    if is_root then
        result[uuid] = map_name
        result[map_name] = uuid
    else
    end
    if is_array(map) then
        result[uuid.."_type"] = "arr"
        result[uuid.."_len"] = #map
        -- 数组处理
        for index, value in ipairs(map) do
            if type(value) == "table" then
                if is_array(value) then
                    result[uuid.."_elem_"..index.."_type"] = "arr"
                else
                    result[uuid.."_elem_"..index.."_type"] = "map"
                end
                local new_t_uuid = self:get_apis():uuid()
                result[uuid.."_elem_"..index.."_val"] = new_t_uuid
                local sub_t = self:flattened_map(nil,value,false,new_t_uuid)
                for key, val in pairs(sub_t) do
                    result[key] = val
                end
            else
                result[uuid.."_elem_"..index.."_type"] = "val"
                result[uuid.."_elem_"..index.."_val"] = value
            end
        end
    else
        -- 键值表或者混合表处理
        local len = 0
        for key, value in pairs(map) do
            len = len + 1
            result[uuid.."_elem_"..len.."_key"] = key
            if type(value) == "table" then
                if is_array(value) then
                    result[uuid.."_elem_"..len.."_type"] = "arr"
                else
                    result[uuid.."_elem_"..len.."_type"] = "map"
                end
                local new_t_uuid = self:get_apis():uuid()
                result[uuid.."_elem_"..len.."_val"] = new_t_uuid
                local sub_t = self:flattened_map(nil,value,false,new_t_uuid)
                for key, val in pairs(sub_t) do
                    result[key] = val
                end
            else
                result[uuid.."_elem_"..len.."_type"] = "val"
                result[uuid.."_elem_"..len.."_val"] = value
            end
        end
        result[uuid.."_type"] = "map"
        result[uuid.."_len"] = len
    end
    return result
end

-- 从保存的扁平化的map结构恢复为正常的嵌套map结构
function MapProcessor:restore_to_nested_map(map_name)
    local shared_map = self:get_apis():shared_map()
    local result = {}
    local map_uuid = shared_map:get(map_name)
end
