function LoggerFactory:set_log_level(num)
    if type(num) ~= "number" then
        return
    end
    self.accessor:set_log_level(num)
end

function LoggerFactory:info(msg, ...)
    msg = string.format(msg, ...)
    self.accessor:print(4,
        ("%s [%s] %s %s%s" .. "\27[0m"):format(os.date("!%H:%M:%S", self.accessor:now()), self.accessor:get_name(),
            self.accessor:get_level_header(4), self.accessor:get_level_body(4), msg))
end

function LoggerFactory:set_debug_stack_depth(num)
    if type(num) ~= "number" then
        self:error("你设置的debug栈深不为数字，保持原栈深")
        self:warn("将在不是期望的debug显示行数下继续运行程序")
        return
    end
    self.accessor:set_debug_stack_depth(num)
end

function LoggerFactory:debug(msg, ...)
    local function get_debug_line()
        local info = debug.getinfo(self.accessor:get_debug_stack_depth(), "Sl") -- "S"和"l"分别表示要获取的信息是源(source)和当前行(line)。
        if info then
            return info.currentline
        else
            return "未知行数"
        end
    end
    msg = string.format(msg, ...)
    self.accessor:print(6,
        ("%s [%s] %s %s%s" .. "\27[0m" .. "\027[90m line:%s\027[0m"):format(os.date("!%H:%M:%S", self.accessor:now()),
            self.accessor:get_name(), self.accessor:get_level_header(6), self.accessor:get_level_body(6), msg,
            get_debug_line()))
end

function LoggerFactory:error(msg, ...)
    msg = string.format(msg, ...)
    self.accessor:_log(2,
        ("%s %s[%s] %s\n" .. debug.traceback() .. "\27[0m"):format(self.accessor:get_level_header(2),
            self.accessor:get_level_body(2), self.accessor:get_name(), msg))
end

function LoggerFactory:warn(msg, ...)
    msg = string.format(msg, ...)
    self.accessor:_log(3,
        ("%s %s[%s] %s" .. "\27[0m"):format(self.accessor:get_level_header(3), self.accessor:get_level_body(3),
            self.accessor:get_name(), msg))
end

function LoggerFactory:succ(msg, ...)
    msg = string.format(msg, ...)
    self.accessor:print(5,
        ("%s [%s] %s %s%s" .. "\27[0m"):format(os.date("!%H:%M:%S", self.accessor:now()), self.accessor:get_name(),
            self.accessor:get_level_header(5), self.accessor:get_level_body(5), msg))
end

function LoggerFactory:log(msg, ...)
    msg = string.format(msg, ...)
    self.accessor:log(msg)
end

function LoggerFactory:printf(msg, ...)
    msg = string.format(msg, ...)
    self.accessor:print(msg)
end

function LoggerFactory:raw_printf(msg, ...)
    msg = string.format(msg, ...)
    print(msg)
end

local default_config = {
    headers = { -- 标签样式
        "NONE",
        "\027[41m\027[37m\27[1m ERRO \027[0m",
        "\027[103m\027[30m\27[1m WARN \027[0m",
        "\027[44m\027[37m\027[1m INFO \027[0m",
        "\027[102m\027[1m\027[30m SUCC \027[0m",
        "\027[45m\027[37m\027[1m DBUG \027[0m"
    },
    body = { -- 字体样式
        "",
        "\27[1m\27[31m",
        "\27[1m\27[33m",
        "\27[1m\27[34m",
        "\27[1m\27[92m",
        "\27[1m\27[35m"
    },
    log_level = 2, --当前日志机日志等级
}