return function (interface)
    --- @class container
    interface = interface
    --- 设置玩家登录事件的回调函数
    --- @param callback function 玩家登录时调用的回调函数, 获得玩家对象
    function interface:on_player_login(callback) end
end