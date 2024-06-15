--- @class LockManager
--- @field _shared_map table
--- @field _root_tag string
--- @field _sleep function
local LockManager = {}
--- 锁定指定的key
--- @param key string 需要锁定的key
--- @return boolean 是否成功锁定
function LockManager:lock(key) return true end

--- 解锁指定的key
--- @param key string 需要解锁的key
function LockManager:unlock(key) end

--- 尝试锁定指定的key
--- @param key string 需要尝试锁定的key
--- @return boolean 是否成功锁定
function LockManager:trylock(key) return true end

--- 获取指定key的锁状态
--- @param key string 需要获取状态的key
--- @return boolean 锁是否被占用
function LockManager:get_lock_state(key) return true end

return LockManager