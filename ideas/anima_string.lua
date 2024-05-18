--- 字符串工厂基类
--- @class AnimaStringFactory
AnimaStringFactory = {}

--- 创建一个新的字符串生成器实例
--- @param data table @初始化表,包含now_fun,print_fun,log_fun,name(可选)
--- @return AnimaStringFactory @返回一个字符串生成器的实例
local function newAnimaStringFactory(data)
    --- @class AnimaStringFactory:ModuleFactory
    local instance = newModule(data.name or "字符生成", {
        need_cache = true,  --是否缓存
        need_logger = true, --是否需要日志
        logger_now = function()
            if data.now_fun then
                return data.now_fun()
            end
            return 0
        end,
        logger_default_print = function(msg)
            if data.print_fun then
                return data.print_fun(msg)
            end
            return print(msg)
        end,
        logger_default_log = function(msg)
            if data.log_fun then
                return data.log_fun(msg)
            end
            return print(msg)
        end,
        logger_config = { log_level = log_levels.string },
        debug_stack_depth = data.debug_stack_depth
    }, AnimaStringFactory)
    return instance
end

---解析输入字符串并返回一个展开的字符串数组
---@param inputString string 输入的字符串
---@return string[] @返回一个字符串数组
function AnimaStringFactory:expand_string_array(inputString)
    --检查字符串是否是以"§*"格式结尾
    local function checkend(str)
        local pattern = "[%z\1-\127\194-\244][\128-\191]*$"
        local startIndex, endIndex = string.find(str, pattern)
        str = string.sub(str, 1, startIndex - 1)
        startIndex, endIndex = string.find(str, pattern)
        if startIndex == nil or endIndex == nil then
            return false
        end
        return string.sub(str, startIndex, endIndex) == "§"
    end
    -- 去除末尾的颜色代码（双字符）
    local function trim_tring(str)
        local pattern = "[%z\1-\127\194-\244][\128-\191]*$"
        local startIndex, _ = string.find(str, pattern)
        str = string.sub(str, 1, startIndex - 1)
        startIndex, _ = string.find(str, pattern)
        str = string.sub(str, 1, startIndex - 1)
        return str
    end
    --将原字符串添加到序列首位
    local result = { inputString }
    --循环直至字符串减为空
    while inputString ~= "" do
        if checkend(inputString) then
            inputString = trim_tring(inputString)
        else --如果尾不是颜色代码则减去一个字符，然后加入序列
            if inputString == "" then
                break
            end
            local startIndex, _ = string.find(inputString, "[%z\1-\127\194-\244][\128-\191]*$")
            inputString = string.sub(inputString, 1, startIndex - 1)
            while inputString ~= "" do
                if checkend(inputString) then
                    inputString = trim_tring(inputString)
                else
                    break
                end
            end
            if inputString == "" then
                break
            end
            table.insert(result, inputString)
        end
    end

    return result
end