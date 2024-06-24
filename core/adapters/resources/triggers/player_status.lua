local t = {}

function t:on_player_login(fun)
    self:when_player_change():start_new(function(player, action)
        if action == "online" then
            fun(self:get_player(player))
        end
    end)
end

return t