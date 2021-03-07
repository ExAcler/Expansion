
txt_messages = D2Editor.newRichText()    -- 游戏记录 (富文本框)
function init_run()
-- 函数执行队列 (定时器) --
funcptr_queue = {}
funcptr_i = 1

-- 游戏记录 --
message_list = {}

-- 标识符 --
game_skip_mopai = false    -- 跳过摸牌阶段标识
game_skip_chupai = false    -- 跳过出牌阶段标识
game_victory = false    -- 游戏胜利标识

-- 状态信息 --
jiaohu_text = ""    -- 交互提示区文字
skill_text_1 = ""; skill_text_2 = ""    -- 当前武将技能提示文字
gamerun_huihe = ""    -- 回合阶段 ("开始"、"判定"、"摸牌"、"出牌"、"弃牌"、"结束"、"游戏结束")
gamerun_status = ""    --[[游戏状态
                           选择目标： 使用 "杀"、锦囊等需指定作用目标的卡牌时
								选择目标-B：使用 "借刀杀人" 选择目标A确定之后的状态
						   手牌生效中：卡牌需要队列执行效果时
						   观看手牌 ("-拆、-顺"、"-杀")：使用一些卡牌需要选择对方手牌时
						   牌堆选择 ("-五谷")：使用一些卡牌、技能等需要翻开牌堆顶数张牌并选择时
						   主动出牌 ("-决斗"、"-火攻"、"-青龙"、"-贯石"、"-刚烈")：使用一些卡牌需要己方进一步响应时
						   技能选择 ("-单牌"：选取单张牌、"-多牌"：选取多张牌、"-目标"：选取目标状态)
						   确认操作：技能等需要确认发动的
					   --]]
last_status = ""    -- 上一个状态：用于技能从选择目标返回单牌或多牌选择时

gamerun_target_selected = 0    -- "选择目标"状态选取的目标 ID
gamerun_skill_selected = 0    -- 高亮选取的武将技能 (1 - 4，0为不选取)
gamerun_OK = false; gamerun_OK_ptr = nil
last_OK = false    -- 上一个OK状态：用于技能时

gamerun_tab_ptr = nil
imp_card = ""    -- 武将技能发动时要实现的卡牌名称

gamerun_guankan_type = {}    -- "观看手牌"状态牌类型 (格式：{类型, 附加值})
gamerun_guankan_selected = 1    -- "观看手牌"状态选取的目标牌
guankan_s = 0    -- "观看手牌"作用源 (兼作火攻选择花色、贯石斧（五谷丰登）来源手牌临时存储，借刀杀人的目标A)
guankan_d = 0    -- "观看手牌"作用目标
gamerun_temp = 0
lianhuan_va = nil    -- 连环伤害传导前，若有麒麟弓结算，伤害函数va_list的存储
sha_va = nil    -- 发动寒冰剑后，杀来源目标的va_list存储

funcptr_add_tag = nil	-- 如果设置为一个字符串，则设置的字符串会被加入到之后的每一个funcptr_queue项的tag

wuxie_queue_jinnang = {}	-- 无懈可击未执行时，原有的函数执行队列
wuxie_queue_xiangying = {}	-- 无懈可击轮到己方响应时，记录原有的他方响应函数队列，以便己方不使用无懈时恢复原有轮询（兼鬼才、鬼道）
wuxie_queue_xiangying_i = 0	-- 无懈可击轮到己方响应时，原有函数队列的执行位置（兼鬼才、鬼道）
wuxie_va = nil		-- 无懈可击轮到己方响应时，原有锦囊来源目标的va_list存储
wuxie_in_effect = false		-- 目前无懈可击是否生效（无懈可击可能被其他无懈可击抵消导致失效）

skill_disrow = 0    -- 技能多于四个时显示的四个技能前面忽略的技能的行数
end

--  定义变量  --
init_run()

--  table 库增补函数：获得 table 实际项数
function table.getn2(t)
    local i
	
	i = 0
	for _, _ in pairs(t) do
	    i = i + 1
	end
	
	return i
end

--  table 库增补函数：复制一个表并返回
function table.copy(t)
	local t2 = {}
	local v
	for _, v in pairs(t) do
		table.insert(t2, v)
	end
	return t2
end

--  将函数地址加入执行队列  --
function add_funcptr(func, va_list, p, tag)
    local t = {}
	t.func = func; t.va_list = va_list
	if tag ~= nil then
		t.tag = tag
	else
		t.tag = funcptr_add_tag
	end
	if p ~= nil then
	    table.insert(funcptr_queue, p, t)
	else
	    table.insert(funcptr_queue, t)
	end
	return #funcptr_queue
end

--  将函数队列覆盖  --
function change_funcptr(func, va_list, p)
    local t = {}
	t.func = func; t.va_list = va_list
	if p ~= nil then
	    table.remove(funcptr_queue,p)
		table.insert(funcptr_queue, p, t)
	else
		table.remove(funcptr_queue,#funcptr_queue)
	    table.insert(funcptr_queue, t)
	end
	return #funcptr_queue
end
--  开始函数队列执行  --
function consent_func_queue(interval)
	funcptr_i = 1
    timer.start(interval)
end

--  暂停函数队列执行  --
function pause_func_queue()
	pause = true
	timer.stop()
	stick_at = funcptr_i
end

--  继续函数队列执行  --
function continue_func_queue(interval)
	if stick_at == nil then
		consent_func_queue(interval)
	else
		funcptr_i = stick_at
		timer.start(interval)
	end
end

--  富文本框初始化  --
function txt_messages_init()
    txt_messages:move(99, -2)
	txt_messages:resize(111, 123)
	txt_messages:setReadOnly(true)
	
	txt_messages:registerFilter {
	    tabKey = function() return true end, 
		enterKey = function() return true end, 
		escapeKey = function() return true end, 
	}
end

--  在富文本框中显示消息  --
function draw_messages_r()
    local t, i, j, lower
	
	t = {}; j = 1
	if #message_list <= 7 then
	    lower = 1
	else
	    lower = #message_list - 7
	end
	for i = lower, #message_list do
	    t[j] = message_list[i]
		t[j + 1] = '\n'
		j = j + 2
	end
	table.remove(t)
	txt_messages:setExpression(table.concat(t), -1)
	
	t = {}
	collectgarbage()
end

--  向游戏记录中插入一条消息  --
function push_message(message)
    table.insert(message_list, message)
	print(message)
	draw_messages_r()
	platform.window:invalidate()
end

--  设置交互提示区文字  --
function set_hints(text)
    jiaohu_text = text
	platform.window:invalidate()
end

--  设置回合阶段  --
function gamerun_huihe_set(jieduan)
    gamerun_huihe = jieduan
end

--  游戏开始阶段初始化  --
function gamerun_init()
	add_funcptr(card_xipai, false)    -- 重置牌堆
	char_fenpei_id()    -- 分配身份
	char_fenpei_wujiang()    -- 分配武将
	add_funcptr(card_fenfa_init, nil)  -- 初始发牌
	add_funcptr(_init_sub1, nil)
end
function _init_sub1()
    gamerun_huihe_set("开始")
	set_hints("请按'确定'继续")
end

--  当前玩家回合开始 (至出牌阶段)  --
function gamerun_huihe_start()
    local msg
	
	funcptr_queue = {}
	card_selected = {}
	game_skip_mopai = false
	game_skip_chupai = false
	char_yisha = false
	char_hejiu = false
	
	--  回合开始阶段  --
	msg = {char_juese[char_current_i].name, "回合开始"}
    add_funcptr(push_message, table.concat(msg))
	msg = nil; collectgarbage()
	
	--  判定阶段  --
	gamerun_huihe_panding()
	
	--  摸牌阶段  --
	--  周瑜英姿，多摸一张牌  --
	if char_juese[char_current_i].name == "周瑜" then
		add_funcptr(skills_yingzi,char_current_i)
	end
	if char_juese[char_current_i].name == "许褚" then
		add_funcptr(skills_luoyi_enter,char_current_i)
		return
	end
	if game_skip_mopai == false then
		if char_juese[char_current_i].name == "张辽" then
			add_funcptr(skills_tuxi_enter,char_current_i)
			return
		end
	end
	add_funcptr(card_mopai, nil)
	
	--  出牌阶段  --
	add_funcptr(_start_sub1, nil)
end
function _start_sub1()
    local msg
	
	gamerun_status = ""
	if game_skip_chupai == false then
	    msg = {char_juese[char_current_i].name, "出牌阶段"}
	    push_message(table.concat(msg))
		msg = nil; collectgarbage()
	
        gamerun_huihe_set("出牌")
        set_hints("请您出牌")
	else
	    msg = {char_juese[char_current_i].name, "对'乐不思蜀'判定成功, 不能出牌"}
		push_message(table.concat(msg))
		msg = nil; collectgarbage()
	
        gamerun_huihe_set("出牌")
		on.escapeKey()
	end
end

--  判定阶段  --
function gamerun_huihe_panding()
    local msg, p, q

    msg = {char_juese[char_current_i].name, "判定阶段"}
    add_funcptr(push_message, table.concat(msg))
	gamerun_temp = add_funcptr(gamerun_huihe_set, "判定") + 1
	msg = nil; collectgarbage()
	
	for _, card in ipairs(char_juese[char_current_i].panding) do
		card_wuxie(card, char_current_i, char_current_i, nil)

		funcptr_add_tag = "无懈无效结算"
	    add_funcptr(_panding_sub1, char_current_i)

		if skills_judge_guicai_guidao(char_current_i) ~= "" then
			add_funcptr(skills_guicai_guidao_zhudong_enter)
		end

		funcptr_add_tag = "无懈无效结算/翻判定牌"
		p = add_funcptr(_panding_sub3, nil)    -- 记录位置，供判定阶段伤害结算插队
		funcptr_add_tag = "无懈无效结算/伤害插队"
		add_funcptr(_panding_sub2, {1, p})
		funcptr_add_tag = nil

		funcptr_add_tag = "无懈有效结算"
		add_funcptr(_panding_wuxie)
		funcptr_add_tag = nil
	end

	funcptr_add_tag = "无懈执行完毕"
	add_funcptr(_panding_sub3)
	funcptr_add_tag = nil
end
function _panding_sub1(ID)    -- 子函数1：翻开判定牌
    local msg
	
    -- 牌堆顶的牌进入临时判定区
	if #card_yixi == 0 then
	    card_xipai(true)
	end
    card_panding_card = card_yixi[1]
	table.remove(card_yixi, 1)
	
	msg = {char_juese[ID].name, "的判定牌是'", card_panding_card[2], card_panding_card[3], "的", card_panding_card[1], "'"}
	push_message(table.concat(msg))
	msg = nil; collectgarbage()
end
function _panding_sub2(va_list)    -- 子函数2：确认判定是否生效并修改相应标识符
    local card, msg, pass, v
	local id, p
	id = va_list[1]; p = va_list[2]
	
	card = char_juese[char_current_i].panding[id][1]
	if card ~= "乐不思蜀" and card ~= "兵粮寸断" and card ~= "闪电" then
		--  其他牌面的牌 (技能发动)  --
		card = char_juese[char_current_i].panding[id][4]
	end
    pass = false
	
    if card == "乐不思蜀" then
	    --  如果判定结果不是红桃，则跳过出牌阶段  --
	    if card_panding_card[2] ~= "红桃" then
		    game_skip_chupai = true
		    msg = {char_juese[char_current_i].name, "的'乐不思蜀'判定成功"}
			push_message(table.concat(msg))
		else
		    msg = {char_juese[char_current_i].name, "的'乐不思蜀'判定失败"}
			push_message(table.concat(msg))
		end
	end
	
	if card == "兵粮寸断" then
	    --  如果判定结果不是草花，则跳过摸牌阶段  --
	    if card_panding_card[2] ~= "草花" then
		    game_skip_mopai = true
		    msg = {char_juese[char_current_i].name, "的'兵粮寸断'判定成功"}
			push_message(table.concat(msg))
		else
		    msg = {char_juese[char_current_i].name, "的'兵粮寸断'判定失败"}
			push_message(table.concat(msg))
		end
	end
	
	if card == "闪电" then
	    --  如果判定结果是黑桃2~9，失去3点体力  --
	    if card_panding_card[2] == "黑桃" and card_panding_card[3] >= "2" and card_panding_card[3] <= "9" then
		    msg = {char_juese[char_current_i].name, "的'闪电'判定成功"}
			push_message(table.concat(msg))
			char_tili_deduct({3, char_current_i, nil, "雷", ID_mubiao}, true)
		else
		    msg = {char_juese[char_current_i].name, "的'闪电'判定失败"}
			push_message(table.concat(msg))
			pass = true
		end
		--card_add_qipai(card_panding_card)
	end
	
	if pass then
	    --  闪电判定失败时传递给下一玩家  --
	    _panding_pass(id)
	else
	    --  弃掉玩家判定区及临时判定区内的牌  --
		card_add_qipai(char_juese[char_current_i].panding[id])
		
		if #char_juese[char_current_i].panding == 1 then
			char_juese[char_current_i].panding = {}
		else
			table.remove(char_juese[char_current_i].panding, id)
		end
		
		if char_juese[char_current_i].skill["天妒"] ~= "available" then
			card_add_qipai(card_panding_card)
		else
			push_message(char_juese[char_current_i].name.."发动了武将技能 '天妒'")
			skills_tiandu_add({char_current_i, card_panding_card})
		end
	end
	
	msg = nil; collectgarbage()
end
function _panding_sub3()    -- 子函数3：用于延时

end
function _panding_pass(id)    -- 将闪电传给下一个玩家
	local p, j
	p = char_current_i
	j = true
	while j do
		p = p + 1
		if p > 5 then p = 1 end
		j = false
		
		--  若下家已死亡，则跳过  --
		if char_juese[p].siwang == true then
			j = true
		else
			--  若下家判定区中已有闪电，则跳过之传给再下家  --
			for _, v in ipairs(char_juese[p].panding) do
				if v[1] == "闪电" then
					j = true
					break
				end
			end
		end
	end
	
	table.insert(char_juese[p].panding, 1, char_juese[char_current_i].panding[id])
	table.remove(char_juese[char_current_i].panding, id)
end
function _panding_wuxie()	-- 判定被无懈
	push_message("判定牌被无懈，无需判定")
	if char_juese[char_current_i].panding[1][1] == "闪电" then
		_panding_pass(1)
	else
		card_add_qipai(char_juese[char_current_i].panding[1])
		table.remove(char_juese[char_current_i].panding, 1)
	end
end

--  当前玩家回合结束 (弃牌阶段~回合结束阶段)
function gamerun_huihe_jieshu(qipai)
    local msg
	
	if not qipai then
	    funcptr_queue = {}
		
		--  弃牌阶段  --
	    msg = {char_juese[char_current_i].name, "弃牌阶段"}
        add_funcptr(push_message, table.concat(msg))
		
		if skills_judge_keji(char_current_i) and #char_juese[char_current_i].shoupai > char_juese[char_current_i].tili_max then
			add_funcptr(push_message, char_juese[char_current_i].name.."发动了武将技能 '克己'")
		end
	end
	
	if skills_judge_xueyi(char_current_i) > 0 and #char_juese[char_current_i].shoupai > char_juese[char_current_i].tili_max then
		add_funcptr(push_message, char_juese[char_current_i].name.."发动了武将技能 '血裔'")
	end
	
	--  回合结束  --
	
	--  貂蝉闭月：可在回合结束阶段摸一张牌  --
	if char_juese[char_current_i].skill["闭月"] == "available" then
		skills_biyue(char_current_i)
	end
	if char_juese[char_current_i].skill["崩坏"] == "available" then
		if skills_judge_benghuai(char_current_i) then
			add_funcptr(skills_benghuai_enter)
			return
		end
	end
	
	--  重置仁德给出牌计数  --
	char_rende_given = 0
	last_OK = false
	char_luoyi = false
	skill_disrow = 0
	for i = 1,5 do
		for k,v in pairs(char_juese[i].skill) do
			if v=="locked" then
				char_juese[i].skill[k] = 1
			end
		end
	end
	msg = {char_juese[char_current_i].name, "回合结束"}
    add_funcptr(push_message, table.concat(msg))
	
	add_funcptr(_jieshu_sub1, nil)
	
	msg = nil; collectgarbage()
end
function _jieshu_sub1()
	gamerun_status = ""
    gamerun_huihe_set("结束")
	set_hints("请按'确定'继续")
end

--  移动选取卡牌使用目标  --
function gamerun_select_target(dir)
    local card

	card = char_juese[char_current_i].shoupai[card_highlighted][1]
	
	if dir == "init" then
	    gamerun_target_selected = char_current_i - 1
		if gamerun_target_selected < 1 then
			gamerun_target_selected = 5
		end
		if gamerun_target_selected == guankan_s then
			gamerun_target_selected = gamerun_target_selected - 1
		end
		if gamerun_target_selected < 1 then
			gamerun_target_selected = 5
		end
		
		--  跳过死亡角色  --
		local j = true
		while j do
			j = false
			if char_juese[gamerun_target_selected].siwang == true then
				gamerun_target_selected = gamerun_target_selected - 1
				j = true
			end
			if gamerun_target_selected < 1 then
				gamerun_target_selected = 5
			end
		end
	end
	
    if dir == "right" then
	    gamerun_target_selected = gamerun_target_selected - 1
		
		--  使用目标不能是自己 (火攻、借刀杀人除外)  --
		if gamerun_status ~= "选择目标-B" and gamerun_status ~= "技能选择-目标B" and card ~= "火攻" then
			if gamerun_target_selected == char_current_i then
				gamerun_target_selected = gamerun_target_selected - 1
			end
		else
			if gamerun_target_selected == guankan_s then
				gamerun_target_selected = gamerun_target_selected - 1
			end
		end
		if gamerun_target_selected < 1 then
			gamerun_target_selected = 5
		end
		
		--  跳过死亡角色  --
		local j = true
		while j do
			j = false
			if char_juese[gamerun_target_selected].siwang == true then
				gamerun_target_selected = gamerun_target_selected - 1
				j = true
			end
			if gamerun_status ~= "选择目标-B" and gamerun_status ~= "技能选择-目标B" and card ~= "火攻" then
				if gamerun_target_selected == char_current_i then
					gamerun_target_selected = gamerun_target_selected - 1
				end
			else
				if gamerun_target_selected == guankan_s then
					gamerun_target_selected = gamerun_target_selected - 1
				end
			end
			if gamerun_target_selected < 1 then
				gamerun_target_selected = 5
			end
		end
	end
	
	if dir == "left" then
	    gamerun_target_selected = gamerun_target_selected + 1
		
		if gamerun_status ~= "选择目标-B" and gamerun_status ~= "技能选择-目标B" and card ~= "火攻" then
			if gamerun_target_selected == char_current_i then
				gamerun_target_selected = gamerun_target_selected + 1
			end
		else
			if gamerun_target_selected == guankan_s then
				gamerun_target_selected = gamerun_target_selected + 1
			end
		end
		if gamerun_target_selected > 5 then
		    gamerun_target_selected = 1
		end
		
		local j = true
		while j do
			j = false
			if char_juese[gamerun_target_selected].siwang == true then
				gamerun_target_selected = gamerun_target_selected + 1
				j = true
			end
			if gamerun_status ~= "选择目标-B" and gamerun_status ~= "技能选择-目标B" and card ~= "火攻" then
				if gamerun_target_selected == char_current_i then
					gamerun_target_selected = gamerun_target_selected + 1
				end
			else
				if gamerun_target_selected == guankan_s then
					gamerun_target_selected = gamerun_target_selected + 1
				end
			end
			if gamerun_target_selected > 5 then
				gamerun_target_selected = 1
			end
		end
	end
end

--  部分技能选择可打出的装备  --
function gamerun_card_select_zhuangbei(i)
	if char_juese[char_current_i].shoupai[i] ~= nil then
		if card_selected[i] == 1 then
			card_selected[i] = nil
			card_highlighted = 1

			if gamerun_status == "技能选择-目标" then
				set_hints(skill_text_1)
				gamerun_status = last_status
				gamerun_target_selected = 0
				return
			end
		else	
			if gamerun_status ~= "技能选择-单牌" and gamerun_status ~= "技能选择-多牌" then
				return
			end

			if gamerun_status == "技能选择-单牌" and table.getn2(card_selected) > 0 then
				return
			end
			card_highlighted = i
			card_selected[i] = 1
		end

		if gamerun_tab_ptr ~= nil then
			gamerun_tab_ptr()
		end
	end
end

--  临时将装备牌收入手牌  --
function gamerun_wuqi_into_hand(ID_s)
	if #char_juese[ID_s].wuqi ~= 0 then
		char_juese[ID_s].shoupai[-1] = table.copy(char_juese[ID_s].wuqi)
	end
	if #char_juese[ID_s].fangju ~= 0 then
		char_juese[ID_s].shoupai[-2] = table.copy(char_juese[ID_s].fangju)
	end
	if #char_juese[ID_s].gongma ~= 0 then
		char_juese[ID_s].shoupai[-3] = table.copy(char_juese[ID_s].gongma)
	end
	if #char_juese[ID_s].fangma ~= 0 then
		char_juese[ID_s].shoupai[-4] = table.copy(char_juese[ID_s].fangma)
	end
end

--  收回临时收入手牌的装备牌  -- 
function gamerun_wuqi_out_hand(ID_s)
	char_juese[ID_s].shoupai[-1] = nil
	char_juese[ID_s].shoupai[-2] = nil
	char_juese[ID_s].shoupai[-3] = nil
	char_juese[ID_s].shoupai[-4] = nil
end

--  技能出装备牌后，实际删除该装备牌  --
function gamerun_wuqi_in_hand_chu(ID_s, i)
	if i == -1 then
		char_juese[ID_s].wuqi = {}
	elseif i == -2 then
		char_juese[ID_s].fangju = {}
	elseif i == -3 then
		char_juese[ID_s].gongma = {}
	elseif i == -4 then
		char_juese[ID_s].fangma = {}
	end
end






--                     TI-Lua 系统事件                 --
pause = false
function on.timer()
    --if pause == false then 
		if funcptr_i == 0 then
			funcptr_i = 1
		end
		for i = 1,#funcptr_queue do
		end
		if funcptr_i <= #funcptr_queue then
			if funcptr_queue[funcptr_i].func ~= nil then
				funcptr_queue[funcptr_i].func(funcptr_queue[funcptr_i].va_list)
			else
				print(funcptr_queue[funcptr_i].func)
			end
			funcptr_i = funcptr_i + 1
		else
			--stick_at,funcptr_queue = nil,{}
			timer.stop()
		end
	--else
		--return
	--end
end

--  脚本初始化  --
function on.construction()
    local i, v
	
	-- 初始化图片元素 --
    hongxin_on_img = image.new(hongxin_on)
    hongxin_on = nil
	hongxin_off_img = image.new(hongxin_off)
    hongxin_off = nil
	
	color_img = {}
	for i, v in pairs(color_str) do
	    color_img[i] = image.new(v)
	end
	color_str = nil
	
	cards_img = {}
	for i, v in pairs(cards_img_str) do
	    cards_img[i] = image.new(v)
	end
	cards_img_str = nil
	
	identity_img = {}
	for i, v in pairs(identity_str) do
	    identity_img[i] = image.new(v)
	end
	identity_str = nil
	
	txt_messages_init()
	set_hints("请按'确定'开始")
	
    collectgarbage()
end

--  "确定" 键  --
function on.enterKey()
    if gamerun_status == "手牌生效中" then return end

	local card
	
	--card_into_hand(char_current_i)

	if gamerun_huihe == "判定" then
		if gamerun_status == "确认操作" or string.find(gamerun_status, "技能选择") then
		    gamerun_OK = true
			gamerun_OK_ptr()
		end
		return
	end

	if string.find(gamerun_status, "无懈") then
		if table.getn2(card_selected) ~= 0 then
			card = char_juese[char_current_i].shoupai[card_highlighted]
			if string.find(card[1], "无懈可击") or char_juese[char_current_i].name == "卧龙诸葛" then
				_wuxie_zhudong_chu(card, card_highlighted, wuxie_va)
				card_selected = {}
				set_hints("")
				card_highlighted = 1
			end
		end
		return
	end

	if gamerun_huihe == "摸牌" then
		--  张辽突袭  --
		if gamerun_status == "选择目标" then
			if #char_juese[gamerun_target_selected].shoupai ~= 0 then
				guankan_s = gamerun_target_selected
				set_hints("'确定': 选择B '取消': 仅A")
				gamerun_status = "选择目标-B"
				gamerun_select_target("init")
				platform.window:invalidate()
				return
			end
		end
		if gamerun_status == "选择目标-B" then
			if #char_juese[gamerun_target_selected].shoupai ~= 0 then
				_tuxi_exe(true)
			end
		end
	end
	
	if gamerun_huihe == "出牌" then
	    if string.find(gamerun_status, "观看手牌") then
		    --  确认拆除/顺走手牌  --
		    if string.find(gamerun_status, "顺") then
			    _shun_sub2()
				card_chai_shun_exe(false, gamerun_guankan_selected, guankan_s, guankan_d)
			elseif string.find(gamerun_status, "拆") then
				if lianhuan_va == nil then
					_chai_sub2()
				else
					gamerun_status = "手牌生效中"
					set_hints("")
				end
				card_chai_shun_exe(true, gamerun_guankan_selected, guankan_s, guankan_d)
				
				if lianhuan_va ~= nil then
					local id, shuxing, hengzhi
					id = lianhuan_va[2]; shuxing = lianhuan_va[4]
					hengzhi = char_juese[id].hengzhi
					
					if hengzhi then
						if shuxing == "火" or shuxing == "雷" then
							_deduct_lianhuan(lianhuan_va)
							consent_func_queue(0.6)
						end
					end
				end
			elseif string.find(gamerun_status, "杀") then
				card_chai_shun_exe(true, gamerun_guankan_selected, guankan_s, guankan_d)
			    _sha_sub2()
			elseif string.find(gamerun_status, "寒") then
				card_chai_shun_exe(true, gamerun_guankan_selected, guankan_s, guankan_d)
			    _sha_sub3()
			end
			platform.window:invalidate()
		elseif string.find(gamerun_status, "牌堆选择") then
			if string.find(gamerun_status, "五谷") then
				funcptr_queue = {}
				_wugu_get_card_zhudong(char_current_i, gamerun_guankan_selected)
				_wugu_others_get_card_exe(guankan_s, char_current_i)
				consent_func_queue(0.6)
			end
		elseif string.find(gamerun_status, "主动出牌") then
		    if string.find(gamerun_status, "决斗") then
			    if table.getn2(card_selected) ~= 0 then
			        card = char_juese[char_current_i].shoupai[card_highlighted][1]
					if string.find(card, "杀") then
			            funcptr_queue = {}
						_juedou_exe_ji(char_current_i, gamerun_target_selected, card_highlighted)
			            consent_func_queue(0.6)
					end
				end
			end
			
			if string.find(gamerun_status, "火攻") then
			    if table.getn2(card_selected) ~= 0 then
			        card = char_juese[char_current_i].shoupai[card_highlighted][2]
					if card == guankan_s then
			            funcptr_queue = {}
						_huogong_exe_2(char_current_i, gamerun_target_selected, card_highlighted)
			            consent_func_queue(0.6)
					end
				end
			end
			
			--  青龙刀出杀  --
			if string.find(gamerun_status, "青龙") then
			    if table.getn2(card_selected) ~= 0 then
			        card = char_juese[char_current_i].shoupai[card_highlighted][1]
					if string.find(card, "杀") then
			            funcptr_queue = {}
						_sha_exe_2(char_current_i, gamerun_target_selected, card_highlighted)
			            consent_func_queue(0.6)
					end
				end
			end
	    
		    --  贯石斧强制命中  --
		    if string.find(gamerun_status, "贯石") then
		        if table.getn2(card_selected) == 2 then
				    gamerun_status = "手牌生效中"
		            set_hints("")
			        funcptr_queue = {}; card_highlighted = 1
			        card_qipai_go()
	                _sha_exe_3(char_current_i, gamerun_target_selected, guankan_s)
		            consent_func_queue(0.6)
				end
		    end
			
			--  夏侯惇刚烈  --
			if string.find(gamerun_status, "刚烈") then
		        if table.getn2(card_selected) == 2 then
					_ganglie_exe_1()
					
					if lianhuan_va == nil then
						add_funcptr(_ganglie_sub)
					end
				
					if lianhuan_va ~= nil then
						gamerun_status = "手牌生效中"
						set_hints("")
					
						local id, shuxing, hengzhi
						id = lianhuan_va[2]; shuxing = lianhuan_va[4]
						hengzhi = char_juese[id].hengzhi
					
						if hengzhi then
							if shuxing == "火" or shuxing == "雷" then
								_deduct_lianhuan(lianhuan_va)
							else
								add_funcptr(_ganglie_sub)
							end
						else
							add_funcptr(_ganglie_sub)
						end
					end
					consent_func_queue(0.6)
				end
				return
		    end
		elseif gamerun_status == "确认操作" or string.find(gamerun_status, "技能选择") then
		    gamerun_OK = true
			gamerun_OK_ptr()
			return
		else
		    if table.getn2(card_selected) == 1 and card_selected[card_highlighted] ~= nil then
				local carda = char_juese[char_current_i].shoupai[card_highlighted][1]
				if carda == "借刀杀人" or carda == "铁锁连环" then
					if gamerun_status == "选择目标" then
						--  进入借刀杀人/铁索连环第二阶段  --
						if card_if_d_limit(char_juese[char_current_i].shoupai[card_highlighted][1], char_current_i, gamerun_target_selected) then
							guankan_s = gamerun_target_selected
							if carda == "借刀杀人" then
								set_hints("请选择目标B")
							else
								set_hints("'确定'：选择B '取消'：仅A")
							end
							gamerun_status = "选择目标-B"
							gamerun_select_target("init")
							platform.window:invalidate()
						end
					elseif gamerun_status == "选择目标-B" then
						--  开始借刀杀人/连环  --
						if card_chupai(true) then
							--  恢复状态  --
							--on.tabKey()
							card_selected = {}
							card_highlighted = 1
							platform.window:invalidate()
						end
					end
				else
					--  出牌  --
					if card_chupai(card_highlighted) then
						--  恢复状态  --
						--on.tabKey()
						card_selected = {}
						card_highlighted = 1
						platform.window:invalidate()
					end
				end
			end
			
			--  丈八蛇矛  --
			if table.getn2(card_selected) == 2 then
				if card_chupai(card_highlighted) then
					--  恢复状态  --
					card_selected = {}
					--on.tabKey()
					card_highlighted = 1
					platform.window:invalidate()
				end
			end
		end
		return
	end
	
    --  刚刚选局  --
    if gamerun_huihe == "" then
	    set_hints("")
        gamerun_init()    -- 开始阶段初始化
	    consent_func_queue(0.2)
		return
	end
	
	--  游戏结束，重新开始  --
    if gamerun_huihe == "游戏结束" then
		timer.stop()
	    pause = true
		set_hints("")
		txt_messages:setExpression("", -1)
		txt_messages_init()
		init_character()
		init_cards()
		init_run()
        gamerun_init()    -- 开始阶段初始化
	    consent_func_queue(0.2)
		return
	end
	
	--  上一玩家回合结束，按确定键继续  --
	
	if gamerun_status == "确认操作" then
		gamerun_OK = true
		gamerun_OK_ptr()
	else
		if gamerun_huihe == "结束" or gamerun_huihe == "开始" then
			if gamerun_huihe == "结束" then
				char_current_i = char_current_i + 1
				if char_current_i > 5 then
					char_current_i = 1
				end
			
				--  跳过死亡以及翻面的玩家  --
				local j = true
				while j do
					j = false
					if char_juese[char_current_i].siwang == true then
						char_current_i = char_current_i + 1
						j = true
					end
					if char_juese[char_current_i].fanmian == true and char_juese[char_current_i].siwang == false then
						char_juese[char_current_i].fanmian = false
						push_message(table.concat({char_juese[char_current_i].name,"将武将牌翻回正面"}))
						char_current_i = char_current_i + 1
						j = true
					end
					if char_current_i > 5 then
						char_current_i = 1
					end
				end
			end
			set_hints("")
			card_highlighted = 1
			gamerun_huihe_start()    -- 下一玩家回合开始
			consent_func_queue(0.2)
		end
	end
	
	--  需弃的牌选择完毕  --
	if gamerun_huihe == "弃牌" then
		--  袁绍作为主公，若有一个群雄势力角色存活，其手牌上限+2  --
		local extra = 0
		extra = skills_judge_xueyi(char_current_i)
	
	    --  确认已选择足够的牌  --
		if table.getn2(card_selected) == #char_juese[char_current_i].shoupai - char_juese[char_current_i].tili - extra then
		    set_hints("")
			funcptr_queue = {}; card_highlighted = 1
			card_qipai_go()    -- 执行弃牌
	        gamerun_huihe_jieshu(true)    -- 进入回合结束阶段
		    consent_func_queue(0.2)
		end
	end
end

--  "取消/弃牌" 键  --
function on.escapeKey()
    local msg, card

	if gamerun_huihe == "" or gamerun_huihe == "游戏结束" then return end
	if gamerun_status == "手牌生效中" or string.find(gamerun_status, "观看手牌") then return end
	
	if string.find(gamerun_status, "无懈") then
		funcptr_queue = {}
		_wuxie_zhudong_fangqi(char_current_i, gamerun_target_selected)
		return
	end
	
	if gamerun_huihe == "摸牌" then
		if gamerun_status == "选择目标-B" then
			_tuxi_exe(false)
		end
	end
	
    if gamerun_huihe == "出牌" then
	    --  未选取牌时  --
	    if table.getn2(card_selected) == 0 then
		    if string.find(gamerun_status, "主动出牌") then
			    --  无牌进行主动回应，放弃  --
			    if string.find(gamerun_status, "决斗") then
				    funcptr_queue = {}
				    _juedou_exe_fangqi(char_current_i, gamerun_target_selected)
					consent_func_queue(0.6)
				end
				
				if string.find(gamerun_status, "火攻") then
				    funcptr_queue = {}
				    _huogong_exe_3(char_current_i)
					consent_func_queue(0.6)
				end

				if string.find(gamerun_status, "无懈") then
					_wuxie_zhudong_fangqi()
				end
				
				if string.find(gamerun_status, "青龙") or string.find(gamerun_status, "贯石") then
				    _sha_exe_2_g()
				end
				
				--  夏侯惇刚烈  --
				if string.find(gamerun_status, "刚烈") then
					_ganglie_exe_2()
					
					if lianhuan_va == nil then
						add_funcptr(_ganglie_sub)
					end
				
					if lianhuan_va ~= nil then
						gamerun_status = "手牌生效中"
						set_hints("")
					
						local id, shuxing, hengzhi
						id = lianhuan_va[2]; shuxing = lianhuan_va[4]
						hengzhi = char_juese[id].hengzhi
					
						if hengzhi then
							if shuxing == "火" or shuxing == "雷" then
								_deduct_lianhuan(lianhuan_va)
							else
								add_funcptr(_ganglie_sub)
							end
						else
							add_funcptr(_ganglie_sub)
						end
					end
					consent_func_queue(0.6)
					return
				end
			elseif gamerun_status == "确认操作" then
		        gamerun_OK = false
			    gamerun_OK_ptr()
			elseif string.find(gamerun_status, "选择目标") then
				
			elseif string.find(gamerun_status, "技能选择") then
				if imp_card == "强袭" and gamerun_status == "技能选择-单牌" then
					gamerun_OK = false
					gamerun_OK_ptr()
				end
			else
		        --  出牌结束，进入弃牌阶段  --
	            gamerun_huihe_set("弃牌")
		
				--  袁绍作为主公，若有一个群雄势力角色存活，其手牌上限+2  --
				local extra = 0
				extra = skills_judge_xueyi(char_current_i)
		
				--  判断吕蒙克己条件  --
				if skills_judge_keji() == false then
					-- 如果体力小于手牌数则需弃牌 --
					if char_juese[char_current_i].tili + extra < #char_juese[char_current_i].shoupai then
						msg = {char_juese[char_current_i].name, "弃牌阶段"}
						push_message(table.concat(msg))
						msg = {"您须弃", #char_juese[char_current_i].shoupai - char_juese[char_current_i].tili - extra, "张牌"}
						set_hints(table.concat(msg))
						msg = nil; collectgarbage()
					else
						set_hints("")
						gamerun_huihe_jieshu(false)    -- 进入回合结束
						consent_func_queue(0.2)
					end
				else
					set_hints("")
					gamerun_huihe_jieshu(false)    -- 进入回合结束
					consent_func_queue(0.2)
				end
			end
			return
	    end
	    
		--  已选取至少一张牌时  --
		card = char_juese[char_current_i].shoupai[card_highlighted][1]
		if table.getn2(card_selected) == 1 and card == "铁锁连环" then
			if gamerun_status == "选择目标" then
				--  发动铁索连环 (重铸效果)  --
				card_lian_chongzhu(card_highlighted, char_current_i)
				--  恢复状态  --
				--on.tabKey()
				card_selected = {}
				card_highlighted = 1
				platform.window:invalidate()
			elseif gamerun_status == "选择目标-B" then
				--  发动铁索连环 (连环效果)  --
				if card_chupai(false) then
					--  恢复状态  --
					--on.tabKey()
					card_selected = {}
					card_highlighted = 1
					platform.window:invalidate()
				end
			end
		end
		
		if string.find(gamerun_status, "技能选择") then
			if imp_card == "铁锁连环" then
				gamerun_OK = false
				gamerun_OK_ptr()
			end
		end
	end
	
	if gamerun_huihe == "结束" or gamerun_huihe == "摸牌" then
		if gamerun_status == "确认操作" then
		    gamerun_OK = false
			gamerun_OK_ptr()
		end
	end

	if gamerun_huihe == "判定" then
		if gamerun_status == "确认操作" or string.find(gamerun_status, "技能选择") then
		    gamerun_OK = false
			gamerun_OK_ptr()
		end
	end
end

--  左/右键 (移动高亮的牌/选择卡牌使用目标)  --
function on.arrowKey(key)
	--if card_highlighted <= 0 then return end
	if gamerun_huihe == "" or gamerun_huihe == "游戏结束" then return end
    if gamerun_huihe == "结束" or gamerun_status == "手牌生效中" or string.find(gamerun_status, "确认操作") then return end

    if key == "left" then
	    if string.find(gamerun_status, "选择目标") or gamerun_status == "技能选择-目标" or gamerun_status == "技能选择-目标B" then
		    --  选择卡牌使用目标状态  --
		    gamerun_select_target(key)
		elseif string.find(gamerun_status, "观看手牌") or string.find(gamerun_status, "牌堆选择") then
		    --  观看手牌状态  --
			if string.find(gamerun_status, "观看手牌") then
				if gamerun_guankan_selected > 1 then
					gamerun_guankan_selected = gamerun_guankan_selected - 1
				end
			elseif string.find(gamerun_status, "牌堆选择") then
				if gamerun_guankan_selected > 1 then
					gamerun_guankan_selected = gamerun_guankan_selected - 1
				end
			end
		else
		    --  选取手牌状态  --
			--  已选取牌的情况下不允许移动 (弃牌阶段、装备丈八蛇矛时、贯石斧效果除外)  --
			local wuqi
			if #char_juese[char_current_i].wuqi ~= 0 then
				wuqi = char_juese[char_current_i].wuqi[1]
			else
				wuqi = ""
			end
			
		    if table.getn2(card_selected) == 0 or gamerun_huihe == "弃牌" or string.find(gamerun_status, "贯石") or wuqi == "丈八矛" or gamerun_status == "技能选择-多牌" or gamerun_status == "主动出牌-刚烈" then
		        if card_highlighted > 1 then
		            card_highlighted = card_highlighted - 1
			    end
		    end
		end
	end
	if key == "right" then
	    if string.find(gamerun_status, "选择目标") or gamerun_status == "技能选择-目标" or gamerun_status == "技能选择-目标B" then
		    gamerun_select_target(key)
		elseif string.find(gamerun_status, "观看手牌") or string.find(gamerun_status, "牌堆选择") then
		    if string.find(gamerun_status, "观看手牌") then
				if gamerun_guankan_selected < #gamerun_guankan_type then
					gamerun_guankan_selected = gamerun_guankan_selected + 1
				end
			elseif string.find(gamerun_status, "牌堆选择") then
				if gamerun_guankan_selected < #wugucards then
					gamerun_guankan_selected = gamerun_guankan_selected + 1
				end
			end
		else
			local wuqi
			if #char_juese[char_current_i].wuqi ~= 0 then
				wuqi = char_juese[char_current_i].wuqi[1]
			else
				wuqi = ""
			end
		
		    if (table.getn2(card_selected) == 0 or gamerun_huihe == "弃牌" or string.find(gamerun_status, "贯石") or wuqi == "丈八矛" or gamerun_status == "技能选择-多牌" or gamerun_status == "主动出牌-刚烈") then
	            if card_highlighted < #char_juese[char_current_i].shoupai then
		            card_highlighted = card_highlighted + 1
			    end
			end
		end
	end
	if key == "up" then
		if string.find(gamerun_status, "选项选择") then
		    if gamerun_guankan_selected > 1 then
				gamerun_guankan_selected = gamerun_guankan_selected - 1
			end
		elseif #char_juese[char_current_i].skillname > 4 and skill_disrow > 0 then
			skill_disrow = skill_disrow - 1
		end
	end
	if key == "down" then
		if string.find(gamerun_status, "选项选择") then
		    if gamerun_guankan_selected < #choose_option then
				gamerun_guankan_selected = gamerun_guankan_selected - 1
			end
		elseif #char_juese[char_current_i].skillname > 4 and math.ceil(#char_juese[char_current_i].skillname / 2) - 2 > skill_disrow then
			skill_disrow = skill_disrow + 1
		end
	end
	platform.window:invalidate()
end

--  "选取" 键  --
function on.tabKey()
    local card, card2
    if card_highlighted <=0 then return end
	if gamerun_huihe == "" or gamerun_huihe == "游戏结束" or gamerun_status == "手牌生效中" then return end
    if gamerun_huihe == "结束" or string.find(gamerun_status, "确认操作") or string.find(gamerun_status, "观看手牌") or string.find(gamerun_status, "牌堆选择") then return end
	if #char_juese[char_current_i].shoupai == 0 then return end
	
    if card_selected[card_highlighted] ~= nil then
	    --  取消选择  --
		card_selected[card_highlighted] = nil
		if last_status == "技能选择-多牌" then
			if gamerun_status == "技能选择-目标" then
				set_hints(skill_text_1)
				gamerun_status = last_status
				gamerun_target_selected = 0
				return
			end
			
			if gamerun_status == "技能选择-多牌" then
				if gamerun_tab_ptr ~= nil then
					gamerun_tab_ptr()
				end
				return
			end
		end
		
		if (gamerun_huihe == "出牌" or (gamerun_huihe == "判定" and (string.find(gamerun_status, "无懈") or imp_card == "鬼才"))) and table.getn2(card_selected) == 0 then
		    if string.find(gamerun_status, "选择目标") or gamerun_status == "" then
			    set_hints("请您出牌")
			    gamerun_status = ""
			    gamerun_target_selected = 0
			end
			
			if gamerun_status == "技能选择-目标" or gamerun_status == "技能选择-目标B" then
				if last_status ~= "技能选择-目标" and last_OK ~= false then
					set_hints(skill_text_1)
					gamerun_status = last_status
					gamerun_target_selected = 0
				end
				return
			end
			
			if gamerun_status == "技能选择-单牌" or gamerun_status == "技能选择-多牌" then
				if gamerun_tab_ptr ~= nil then
					gamerun_tab_ptr()
				end
				return
			end
			
			if string.find(gamerun_status, "主动出牌") then
			
			end
		end
		
		--  丈八蛇矛恢复默认出牌方式  --
		if #char_juese[char_current_i].wuqi ~= 0 then
			if gamerun_huihe == "出牌" and table.getn2(card_selected) == 1 and char_juese[char_current_i].wuqi[1] == "丈八矛" then
				local i
				for i = 1, #char_juese[char_current_i].shoupai do
					if card_selected[i] ~= nil then
						card2 = char_juese[char_current_i].shoupai[i][1]
					end
				end
				
				set_hints(card_tishi[card2])
			    gamerun_status = ""
			    gamerun_target_selected = 0
			end
		end
	else
	    if gamerun_huihe == "出牌" or (gamerun_huihe == "判定" and (string.find(gamerun_status, "无懈") or imp_card == "鬼才")) then
			if gamerun_status == "技能选择-单牌" or gamerun_status == "技能选择-多牌" then
				card_selected[card_highlighted] = 0
				if gamerun_tab_ptr ~= nil then
					gamerun_tab_ptr()
				end
				platform.window:invalidate()
				return
			end
		
		    card = char_juese[char_current_i].shoupai[card_highlighted][1]
		    
			local flag = true
			if #char_juese[char_current_i].wuqi ~= 0 then
				if char_juese[char_current_i].wuqi[1] == "丈八矛" then
					if table.getn2(card_selected) < 2 then
						card_selected[card_highlighted] = 0
					end
					if table.getn2(card_selected) == 2 then
						set_hints("杀")
						gamerun_status = "选择目标"
						gamerun_select_target("init")
					end
					flag = false
				end
			end
			
			if flag then
				if string.find(gamerun_status, "贯石") then
					if table.getn2(card_selected) < 2 then
						card_selected[card_highlighted] = 0
					end
				else
					card_selected[card_highlighted] = 0
				end
			end
			
			if gamerun_status == "" then
			    set_hints(card_tishi[card])
			
			    --  选取的是锦囊 (闪电、无懈可击、南蛮入侵、万箭齐发、桃园结义、无中生有、五谷丰登除外)、杀  --
				--  借刀杀人、铁锁连环选取目标A  --
			    if card_get_leixing(card) == "延时类锦囊" and card ~= "闪电" or card == "顺手牵羊" or card == "过河拆桥" or card == "决斗" or card == "火攻" or card == "杀" or card == "火杀" or card == "雷杀" or card == "借刀杀人" or card == "铁锁连环" then
			        gamerun_status = "选择目标"
				    gamerun_select_target("init")    -- 初始化选择目标状态
			    end
			end
		end
	    --  选择的牌超过需弃牌数，则不能继续选择  --
		if gamerun_huihe == "弃牌" and table.getn2(card_selected) < #char_juese[char_current_i].shoupai - char_juese[char_current_i].tili then
		    card_selected[card_highlighted] = 0
		end
	end
	platform.window:invalidate()
end

--  选择技能、装备牌  --
function on.charIn(char)
	local skills
	if char_juese[char_current_i].name == "" then return end
	if gamerun_huihe ~= "出牌" then return end
	
	skills = char_juese[char_current_i].skillname
	
	if char == '1' then
		if gamerun_skill_selected == 1 + 2 * skill_disrow then
			gamerun_skill_selected = 0
			skills_rst()
		else
			if skills[1 + 2 * skill_disrow] ~= nil and char_juese[char_current_i].skill[skills[1 + 2 * skill_disrow]]~="locked" then 
				if skills_func[skills[1 + 2 * skill_disrow]] ~= nil then
					if skills_func[skills[1 + 2 * skill_disrow]]() then
						gamerun_skill_selected = 1 + 2 * skill_disrow
					end
				end
			end
		end
	end
	
	if char == '2' then
		if gamerun_skill_selected == 2 + 2 * skill_disrow then
			gamerun_skill_selected = 0
			skills_rst()
		else
			if skills[2 + 2 * skill_disrow] ~= nil and char_juese[char_current_i].skill[skills[2 + 2 * skill_disrow]]~="locked" then
				if skills_func[skills[2 + 2 * skill_disrow]] ~= nil then
					if skills_func[skills[2 + 2 * skill_disrow]]() then
						gamerun_skill_selected = 2 + 2 * skill_disrow
					end
				end
			end
		end
	end
	
	if char == '3' then
		if gamerun_skill_selected == 3 + 2 * skill_disrow then
			gamerun_skill_selected = 0
			skills_rst()
		else
			if skills[3 + 2 * skill_disrow] ~= nil and char_juese[char_current_i].skill[skills[3 + 2 * skill_disrow]]~="locked" then
				if skills_func[skills[3 + 2 * skill_disrow]] ~= nil then
					if skills_func[skills[3 + 2 * skill_disrow]]() then
						gamerun_skill_selected = 3 + 2 * skill_disrow
					end
				end
			end
		end
	end
	
	if char == '4' then
		if gamerun_skill_selected == 4 + 2 * skill_disrow then
			gamerun_skill_selected = 0
			skills_rst()
		else
			if skills[4 + 2 * skill_disrow] ~= nil and char_juese[char_current_i].skill[skills[4 + 2 * skill_disrow]]~="locked" then
				if skills_func[skills[4 + 2 * skill_disrow]] ~= nil then
					if skills_func[skills[4 + 2 * skill_disrow]]() then
						gamerun_skill_selected = 4 + 2 * skill_disrow
					end
				end
			end
		end
	end
	
	if char == 'a' then
		gamerun_card_select_zhuangbei(-1)
	end
	
	if char == 'b' then
		gamerun_card_select_zhuangbei(-2)
	end
	
	if char == 'c' then
		gamerun_card_select_zhuangbei(-3)
	end
	
	if char == 'd' then
		gamerun_card_select_zhuangbei(-4)
	end
	platform.window:invalidate()
end

function skills_rst()
	card_selected = {}
	card_highlighted = 1
	imp_card = ""
	skill_text_1 = ""
	skill_text_2 = ""
	set_hints("请您出牌")
	gamerun_status = ""
	last_OK = false
end

--  点击客户区时，移除富文本框的焦点  --
function on.mouseDown(x, y)
    txt_messages:setFocus(false)
end