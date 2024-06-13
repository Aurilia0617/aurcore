local Hub = require("aurcore.hub")
local Config = Hub:get_config()
local I18n = Hub:get_i18n()

local LockManager = Hub:new_class("LockManager")

LockManager:init(function (instance, container)
    instance._shared_map = container:shared_map()
    instance._root_tag = Config.collaborator_tag .. "-lock"
    instance._sleep = function (...)
        container:sleep(...)
    end
end)

--- 锁定指定的key
--- @param key string 需要锁定的key
--- @return boolean 是否成功锁定
function LockManager:lock(key)
    while true do
        local _, loaded = self._shared_map:load_or_store(self._root_tag .. key, true)
        if not loaded then
            return true
        end
        self._sleep(0.001)
    end
end

--- 解锁指定的key
--- @param key string 需要解锁的key
function LockManager:unlock(key)
    assert(self._shared_map:compare_and_swap(self._root_tag .. key, true, nil), I18n:error_msg("lock_key_not_exist", key))
end

--- 尝试锁定指定的key
--- @param key string 需要尝试锁定的key
--- @return boolean 是否成功锁定
function LockManager:trylock(key)
    local _, loaded = self._shared_map:load_or_store(self._root_tag .. key, true)
    return not loaded
end

--- 获取指定key的锁状态
--- @param key string 需要获取状态的key
--- @return boolean 锁是否被占用
function LockManager:get_lock_state(key)
    return self._shared_map:get(self._root_tag .. key) ~= nil
end

return LockManager
