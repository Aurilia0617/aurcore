local omega = require("omega")
local coromega = require("coromega").from(omega)
local ac = require("aurcore.init").from(coromega)

local needAcVersion = 1         -- 请勿修改，有的高版本并不能兼容低版本，除非你知道你在做什么
ac:check_version(needAcVersion) -- 检查当前版本的ac库是否兼容要求版本
ac:set_log_name("入服欢迎")

--[[
    因为有特殊格式, 指定地方需要加%s, 门槛较高, 因此不开放到配置中
    第一个%s放时间字符串
    第二个%s放旧版本号字符串
    第三个%s放新版本号字符串
    第四个%s放格式化的配置公告内容
]]
local annocementBox = [[
§a▎ §7%s正在为您读取最新更新§e♪~
§7更新时间：%s§r
§r§c〓〓§6〓〓§g〓〓〓§e〓〓〓〓§f〓〓〓〓〓〓〓〓〓〓§r
§l§bPot§cential§r 系统§e§lAlpha§r版本更新
Version: %s ➤ §a§l%s§r
%s§r§f〓〓〓〓〓〓〓〓〓〓§e〓〓〓〓§g〓〓〓§6〓〓§c〓〓§r
]]
local oldVersionCodeStr = "0.0.4"
local newVersionCodeStr = "0.0.5"
local annocementContent

local function format_annocement(types, symbol)
    local announcements = ""
    for _, value in ipairs(coromega.config[types]) do
        announcements = announcements .. symbol .. value .. "\n"
    end
    return announcements
end

local function init_annocementContent()
    local annocementList = format_annocement("更改", "§b➠§r ")
    annocementList = annocementList .. format_annocement("添加", "§a✚§r ")
    annocementList = annocementList .. format_annocement("修复", "§c✖§r ")

    annocementContent = annocementBox:format(
        coromega.config["看板娘称呼"],
        os.date("!%Y/%m/%d", coromega:now() - (2 * 24 * 60 * 60)),
        oldVersionCodeStr, newVersionCodeStr,
        annocementList
    )
end


local function check_config()
    local function is_array(t)
        if type(t) ~= "table" then return false end
        local i = 0
        for k in pairs(t) do
            i = i + 1
            if t[i] == nil then return false end
        end
        return true
    end
    local function assert_string(field)
        assert(type(coromega.config[field]) == 'string', field .. " 字段需要是字符串类型")
    end
    local function assert_string_array(field)
        assert(is_array(coromega.config[field]), field .. " 字段需要是字符串数组类型")
    end
    assert_string("Q群号")
    assert_string_array("修复")
    assert_string_array("更改")
    assert_string_array("添加")
    assert_string("服务器名")
    assert_string("服务器英文名")
    assert_string("玩法")
    assert_string("看板娘称呼")
end

local function toggle_actionbar_lock(player, lock)
    local action = lock and "lock_with_tag" or "unlock_with_tag"
    ac:get_score_manager()[action]({
        tag = player,
        lockName = "actionbar"
    })  -- 在计分板层面对actionbar栏进行上锁
    ac[action]({
        tag = player,
        lockName = "actionbar"
    })  -- 在插件层面对actionbar栏进行上锁
end

check_config()
init_annocementContent()
ac:on_player_login(function(player)
    -- 等待计分板管理器初始化完成, 因为本插件会有抢占actionbar栏的行为，需要统一控制
    ac:wait_for_scoreboards_init()

    local playerName = player:get_name()

    --玩家进服时晴天
    ac:wocmd("weather clear")
    ac:sleep(3)

    -- 获取玩家notWelcome tag以决定是否对玩家进行入服欢迎
    if player:get_saved_tag("notWelcome") then
        ac:log("玩家 %s 设置拒绝入服欢迎，已取消流程", playerName)
        ac:sleep(5)
        player:play_sound("random.toast")
        player:text("§a▎ §r你的入服欢迎已取消§a✔")
        return
    else
        ac:log("玩家 %s 没有设置或者开启了入服欢迎开关", playerName)
        player:set_temp_tag("入服欢迎中")
    end

    --检测玩家开始移动后开始入服欢迎
    local oldPos
    while true do
        local snow_socre = player:get_score("snow")
        if snow_socre and snow_socre ~= 0 then
            ac:log("玩家 %s 使用雪球菜单打断了入服欢迎", playerName)
            player:del_temp_tag("入服欢迎中")
            return
        end

        if not player:is_online() then
            ac:log("玩家 %s 动都没动就退出了游戏", playerName)
            return
        end

        local newPos = player:get_pos_str(2) --精确到2位小数
        oldPos = oldPos or newPos
        if newPos and newPos ~= oldPos then
            break
        end

        player:actionbar("§l§c请移动一下以激活功能")
        ac:sleep(0.5)
    end

    toggle_actionbar_lock(player, true)

    -- 主流程
    player:changing_actionbar("§l§c请移动一下以激活功能", "§a▎ §b§l激活成功§r §a▎")
    ac:sleep(1)
    player:play_sound("conduit.activate")
    player:text("§o§e▍§c▍§b▍ §r§l§c[中国版]§r§l§b%s -> §e%s§a✧§e纯净生存\n§r§fＷｅｌｃｏｍｅ ｔｏ §b%s §cＳｅｒｖｅｒ ！", playerName,
        coromega.config["服务器名"], coromega.config["服务器英文名"], coromega.config["玩法"])
    player:play_sound("mob.cat.meow")
    player:title_time(0.3, 2, 0.5)
    player:title("§b§l✽ §r§e%s§l§b ✽", coromega.config["服务器名"])
    player:subtitle("§a" .. playerName .. " §f我们等你好久了")
    player:changing_actionbar("§a▎ §b§l激活成功§r §a▎", "§o§7◂▎§f▍ §r§7正在拉起固有弹窗 §o§f▍§7▎▸")

    ac:sleep(2)
    player:text("§rＪｏｉｎ §l§eＱ§rＧｒｏｕｐ §7>> §b§l%s", coromega.config["Q群号"])
    player:play_sound("mob.cat.straymeow")
    player:title("§6遇§g到§e困难了§f？")
    player:subtitle("§e" .. playerName .. " §f前往群聊与大家讨论吧~")
    player:changing_actionbar("§o§7◂▎§f▍ §r§7正在拉起固有弹窗 §o§f▍§7▎▸", "§o§7◂▎§f▍ §r§7正在拉起群引导弹窗 §o§f▍§7▎▸")

    ac:sleep(2)
    player:play_sound("mob.cat.purreow")
    player:title("§fＴｈｅ Ｐｏｔｅｎｔｉａｌ ")
    player:subtitle("§7系统版本： §e§o§7§lAlpha§f-§bv%s", newVersionCodeStr)
    player:changing_actionbar("§o§7◂▎§f▍ §r§7正在拉起群引导弹窗 §o§f▍§7▎▸",
        "§o§7◂▎§f▍ §r§7正在拉起 §e§l" .. playerName .. "§7 的数据寄存器 §o§f▍§7▎▸")

    ac:sleep(2)
    player:play_sound("mob.cat.purr")
    player:changing_actionbar("§o§7◂▎§f▍ §r§7正在拉起 §e§l" .. playerName .. "§7 的数据寄存器 §o§f▍§7▎▸", "=￣ω￣= §7弹窗炫完了，喵喵去睡觉了~")

    ac:sleep(2)
    player:play_sound("mob.sheep.shear")
    player:text(annocementContent)
    player:changing_actionbar("=￣ω￣= §7弹窗炫完了，喵喵去睡觉了~", "数据初始化完成，可以使用菜单啦~")
    player:play_sound("random.toast")
    --player:text("§a▎ §7初始化完成，系统功能已向你开放~\n  试试在聊天栏输入 §b110 §7或 §bomg")
    player:text("§a▎ §7初始化完成，系统功能已向你开放~")

    toggle_actionbar_lock(player, false)
    player:del_temp_tag("入服欢迎中")
    ac:log("玩家 %s 完成了入服欢迎", playerName)
end)

coromega:run()
