
txt_messages = D2Editor.newRichText()    -- 游戏记录 (富文本框)
function init_run()
-- 函数执行队列 (定时器) --
funcptr_queue = {}
funcptr_i = 1

-- 游戏记录 --
message_list = {}

-- 标识符 --
game_skip_mopai = false    -- 跳过摸牌阶段标识
game_skip_panding = false	-- 跳过判定阶段标识
game_skip_chupai = false    -- 跳过出牌阶段标识

-- 状态信息 --
jiaohu_text = ""    -- 交互提示区文字
skill_text_1 = ""; skill_text_2 = ""    -- 当前武将技能提示文字
gamerun_huihe = ""    -- 回合阶段 ("开始"、"判定"、"摸牌"、"出牌"、"弃牌"、"结束"、"游戏结束")
gamerun_status = ""    --[[游戏状态
                           选择目标： 使用 "杀"、锦囊等需指定作用目标的卡牌时
								选择目标-B/C/D：选择目标A确定之后的状态
						   手牌生效中：卡牌需要队列执行效果时
						   观看手牌 ("-拆、-顺"、"-杀")：使用一些卡牌需要选择对方手牌时
						   牌堆选择 ("-五谷、-固政")：使用一些卡牌、技能等需要翻开一个牌堆并选择时
						   主动出牌 ("-决斗"、"-火攻A"、"-青龙"、"-贯石"、"-刚烈"|"-杀"、"-南蛮"、"-万箭"、"-火攻B"、"-借刀"、"-雌雄")：使用一些卡牌需要己方进一步响应时
						   技能选择 ("-单牌"：选取单张牌、"-多牌"：选取多张牌、"-目标"：选取目标状态)
						   确认操作：技能等需要确认发动的
						   选项选择
					   --]]
last_status = ""    -- 上一个状态：用于技能从选择目标返回单牌或多牌选择时

gamerun_target_selected = 0    -- "选择目标"状态选取的目标 ID
gamerun_skill_selected = 0    -- 高亮选取的武将技能 (1 - 4，0为不选取)
gamerun_armskill_selected = false	--  是否处于选取发动武器技能状态 (丈八蛇矛)
gamerun_lordskill_selected = false	--  是否处于选取响应主公技状态
gamerun_OK = false; gamerun_OK_ptr = nil
last_OK = false    -- 上一个OK状态：用于技能时

gamerun_tab_ptr = nil
imp_card = ""    -- 武将技能发动时要实现的卡牌名称

gamerun_guankan_type = {}    -- "观看手牌"状态牌类型 (格式：{类型, 附加值})
gamerun_guankan_selected = 1    -- "观看手牌"状态选取的目标牌
guankan_s = 0    -- "观看手牌"作用源 (兼作火攻选择花色、贯石斧（五谷丰登）来源手牌临时存储，选择目标数为2的目标A)
guankan_d = 0    -- "观看手牌"作用目标
selected_target_b = 0	--  选择目标数为3时的目标B
selected_target_c = 0	--  选择目标数为4时的目标C
sha_va = nil    -- 发动寒冰剑后，杀来源目标的va_list存储

funcptr_add_tag = nil	-- 如果设置为一个字符串，则设置的字符串会被加入到之后的每一个funcptr_queue项的tag

wuxie_queue_jinnang = {}	-- 无懈可击未执行时，原有的函数执行队列
wuxie_queue_xiangying = {}	-- 无懈可击轮到己方响应时，记录原有的他方响应函数队列，以便己方不使用无懈时恢复原有轮询
wuxie_queue_xiangying_i = 0	-- 无懈可击轮到己方响应时，原有函数队列的执行位置
wuxie_va = nil		-- 无懈可击轮到己方响应时，原有锦囊来源目标的va_list存储
wuxie_in_effect = false		-- 目前无懈可击是否生效（无懈可击可能被其他无懈可击抵消导致失效）

zhudong_queue_stack = {}	-- 队列内函数执行堆栈
zhudong_queue_stack_i = {}	-- 队列内函数执行位置记录

skill_disrow = 0    -- 技能多于四个时显示的四个技能前面忽略的技能的行数
item_disrow = 0   -- 选项多于三个时显示的三个选项前面忽略的选项的个数

gamerun_dangxian = false  -- 廖化当先发动与否的存储
gamerun_shensu = false	-- 夏侯渊神速发动与否的存储
gamerun_fangquan = false  -- 刘禅放权发动与否的存储
gamerun_qiaobian = false	-- 张郃巧变发动与否的存储
fenxin_pending = nil	-- 玩家当前需要决定是否发动焚心的死亡角色ID (无则为nil)，如果是，则暂时隐藏死亡角色的身份牌
kunfen_adjusted = {}  --困奋是否已经修改的存储
skill_double = {}  --同一角色是否存在重复技能的存储
extra_turn = {}  --额外回合角色的存储
real_last = 0  --正常顺序的上个回合行动的角色
mark_ren = {}  --忍标记数量
gamerun_killed = {}  --在当前回合内杀死角色的数量
skill_temp = {}  --临时获得的技能，在自己的回合结束后失去
lordskill_used = {}		-- 当前回合中角色是否已经使用过主公技
gamerun_qipai_n = 0		-- 当前回合于弃牌阶段弃牌总数

ai_skills_discard = {}	-- 记录AI不再在本回合考虑的技能
ai_attack_priority = nil	-- 记录AI是否有要在本回合优先攻击的对象 (决斗或杀)

for i = 1, 5 do
	kunfen_adjusted[i] = false
	skill_double[i] = {}
	mark_ren[i] = 0
	gamerun_killed[i] = 0
	skill_temp[i] = {}
	lordskill_used[i] = {}
end

end

--  定义变量  --
init_run()

--  往函数队列堆栈中添加队列  --
function push_zhudong_queue(queue, i)
	table.insert(zhudong_queue_stack, queue)
	table.insert(zhudong_queue_stack_i, i)
end

--  从函数队列堆栈顶取出队列  --
function pop_zhudong_queue()
	if #zhudong_queue_stack <= 0 or #zhudong_queue_stack_i <= 0 or #zhudong_queue_stack ~= #zhudong_queue_stack_i then
		return nil, nil
	end

	local queue = zhudong_queue_stack[#zhudong_queue_stack]
	local i = zhudong_queue_stack_i[#zhudong_queue_stack_i]
	table.remove(zhudong_queue_stack)
	table.remove(zhudong_queue_stack_i)

	return queue, i
end

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
	timer.stop()
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

--  设置游戏状态  --
function gamerun_status_set(jieduan)
    gamerun_status = jieduan
end

--  游戏开始阶段初始化  --
function gamerun_init()
	add_funcptr(card_xipai, false)    -- 重置牌堆
	char_fenpei_id()    -- 分配身份
	char_fenpei_wujiang()    -- 分配武将
	add_funcptr(ai_init_shenfen)
	add_funcptr(card_fenfa_init, nil)  -- 初始发牌
	add_funcptr(_init_huashen)
	add_funcptr(_init_weidi)
	add_funcptr(_init_sub1, nil)
end
--[[function _init_huashen()
	huashen_paidui = {}
	if char_juese[char_current_i].skill["化身"] == "available" then
		push_zhudong_queue(table.copy(funcptr_queue), funcptr_i)
		funcptr_queue = {}
		funcptr_i = 0

		add_funcptr(skills_xinsheng_exe, {char_current_i, true})
		add_funcptr(skills_xinsheng_exe, {char_current_i, true})
		add_funcptr(skills_huashen, {char_current_i, "游戏开始"})
		add_funcptr(_init_huifu)
	end
end]]
function _init_huashen()
	huashen_paidui, huashen_wujiang, huashen_skill = {},{},{}
	local had_huashen = {}
	for i = 1, 5 do
		huashen_paidui[i] = {}
		if char_juese[i].skill["化身"] == "available" then
			table.insert(had_huashen, i)
		end
	end
	if #had_huashen ~= 0 then
		push_zhudong_queue(table.copy(funcptr_queue), funcptr_i)
		funcptr_queue = {}
		funcptr_i = 0
		for i = 1, #had_huashen do
			add_funcptr(skills_xinsheng_exe, {had_huashen[i], true})
			add_funcptr(skills_xinsheng_exe, {had_huashen[i], true})
			add_funcptr(skills_huashen, {had_huashen[i], "游戏开始"})
		end
		add_funcptr(_init_huifu)
	end
end
function _init_weidi()
	local had_weidi = {}
	for i = 1, 5 do
		if char_juese[i].skill["伪帝"] == "available" then
			table.insert(had_weidi, i)
		end
	end
	if #had_weidi ~= 0 then
		push_zhudong_queue(table.copy(funcptr_queue), funcptr_i)
		funcptr_queue = {}
		funcptr_i = 0
		for i = 1, #had_weidi do
			add_funcptr(skills_weidi, had_weidi[i])
		end
		add_funcptr(_init_huifu)
	end
end
function _init_huifu()
	funcptr_queue, funcptr_i = pop_zhudong_queue()
end
function _init_sub1()
    gamerun_huihe_set("开始")
	set_hints("请按'确定'继续")
end

--  当前玩家/AI回合开始 (至出牌阶段)  --
function gamerun_huihe_start()
    local msg
	
	funcptr_queue = {}
	card_selected = {}
	game_skip_mopai = false
	game_skip_panding = false
	game_skip_chupai = false
	char_yisha = false
	char_sha_time = 1
	char_jiu_time = 1
	char_distance_infinity = false
	char_sha_add_target_able = false
	char_sha_additional_target = 0
	char_sha_able = true
	char_hejiu = false
	char_shuangxiong = nil
	gamerun_qipai_n = 0
	ai_skills_discard = {}
	ai_attack_priority = nil
	lordskill_used = {}
	for i = 1, 5 do
		lordskill_used[i] = {}
	end

	--  廖化当先额外出牌阶段  --
	if char_juese[char_acting_i].skill["当先"] == "available" and gamerun_dangxian == false then
		msg = {char_juese[char_acting_i].name, "触发了技能 '当先'"}
		push_message(table.concat(msg))
		if char_acting_i == char_current_i then
			add_funcptr(_start_sub1, nil)
		else
			add_funcptr(_start_chupai_ai, nil)
		end
		gamerun_dangxian = true
		return
	elseif gamerun_dangxian == true then
		gamerun_dangxian = false
	end
	
	--  回合开始阶段  --
	msg = {char_juese[char_acting_i].name, "回合开始"}
    add_funcptr(push_message, table.concat(msg))
	gamerun_huihe = "开始"
	msg = nil

	--  回合开始阶段技能  --
	--  左慈化身  --
	if char_juese[char_acting_i].skill["化身"] == "available" then
		add_funcptr(skills_huashen, {char_acting_i, "回合开始"})
	end
	
	--  神司马懿拜印  --
	if char_juese[char_acting_i].skill["拜印"] == "available" and mark_ren[char_acting_i] >= 4 then
		add_funcptr(skills_baiyin)
	end
	
	--  孙策魂姿  --
	if char_juese[char_acting_i].skill["魂姿"] == "available" and char_juese[char_acting_i].tili == 1 then
		add_funcptr(skills_hunzi)
	end

	--  邓艾凿险  --
	if char_juese[char_acting_i].skill["凿险"] == "available" and #card_tian[char_acting_i] > 2 then
		add_funcptr(skills_zaoxian)
	end

	--  刘禅若愚  --
	if char_juese[char_acting_i].skill["若愚"] == "available" and skills_judge_ruoyu() then
		add_funcptr(skills_ruoyu)
	end
	
	--  姜维志继  --
	if char_juese[char_acting_i].skill["志继"] == "available" and #char_juese[char_acting_i].shoupai == 0 then
		add_funcptr(skills_zhiji)
	end
	
	--  孙坚英魂  --
	add_funcptr(skills_yinghun_check_and_run)
	
	--  诸葛亮观星  --
	add_funcptr(skills_guanxing_check_and_run)
	
	--  甄姬洛神  --
	if char_juese[char_acting_i].skill["洛神"] == "available" then
		add_funcptr(skills_luoshen, char_acting_i)
	end
	
	--  判定阶段  --
	--  进入判定阶段前技能  --
	--  夏侯渊神速  --
	if char_juese[char_acting_i].skill["神速"] == "available" then
		add_funcptr(skills_shensu, {char_acting_i, true})
	end

	--  张郃巧变  --
	if char_juese[char_acting_i].skill["巧变"] == "available" then
		add_funcptr(skills_qiaobian, {char_acting_i, "判定"})
	end

	--  判定  --
	add_funcptr(gamerun_huihe_panding)
	
	--  摸牌阶段  --
	--  进入摸牌阶段前技能  --
	--  颜良文丑双雄  --
	if char_juese[char_acting_i].skill["双雄"] == "available" then
		add_funcptr(skills_shuangxiong_1, char_acting_i)
	end

	--  张郃巧变  --
	if char_juese[char_acting_i].skill["巧变"] == "available" then
		add_funcptr(skills_qiaobian, {char_acting_i, "摸牌"})
	end

	--  周瑜英姿  --
	add_funcptr(skills_yingzi_check_and_run)

	--  袁术庸肆  --
	if char_juese[char_acting_i].skill["庸肆"] == "available" then
		add_funcptr(skills_yongsi, char_acting_i)
	end

	--  许褚裸衣  --
	if char_juese[char_acting_i].skill["裸衣"] == "available" then
		if char_acting_i == char_current_i or ai_judge_luoyi(char_acting_i) == 1 then
			add_funcptr(skills_luoyi, char_acting_i)
		end
	end

	--  曹彰将驰  --
	if char_juese[char_acting_i].skill["将驰"] == "available" then
		if char_acting_i == char_current_i or ai_judge_jiangchi(char_acting_i) ~= 3 then
			add_funcptr(skills_jiangchi, char_acting_i)
		end
	end

	--  张辽突袭  --
	if char_juese[char_acting_i].skill["突袭"] == "available" then
		add_funcptr(skills_tuxi, char_acting_i)
	end

	--  鲁肃好施  --
	if char_juese[char_acting_i].skill["好施"] == "available" then
		if char_acting_i == char_current_i or ai_judge_haoshi(char_acting_i) == 1 then
			add_funcptr(skills_haoshi_stage_1, char_acting_i)
		end
	end

	--  孟获再起  --
	if char_juese[char_acting_i].skill["再起"] == "available" then
		if char_juese[char_acting_i].tili < char_juese[char_acting_i].tili_max then
			add_funcptr(skills_zaiqi, char_acting_i)
		end
	end

	--  神吕蒙涉猎  --
	if char_juese[char_acting_i].skill["涉猎"] == "available" then
		if char_acting_i == char_current_i or ai_judge_shelie(char_acting_i) == 1 then
			add_funcptr(skills_shelie, char_acting_i)
		end
	end

	--  摸牌  --
	add_funcptr(card_mopai, nil)

	--  出牌阶段  --
	--  进入出牌阶段前技能  --
	--  鲁肃好施  --
	if char_juese[char_acting_i].skill["好施"] == "available" then
		add_funcptr(skills_haoshi_stage_2, char_acting_i)
	end

	--  张郃巧变  --
	if char_juese[char_acting_i].skill["巧变"] == "available" then
		add_funcptr(skills_qiaobian, {char_acting_i, "出牌"})
	end
	
	--  夏侯渊神速  --
	if char_juese[char_acting_i].skill["神速"] == "available" then
		add_funcptr(skills_shensu, {char_acting_i, false})
	end
	
	--  刘禅放权  --
	if char_juese[char_acting_i].skill["放权"] == "available" then
		add_funcptr(skills_fangquan, char_acting_i)
	end
	
	--  出牌  --
	if char_acting_i == char_current_i then
		add_funcptr(_start_sub1, nil)
	else
		add_funcptr(_start_chupai_ai, nil)
	end
end
function _start_sub1()	--  回合开始：当前玩家进入出牌阶段
    local msg
	
	gamerun_status = ""
	funcptr_queue = {}
	funcptr_i = 0
	
	if game_skip_chupai == false then
	    msg = {char_juese[char_current_i].name, "出牌阶段"}
	    push_message(table.concat(msg))
		
        gamerun_huihe_set("出牌")
        set_hints("请您出牌")
	else
	    msg = {char_juese[char_current_i].name, "不能出牌"}
		push_message(table.concat(msg))
		
        gamerun_huihe_set("出牌")
		on.escapeKey()
	end
end
function _start_chupai_ai()		--  回合开始：AI进入出牌阶段
	funcptr_queue = {}
	funcptr_i = 0
	
	gamerun_status = "AI出牌"
	gamerun_huihe_set("出牌")
    set_hints("")

	if game_skip_chupai == false then
	    push_message(table.concat({char_juese[char_acting_i].name, "出牌阶段"}))
		add_funcptr(ai_card_use, char_acting_i)
	else
		push_message(table.concat({char_juese[char_acting_i].name, "不能出牌"}))
		ai_stage_qipai(char_acting_i)
	end
	timer.start(0.6)
end

--  判定阶段  --
function gamerun_huihe_panding()
	if game_skip_panding ~= true then
		push_zhudong_queue(table.copy(funcptr_queue), funcptr_i)
		timer.stop()
		funcptr_queue = {}
		funcptr_i = 0

		_panding_huihe_set()
		
		for i = #char_juese[char_acting_i].panding, 1, -1 do
			local card = _panding_get_leixing(char_acting_i, i)

			funcptr_add_tag = "无懈执行前"
			add_funcptr(_nanman_send_msg, {char_juese[char_acting_i].name, "的'", card, "'即将生效"})
			funcptr_add_tag = nil

			card_wuxie(card, char_acting_i, char_acting_i)

			funcptr_add_tag = "无懈无效结算"
			add_funcptr(_panding_sub1, char_acting_i)

			--  如场上有司马懿或张角，询问其改判技能  --
			skills_guicai_guidao_ask(char_acting_i, nil, char_acting_i, _panding_get_leixing(char_acting_i, i))

			funcptr_add_tag = "无懈无效结算/伤害插队"
			add_funcptr(_panding_sub2, {i, nil})
			funcptr_add_tag = nil

			funcptr_add_tag = "无懈有效结算"
			add_funcptr(_panding_wuxie, i)
			funcptr_add_tag = nil
		end

		funcptr_add_tag = "无懈执行完毕"
		add_funcptr(_panding_sub3)
		funcptr_add_tag = nil

		timer.start(0.2)
	else
		game_panding_skip = false
		push_message(char_juese[char_acting_i].name .. "的判定阶段被跳过")
	end
end
function _panding_huihe_set()
	local msg

    msg = {char_juese[char_acting_i].name, "判定阶段"}
	push_message(table.concat(msg))
	gamerun_huihe_set("判定")
end
function _panding_get_leixing(id, panding_id)		--  判定阶段：获取判定牌的类型
	local leixing = char_juese[id].panding[panding_id][1]
	if leixing ~= "乐不思蜀" and leixing ~= "兵粮寸断" and leixing ~= "闪电" then
		--  其他牌面的牌 (技能发动)  --
		leixing = char_juese[id].panding[panding_id][4]
	end
	return leixing
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
end
function _panding_sub2(va_list)    -- 子函数2：确认判定是否生效并修改相应标识符
    local card, msg, pass, v
	local id, p
	id = va_list[1]; p = va_list[2]
	
	push_zhudong_queue(table.copy(funcptr_queue), funcptr_i)
	timer.stop()
	funcptr_queue = {}
	funcptr_i = 0

	card = _panding_get_leixing(char_acting_i, id)
    pass = false

	local yanse, huase, dianshu = ai_judge_cardinfo(char_acting_i, {card_panding_card})

	--  曹丕颂威  --
	skills_judge_songwei(char_acting_i)

    if card == "乐不思蜀" then
	    --  如果判定结果不是红桃，则跳过出牌阶段  --
	    if huase ~= "红桃" then
		    game_skip_chupai = true
		    msg = {char_juese[char_acting_i].name, "的'乐不思蜀'判定成功"}
			push_message(table.concat(msg))
		else
		    msg = {char_juese[char_acting_i].name, "的'乐不思蜀'判定失败"}
			push_message(table.concat(msg))
		end

		skills_card_qi_panding(char_acting_i)
	end
	
	if card == "兵粮寸断" then
	    --  如果判定结果不是草花，则跳过摸牌阶段  --
	    if huase ~= "草花" then
		    game_skip_mopai = true
		    msg = {char_juese[char_acting_i].name, "的'兵粮寸断'判定成功"}
			push_message(table.concat(msg))
		else
		    msg = {char_juese[char_acting_i].name, "的'兵粮寸断'判定失败"}
			push_message(table.concat(msg))
		end

		skills_card_qi_panding(char_acting_i)
	end
	
	if card == "闪电" then
	    --  如果判定结果是黑桃2~9，受到3点雷电伤害  --
	    if huase == "黑桃" and dianshu >= "2" and dianshu <= "9" then
		    msg = {char_juese[char_acting_i].name, "的'闪电'判定成功"}
			push_message(table.concat(msg))

			skills_card_qi_panding(char_acting_i)
			char_tili_deduct({3, char_acting_i, -1, "雷", char_acting_i})
		else
		    msg = {char_juese[char_acting_i].name, "的'闪电'判定失败"}
			push_message(table.concat(msg))
			pass = true

			skills_card_qi_panding(char_acting_i)
		end
	end
	
	if pass then
	    --  闪电判定失败时传递给下一玩家  --
	    _panding_pass(id)
	else
	    --  弃掉玩家判定区及临时判定区内的牌  --
		card_add_qipai(char_juese[char_acting_i].panding[id])
		
		if #char_juese[char_acting_i].panding == 1 then
			char_juese[char_acting_i].panding = {}
		else
			table.remove(char_juese[char_acting_i].panding, id)
		end
	end
	
	add_funcptr(_panding_huifu)
	timer.start(0.2)
end
function _panding_sub3()    -- 子函数3：用于延时
	funcptr_queue, funcptr_i = pop_zhudong_queue()
	on.timer()
end
function _panding_huifu()	--  判定阶段：闪电伤害结算后恢复原有函数队列执行
	funcptr_queue, funcptr_i = pop_zhudong_queue()
end
function _panding_pass(id)    -- 将闪电传给下一个玩家
	local p, j
	p = char_acting_i
	j = true
	while j do
		p = p + 1
		if p > 5 then p = 1 end
		j = false
		
		if p == char_acting_i then
			--  其他角色判定区都无法放闪电，只能留在自己的判定区  --
			return
		else
			--  若下家已死亡，则跳过  --
			if char_juese[p].siwang == true then
				j = true
			else
				local yanse, huase, dianshu = ai_judge_cardinfo(p, {char_juese[char_acting_i].panding[id]})
				if yanse == "黑色" and char_juese[p].skill["帷幕"] == "available" then
					j = true
				end

				--  若下家判定区中已有闪电，则跳过之传给再下家  --
				for _, v in ipairs(char_juese[p].panding) do
					if v[1] == "闪电" then
						j = true
						break
					end
				end
			end
		end
	end
	
	table.insert(char_juese[p].panding, 1, char_juese[char_acting_i].panding[id])
	table.remove(char_juese[char_acting_i].panding, id)
end
function _panding_wuxie(id)	-- 判定被无懈
	--push_message("锦囊被无懈，无需判定")
	if char_juese[char_acting_i].panding[id][1] == "闪电" then
		_panding_pass(id)
	else
		card_add_qipai(char_juese[char_acting_i].panding[id])
		table.remove(char_juese[char_acting_i].panding, id)
	end
	skills_skip_subqueue()
end

--  当前玩家/AI回合结束 (弃牌阶段~回合结束阶段)
function gamerun_huihe_jieshu(qipai)
    local msg
	if not qipai then
		funcptr_queue = {}
	end

	--  弃牌阶段技能  --
	if char_juese[char_acting_i].skill["旋风"] == "available" and gamerun_qipai_n >= 2 then
		add_funcptr(skills_xuanfeng, {char_acting_i, "弃牌"})
	end

	if char_juese[char_acting_i].skill["忍戒"] == "available" and char_juese[char_acting_i].siwang == false and gamerun_qipai_n > 0 then
		add_funcptr(skills_renjie, {char_acting_i, gamerun_qipai_n})
	end

	for i = 1, 5 do
		if i ~= char_acting_i and char_juese[i].skill["固政"] == "available" and char_juese[i].siwang == false then
			add_funcptr(skills_guzheng, {i, char_acting_i})
		end
	end
	
	--  回合结束  --
	add_funcptr(_jieshu_huihe_set, qipai)
	
	if skills_judge_xueyi(char_acting_i) > 0 and #char_juese[char_acting_i].shoupai > char_juese[char_acting_i].tili_max then
		add_funcptr(push_message, char_juese[char_acting_i].name .. "触发了武将技能 '血裔'")
	end
	
	--  回合结束阶段技能  --
	if char_juese[char_acting_i].skill["闭月"] == "available" then
		add_funcptr(skills_biyue,char_acting_i)
	end
	
	if char_juese[char_acting_i].skill["据守"] == "available" then
		add_funcptr(skills_jushou,char_acting_i)
	end
	
	if char_juese[char_acting_i].skill["放权"] == "available" and gamerun_fangquan == true then
		add_funcptr(skills_fangquan_2,char_acting_i)
	end
	
	if char_juese[char_acting_i].skill["困奋"] == "available" then
		add_funcptr(skills_kunfen,char_acting_i)
	end
	
	if char_juese[char_acting_i].skill["崩坏"] == "available" then
		if skills_judge_benghuai(char_acting_i) then
			add_funcptr(skills_benghuai)
		end
	end
	for i = 1, 5 do
		if char_juese[i].skill["连破"] == "available" and char_juese[i].siwang == false and gamerun_killed[i] > 0 then
			add_funcptr(skills_lianpo,i)
		end
	end
	
	if char_juese[char_acting_i].skill["化身"] == "available" then
		add_funcptr(skills_huashen, {char_acting_i, "回合结束"})
	end

	--  重置仁德给出牌计数  --
	char_rende_given = 0
	last_OK = false
	char_luoyi = false
	skill_disrow = 0
	for i = 1, 5 do
		gamerun_killed[i] = 0
	end
	gamerun_skills_reset()
	
	msg = {char_juese[char_acting_i].name, "回合结束"}
    add_funcptr(push_message, table.concat(msg))
	
	add_funcptr(_jieshu_sub1, nil)
end
function _jieshu_huihe_set(qipai)
	local msg

	gamerun_huihe_set("结束")
	card_huihe_cards_into_qipai()

	if not qipai then
	    msg = {char_juese[char_acting_i].name, "弃牌阶段"}
        push_message(table.concat(msg))
	else
		skills_skip_subqueue()
	end
end
function _jieshu_sub1()
	gamerun_status = ""
    gamerun_huihe_set("结束")
	set_hints("请按'确定'继续")
end

--  己方进入弃牌阶段  --
function gamerun_enter_qipai()
	gamerun_huihe_set("弃牌")
	gamerun_status = ""
	wugucards = {}

	char_yongsi_withdraw = nil
	
	--  袁绍作为主公，若有一个群雄势力角色存活，其手牌上限+2  --
	local extra = 0
	extra = skills_judge_xueyi(char_current_i)
	
	-- 如果体力小于手牌数则需弃牌 --
	if char_juese[char_current_i].tili + extra < #char_juese[char_current_i].shoupai then
		local msg = {char_juese[char_current_i].name, "弃牌阶段"}
		push_message(table.concat(msg))
		msg = {"您须弃", math.min(#char_juese[char_current_i].shoupai - char_juese[char_current_i].tili - extra, #char_juese[char_current_i].shoupai), "张牌"}
		set_hints(table.concat(msg))
	else
		set_hints("")
		gamerun_huihe_jieshu(false)    -- 进入回合结束
		consent_func_queue(0.2)
	end
end

--  移动选取卡牌使用目标  --
function gamerun_select_target(dir)
    local card

	if card_highlighted ~= nil then
		if char_juese[char_current_i].shoupai[card_highlighted] ~= nil then
			if #char_juese[char_current_i].shoupai[card_highlighted] > 0 then
				card = char_juese[char_current_i].shoupai[card_highlighted][1]
			end
		end
	end
	
	if dir == "init" then
	    gamerun_target_selected = char_current_i - 1
		gamerun_target_skip_self("right", card)
		if gamerun_target_selected < 1 then
			gamerun_target_selected = 5
		end
		
		local j = true
		while j do
			j = false
			if char_juese[gamerun_target_selected].siwang == true then
				gamerun_target_selected = gamerun_target_selected - 1
				j = true
			end
			gamerun_target_skip_self("right", card)
			if gamerun_target_selected < 1 then
				gamerun_target_selected = 5
			end
		end
	end
	
    if dir == "right" then
	    gamerun_target_selected = gamerun_target_selected - 1
		gamerun_target_skip_self("right", card)
		if gamerun_target_selected < 1 then
			gamerun_target_selected = 5
		end
		
		local j = true
		while j do
			j = false
			if char_juese[gamerun_target_selected].siwang == true then
				gamerun_target_selected = gamerun_target_selected - 1
				j = true
			end
			gamerun_target_skip_self("right", card)
			if gamerun_target_selected < 1 then
				gamerun_target_selected = 5
			end
		end
	end
	
	if dir == "left" then
	    gamerun_target_selected = gamerun_target_selected + 1
		gamerun_target_skip_self("left", card)
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
			gamerun_target_skip_self("left", card)
			if gamerun_target_selected > 5 then
				gamerun_target_selected = 1
			end
		end
	end
end

function gamerun_target_skip_self(direction, card)
	local increment
	if direction == "left" then
		increment = 1
	elseif direction == "right" then
		increment = -1
	end

	if gamerun_target_selected > 5 then
		gamerun_target_selected = 1
	end

	if card == "火攻" then
		return
	end

	if gamerun_status == "选择目标-B" then
		while gamerun_target_selected == guankan_s or (gamerun_target_selected == char_current_i and card ~= "借刀杀人" and card ~= "铁索连环") do
			gamerun_target_selected = gamerun_target_selected + increment
		end
		return
	end

	if gamerun_status == "选择目标-C" then
		while gamerun_target_selected == guankan_s or gamerun_target_selected == selected_target_b or gamerun_target_selected == char_current_i do
			gamerun_target_selected = gamerun_target_selected + increment
		end
		return
	end

	if gamerun_status == "选择目标-D" then
		while gamerun_target_selected == guankan_s or gamerun_target_selected == selected_target_b or gamerun_target_selected == selected_target_c or gamerun_target_selected == char_current_i do
			gamerun_target_selected = gamerun_target_selected + increment
		end
		return
	end

	if gamerun_status == "技能选择-目标B" then
		if gamerun_target_selected == guankan_s and (imp_card ~= "节命" and imp_card ~= "好施") then
			gamerun_target_selected = gamerun_target_selected + increment
		end
		return
	end

	if gamerun_target_selected == char_current_i then
		gamerun_target_selected = gamerun_target_selected + increment
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
			if gamerun_status ~= "技能选择-单牌" and gamerun_status ~= "技能选择-多牌" and gamerun_status ~= "主动出牌-贯石" then
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

--  将游戏回合交给下一位玩家  --
function gamerun_next_player()
	if #extra_turn > 0 then
		while #extra_turn > 0 do
			if char_juese[extra_turn[1]].siwang == true then
				table.remove(extra_turn, 1)
			elseif char_juese[extra_turn[1]].fanmian == true then
				char_juese[extra_turn[1]].fanmian = false
				push_message(table.concat({char_juese[extra_turn[1]].name, "将武将牌翻回正面"}))
				table.remove(extra_turn, 1)
			else
				if real_last == 0 then
					real_last = char_acting_i
				end
				char_acting_i = extra_turn[1]
				table.remove(extra_turn, 1)
				break
			end
		end
	else
		if real_last ~= 0 then
			char_acting_i = real_last
			real_last = 0
		end
		char_acting_i = char_acting_i + 1
		if char_acting_i > 5 then
			char_acting_i = 1
		end
				
		--  跳过死亡以及翻面的玩家  --
		local j = true
		while j do
			j = false
			if char_juese[char_acting_i].siwang == true then
				char_acting_i = char_acting_i + 1
				j = true
			elseif char_juese[char_acting_i].fanmian == true and char_juese[char_acting_i].siwang == false then
				char_juese[char_acting_i].fanmian = false
				push_message(table.concat({char_juese[char_acting_i].name, "将武将牌翻回正面"}))
				char_acting_i = char_acting_i + 1
				j = true
			end
			if char_acting_i > 5 then
				char_acting_i = 1
			end
		end
	end
	--  注释此行即使用主动AI，不注释不使用  --
	--char_current_i = char_acting_i
end

--  从主公开始游戏  --
function gamerun_start_from_lord()
	while char_juese[char_acting_i].shenfen ~= "主公" do
		char_acting_i = char_acting_i + 1
		if char_acting_i > 5 then
			char_acting_i = 1
		end
	end
end

--  重置所有"回限x"技能并失去临时获得的技能  --
function gamerun_skills_reset()
	for i = 1,5 do
		for k,v in pairs(char_juese[i].skill) do
			if v == "locked" then
				char_juese[i].skill[k] = 1
			end
		end
	end
	for i = 1,5 do
		for j = #skill_temp[i], 1, -1 do
			if skill_double[i][skill_temp[i][j]] then
				skill_double[i][skill_temp[i][j]] = nil
			else
				char_juese[i].skill[skill_temp[i][j]] = nil
				for k = #char_juese[i].skillname, 1, -1 do
					if char_juese[i].skillname[k] == skill_temp[i][j] then
						table.remove(char_juese[i].skillname,k)
					end
				end
			end
		end
	end
end

--  判断是否符合方天画戟发动条件  --
function gamerun_judge_fangtian()
	local carda = char_juese[char_current_i].shoupai[card_highlighted][1]

	if #char_juese[char_current_i].wuqi > 0 then
		if char_juese[char_current_i].wuqi[1] == "方天戟" then
			if #char_juese[char_current_i].shoupai == 1 and (carda == "杀" or carda == "火杀" or carda == "雷杀") then
				return true
			end
		end
	end

	return false
end






--                     TI-Lua 系统事件                 --
function on.timer()
	if funcptr_i == 0 then
		funcptr_i = 1
	end
	
	if funcptr_i <= #funcptr_queue then
		funcptr_i = funcptr_i + 1
		if funcptr_queue[funcptr_i - 1].func ~= nil then
			funcptr_queue[funcptr_i - 1].func(funcptr_queue[funcptr_i - 1].va_list)
		end
	else
		timer.stop()
	end
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
end

function on.enterKey()
    if gamerun_status == "手牌生效中" or gamerun_status == "AI出牌" then return end
	local card

    --  刚刚选局  --
    if gamerun_huihe == "" and gamerun_status ~= "选项选择" then
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

	if gamerun_status == "选项选择" then
		gamerun_item(item_disrow + gamerun_guankan_selected)
		return
	end

	if gamerun_status == "牌堆操作" then
		gamerun_deal()
		return
	end

	if gamerun_status == "确认操作" or string.find(gamerun_status, "技能选择") then
		gamerun_OK = true
		if string.find(gamerun_status, "拼点") then
			gamerun_OK_pindian_ptr()
		else
			gamerun_OK_ptr()
		end
		return
	end

	if string.find(gamerun_status, "观看手牌") then
		funcptr_queue = {}
		funcptr_i = 0
		if string.find(gamerun_status, "顺") then
			add_funcptr(card_chai_shun_exe, {false, gamerun_guankan_selected, guankan_s, guankan_d})
			skills_losecard(guankan_d)
			add_funcptr(_shun_sub2)

		elseif string.find(gamerun_status, "拆") then
			add_funcptr(card_chai_shun_exe, {true, gamerun_guankan_selected, guankan_s, guankan_d})
			skills_losecard(guankan_d)
			add_funcptr(_chai_sub2)

		elseif string.find(gamerun_status, "杀") then
			add_funcptr(card_chai_shun_exe, {true, gamerun_guankan_selected, guankan_s, guankan_d})
			add_funcptr(_sha_qilin_huifu)

		elseif string.find(gamerun_status, "寒1") then
			add_funcptr(card_chai_shun_exe, {true, gamerun_guankan_selected, guankan_s, guankan_d})
			skills_losecard(guankan_d)
			add_funcptr(_sha_sub3)

		elseif string.find(gamerun_status, "寒2") then
			add_funcptr(card_chai_shun_exe, {true, gamerun_guankan_selected, guankan_s, guankan_d})
			skills_losecard(guankan_d)
			add_funcptr(_sha_sub2)

		elseif string.find(gamerun_status, "归心") then
			add_funcptr(card_chai_shun_exe, {false, gamerun_guankan_selected, guankan_s, guankan_d})
			skills_losecard(guankan_d)
			add_funcptr(_guixin_sub2, {gamerun_guankan_selected, guankan_s, guankan_d})

		elseif string.find(gamerun_status, "反馈") or string.find(gamerun_status, "烈刃") then
			add_funcptr(card_chai_shun_exe, {false, gamerun_guankan_selected, guankan_s, guankan_d})
			skills_losecard(guankan_d)
			add_funcptr(_fankui_status_restore)

		elseif string.find(gamerun_status, "猛进") then
			add_funcptr(card_chai_shun_exe, {true, gamerun_guankan_selected, guankan_s, guankan_d})
			skills_losecard(guankan_d)
			add_funcptr(_fankui_status_restore)

		elseif string.find(gamerun_status, "旋风") then
			add_funcptr(card_chai_shun_exe, {true, gamerun_guankan_selected, guankan_s, guankan_d})
			skills_losecard(guankan_d)

			if string.find(gamerun_status, "旋风1") then
				add_funcptr(_xuanfeng_select_target, "观看手牌-旋风2")
			else
				_xuanfeng_chai_post()
			end

		end
		timer.start(0.6)

		platform.window:invalidate()
		return
	end

	if string.find(gamerun_status, "主动出牌") then
		if string.find(gamerun_status, "无懈") then
			if table.getn2(card_selected) ~= 0 then
				card = char_juese[char_current_i].shoupai[card_highlighted]
				if string.find(card[1], "无懈可击") or char_juese[char_current_i].skill["看破"] == "available" then
					_wuxie_zhudong_chu(card, card_highlighted, wuxie_va)
					card_selected = {}
					set_hints("")
					card_highlighted = 1
				end
			end
			return
		end

		if string.find(gamerun_status, "决斗") then
			if table.getn2(card_selected) ~= 0 then
				card = char_juese[char_current_i].shoupai[card_highlighted][1]
				if card_judge_if_sha(char_current_i, card_highlighted) then
					funcptr_queue = {}
					_juedou_exe_ji(wuxie_va[1], wuxie_va[2], card_highlighted)
					consent_func_queue(0.6)
				end
			end
			return
		end
	
		if string.find(gamerun_status, "火攻A") then
			if table.getn2(card_selected) ~= 0 then
				card = char_juese[char_current_i].shoupai[card_highlighted]
				local yanse, huase, dianshu = ai_judge_cardinfo(char_current_i, {card})

				if huase == guankan_s then
					funcptr_queue = {}
					_huogong_exe_2(char_current_i, gamerun_target_selected, card_highlighted)
					consent_func_queue(0.6)
				end
			end
			return
		end

		if string.find(gamerun_status, "火攻B") then
			if table.getn2(card_selected) ~= 0 then
				funcptr_queue = {}
				_huogong_beidong_exe_2(wuxie_va[1], wuxie_va[2], card_highlighted)
				consent_func_queue(0.6)
			end
			return
		end

		if string.find(gamerun_status, "补益") then
			if table.getn2(card_selected) ~= 0 then
				funcptr_queue = {}
				_buyi_exe({char_current_i, char_current_i, card_highlighted})
				add_funcptr(_buyi_huifu_2, nil)
				consent_func_queue(0.6)
			end
			return
		end

		if string.find(gamerun_status, "南蛮") then
			if table.getn2(card_selected) ~= 0 then
				card = char_juese[char_current_i].shoupai[card_highlighted]
				if card_judge_if_sha(char_current_i, card_highlighted) then
					funcptr_queue = {}
					_nanman_zhudong_chu(wuxie_va)
					consent_func_queue(0.6)
				end
			end
			return
		end

		if string.find(gamerun_status, "万箭") then
			if table.getn2(card_selected) ~= 0 then
				card = char_juese[char_current_i].shoupai[card_highlighted]
				if card_judge_if_shan(char_current_i, card_highlighted) then
					funcptr_queue = {}
					_wanjian_zhudong_chu(wuxie_va)
					consent_func_queue(0.6)
				end
			end
			return
		end

		if string.find(gamerun_status, "借刀") then
			if table.getn2(card_selected) ~= 0 then
				card = char_juese[char_current_i].shoupai[card_highlighted]
				funcptr_queue = {}
				if _jiedao_zhudong_chu(wuxie_va) then
					consent_func_queue(0.6)
				end
			end
			return
		end

		if string.find(gamerun_status, "-杀") then
			if table.getn2(card_selected) ~= 0 then
				if card_judge_if_shan(char_current_i, card_highlighted) then
					funcptr_queue = {}
					_sha_zhudong_chu(wuxie_va)
					consent_func_queue(0.6)
				end
			end
			return
		end

		if string.find(gamerun_status, "雌雄") then
			if table.getn2(card_selected) ~= 0 then
				funcptr_queue = {}
				_sha_cixiong_zhudong_qipai(wuxie_va)
				consent_func_queue(0.6)
			end
			return
		end
	
		if string.find(gamerun_status, "青龙") then
			if table.getn2(card_selected) ~= 0 then
				card = char_juese[char_current_i].shoupai[card_highlighted][1]
				if card_judge_if_sha(char_current_i, card_highlighted) then
					funcptr_queue = {}
					_sha_exe_2(char_current_i, gamerun_target_selected, card_highlighted)
					consent_func_queue(0.6)
				end
			end
			return
		end

		if string.find(gamerun_status, "贯石") then
			if table.getn2(card_selected) == 2 then
				gamerun_status = "手牌生效中"
				set_hints("")
				funcptr_queue = {}; card_highlighted = 1

				n_qipai = table.getn2(card_selected)
				card_qipai_go()
				skills_losecard(char_current_i)
				
				_sha_exe_3(char_current_i, gamerun_target_selected, guankan_s)
				consent_func_queue(0.6)
			end
			return
		end
	
		if string.find(gamerun_status, "刚烈") then
			if table.getn2(card_selected) == 2 then
				funcptr_queue = {}
				_ganglie_exe_1()
				consent_func_queue(0.6)
			end
			return
		end

		return
	end

	if string.find(gamerun_status, "牌堆选择") then
		if string.find(gamerun_status, "五谷") then
			_wugu_get_card_zhudong(char_current_i, gamerun_guankan_selected)
			return
		end

		if string.find(gamerun_status, "固政") then
			_guzheng_exe({gamerun_guankan_selected, char_current_i, guankan_s})
			return
		end

		if string.find(gamerun_status, "不屈") then
			_buqu_remove_card_exe(char_current_i, gamerun_guankan_selected)
			return
		end

		if string.find(gamerun_status, "急袭") then
			_jixi_exe(char_current_i, gamerun_target_selected, gamerun_guankan_selected)
			return
		end

		return
	end
	
	--  出牌阶段特有模式  --
	if gamerun_huihe == "出牌" then
		if table.getn2(card_selected) == 1 and card_selected[card_highlighted] ~= nil then
			local carda = char_juese[char_current_i].shoupai[card_highlighted][1]
			local fangtian = false
			local n_sha_mubiao = 1
			
			--  判断是否符合方天画戟发动条件  --
			if gamerun_judge_fangtian() == true then
				fangtian = true
				n_sha_mubiao = 3
			end

			--  判断是否通过技能增加了出杀目标  --
			if char_sha_add_target_able == true and (carda == "杀" or carda == "火杀" or carda == "雷杀") then
				fangtian = true
				n_sha_mubiao = math.min(n_sha_mubiao + char_sha_additional_target, 4)
			end

			if gamerun_status == "" then
				if card_chupai(card_highlighted) then
					--  恢复状态  --
					card_selected = {}
					card_highlighted = 1
					platform.window:invalidate()
				end
				return
			end

			if gamerun_status == "选择目标" then
				if carda == "借刀杀人" or carda == "铁索连环" or fangtian == true then
					--  多目标出牌  --
					if card_if_d_limit(char_juese[char_current_i].shoupai[card_highlighted][1], char_current_i, gamerun_target_selected, {card_highlighted}) then
						if carda == "借刀杀人" then
							set_hints("请选择目标B")
						elseif carda == "铁索连环" then
							set_hints("'确定'：选择B '取消'：仅A")
						elseif fangtian == true then
							--  若只有两人存活，方天画戟只能指定一个目标  --
							if char_alive_stat() == 2 or n_sha_mubiao == 1 then
								if card_fangtian(1, false) then
									card_selected = {}
									card_highlighted = 1
									platform.window:invalidate()
								end
								return
							else
								set_hints("请选择目标B或'取消'出杀")
							end
						end

						guankan_s = gamerun_target_selected
						gamerun_status = "选择目标-B"
						gamerun_select_target("init")
						platform.window:invalidate()
					end
				else
					--  单目标出牌  --
					if card_chupai(card_highlighted) then
						--  恢复状态  --
						card_selected = {}
						card_highlighted = 1
						platform.window:invalidate()
					end
				end

				return
			end

			if gamerun_status == "选择目标-B" then
				if carda == "借刀杀人" or carda == "铁索连环" then
					--  开始借刀杀人/连环  --
					if card_chupai(true) then
						--  恢复状态  --
						card_selected = {}
						card_highlighted = 1
						platform.window:invalidate()
					end

				elseif fangtian == true then
					if char_alive_stat() == 3 or n_sha_mubiao == 2 then
						if card_fangtian(2, false) then
							card_selected = {}
							card_highlighted = 1
							platform.window:invalidate()
						end
						return
					end

					--  杀第二目标  --
					if card_if_d_limit(char_juese[char_current_i].shoupai[card_highlighted][1], char_current_i, gamerun_target_selected, {card_highlighted}) then
						set_hints("请选择目标C或'取消'出杀")
						selected_target_b = gamerun_target_selected
						gamerun_status = "选择目标-C"
						gamerun_select_target("init")
						platform.window:invalidate()
					end

				end
				return
			end

			if gamerun_status == "选择目标-C" then
				if char_alive_stat() == 4 or n_sha_mubiao == 3 then
					if card_fangtian(3, false) then
						card_selected = {}
						card_highlighted = 1
						platform.window:invalidate()
					end
					return
				end

				--  杀第三目标  --
				if card_if_d_limit(char_juese[char_current_i].shoupai[card_highlighted][1], char_current_i, gamerun_target_selected, {card_highlighted}) then
					set_hints("请选择目标D或'取消'出杀")
					selected_target_c = gamerun_target_selected
					gamerun_status = "选择目标-D"
					gamerun_select_target("init")
					platform.window:invalidate()
				end

				return
			end

			if gamerun_status == "选择目标-D" then
				--  杀第四目标  --
				if card_fangtian(4, false) then
					card_selected = {}
					card_highlighted = 1
					platform.window:invalidate()
				end
				return
			end

			return
		end

		return
	end

	--  弃牌阶段特有模式  --
	if gamerun_huihe == "弃牌" then
		--  袁绍作为主公，若有一个群雄势力角色存活，其手牌上限+2  --
		local extra = 0
		extra = skills_judge_xueyi(char_current_i)
	
	    --  确认已选择足够的牌  --
		if table.getn2(card_selected) == math.min(#char_juese[char_current_i].shoupai - char_juese[char_current_i].tili - extra, #char_juese[char_current_i].shoupai) then
		    set_hints("")
			funcptr_queue = {}; card_highlighted = 1
			wugucards = {}

			gamerun_qipai_n = gamerun_qipai_n + table.getn2(card_selected)
			card_qipai_go()    -- 执行弃牌
			skills_losecard(char_current_i)

	        gamerun_huihe_jieshu(true)    -- 进入回合结束阶段
		    consent_func_queue(0.2)
		end
	end
	
	--  结束阶段特有模式  --
	if gamerun_huihe == "结束" or gamerun_huihe == "开始" then
		if gamerun_huihe == "结束" then
			gamerun_next_player()
		elseif gamerun_huihe == "开始" then
			gamerun_start_from_lord()
		end
			
		set_hints("")
		card_highlighted = 1
		gamerun_huihe_start()    -- 下一玩家回合开始
		consent_func_queue(0.2)
		
		return
	end
end

--  "取消/弃牌" 键  --
function on.escapeKey()
    local msg, card

	if gamerun_huihe == "" or gamerun_huihe == "游戏结束" then
		return
	end

	if gamerun_status == "手牌生效中" or gamerun_status == "AI出牌" then
		return
	end
	
	if string.find(gamerun_status, "观看手牌") or string.find(gamerun_status, "牌堆选择") or string.find(gamerun_status, "选项选择") or string.find(gamerun_status, "牌堆操作") then
		return
	end
	
	if gamerun_status == "确认操作" then
		gamerun_OK = false
		gamerun_OK_ptr()
		return
	end

	--  未选取牌时  --
	if table.getn2(card_selected) == 0 then
		if string.find(gamerun_status, "主动出牌") then
			if string.find(gamerun_status, "无懈") then
				funcptr_queue = {}
				_wuxie_zhudong_fangqi()
				return
			end

			if string.find(gamerun_status, "决斗") then
				funcptr_queue = {}
				_juedou_exe_fangqi(wuxie_va[1], wuxie_va[2])
				consent_func_queue(0.6)
				return
			end
			
			if string.find(gamerun_status, "火攻A") then
				funcptr_queue = {}
				_huogong_exe_3(char_current_i)
				consent_func_queue(0.6)
				return
			end

			if string.find(gamerun_status, "南蛮") then
				funcptr_queue = {}
				_nanman_zhudong_fangqi(wuxie_va)
				consent_func_queue(0.6)
				return
			end

			if string.find(gamerun_status, "万箭") then
				funcptr_queue = {}
				_wanjian_zhudong_fangqi(wuxie_va)
				consent_func_queue(0.6)
				return
			end

			if string.find(gamerun_status, "借刀") then
				funcptr_queue = {}
				_jiedao_zhudong_fangqi(wuxie_va)
				consent_func_queue(0.6)
				return
			end

			if string.find(gamerun_status, "-杀") then
				funcptr_queue = {}
				_sha_zhudong_fangqi(wuxie_va, true)
				consent_func_queue(0.6)
				return
			end

			if string.find(gamerun_status, "雌雄") then
				funcptr_queue = {}
				_sha_cixiong_zhudong_fangqi(wuxie_va)
				consent_func_queue(0.6)
				return
			end
			
			if string.find(gamerun_status, "青龙") or string.find(gamerun_status, "贯石") then
				_sha_exe_2_g()
				return
			end

			if string.find(gamerun_status, "刚烈") then
				funcptr_queue = {}
				_ganglie_exe_2()
				consent_func_queue(0.6)
				return
			end

			return
		end

		if string.find(gamerun_status, "技能选择") then
			--if imp_card == "强袭" or imp_card == "濒死" or imp_card == "铁索连环" or imp_card == "天香" or imp_card == "鬼才" or imp_card == "流离" or imp_card == "杀" or imp_card == "护驾" or imp_card == "突袭" or imp_card == "黄天" or imp_card == "制霸" or imp_card == "享乐" or imp_card == "竭缘" or imp_card == "悲歌" or imp_card == "旋风" then
				gamerun_OK = false
				gamerun_OK_ptr()
			--end

			return
		end
		
		--  出牌阶段特有模式  --
		if gamerun_huihe == "出牌" then
			if lihun_target ~= nil then
				skills_lihun_stage_2_enter()
			elseif gamerun_dangxian == true then
				gamerun_skills_reset()
				set_hints("")
				card_highlighted = 1
				gamerun_huihe_start()    -- 正常回合开始
				consent_func_queue(0.2)
			elseif char_juese[char_acting_i].skill["巧变"]=="available" and not gamerun_qiaobian then
				skills_qiaobian({char_acting_i,"弃牌"})
			elseif char_juese[char_acting_i].skill["克己"]=="available" and not char_yisha then
				skills_keji(char_acting_i)
			elseif char_juese[char_acting_i].skill["庸肆"]=="available" and char_yongsi_withdraw == nil then
				local shili = {}
				for i = 1, 5 do
					if char_juese[i].siwang ~= true then
						shili[char_juese[i].shili] = 1
					end
				end

				gamerun_wuqi_into_hand(char_current_i)
				skills_enter("您须弃"..math.min(table.getn2(shili),table.getn2(char_juese[char_current_i].shoupai)).."张牌", "", "庸肆", "技能选择-多牌")
					gamerun_OK_ptr = function()
					if table.getn2(card_selected) == math.min(table.getn2(shili),table.getn2(char_juese[char_current_i].shoupai)) then
						gamerun_status = "手牌生效中"
						funcptr_queue = {}
						push_message(char_juese[char_acting_i].name.."触发了武将技能 '庸肆'")

						gamerun_qipai_n = table.getn2(card_selected)
						card_qipai_go()
						skills_losecard(char_current_i)

						add_funcptr(gamerun_wuqi_out_hand, char_acting_i)
						char_yongsi_withdraw = true
						
						add_funcptr(gamerun_status_set, "")
						add_funcptr(on.escapeKey, nil)
						consent_func_queue(0.2)
					end
				end
	
				gamerun_tab_ptr = function() end
			else
				--  出牌阶段结束，进入弃牌阶段  --
				gamerun_enter_qipai()
			end
		end

		return
	end
	
	--  已选取至少一张牌时  --
	if table.getn2(card_selected) > 0 then
		local fangtian = false

		card = char_juese[char_current_i].shoupai[card_highlighted][1]

		--  判断是否符合方天画戟发动条件  --
		if gamerun_judge_fangtian() == true then
			fangtian = true
		end

		--  判断是否通过技能增加了出杀目标  --
		if char_sha_add_target_able == true and (card == "杀" or card == "火杀" or card == "雷杀") then
			fangtian = true
		end

		if table.getn2(card_selected) == 1 then
			if string.find(gamerun_status, "技能选择") then
				if imp_card == "铁索连环" then
					gamerun_OK = false
					gamerun_OK_ptr()
				end
			end

			if gamerun_status == "选择目标" then
				if card == "铁索连环" then
					--  发动铁索连环 (重铸效果)  --
					card_lian_chongzhu({card_highlighted, char_current_i})
					--  恢复状态  --
					card_selected = {}
					card_highlighted = 1
					platform.window:invalidate()
				end
				return
			end

			if gamerun_status == "选择目标-B" then
				if card == "铁索连环" then
					--  发动铁索连环 (连环效果)  --
					if card_chupai(false) then
						--  恢复状态  --
						card_selected = {}
						card_highlighted = 1
						platform.window:invalidate()
					end
				elseif fangtian == true then
					--  杀仅选择一个目标  --
					if card_fangtian(1, true) then
						card_selected = {}
						card_highlighted = 1
						platform.window:invalidate()
					end
				end
				return
			end

			if gamerun_status == "选择目标-C" then
				--  杀仅选择两个目标  --
				if card_fangtian(2, true) then
					card_selected = {}
					card_highlighted = 1
					platform.window:invalidate()
				end
				return
			end

			if gamerun_status == "选择目标-D" then
				--  杀仅选择三个目标  --
				if card_fangtian(3, true) then
					card_selected = {}
					card_highlighted = 1
					platform.window:invalidate()
				end
				return
			end
		end

		return
	end
end

--  方向键 (移动高亮的牌/选择卡牌使用目标)  --
function on.arrowKey(key)
	if (gamerun_huihe == "" or gamerun_huihe == "游戏结束") and gamerun_status ~= "选项选择" then
		return
	end
	if (((gamerun_huihe == "结束" and imp_card ~= "放权") or gamerun_status == "手牌生效中") and gamerun_status ~= "选项选择") then
		return
	end

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
		elseif string.find(gamerun_status, "牌堆操作") then
			if choose_name == "观星" or choose_name == "涉猎" or choose_name == "攻心" then
				if gamerun_guankan_selected > 1 then
					if gamerun_guankan_selected == card_dealed_selected then
						if card_paidui_dealed == 1 then
							card_dealed_1[card_dealed_selected],card_dealed_1[card_dealed_selected-1] = card_dealed_1[card_dealed_selected-1],card_dealed_1[card_dealed_selected]
						elseif card_paidui_dealed == 2 then
							card_dealed_2[card_dealed_selected],card_dealed_2[card_dealed_selected-1] = card_dealed_2[card_dealed_selected-1],card_dealed_2[card_dealed_selected]
						end
						card_dealed_selected = card_dealed_selected - 1
					end
					gamerun_guankan_selected = gamerun_guankan_selected - 1
				end
			elseif choose_name == "巧变" then
				if gamerun_guankan_selected > 1 then
					if gamerun_guankan_selected ~= card_dealed_selected then
						gamerun_guankan_selected = gamerun_guankan_selected - 1
					end
				end
			end
		else
		    --  选取手牌状态  --
			--  已选取牌的情况下不允许移动  --
			--  允许移动的情况  --
		    if table.getn2(card_selected) == 0 or gamerun_huihe == "弃牌" or string.find(gamerun_status, "贯石") or string.find(gamerun_status, "借刀") or gamerun_status == "技能选择-多牌" or gamerun_status == "主动出牌-刚烈" then
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
		elseif string.find(gamerun_status, "牌堆操作") then
			if choose_name == "观星" or choose_name == "涉猎" or choose_name == "攻心" then
				if (gamerun_guankan_selected < #card_dealed_1 and card_paidui_dealed == 1) or (gamerun_guankan_selected < #card_dealed_2 and card_paidui_dealed == 2) then
					if gamerun_guankan_selected == card_dealed_selected then
						if card_paidui_dealed == 1 then
							card_dealed_1[card_dealed_selected],card_dealed_1[card_dealed_selected+1] = card_dealed_1[card_dealed_selected+1],card_dealed_1[card_dealed_selected]
						elseif card_paidui_dealed == 2 then
							card_dealed_2[card_dealed_selected],card_dealed_2[card_dealed_selected+1] = card_dealed_2[card_dealed_selected+1],card_dealed_2[card_dealed_selected]
						end
						card_dealed_selected = card_dealed_selected + 1
					end
					gamerun_guankan_selected = gamerun_guankan_selected + 1
				end
			elseif choose_name == "巧变" then
				if (gamerun_guankan_selected < #card_dealed_1 and card_paidui_dealed == 1) or (gamerun_guankan_selected < #card_dealed_2 and card_paidui_dealed == 2) then
					if gamerun_guankan_selected ~= card_dealed_selected then
						gamerun_guankan_selected = gamerun_guankan_selected + 1
					end
				end
			end
		else
		    if table.getn2(card_selected) == 0 or gamerun_huihe == "弃牌" or string.find(gamerun_status, "贯石") or string.find(gamerun_status, "借刀") or gamerun_status == "技能选择-多牌" or gamerun_status == "主动出牌-刚烈" then
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
			else
				if item_disrow > 0 then
					item_disrow = item_disrow - 1
				end
			end
		elseif string.find(gamerun_status, "牌堆操作") and card_paidui_dealed == 2 and (gamerun_guankan_selected == card_dealed_selected or #card_dealed_1 > 0) then
			if choose_name == "观星" or choose_name == "涉猎" or choose_name == "攻心" then
				if gamerun_guankan_selected == card_dealed_selected then
					table.insert(card_dealed_1,1,card_dealed_2[card_dealed_selected])
					table.remove(card_dealed_2,card_dealed_selected)
					card_dealed_selected = 1
				end
				gamerun_guankan_selected = 1
				card_paidui_dealed = 1
			elseif choose_name == "巧变" then
				if gamerun_guankan_selected ~= card_dealed_selected then
					gamerun_guankan_selected = 1
					card_paidui_dealed = 1
				elseif gamerun_guankan_selected == card_dealed_selected then
					if gamerun_guankan_selected <= 4 then
						if card_dealed_1[gamerun_guankan_selected][1] == "空" then
							skills_qiaobian_chupai_set({qiaobian_up, qiaobian_down, gamerun_guankan_selected})
						end
					else
						local cardname, same_card = "",false
						if card_dealed_2[gamerun_guankan_selected][1] == "闪电" or card_dealed_2[gamerun_guankan_selected][1] == "乐不思蜀" or card_dealed_2[gamerun_guankan_selected][1] == "兵粮寸断" then
							cardname = card_dealed_2[gamerun_guankan_selected][1]
						else
							cardname = card_dealed_2[gamerun_guankan_selected][4]
						end
						for i = 5, #card_dealed_1 do
							if cardname == card_dealed_1[i][1] or cardname == card_dealed_1[i][4] then
								same_card = true
							end
						end
						if same_card == false and (cardname ~= "乐不思蜀" or char_juese[qiaobian_up].skill["谦逊"] ~= "available") and (ai_judge_cardinfo(qiaobian_down,{card_dealed_2[gamerun_guankan_selected]}) ~= "黑色" or char_juese[qiaobian_up].skill["帷幕"] ~= "available")  then
							skills_qiaobian_chupai_set({qiaobian_up, qiaobian_down, gamerun_guankan_selected})
						end
					end
				end
			end
		elseif #char_juese[char_current_i].skillname > 4 and skill_disrow > 0 then
			skill_disrow = skill_disrow - 1
		end
	end
	if key == "down" then
		if string.find(gamerun_status, "选项选择") then
		    if gamerun_guankan_selected < 3 and gamerun_guankan_selected + item_disrow < #choose_option then
				gamerun_guankan_selected = gamerun_guankan_selected + 1
			else
				if item_disrow < #choose_option - 3 then
					item_disrow = item_disrow + 1
				end
			end
		elseif string.find(gamerun_status, "牌堆操作") and card_paidui_dealed == 1 and (gamerun_guankan_selected == card_dealed_selected or #card_dealed_2 > 0) then
			if choose_name == "观星" or choose_name == "涉猎" or choose_name == "攻心" then
				if gamerun_guankan_selected == card_dealed_selected then
					table.insert(card_dealed_2,1,card_dealed_1[card_dealed_selected])
					table.remove(card_dealed_1,card_dealed_selected)
					card_dealed_selected = 1
				end
				gamerun_guankan_selected = 1
				card_paidui_dealed = 2
			elseif choose_name == "巧变" then
				if gamerun_guankan_selected ~= card_dealed_selected then
					gamerun_guankan_selected = 1
					card_paidui_dealed = 2
				elseif gamerun_guankan_selected == card_dealed_selected then
					if gamerun_guankan_selected <= 4 then
						if card_dealed_2[gamerun_guankan_selected][1] == "空" then
							skills_qiaobian_chupai_set({qiaobian_up, qiaobian_down, gamerun_guankan_selected})
						end
					else
						local cardname, same_card = "",false
						if card_dealed_1[gamerun_guankan_selected][1] == "闪电" or card_dealed_1[gamerun_guankan_selected][1] == "乐不思蜀" or card_dealed_1[gamerun_guankan_selected][1] == "兵粮寸断" then
							cardname = card_dealed_1[gamerun_guankan_selected][1]
						else
							cardname = card_dealed_1[gamerun_guankan_selected][4]
						end
						for i = 5, #card_dealed_2 do
							if cardname == card_dealed_2[i][1] or cardname == card_dealed_2[i][4] then
								same_card = true
							end
						end
						if same_card == false and (cardname ~= "乐不思蜀" or char_juese[qiaobian_down].skill["谦逊"] ~= "available") and (ai_judge_cardinfo(qiaobian_up,{card_dealed_1[gamerun_guankan_selected]}) ~= "黑色" or char_juese[qiaobian_down].skill["帷幕"] ~= "available") then
							skills_qiaobian_chupai_set({qiaobian_down, qiaobian_up, gamerun_guankan_selected})
						end
					end
				end
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

    if card_highlighted <= 0 then
		return
	end

	if gamerun_status == "手牌生效中" or gamerun_status == "AI出牌" then
		return
	end
	
	if gamerun_huihe == "" or gamerun_huihe == "游戏结束" or (gamerun_huihe == "结束" and imp_card ~= "放权") then
		return
	end

    if string.find(gamerun_status, "确认操作") or string.find(gamerun_status, "选项选择") or string.find(gamerun_status, "观看手牌") or string.find(gamerun_status, "牌堆选择") then
		return
	end
	
	if string.find(gamerun_status, "牌堆操作") then
		if choose_name == "观星" or choose_name == "涉猎" or choose_name == "攻心" then
			if gamerun_guankan_selected ~= card_dealed_selected then
				card_dealed_selected = gamerun_guankan_selected
			else
				card_dealed_selected = 0
			end
			platform.window:invalidate()
			return
		elseif choose_name == "巧变" then
			if gamerun_guankan_selected ~= card_dealed_selected then
				if card_paidui_dealed == 1 then
					if card_dealed_1[gamerun_guankan_selected][1] ~= "空" then
						card_dealed_selected = gamerun_guankan_selected
					end
				else
					if card_dealed_2[gamerun_guankan_selected][1] ~= "空" then
						card_dealed_selected = gamerun_guankan_selected
					end
				end
			else
				card_dealed_selected = 0
			end
			platform.window:invalidate()
			return
		end
	end
	
	if #char_juese[char_current_i].shoupai == 0 then
		return
	end
	
    if card_selected[card_highlighted] ~= nil then
	    --  取消选择  --
		card_selected[card_highlighted] = nil
		platform.window:invalidate()
		
		if last_status == "技能选择-多牌" then
			if gamerun_status == "技能选择-目标" then
				set_hints(skill_text_1)
				gamerun_status = last_status
				gamerun_target_selected = 0
				platform.window:invalidate()
				return
			end
			
			if gamerun_status == "技能选择-多牌" then
				if gamerun_tab_ptr ~= nil then
					gamerun_tab_ptr()
				end
				platform.window:invalidate()
				return
			end
		end
		
		if table.getn2(card_selected) == 0 then
		    if gamerun_huihe == "出牌" and (string.find(gamerun_status, "选择目标") or gamerun_status == "") then
			    set_hints("请您出牌")
			    gamerun_status = ""
			    gamerun_target_selected = 0
				platform.window:invalidate()
				return
			end
			
			if gamerun_status == "技能选择-目标" or gamerun_status == "技能选择-目标B" then
				if last_status ~= "技能选择-目标" and last_OK ~= false then
					set_hints(skill_text_1)
					gamerun_status = last_status
					gamerun_target_selected = 0
					platform.window:invalidate()
				end
				return
			end
			
			if gamerun_status == "技能选择-单牌" or gamerun_status == "技能选择-多牌" then
				if gamerun_tab_ptr ~= nil then
					gamerun_tab_ptr()
				end
				platform.window:invalidate()
				return
			end
		end
	else
		--  弃牌阶段  --
	    --  选择的牌超过需弃牌数，则不能继续选择  --
		if gamerun_huihe == "弃牌" then
			if table.getn2(card_selected) < #char_juese[char_current_i].shoupai - char_juese[char_current_i].tili then
		    	card_selected[card_highlighted] = 0
				platform.window:invalidate()
			end
			return
		end

		--  技能选择  --
		if gamerun_status == "技能选择-单牌" or gamerun_status == "技能选择-多牌" then
			card_selected[card_highlighted] = 0
			if gamerun_tab_ptr ~= nil then
				gamerun_tab_ptr()
			end
			platform.window:invalidate()
			return
		end

		--  其他情况  --
		card = char_juese[char_current_i].shoupai[card_highlighted][1]
		local fangtian = false

		--  判断是否符合方天画戟发动条件  --
		if gamerun_judge_fangtian() == true then
			fangtian = true
		end

		--  判断是否通过技能增加了出杀目标  --
		if char_sha_add_target_able == true and (card == "杀" or card == "火杀" or card == "雷杀") then
			fangtian = true
		end

		if gamerun_huihe == "出牌" and gamerun_status == "" then
			if fangtian == false then
				set_hints(card_tishi[card])
			else
				set_hints("请选择目标A")
			end

			--  选取的是锦囊 (闪电、无懈可击、南蛮入侵、万箭齐发、桃园结义、无中生有、五谷丰登除外)、杀  --
			--  借刀杀人、铁索连环选取目标A  --
			if card_get_leixing(card) == "延时类锦囊" and card ~= "闪电" or card == "顺手牵羊" or card == "过河拆桥" or card == "决斗" or card == "火攻" or card == "杀" or card == "火杀" or card == "雷杀" or card == "借刀杀人" or card == "铁索连环" then
				gamerun_status = "选择目标"
				gamerun_select_target("init")    -- 初始化选择目标状态
			end
		end
		
		--  选择牌  --
		if string.find(gamerun_status, "贯石") then
			if table.getn2(card_selected) < 2 then
				card_selected[card_highlighted] = 0
			end
		else
			card_selected[card_highlighted] = 0
		end
	end
	platform.window:invalidate()
end

--  选择技能、装备牌  --
function on.charIn(char)
	local skills
	if char_juese[char_current_i].name == "" then return end
	if gamerun_status == "AI出牌" then return end
	
	skills = char_juese[char_current_i].skillname
	
	if gamerun_huihe == "出牌" then
		--  选取主公技  --
		if char == '0' then
			if gamerun_status == "" and gamerun_lordskill_selected == false then
				skills_lordskill_select_enter()
			elseif gamerun_lordskill_selected == true then
				gamerun_lordskill_selected = false
				skills_rst()
			end
		end

		--  选取1~4号技能  --
		if char == '1' then
			if gamerun_skill_selected == 1 + 2 * skill_disrow then
				gamerun_skill_selected = 0
				skills_rst()
			elseif gamerun_status == "" then
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
			elseif gamerun_status == "" then
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
			elseif gamerun_status == "" then
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
			elseif gamerun_status == "" then
				if skills[4 + 2 * skill_disrow] ~= nil and char_juese[char_current_i].skill[skills[4 + 2 * skill_disrow]]~="locked" then
					if skills_func[skills[4 + 2 * skill_disrow]] ~= nil then
						if skills_func[skills[4 + 2 * skill_disrow]]() then
							gamerun_skill_selected = 4 + 2 * skill_disrow
						end
					end
				end
			end
		end
	end
	
	--  选取武器牌  --
	if char == 'a' then
		if gamerun_huihe == "出牌" then
			--  丈八蛇矛技能发动  --
			if gamerun_status == "" and gamerun_armskill_selected == false then
				if card_zhangba_enter() then
					gamerun_armskill_selected = true
				end
				return
			elseif gamerun_armskill_selected == true then
				gamerun_armskill_selected = false
				skills_rst()
				return
			end
		end

		gamerun_card_select_zhuangbei(-1)
	end
	
	--  选取防具牌  --
	if char == 'b' then
		gamerun_card_select_zhuangbei(-2)
	end
	
	--  选取-1马牌  --
	if char == 'c' then
		gamerun_card_select_zhuangbei(-3)
	end
	
	--  选取+1马牌  --
	if char == 'd' then
		gamerun_card_select_zhuangbei(-4)
	end

	platform.window:invalidate()
end

function skills_rst()
	last_OK = false
	imp_card = ""
	skill_text_1 = ""
	skill_text_2 = ""
	gamerun_wuqi_out_hand(char_acting_i)

	if char_acting_i == char_current_i then
		card_selected = {}
		card_highlighted = 1
		set_hints("请您出牌")
		gamerun_status = ""
	else
		set_hints("")
		gamerun_status = "AI出牌"

		ai_card_use(char_acting_i)
	end
end

--  点击客户区时，移除富文本框的焦点  --
function on.mouseDown(x, y)
    txt_messages:setFocus(false)
end