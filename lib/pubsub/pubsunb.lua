local PubSubFactory = {}

-- 创建一个新的PubSub实例
function PubSubFactory.new()
    local self = {
        subscribers = {},
        processing = false,
        defer = {},
        destroyed = {}
    }

    -- 获取或创建一个给定事件名称的订阅者队列
    local function subscriber_queue(name)
        self.subscribers[name] = self.subscribers[name] or {}
        return self.subscribers[name]
    end

    -- 发布事件的接口
    function self.pub(name, ...)
        if self.processing then
            table.insert(self.defer, { name, ... })
            return
        end

        self.processing = true
        do
            local queue = subscriber_queue(name)
            for i, callback in ipairs(queue) do
                if callback(...) then
                    table.insert(self.destroyed, i)
                end
            end

            for i = #self.destroyed, 1, -1 do
                table.remove(queue, self.destroyed[i])
                self.destroyed[i] = nil
            end
        end
        self.processing = false

        local e = table.remove(self.defer, 1)
        if e then
            self.pub(unpack(e))
        end
    end

    -- 订阅事件的接口
    function self.sub(name, callback)
        local queue = subscriber_queue(name)

        local function subscriber(...)
            if callback then
                callback(...)
            else
                return true
            end
        end

        table.insert(queue, subscriber)

        return function()
            callback = nil
        end
    end

    -- 一次性订阅接口
    function self.sub_once(name, callback)
        local unsub; unsub = self.sub(name, function(...)
            unsub()
            callback(...)
        end)
    end

    -- 多次订阅接口
    function self.sub_many(name, callback, num)
        assert(num >= 1)
        local count = 0
        local unsub; unsub = self.sub(name, function(...)
            count = count + 1
            if count == num then
                unsub()
            end
            callback(...)
        end)
    end

    return self
end

return PubSubFactory
