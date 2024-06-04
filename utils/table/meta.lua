--- 添加有tostring元方法的元表
--- @param pre table
--- @param name string
--- @return table
local function add_tostring(_, name, pre)
    return setmetatable(pre or {}, {
        __tostring = function()
            return name
        end
    })
end

--- 检查方法是否存在并且是函数
--- @param unitTestLib table 单元测试目标库
--- @param Interface table 接口表
--- @return boolean
local function check_method(_, moduleName, unitTestLib, Interface)
    for key, _ in pairs(Interface) do
        local method = unitTestLib[key]
        assert(method, ("The %s interface is missing the method %s"):format(moduleName, key))
        assert(type(method) == "function", ("%s is not a function"):format(key))
    end
    return true
end

local function add_as_alternative(_, source, new)
    return setmetatable({}, {
        __index = function(_, name)
            local val = source[name]
            if val ~= nil then
                return val
            else
                return new[name]
            end
        end
    })
end

local function add_as_priority(_, source, new)
    return setmetatable({}, {
        __index = function(_, name)
            local val = new[name]
            if val ~= nil then
                return val
            else
                return source[name]
            end
        end
    })
end

-- 添加新模块到资源容器中
local function add_to_module_container(_, resource, newModuleName, newModule)
    -- 获得资源的元表，若不存在则创建默认模块容器元表
    local moduleContainer = getmetatable(resource) or { name = "module_container" }

    -- 初始化模块列表和缓存
    local function initializeModuleContainer(container)
        container.moduleList = container.moduleList or { name = "module_container_moduleList" }
        container.apiCache = { name = "module_container_cache" }
    end

    -- 更新模块元表的 __index 方法
    local function updateMetatable(resource, container, moduleList, oldIndex)
        setmetatable(resource, {
            __index = function(_, key)
                if not container.apiCache[key] then
                    for _, object in pairs(moduleList) do
                        local item = type(object) == "table" and object[key]
                        if item then
                            container.apiCache[key] = item
                            break
                        end
                    end
                end
                local item = container.apiCache[key]
                if not item and oldIndex then
                    if type(oldIndex) == "function" then
                        item = oldIndex(_, key)
                    else
                        item = oldIndex[key]
                    end
                end
                return item
            end,
            name = "module_container_mt"
        })
    end

    -- 处理资源的元表
    if moduleContainer.name == "module_container" then
        -- 如果元表是模块容器，直接添加新模块
        initializeModuleContainer(moduleContainer)
        moduleContainer.moduleList[newModuleName] = newModule
        updateMetatable(resource, moduleContainer, moduleContainer.moduleList)
    else
        -- 处理拥有未知元表的情况
        local oldMt = moduleContainer
        local newModuleContainer = { name = "module_container" }
        initializeModuleContainer(newModuleContainer)
        newModuleContainer.moduleList[newModuleName] = newModule
        local oldIndex = oldMt.__index
        updateMetatable(resource, newModuleContainer, newModuleContainer.moduleList, oldIndex)
    end

    return resource
end



return {
    add_tostring = add_tostring,
    check_method = check_method,
    add_as_alternative = add_as_alternative,
    add_as_priority = add_as_priority,
    add_to_module_container = add_to_module_container
}
