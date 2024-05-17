local omega = require("omega")
local coromega = require("coromega").from(omega)
local ac = require("aurcore").from(coromega)

local silo = {
    _VERSION     = "silo v0.0.1",
    _ACVERSION   = "v0.1.1", -- 该值请勿修改，因为ac库之间的版本可能不兼容，会出Bug
    _DESCRIPTION = [[
        这是NeOmega自带的仓库插件的二改版本

        - 添加了仓库权限管理;

        - 仓库可导出
            用于换服什么的物品跨存档传输

        - 仓库可导入
            要求你是有导入权限的（绝大部分云裳用户或者个别被授权的用户）

        - 仓库添加删除选项

        - 仓库支持非所有者的访问的记录
            1号仓库将被系统占有用于部署支持记录的命令方块组(?cb)
    ]],
    _URL         = 'https://github.com/kikito/middleclass' -- 如果提示你的ac库版本不适配，可以从这里获取对应版本的本插件
}

function silo:new()
    -- 坐标大小自动排序
    self.instance = ac:get_new_silo_manager(coromega.config["仓库边长"],
        coromega.config["仓库x轴起始坐标"], coromega.config["仓库x轴终点坐标"],
        coromega.config["仓库z轴起始坐标"], coromega.config["仓库z轴终点坐标"])
end

-- 系统占有1号仓库并部署访问记录命令方块（带常加载）和记录回调触发器
function silo:init()
    ac:check_version(self._ACVERSION)
    ac:set_log_name("个人仓库")
    self:new()
end

-- 记录非仓库所有者（访客）进入仓库的访问记录
function silo:visitor_log(siloInfo, player)

end

function silo:get_root_menu_head(player)

end

function silo:get_root_menu_tail(player)

end

function silo:return_my_silo(player)

end

function silo:apply_for_new_silo(player)

end

--[[
    当有旧仓库的玩家申请恢复旧仓库时（仅可成功一次），将在仓库列表中新分配一个仓库给
    这个玩家（要求其最大仓库数上限仍有剩余），并从之前导出的存档中仅选取这个玩家的仓
    库导入覆盖这个新仓库。如果该玩家拥有的仓库数已达上限则无法恢复导出的旧仓库
]]
local canImport = coromega.config["你是否有导入权限"]
function silo:restore_silo_from_old_save(player)

end

function silo:abandon_silo(player)

end

function silo:export()

end

function silo:overwrite_new_reset_silo_with_old(mcworldPath, DBPath)

end

--[[
    如果 未启用命令方块 或者 常加载区域已满 或者 1号仓库常加载被清除，将不会记录
    将每隔60秒检测一次1号仓库的常加载是否存在，以此结果作为访问记录失效时间戳
]]
function silo:silo_access_history(player)
    --[[
        检测间隔，单位秒，不建议设为0
        当有新记录来临时，说明当前可用，重置检测间隔以减少命令发送次数
    ]]
    local detectionInterval = 60
end

function silo:engage_with_root_menu(player)
    local rootMenu = ac:new_chat_menu()
    rootMenu:set_box(self:get_root_menu_head(player), self:get_root_menu_tail(player))
    rootMenu:set_options({
        { optionName = "返回仓库", cb = self.return_my_silo },
        { optionName = "申请仓库", cb = self.apply_for_new_silo },
        { optionName = "恢复仓库", cb = self.restore_silo_from_old_save },
        { optionName = "抛弃仓库", cb = self.abandon_silo },
        { optionName = "访问记录", cb = self.silo_access_history }
    })
    rootMenu:boot(player)
end

-- silo:init()
coromega:when_called_by_game_menu({
    triggers = { "个人仓库" },
    argument_hint = "",
    usage = "",
}):start_new(function(chat)
    local player = ac:get_player(chat.name)
    if player then
        player:set_temp_tag("入服欢迎中")
        silo:engage_with_root_menu(player)
        player:del_temp_tag("入服欢迎中")
        ac:log("玩家 %s 结束了仓库菜单的使用", chat.name)
    else
        ac:warn("玩家 %s 的玩家对象获取失败，其唤醒仓库菜单的操作已取消", chat.name)
    end
end)

coromega:when_called_by_terminal_menu({
    triggers = { "exportSilo" },
    argument_hint = "",
    usage = "导出服内的仓库区为存档",
}):start_new(function(input)
    -- 两个文件，一个是mcworld存档，一个是仓库数据库文件
    silo:export()
end)

coromega:when_called_by_terminal_menu({
    triggers = { "importSilo" },
    argument_hint = "",
    usage = "将旧仓库覆盖当前仓库（需要你有导入权限）",
}):start_new(function(input)
    -- 如果非1号仓库已经有人申请，则打印信息（前三条）并要求二次确认
    silo:overwrite_new_reset_silo_with_old()
end)

coromega:run()
