--[[--------------------------------字符串处理-----------------------------------------

--------------------------------------------------------------------------------------]]

--- 分析并两头切割字符串，并处理Minecraft中的颜色代码
--- @param inputString string @要转换的原始字符串
--- @return table @一个包含处理后的字符串的数组
local function ActionbarLateralString(inputString)
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
    --将原字符串添加到序列首位
    local result = { inputString }
    --初始化颜色代码前缀
    local color = ""
    --循环直至字符串减为空
    while inputString ~= "" do
        --如果开头是颜色代码则剪出放入颜色代码前缀
        if string.sub(inputString, 1, 1) == (string.sub("§", 1, 1)) then
            local pattern = "^([%z\1-\127\194-\244][\128-\191]*)"
            local _, endIndex = string.find(inputString, pattern)
            inputString = string.sub(inputString, endIndex + 1)
            _, endIndex = string.find(inputString, pattern)
            color = color .. "§" .. string.sub(inputString, 1, endIndex)
            inputString = string.sub(inputString, endIndex + 1)
            --如果结尾是颜色代码则直接删除
        elseif checkend(inputString) then
            local pattern = "[%z\1-\127\194-\244][\128-\191]*$"
            local startIndex, endIndex = string.find(inputString, pattern)
            inputString = string.sub(inputString, 1, startIndex - 1)
            startIndex, endIndex = string.find(inputString, pattern)
            inputString = string.sub(inputString, 1, startIndex - 1)
            --如果头尾都不是颜色代码则前后各减去一个字符，然后加入序列
        else
            if inputString == "" then
                break
            end
            local _, endIndex = string.find(inputString, "^([%z\1-\127\194-\244][\128-\191]*)")
            inputString = string.sub(inputString, endIndex + 1)
            if inputString == "" then
                break
            end
            local startIndex, endIndex = string.find(inputString, "[%z\1-\127\194-\244][\128-\191]*$")
            inputString = string.sub(inputString, 1, startIndex - 1)
            if inputString == "" then
                break
            end
            table.insert(result, color .. inputString)
        end
    end

    return result
end

local function expanded_string_array(inputString)
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
    --将原字符串添加到序列首位
    local result = { inputString }
    --循环直至字符串减为空
    while inputString ~= "" do
        if checkend(inputString) then
            local pattern = "[%z\1-\127\194-\244][\128-\191]*$"
            local startIndex, endIndex = string.find(inputString, pattern)
            inputString = string.sub(inputString, 1, startIndex - 1)
            startIndex, endIndex = string.find(inputString, pattern)
            inputString = string.sub(inputString, 1, startIndex - 1)
            --如果尾不是颜色代码则减去一个字符，然后加入序列
        else
            if inputString == "" then
                break
            end
            local startIndex, endIndex = string.find(inputString, "[%z\1-\127\194-\244][\128-\191]*$")
            inputString = string.sub(inputString, 1, startIndex - 1)
            if inputString == "" then
                break
            end
            table.insert(result, inputString)
        end
    end

    return result
end

--[[--------------------------------AC方法部分-----------------------------------------



--------------------------------------------------------------------------------------]]

--- AC基类
--- @class AurCore
AurCore = {}

--- 初始化AC类的新实例
--- @return AurCore @AC类实例
function newAurCore(APIs)
    --- @class AurCore:ModuleFactory
    local instance = newModule(AurCore, nil, {
        prioritize = false,
        need_cache = false
    })
    -- 私有化属性
    instance.accessor = instance.accessor or {}
    function instance.accessor.get_apis()
        return APIs
    end

    return instance
end

-----------------打印系--------------------

function AurCore:printf(msg, ...)
    msg = string.format(msg, ...)
    self.accessor.get_apis().coromega:print(msg)
end

function AurCore:sprintf(msg, ...)
    return string.format(msg, ...)
end

function parseTextCommand(str)
    local parts = {}
    local pattern = "(.-)%$(.-)%$"
    local last_end = 1

    -- 匹配文本和命令并添加到数组
    for text, cmd in string.gmatch(str, pattern) do
        if last_end < str:find("%$", last_end) then
            table.insert(parts, { type = "text", value = text })
            table.insert(parts, { type = "command", value = cmd })
            last_end = last_end + #text + #cmd + 2 -- 更新上一次结束的位置
        end
    end

    -- 检查是否有剩余的文本段并添加到数组
    local remainingText = str:sub(last_end)
    if remainingText ~= "" then
        table.insert(parts, { type = "text", value = remainingText })
    end

    return parts
end

local actionbar_printer_addons = {
    sleep = function(msg_i, ...)
        local msgs
        if msg_i.mode == "expand" then
            msgs = { msg_i.expand_text }
        elseif msg_i.mode == "shrink_then_expand" then
            msgs = { msg_i.shrink_text, msg_i.expand_text }
        elseif msg_i.mode == "increment" then
            msgs = { msg_i.expand_text }
        end
        if msgs and #msgs > 0 then
            for _, msg in ipairs(msgs) do
                local parse_text_list = parseTextCommand(msg)
                for index, part in ipairs(parse_text_list) do
                    if part.type == "command" then
                        local result = {}
                        for word in string.gmatch(part.value, "[^:]+") do
                            table.insert(result, word)
                        end
                        if result[1] == "sleep" and #result > 1 then
                            parse_text_list[index] = function(ac)
                                ac.accessor.get_apis().coromega:sleep(tonumber(result[2]) or 0)
                            end
                        end
                    end
                end
                msg_i.parse_text_list = msg_i.parse_text_list or {}
                table.insert(msg_i.parse_text_list, parse_text_list)
            end
        end
    end,
}

local actionbar_printer_mode = {
    expand = function(ac, minimum_time_interval, msg_i, ...)
        local player_name = msg_i.player_name
        if not msg_i.parse_text_list then
            msg_i.parse_text_list = { {
                {
                    value = msg_i.expand_text or "",
                    type = "text"
                }
            } }
        end
        for _, value in ipairs(msg_i.parse_text_list) do
            for _, value2 in ipairs(value) do
                local old_text = ""
                if type(value2) == "function" then
                    value2(ac)
                elseif value2.type == "text" then
                    -- 获取起始和结束文本合并后的渐变数组
                    local textTransitionList = ActionbarLateralString("")
                    local str_list2 = ActionbarLateralString(value2.value)
                    for i = 1, #str_list2 do
                        table.insert(textTransitionList, str_list2[#str_list2 - i + 1])
                    end
                    -- 遍历每个文本变化步骤
                    for i = 1, #textTransitionList do
                        -- 暂停一个间隔时间
                        ac.accessor.get_apis().coromega:sleep(minimum_time_interval)
                        ac.accessor.get_apis().coromega:send_wo_cmd("title " ..
                            player_name ..
                            " actionbar " .. msg_i.prefix_text ..old_text..textTransitionList[i] .. msg_i.suffix_text)
                    end
                    print(textTransitionList[#textTransitionList])
                    old_text = old_text..textTransitionList[#textTransitionList]
                end
            end
        end
    end,
    shrink_then_expand = function(ac, minimum_time_interval, msg_i, ...)
        local player_name = msg_i.player_name
        if not msg_i.parse_text_list then
            msg_i.parse_text_list = { {
                {
                    value = msg_i.shrink_text or "",
                    type = "text"
                }
            }, {
                {
                    value = msg_i.expand_text or "",
                    type = "text"
                }
            } }
        end
        for index, value in ipairs(msg_i.parse_text_list) do
            for _, value2 in ipairs(value) do
                if type(value2) == "function" then
                    value2(ac)
                elseif value2.type == "text" then
                    -- 获取起始和结束文本合并后的渐变数组
                    local textTransitionList
                    local str_list2
                    if index == 1 then
                        textTransitionList = ActionbarLateralString(value2.value or "")
                        str_list2 = ActionbarLateralString("")
                    else
                        textTransitionList = ActionbarLateralString("")
                        str_list2 = ActionbarLateralString(value2.value or "")
                    end
                    table.insert(textTransitionList, "§r")
                    for i = 1, #str_list2 do
                        table.insert(textTransitionList, str_list2[#str_list2 - i + 1])
                    end
                    -- 遍历每个文本变化步骤
                    for i = 1, #textTransitionList do
                        -- 暂停一个间隔时间
                        ac.accessor.get_apis().coromega:sleep(minimum_time_interval)
                        ac.accessor.get_apis().coromega:send_wo_cmd("title " ..
                            player_name ..
                            " actionbar " .. msg_i.prefix_text .. textTransitionList[i] .. msg_i.suffix_text)
                    end
                end
            end
        end
    end,
    increment = function(ac, minimum_time_interval, msg_i, ...)
        local player_name = msg_i.player_name
        if not msg_i.parse_text_list then
            msg_i.parse_text_list = { {
                {
                    value = msg_i.expand_text or "",
                    type = "text"
                }
            } }
        end
        for _, value in ipairs(msg_i.parse_text_list) do
            for _, value2 in ipairs(value) do
                if type(value2) == "function" then
                    value2(ac)
                elseif value2.type == "text" then
                    -- 获取起始和结束文本合并后的渐变数组
                    local textTransitionList = expanded_string_array("")
                    local str_list2 = expanded_string_array(value2.value)
                    for i = 1, #str_list2 do
                        table.insert(textTransitionList, str_list2[#str_list2 - i + 1])
                    end
                    -- 遍历每个文本变化步骤
                    for i = 1, #textTransitionList do
                        -- 暂停一个间隔时间
                        ac.accessor.get_apis().coromega:sleep(minimum_time_interval)
                        ac.accessor.get_apis().coromega:send_wo_cmd("title " ..
                            player_name ..
                            " actionbar " .. msg_i.prefix_text .. textTransitionList[i] .. msg_i.suffix_text)
                    end
                end
            end
        end
    end,
    -- TODO参数化
    list = function(ac, minimum_time_interval, msg_i, ...)
        local player_name = msg_i.player_name
        local function generateIndentedLines(numLines)
            local lines = ""
            for i = 1, numLines do
                -- 每一行前面的空格数是当前行数减1乘以2（因为从第二行开始增加空格）
                local spacing = string.rep("  ", i - 1)
                lines = lines .. "  " .. spacing .. "▎" .. "\n"
            end
            return lines
        end
        function reduceSpacesAndAppend(inputString, appendStrings)
            -- 将输入字符串按行分割
            local function reduceLeadingSpace(inputString)
                -- 使用模式匹配检查字符串是否以空格开头
                if inputString:match("^ ") then
                    -- 如果以空格开头，去掉这个空格并返回修改后的字符串及true
                    return inputString:sub(2), true
                else
                    -- 如果不以空格开头，返回原字符串及false
                    return inputString, false
                end
            end
            local lines = {}
            for line in inputString:gmatch("[^\n]+") do
                table.insert(lines, line)
            end

            local result = {}
            local finish_line_count = 0
            local finish_line_num = {}
            while finish_line_count < #appendStrings do
                local result_i = ""
                for index, line in ipairs(lines) do
                    local new_line, ok = reduceLeadingSpace(line)
                    lines[index] = new_line
                    if ok then
                        result_i = result_i..new_line.."\n"
                    else
                        if not finish_line_num[index] then
                            finish_line_count = finish_line_count + 1
                            finish_line_num[index] = true
                        end
                        result_i = result_i..new_line.." "..appendStrings[index].."\n"
                    end
                end
                table.insert(result,result_i)
            end

            return result
        end

        local str_list = reduceSpacesAndAppend(generateIndentedLines(#msg_i.list_text), msg_i.list_text)
        for i = 1, #str_list do
            -- print(str_list[i])
            -- 暂停一个间隔时间
            ac.accessor.get_apis().coromega:sleep(0.07)
            ac.accessor.get_apis().coromega:send_wo_cmd("title " ..
                player_name .. " actionbar " .. msg_i.prefix_text .. str_list[i] .. msg_i.suffix_text)
        end
    end,
    normal = function(ac, minimum_time_interval, msg_i, ...)
        local player_name = msg_i.player_name
        ac.accessor.get_apis().coromega:send_wo_cmd("title " ..
                player_name .. " actionbar " .. msg_i.prefix_text .. msg_i.text .. msg_i.suffix_text)
    end
}

function AurCore:new_actionbar_printer(minimum_time_interval)
    local minimum_time_interval = minimum_time_interval
    local printer = {}
    local ac = self
    function printer:run(msg_list)
        -- TODO 插件后台运行
        -- TODO 插件间通信
        local execution_entity_list = {}
        for _, msg_i in ipairs(msg_list) do
            if msg_i.player_name and msg_i.mode then
                msg_i.addons      = msg_i.addons or {}
                msg_i.expand_text = msg_i.expand_text or ""
                msg_i.prefix_text = msg_i.prefix_text or ""
                msg_i.suffix_text = msg_i.suffix_text or ""
                local result      = {}
                for word in string.gmatch(msg_i.mode, "[^:]+") do
                    table.insert(result, word)
                end
                local msg_mode = actionbar_printer_mode[result[1]]
                if msg_mode then
                    local msg_addons = {}
                    for _, value in ipairs(msg_i.addons) do
                        local result2 = {}
                        for word in string.gmatch(value, "[^:]+") do
                            table.insert(result2, word)
                        end
                        if actionbar_printer_addons[result2[1]] then
                            table.insert(msg_addons, function()
                                actionbar_printer_addons[result2[1]](msg_i, unpack(result2, 2))
                            end)
                        end
                    end
                    table.insert(execution_entity_list, {
                        execute_fun = function()
                            msg_mode(ac, minimum_time_interval, msg_i, unpack(result, 2))
                        end,
                        addons = msg_addons
                    })
                end
            end
        end
        for _, exe_i in ipairs(execution_entity_list) do
            for _, addons_fun in ipairs(exe_i.addons) do
                addons_fun()
            end
            exe_i.execute_fun()
        end
    end

    return printer
end