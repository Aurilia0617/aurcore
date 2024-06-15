return function (container)
    function container:on_player_login(fun)
        container:when_player_change():start_new(function(player, action)
            if action == "online" then
                fun(player)
            end
        end)
    end
end