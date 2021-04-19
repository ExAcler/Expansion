--  张春华：伤逝  --
function skills_shangshi(ID, not_in_queue)
	if #char_juese[ID].shoupai >= char_juese[ID].tili_max - char_juese[ID].tili then
		skills_skip_subqueue()
		return
	end

	if ID == char_current_i then
		push_zhudong_queue(table.copy(funcptr_queue), funcptr_i)
		timer.stop()
		funcptr_queue = {}
		funcptr_i = 0
		skills_shangshi_enter(ID, not_in_queue)
	else
		skills_shangshi_set(ID, ai_judge_shangshi(ID))
		if not_in_queue then
			_lianying_shangshi_status_restore()
			if char_juese[ID].skill["连营"] == "available" and #char_juese[ID].shoupai == 0 then
				skills_lianying(ID, true)
			end
		end
	end
end
function skills_shangshi_enter(ID, not_in_queue)
	local old_gamerun_status = gamerun_status

	gamerun_status = "确认操作"
	jiaohu_text = "是否发动 '伤逝'?"
	gamerun_OK = false
	gamerun_OK_ptr = function()
		funcptr_queue = {}
		skills_shangshi_set(char_current_i,gamerun_OK)
		
		gamerun_status = old_gamerun_status
		set_hints("")
		funcptr_queue, funcptr_i = pop_zhudong_queue()
		--funcptr_i = funcptr_i + 1

		if not_in_queue then
			_lianying_shangshi_status_restore()
			if char_juese[ID].skill["连营"] == "available" and #char_juese[ID].shoupai == 0 then
				skills_lianying(ID, true)
			end
		else
			timer.start(0.2)
		end
	end
	
	platform.window:invalidate()
end
function skills_shangshi_set(ID,gamerun_OK)
	if gamerun_OK then
		push_message(char_juese[ID].name .. "发动了武将技能 '伤逝'")
		card_fenfa({ID, char_juese[ID].tili_max-char_juese[ID].tili-#char_juese[ID].shoupai, true})
	end
	jiaohu_text = ""
end

--  荀彧：驱虎  --
function skills_quhu_ai(ID_s, ID_mubiao, ID_to_shanghai)	--  AI发动驱虎
	if #char_juese[ID_s].shoupai == 0 or #char_juese[ID_mubiao].shoupai == 0 then
		return false
	end

	--  ID_mubiao: 要拼点的目标; ID_to_shanghai: 拼点胜利后，要对方伤害的目标  --
	local win = function(s_win, mubiao_win)
		funcptr_queue = {}
		funcptr_i = 0
		
		if ID_s == char_current_i or ID_mubiao == char_current_i then
			skills_cs()
		end
		char_juese[ID_s].skill["驱虎"] = "locked"

		if s_win then
			if #ai_judge_in_range(ID_mubiao) > 0 then
				char_tili_deduct({1, ID_to_shanghai, ID_mubiao, "普通", ID_to_shanghai})
			end
		else
			char_tili_deduct({1, ID_s, ID_mubiao, "普通", ID_s})
		end

		add_funcptr(_pindian_huifu)
		timer.start(0.6)
	end

	add_funcptr(push_message, char_juese[ID_s].name .. "发动了武将技能 '驱虎'")
	add_funcptr(push_message, table.concat({char_juese[ID_s].name, "与", char_juese[ID_mubiao].name, "进行拼点"}))
	add_funcptr(card_pindian, {ID_s, ID_mubiao, win, false})
	add_funcptr(_quhu_sub2)
	timer.start(0.6)

	return true
end
function skills_quhu_enter()	--  己方发动驱虎
	if #char_juese[char_current_i].shoupai == 0 then return false end
	timer.stop()
	funcptr_queue = {}
	skills_enter("请选择目标", "", "驱虎", "技能选择-目标")
	gamerun_select_target("init")
	gamerun_OK_ptr = function()
		if #char_juese[gamerun_target_selected].shoupai == 0 then return false end

		gamerun_status = "手牌生效中"
		set_hints("")
		skills_cs()

		local win_fp = function(s_win, mubiao_win)
			if s_win then
				char_juese[char_current_i].skill["驱虎"] = "locked"
				if #ai_judge_in_range(gamerun_target_selected) > 0 then
					guankan_s = gamerun_target_selected
					_quhu_sub1()
				else
					skills_cs()
				end
			else
				timer.stop()
				funcptr_queue = {}
				funcptr_i = 0

				skills_cs()
				char_juese[char_current_i].skill["驱虎"] = "locked"

				char_tili_deduct({1, char_current_i, gamerun_target_selected, "普通", char_current_i, nil, true})
				add_funcptr(_pindian_huifu)
				timer.start(0.6)
			end
		end

		add_funcptr(push_message, char_juese[char_current_i].name .. "发动了武将技能 '驱虎'")
		add_funcptr(push_message, table.concat({char_juese[char_current_i].name, "与", char_juese[gamerun_target_selected].name, "进行拼点"}))
		add_funcptr(card_pindian, {char_current_i, gamerun_target_selected, win_fp, false})
		add_funcptr(_quhu_sub2)
		timer.start(0.6)
	end
	return true
end
function _quhu_sub1()
	timer.stop()
	funcptr_queue = {}
	funcptr_i = 0

	skills_enter("请选择伤害的目标", "", "驱虎2", "技能选择-目标B")
	gamerun_select_target("init")
	
	gamerun_OK_ptr = function()
		if card_if_d_limit("驱虎2", guankan_s, gamerun_target_selected, nil) then
			set_hints("")
			gamerun_status = "手牌生效中"

			skills_cs()
			char_tili_deduct({1, gamerun_target_selected, guankan_s, "普通", gamerun_target_selected})
			add_funcptr(_pindian_huifu)
			timer.start(0.6)
		end
	end
end
function _quhu_sub2()
	gamerun_OK = false

	if char_acting_i == char_current_i then
		gamerun_status = ""
		jiaohu_text = "请您出牌"
	else
		gamerun_status = "AI出牌"
		jiaohu_text = ""

		ai_card_use(char_acting_i)
	end

	platform.window:invalidate()
end

--  曹丕：行殇  --
function skills_xingshang(va_list)
	local ID_s, ID_siwang
	ID_s = va_list[1]; ID_siwang = va_list[2]

	skills_push_queue()

	if ID_s == char_current_i then
		skills_xingshang_enter(ID_siwang)
	else
		_xingshang_exe(ID_s, ID_siwang)
	end
end
function skills_xingshang_enter(ID_siwang)
	local old_gamerun_status = gamerun_status
	gamerun_status = "确认操作"
	jiaohu_text = "是否发动 '行殇'?"
	gamerun_OK = false
	
	gamerun_OK_ptr = function()
		funcptr_queue = {}

		if gamerun_OK then
			_xingshang_exe(char_current_i, ID_siwang)
	    else
			gamerun_status = old_gamerun_status
			set_hints("")

			skills_pop_queue(true)
			timer.start(0.6)
		end
		platform.window:invalidate()
	end
	
	platform.window:invalidate()
end
function _xingshang_exe(ID_s, ID_siwang)
	gamerun_status = "手牌生效中"
	set_hints("")

	push_message(char_juese[ID_s].name .. "发动了武将技能 '行殇'")
	add_funcptr(_xingshang_card_transfer, {ID_s, ID_siwang})
	add_funcptr(skills_pop_queue)
	timer.start(0.6)
end
function _xingshang_card_transfer(va_list)    --  行殇：将死亡玩家所有卡牌转移至曹丕
	local ID_s, ID_siwang
	ID_s = va_list[1]; ID_siwang = va_list[2]

	local i, max_select
	
	max_select = #char_juese[ID_siwang].shoupai
	
	if max_select > 0 then
		for i = 1, max_select do
			if char_juese[ID_siwang].shoupai[i] ~= nil then
				card_insert(ID_s, char_juese[ID_siwang].shoupai[i])
			end
		end
	end
	char_juese[ID_siwang].shoupai = {}
	
	if #char_juese[ID_siwang].wuqi ~= 0 then
		card_insert(ID_s, char_juese[ID_siwang].wuqi)
	end
	char_juese[ID_siwang].wuqi = {}
	
	if #char_juese[ID_siwang].fangju ~= 0 then
		card_insert(ID_s, char_juese[ID_siwang].fangju)
	end
	char_juese[ID_siwang].fangju = {}
	
	if #char_juese[ID_siwang].gongma ~= 0 then
		card_insert(ID_s, char_juese[ID_siwang].gongma)
	end
	char_juese[ID_siwang].gongma = {}
	
	if #char_juese[ID_siwang].fangma ~= 0 then
		card_insert(ID_s, char_juese[ID_siwang].fangma)
	end
	char_juese[ID_siwang].fangma = {}

	push_message(table.concat({char_juese[ID_s].name, "获得了", char_juese[ID_siwang].name, "的所有牌"}))
end

--  SP姜维：困奋  --
function skills_kunfen()
	push_zhudong_queue(table.copy(funcptr_queue), funcptr_i)
	timer.stop()
	funcptr_queue = {}
	funcptr_i = 0

	if char_acting_i == char_current_i then
		skills_kunfen_enter()
	else
		skills_kunfen_ai()
	end
end
function skills_kunfen_ai()
	add_funcptr(push_message, char_juese[char_acting_i].name .. "触发了武将技能 '困奋'")
	--if ai_judge_kunfen(char_acting_i) == false then
		--add_funcptr(_kunfen_reduce_max, char_acting_i)
	--else
		if kunfen_adjusted[char_acting_i] == false then
			char_tili_deduct({1, char_acting_i, -1, "流失", char_acting_i})
			add_funcptr(card_fenfa,{char_acting_i,2,true})
		end
	--end

	add_funcptr(_skills_kunfen_huifu)
	timer.start(0.6)
end
function skills_kunfen_enter()    --  进入困奋
	gamerun_huihe = "结束"
    gamerun_status = "确认操作"
	jiaohu_text = "是否发动 '困奋'?"
	
	gamerun_OK_ptr = function()    -- 如果确认发动，执行的函数
		if gamerun_OK == true then
			if char_juese[char_current_i].tili_max > 1 then
				set_hints("")
				if kunfen_adjusted[char_acting_i] == false then
					add_funcptr(push_message, char_juese[char_acting_i].name .. "触发了武将技能 '困奋'")
				else
					add_funcptr(push_message, char_juese[char_acting_i].name .. "发动了武将技能 '困奋'")
				end
				char_tili_deduct({1, char_current_i, -1, "流失", char_current_i})
				add_funcptr(card_fenfa,{char_acting_i,2,true})
				add_funcptr(_skills_kunfen_huifu)
				timer.start(0.6)
			end
		else
			set_hints("")
			add_funcptr(_skills_kunfen_huifu)
			timer.start(0.6)
		end
	end
	if kunfen_adjusted[char_acting_i] == false then
		on.enterKey()
	end
	
	platform.window:invalidate()
end
function _skills_kunfen_huifu()
	funcptr_queue, funcptr_i = pop_zhudong_queue()
end

--  曹仁：据守  --
function skills_jushou(ID)
	if ID == char_current_i then
		push_zhudong_queue(table.copy(funcptr_queue), funcptr_i)
		timer.stop()
		funcptr_queue = {}
		funcptr_i = 0
		skills_jushou_enter(ID)
	else
		skills_jushou_set(ID, ai_judge_jushou(ID))
	end
end
function skills_jushou_enter(ID)

	gamerun_status = "确认操作"
	jiaohu_text = "是否发动 '据守'?"
	gamerun_OK = false
	gamerun_OK_ptr = function()
		funcptr_queue = {}
		skills_jushou_set(char_current_i,gamerun_OK)
		
		gamerun_status = ""
		funcptr_queue, funcptr_i = pop_zhudong_queue()
		--funcptr_i = funcptr_i + 1
		timer.start(0.2)
	end
	
	platform.window:invalidate()
end
function skills_jushou_set(ID,gamerun_OK)
	if gamerun_OK then
		push_message(char_juese[ID].name .. "发动了武将技能 '据守'")
		card_fenfa({ID, 3, true})
		char_fanmian(ID)
	end
	jiaohu_text = ""
end

--  司马懿：反馈  --
function skills_fankui(va_list)
	local ID, laiyuan
	ID = va_list[1]
	laiyuan = va_list[2]

	if ai_card_stat(laiyuan, true, false) == 0 then
		return
	end

	push_zhudong_queue(table.copy(funcptr_queue), funcptr_i)
	timer.stop()
	funcptr_queue = {}
	funcptr_i = 0

	if ID == char_current_i then
		fankui_gamerun_status = gamerun_status
		skills_fankui_enter(laiyuan)
	else
		skills_fankui_ai(ID,laiyuan)
	end
end
function skills_fankui_enter(laiyuan)
	local old_gamerun_status = gamerun_status
	gamerun_status = "确认操作"
	jiaohu_text = "是否发动 '反馈'?"
	gamerun_OK = false
	
	gamerun_OK_ptr = function()
		gamerun_status = old_gamerun_status; set_hints("")
		funcptr_queue = {}
	
		if gamerun_OK then
			push_message(char_juese[char_current_i].name .. "发动了武将技能 '反馈'")
			_fankui_exe({char_current_i, laiyuan})
	    else
			_fankui_huifu()
			--funcptr_i = funcptr_i + 1
			timer.start(0.6)
		end
		platform.window:invalidate()
	end
	platform.window:invalidate()
end
function skills_fankui_ai(ID,ID_mubiao)
	local fanmian_mubiao = ai_judge_fankui_mubiao(ID,ID_mubiao)
	
	if fanmian_mubiao ~= nil then
		push_message(char_juese[ID].name .. "发动了武将技能 '反馈'")
		add_funcptr(_fankui_exe, {ID, fanmian_mubiao})
		skills_losecard(fanmian_mubiao)
	end
	add_funcptr(_fankui_huifu)
	timer.start(0.6)
end
function _fankui_exe(va_list)
	local ID_s, ID_mubiao
	ID_s = va_list[1]; ID_mubiao = va_list[2]

	if ID_s == char_current_i then
		_fankui_exe_2({ID_s, ID_mubiao})
	else
		_shun_ai({ID_s, ID_mubiao, true})
	end
end
function _fankui_exe_2(va_list)    --  反馈效果初始化
    local i
	local ID_s, ID_d
	ID_s = va_list[1]; ID_d = va_list[2]
	fankui_gamerun_status = gamerun_status
	gamerun_status = "观看手牌-反馈"
	gamerun_guankan_type = {}
	
	--  往观看牌堆添加牌  --
	if #char_juese[ID_d].shoupai > 0 then
	    table.insert(gamerun_guankan_type, {"手牌", 0})
	end
	if #char_juese[ID_d].fangma > 0 then
	    table.insert(gamerun_guankan_type, {"防御马", 0})
	end
	if #char_juese[ID_d].gongma > 0 then
	    table.insert(gamerun_guankan_type, {"攻击马", 0})
	end
	if #char_juese[ID_d].wuqi > 0 then
	    table.insert(gamerun_guankan_type, {"武器", 0})
	end
	if #char_juese[ID_d].fangju > 0 then
	    table.insert(gamerun_guankan_type, {"防具", 0})
	end
	
	--  设置状态信息  --
	gamerun_guankan_selected = 1
	guankan_s = ID_s
	guankan_d = ID_d
	
	txt_messages:setVisible(false)
	platform.window:invalidate()
end
function _fankui_status_restore()
	gamerun_status = fankui_gamerun_status
	set_hints("")
	_fankui_huifu()
end
function _fankui_huifu()
	funcptr_queue, funcptr_i = pop_zhudong_queue()
end

--  夏侯惇：刚烈  --
function skills_ganglie(va_list)
	local ID, laiyuan
	ID = va_list[1]
	laiyuan = va_list[2]

	if ID == char_current_i then
		skills_ganglie_enter(laiyuan)
	else
		skills_ganglie_ai(ID,laiyuan)
	end
end

function skills_ganglie_enter(laiyuan)
	push_zhudong_queue(table.copy(funcptr_queue), funcptr_i)
	timer.stop()
	funcptr_queue = {}
	funcptr_i = 0

	local old_gamerun_status = gamerun_status
	gamerun_status = "确认操作"
	jiaohu_text = "是否发动 '刚烈'?"
	gamerun_OK = false
	
	gamerun_OK_ptr = function()
		funcptr_queue = {}
	
		if gamerun_OK then
			gamerun_status = old_gamerun_status; set_hints("")
			funcptr_queue = {}
			funcptr_i = 0

			_ganglie_exe({char_current_i, laiyuan})
	    else
			set_hints("")
			gamerun_status = old_gamerun_status
			
			_ganglie_huifu()
			--funcptr_i = funcptr_i + 1
			timer.start(0.6)
		end
		platform.window:invalidate()
	end
	platform.window:invalidate()
end
function skills_ganglie_ai(ID,ID_mubiao)
	local fanmian_mubiao = ai_judge_ganglie_mubiao(ID,ID_mubiao)
	
	if fanmian_mubiao == nil then
		return
	end
	
	push_zhudong_queue(table.copy(funcptr_queue), funcptr_i)
	timer.stop()
	funcptr_queue = {}
	funcptr_i = 0

	_ganglie_exe({ID, fanmian_mubiao})
	timer.start(0.6)
end
function _ganglie_exe(va_list)
	local ID_s, ID_mubiao
	ID_s = va_list[1]; ID_mubiao = va_list[2]
	ganglie_gamerun_status = gamerun_status

    push_message(table.concat({char_juese[ID_s].name .. "发动了武将技能 '刚烈'"}))
	add_funcptr(_ganglie_fan_panding, ID_s)

	--  如场上有司马懿或张角，询问其改判技能  --
	skills_guicai_guidao_ask(ID_s, ID_mubiao, ID_s, "刚烈")

	add_funcptr(_ganglie_jiesuan, {ID_s, ID_mubiao})
	timer.start(0.6)
end
function skills_enter_ganglie(ID_s)
	push_zhudong_queue(table.copy(funcptr_queue), funcptr_i)
	timer.stop()
	funcptr_queue = {}
	funcptr_i = 0

	push_message(char_juese[ID_s].name .. "的 '刚烈' 判定成功")
	gamerun_status = "主动出牌-刚烈"
	set_hints("'确定': 弃两张牌 '取消': 失去1体力")
end
function _ganglie_fan_panding(ID_s)		--  刚烈：翻开判定牌
	--  翻开判定牌  --
	if #card_yixi == 0 then
	    card_xipai(true)
	end
    card_panding_card = card_yixi[1]
	table.remove(card_yixi, 1)
	push_message(table.concat({char_juese[ID_s].name .. "的判定牌是'", card_panding_card[2], card_panding_card[3], "的", card_panding_card[1], "'"}))
end
function _ganglie_jiesuan(va_list)		--  刚烈：结算判定牌
	local ID_s, ID_mubiao
	ID_s = va_list[1]; ID_mubiao = va_list[2]

	timer.stop()
	funcptr_queue = {}
	funcptr_i = 0

	local yanse, huase, dianshu = ai_judge_cardinfo(ID_s, {card_panding_card})
	
	--  曹丕颂威  --
	skills_judge_songwei(ID_s)

	if huase ~= "红桃" then
		if ID_mubiao == char_current_i then
			skills_card_qi_panding(ID_s)

			add_funcptr(skills_enter_ganglie, ID_s)
			guankan_s = ID_s
			guankan_d = ID_mubiao
		else
			_ganglie_exe_ai(ID_s, ID_mubiao)
		end
	else
		push_message(char_juese[ID_s].name .. "的 '刚烈' 判定失败")
		skills_card_qi_panding(ID_s)
	end
	
	add_funcptr(_ganglie_huifu)
	timer.start(0.6)
end
function _ganglie_huifu()	--  刚烈：恢复己方中断前函数队列
	funcptr_queue, funcptr_i = pop_zhudong_queue()
end
function _ganglie_exe_ai(ID_s, ID_mubiao)	--  刚烈：AI做出决定
	timer.stop()
	funcptr_queue = {}
	funcptr_i = 0

	push_message(char_juese[ID_s].name .. "的 '刚烈' 判定成功")
	gamerun_status = ganglie_gamerun_status

	skills_card_qi_panding(ID_s)

	if #char_juese[ID_mubiao].shoupai < 2 then
		char_tili_deduct({1, ID_mubiao, ID_s, "普通", ID_mubiao})
	else
		local qipai_id, _ = ai_judge_withdraw(ID_mubiao, 2, false)
		ai_withdraw(ID_mubiao, qipai_id, {}, true)
	end
end
function _ganglie_exe_1()    --  刚烈：弃置两张牌
	gamerun_status = "手牌生效中"
	set_hints("")
	card_highlighted = 1
	
	card_qipai_go()
	skills_losecard(char_current_i)

	gamerun_status = ganglie_gamerun_status
	add_funcptr(_ganglie_huifu)
end
function _ganglie_exe_2()    --  刚烈：失去1点体力
	gamerun_status = "手牌生效中"
	set_hints("")
	card_selected = {}; card_highlighted = 1
	gamerun_status = ganglie_gamerun_status
	char_tili_deduct({1, guankan_d, guankan_s, "普通", guankan_d})
	add_funcptr(_ganglie_huifu)
end
function _ganglie_sub()
	funcptr_queue = {}
	card_selected = {}
	card_highlighted = 1
	set_hints("请您出牌")
	gamerun_status = ""
	guankan_s = 0
	guankan_d = 0
end

--  徐晃：断粮  --
function skills_duanliang_enter()
	if #char_juese[char_current_i].shoupai == 0 and ai_arm_stat(char_current_i) == 0 then return false end

	gamerun_wuqi_into_hand(char_current_i)
	skills_enter("请选择黑色基本或装备牌", "使用兵粮寸断", "兵粮寸断", "技能选择-单牌")
	
	gamerun_OK_ptr = function()
		skills_duanliang()
	end
	
	gamerun_tab_ptr = function()
		if skills_judge_duanliang() then
			skills_enter_target()
		end
	end
	
	return true
end
function skills_judge_duanliang()    --  判断断粮条件是否满足
	if table.getn2(card_selected) ~= 0 then
		local card = char_juese[char_current_i].shoupai[card_highlighted]
		if card[2] == "黑桃" or card[2] == "草花" then
			if card_get_leixing(card[1]) == "基本牌" or card_get_leixing(card[1]) == "武器" or card_get_leixing(card[1]) == "防具" or card_get_leixing(card[1]) == "+1马" or card_get_leixing(card[1]) == "-1马" then
				return true
			end
		end
	end
	return false
end
function skills_duanliang()
	if skills_judge_duanliang() then
		funcptr_queue = {}
		if card_bingliang({card_highlighted, char_current_i, gamerun_target_selected}) then
			gamerun_wuqi_out_hand(char_current_i)
			skills_cs()
			skills_rst()
		end
	end
end

--  郭嘉：天妒  --
function skills_tiandu(va_list)
	local ID, card_panding
	ID = va_list[1]; card_panding = va_list[2]
	if ID == char_current_i then
		push_zhudong_queue(table.copy(funcptr_queue), funcptr_i)
		timer.stop()
		funcptr_queue = {}
		funcptr_i = 0
		skills_tiandu_enter(ID,card_panding)
	else
		skills_tiandu_set(ID, ai_judge_tiandu(ID), card_panding)
	end
end
function skills_tiandu_enter(ID,card_panding)
	gamerun_status = "确认操作"
	jiaohu_text = "是否发动 '天妒'?"
	gamerun_OK = false
	gamerun_OK_ptr = function()
		funcptr_queue = {}
		skills_tiandu_set(char_current_i,gamerun_OK,card_panding)
		
		gamerun_status = ""
		set_hints("")
		funcptr_queue, funcptr_i = pop_zhudong_queue()
		--funcptr_i = funcptr_i + 1
		timer.start(0.2)
	end
	
	platform.window:invalidate()
end
function skills_tiandu_set(ID,gamerun_OK,card_panding)
	if gamerun_OK then
		push_message(char_juese[ID].name .. "发动了武将技能 '天妒'")
		card_insert(ID, card_panding)
		push_message(table.concat({char_juese[ID].name, "获得了'", card_panding[2], card_panding[3], "的", card_panding[1], "'"}))
	else
		card_add_qipai(card_panding)
	end
end

--  典韦：强袭  --
function skills_qiangxi_enter()
	if #char_juese[char_current_i].shoupai == 0 and ai_arm_stat(char_current_i) == 0 then return false end
	
	gamerun_status = "选项选择"
	choose_name = "强袭"
	jiaohu_text = "需要弃装备牌还是失去体力?"
	choose_option = {"弃1张装备牌", "失去1点体力", "取消"}
	
	txt_messages:setVisible(false)
	gamerun_guankan_selected = 1
	item_disrow = 0

	gamerun_item = function(i)
		txt_messages:setVisible(true)

		if i == 1 then
			skills_qiangxi_select("装备")
		elseif i == 2 then
			skills_qiangxi_select("体力")
		else
			gamerun_skill_selected = 0
			skills_rst()
		end
	end
	
	return true
end
function skills_qiangxi_select(mode)
	if mode == "装备" then
		gamerun_wuqi_into_hand(char_current_i)
		skills_enter("请选择装备牌", "请选择目标", "强袭", "技能选择-单牌")
	else
		skills_enter("请选择目标", "", "强袭", "技能选择-目标")
		gamerun_select_target("init")
	end
	
	gamerun_OK_ptr = function()
		if gamerun_OK == true then
			if gamerun_status == "技能选择-目标" then
				local ID_shoupai = card_highlighted
				if mode == "体力" then
					ID_shoupai = 0
				end

				if skills_qiangxi(char_current_i, ID_shoupai, gamerun_target_selected) then
					skills_cs()
					consent_func_queue(0.6)
				end
			end
		end
	end
	
	if mode == "装备" then
		gamerun_tab_ptr = function()
			if skills_judge_zhijian_1(char_current_i, card_highlighted) then
				skills_enter_target()
			end
		end
	else
		gamerun_tab_ptr = nil
	end

	platform.window:invalidate()
end

function skills_qiangxi(ID_s, ID_shoupai, ID_mubiao)
	if #char_juese[ID_s].wuqi ~= 0 then
	    if char_calc_distance(ID_s, ID_mubiao) > card_wuqi_r[char_juese[ID_s].wuqi[1]] then
	        return false
	    end
	else
	    if char_calc_distance(ID_s, ID_mubiao) > 1 then
	        return false
	    end
	end

	if ID_shoupai ~= 0 then
		if skills_judge_zhijian_1(ID_s, ID_shoupai) == false then return false end
	end
	
	funcptr_queue = {}
	gamerun_status = "手牌生效中"
	set_hints("")
	
	add_funcptr(push_message, char_juese[ID_s].name.."发动了武将技能 '强袭'")
	add_funcptr(_qiangxi_sub1, {ID_s, ID_shoupai})
	skills_losecard(ID_s)

	if ID_shoupai == 0 then
		char_tili_deduct({1, ID_s, -1, "流失", ID_s})
	end
	char_tili_deduct({1, ID_mubiao, ID_s, "普通", ID_mubiao})
	add_funcptr(_fanjian_sub4)
	
	return true
end
function _qiangxi_sub1(va_list)
	local ID, ID_shoupai
	ID = va_list[1]; ID_shoupai = va_list[2]

	char_juese[ID].skill["强袭"] = "locked"
	card_selected = {}
	card_highlighted = 1

	if ID_shoupai ~= 0 then
		local card = char_juese[ID].shoupai[ID_shoupai]
		card_shanchu({ID, ID_shoupai})
		gamerun_wuqi_out_hand(ID)
	else
		gamerun_wuqi_out_hand(ID)
		skills_skip_subqueue()
	end
end

--  许褚：裸衣  --
function skills_luoyi(ID)
	if ID == char_current_i then
		push_zhudong_queue(table.copy(funcptr_queue), funcptr_i)
		timer.stop()
		funcptr_queue = {}
		funcptr_i = 0
		skills_luoyi_enter(ID)
	else
		skills_luoyi_set(ID, ai_judge_luoyi(ID))
	end
end
function skills_luoyi_enter(ID)
	gamerun_status = "选项选择"
	choose_name = "裸衣"
	jiaohu_text = "是否发动 '裸衣'?"
	choose_option = {"是","否"}
	txt_messages:setVisible(false)
	gamerun_guankan_selected = 1
	item_disrow = 0
	gamerun_item = function(i)
		txt_messages:setVisible(true)
		skills_luoyi_set(char_current_i, i)
		
		gamerun_status = ""
		funcptr_queue, funcptr_i = pop_zhudong_queue()
		--funcptr_i = funcptr_i + 1
		timer.start(0.2)
	end

	platform.window:invalidate()
end
function skills_luoyi_set(ID, option)
	if option == 1 then
		push_message(char_juese[ID].name .. "发动了武将技能 '裸衣'")
		char_luoyi = true
	else
		char_luoyi = false
	end
end

--  曹彰：将驰 --
function skills_jiangchi(ID)
	if game_skip_mopai == true then
		return
	end

	if ID == char_current_i then
		push_zhudong_queue(table.copy(funcptr_queue), funcptr_i)
		timer.stop()
		funcptr_queue = {}
		funcptr_i = 0
		skills_jiangchi_enter(ID)
	else
		skills_jiangchi_set(ID, ai_judge_jiangchi(ID))
	end
end
function skills_jiangchi_enter(ID)
	gamerun_status = "选项选择"
	choose_name = "将驰"
	jiaohu_text = "是否发动 '将驰' 多摸或少摸牌?"
	choose_option = {"多摸一张","少摸一张","不发动"}
	txt_messages:setVisible(false)
	gamerun_guankan_selected = 1
	item_disrow = 0
	gamerun_item = function(i)
		funcptr_queue = {}
		txt_messages:setVisible(true)
		skills_jiangchi_set(char_current_i, i)
		
		gamerun_status = ""
		set_hints("")
		funcptr_queue, funcptr_i = pop_zhudong_queue()
		--funcptr_i = funcptr_i + 1
		timer.start(0.2)
	end
	
	platform.window:invalidate()
end
function skills_jiangchi_set(ID, option)
	if option == 1 then
		push_message(char_juese[ID].name .. "发动了武将技能 '将驰' 多摸了一张牌")
		char_jiangchi = 1
	elseif option == 2 then
		push_message(char_juese[ID].name .. "发动了武将技能 '将驰' 少摸了一张牌")
		char_jiangchi = -1
	else
		char_jiangchi = 0
	end
end

--  张辽：突袭  --
function skills_tuxi(ID)
	if game_skip_mopai == true then
		return
	end

	if ID == char_current_i then
		skills_tuxi_enter()
	else
		skills_tuxi_ai(ID)
	end
end
function skills_tuxi_ai(ID)
	local char_i = ai_judge_tuxi_mubiao(ID)

	if #char_i > 0 then
		_tuxi_exe_ai(ID, char_i)
	end
end
function _tuxi_exe_ai(ID, char_i)
	push_zhudong_queue(table.copy(funcptr_queue), funcptr_i)
	timer.stop()
	funcptr_queue = {}
	funcptr_i = 0

	gamerun_status = ""
	push_message(char_juese[ID].name .. "发动了武将技能 '突袭'")
	char_tuxi = true

	for i = 1, #char_i do
		add_funcptr(_tuxi_sub1, {ID, char_i[i]})
		skills_losecard(char_i[i])
	end
	
	add_funcptr(_tuxi_huifu, nil)
	timer.start(0.2)
end
function skills_tuxi_enter()
	push_zhudong_queue(table.copy(funcptr_queue), funcptr_i)
	timer.stop()
	funcptr_queue = {}
	funcptr_i = 0

    gamerun_status = "确认操作"
	gamerun_huihe = "摸牌"
	jiaohu_text = "是否发动 '突袭'?"
	gamerun_OK = false
	
	gamerun_OK_ptr = function()
		funcptr_queue = {}
		set_hints("")
	
		if gamerun_OK then
			_tuxi_target1()
	    else
			gamerun_status = ""
			_tuxi_huifu()
			--funcptr_i = funcptr_i + 1
			timer.start(0.2)
		end
		platform.window:invalidate()
	end
	
	platform.window:invalidate()
end
function _tuxi_target1()
	skills_enter("请选择目标A", "", "突袭", "技能选择-目标")
	gamerun_select_target("init")
	gamerun_OK = false

	gamerun_OK_ptr = function()
		if gamerun_OK then
			guankan_s = gamerun_target_selected
			_tuxi_target2()
		end
	end
end
function _tuxi_target2()
	skills_enter("'确定': 选择B '取消': 仅A", "", "突袭", "技能选择-目标B")
	gamerun_select_target("init")
	gamerun_OK = false

	gamerun_OK_ptr = function()
		if gamerun_OK then
			_tuxi_exe(true)
		else
			_tuxi_exe(false)
		end
	end
end
function _tuxi_exe(double)
	gamerun_status = ""
	push_message(char_juese[char_current_i].name.."发动了武将技能 '突袭'")
	char_tuxi = true
	
	add_funcptr(_tuxi_sub1, {char_current_i, gamerun_target_selected})
	skills_losecard(gamerun_target_selected)

	if double then
		add_funcptr(_tuxi_sub1, {char_current_i, guankan_s})
		skills_losecard(guankan_s)
	end
	
	add_funcptr(_tuxi_huifu, nil)
	timer.start(0.2)
end
function _tuxi_sub1(va_list)
	local ID_s, ID_mubiao
	local t, card
	ID_s = va_list[1]; ID_mubiao = va_list[2]
	
	push_message(table.concat({char_juese[ID_s].name.."获得", char_juese[ID_mubiao].name, "的一张手牌"}))
	
	t = math.random(#char_juese[ID_mubiao].shoupai)
	card = char_juese[ID_mubiao].shoupai[t]
	card_remove({ID_mubiao, t})
	card_insert(ID_s, card)
end
function _tuxi_huifu()
	funcptr_queue, funcptr_i = pop_zhudong_queue()
end

--  司马懿：鬼才 / 张角：鬼道  --
function skills_guicai_guidao_ask(id, ID_laiyuan, ID_mubiao, panding_leixing)		--  从当前角色开始，逆时针询问是否发动鬼才或鬼道
	local cur = id
	local i

	for i = 1, 5 do
		if skills_judge_guicai_guidao(cur) ~= "" and char_juese[cur].siwang == false then
			if cur == char_current_i then
				add_funcptr(skills_guicai_guidao_zhudong_enter)
			else
				add_funcptr(skills_guicai_guidao_ai, {cur, ID_laiyuan, ID_mubiao, panding_leixing})
			end
		end

		cur = cur + 1
		if cur > 5 then
			cur = 1
		end
	end
end
function skills_judge_guicai_guidao(id)		--  判断角色是否拥有鬼才或鬼道技能
	if char_juese[id].skill["鬼才"] == "available" then
		return "鬼才"
	elseif char_juese[id].skill["鬼道"] == "available" then
		return "鬼道"
	elseif char_juese[id].skill["极略"] == "available" and mark_ren[id] > 0 then
		return "鬼才"
	else
		return ""
	end
end
function skills_judge_guicai_guidao_use()	--  判断替换判定牌是否合法（张角只能使用黑色牌）
	if table.getn2(card_selected) ~= 1 then
		return false
	end

	local card = char_juese[char_current_i].shoupai[card_highlighted]
	if skills_judge_guicai_guidao(char_current_i) == "鬼道" then
		if card[2] == "草花" or card[2] == "黑桃" then
			return true
		else
			return false
		end
	else
		return true
	end
end
function skills_guicai_guidao_ai(va_list)	--  AI发动鬼才或鬼道
	local id, ID_laiyuan, ID_mubiao, panding_leixing
	id = va_list[1]; ID_laiyuan = va_list[2]; ID_mubiao = va_list[3]; panding_leixing = va_list[4]

	local card_id = ai_judge_change_panding(id, ID_laiyuan, ID_mubiao, panding_leixing)

	if card_id == nil then
		--push_message(char_juese[id].name .. "放弃改判")
		skills_skip_subqueue()
		return
	end

	push_zhudong_queue(table.copy(funcptr_queue), funcptr_i)
	funcptr_queue = {}
	funcptr_i = 0
	timer.stop()

	if skills_judge_guicai_guidao(id) == "鬼才" then
		push_message(char_juese[id].name .. "发动了武将技能 '鬼才'")
	elseif skills_judge_guicai_guidao(id) == "极略" then
		push_message(char_juese[id].name .. "发动了武将技能 '鬼才'")
		mark_ren[id] = mark_ren[id] - 1
	else
		push_message(char_juese[id].name .. "发动了武将技能 '鬼道'")
	end

	local card = char_juese[id].shoupai[card_id]
	
	card_remove({id, card_id})
	skills_losecard(id)

	add_funcptr(_guicai_guidao_exe, {id, card})
	add_funcptr(_guicai_guidao_huifu)
	timer.start(0.6)
end
function skills_guicai_guidao_zhudong_enter()	--  询问己方是否发动鬼才或鬼道
	id = char_current_i

	push_zhudong_queue(table.copy(funcptr_queue), funcptr_i)
	funcptr_queue = {}
	funcptr_i = 0
	timer.stop()

	local old_gamerun_status = gamerun_status
	gamerun_status = "确认操作"

	if skills_judge_guicai_guidao(id) == "鬼才" then
		jiaohu_text = "是否发动 '鬼才'?"
	else
		jiaohu_text = "是否发动 '鬼道'?"
	end
	gamerun_OK = false
	
	gamerun_OK_ptr = function()
		funcptr_queue = {}
	
		if gamerun_OK then
			skills_guicai_guidao_zhudong_choose(old_gamerun_status)
	    else
			set_hints("")
			gamerun_status = old_gamerun_status
			--push_message(char_juese[id].name .. "放弃改判")
			
			_guicai_guidao_huifu()
			timer.start(0.6)
		end
		platform.window:invalidate()
	end
	
	platform.window:invalidate()
end
function skills_guicai_guidao_zhudong_choose(old_gamerun_status)
	id = char_current_i

	gamerun_wuqi_into_hand(char_current_i)
	skills_enter("请选择手牌并按 '确定'", "", "鬼才", "技能选择-单牌")
	gamerun_OK = false

	gamerun_tab_ptr = nil
	gamerun_OK_ptr = function()
		if skills_judge_guicai_guidao_use() and gamerun_OK == true then
			local card = char_juese[id].shoupai[card_highlighted]
			
			set_hints("")
			gamerun_status = old_gamerun_status
			if skills_judge_guicai_guidao(id) == "鬼才" then
				push_message(char_juese[id].name .. "发动了武将技能 '鬼才'")
			else
				push_message(char_juese[id].name .. "发动了武将技能 '鬼道'")
			end

			card_remove({id, card_highlighted})
			skills_losecard(id)
			gamerun_wuqi_out_hand(char_current_i)

			card_selected = {}
			card_highlighted = 1
			imp_card = ""

			add_funcptr(_guicai_guidao_exe, {id, card})
			add_funcptr(_guicai_guidao_huifu)
			timer.start(0.6)
		elseif gamerun_OK == false then
			card_selected = {}
			card_highlighted = 1
			imp_card = ""

			set_hints("")
			gamerun_status = old_gamerun_status
			--push_message(char_juese[id].name .. "放弃改判")
			
			_guicai_guidao_huifu()
			timer.start(0.6)
		end
	end
end
function _guicai_guidao_exe(va_list)
	id = va_list[1]; card = va_list[2]

	if skills_judge_guicai_guidao(id) == "鬼道" then
		--  张角可将原有判定牌收入手牌  --
		card_insert(id, card_panding_card)
	else
		--  否则原有判定牌进入弃牌堆  --
		card_add_qipai(card_panding_card)
	end

	--  将判定牌替换为玩家选择的手牌  --
	card_panding_card = card
	msg = {char_juese[id].name, "将判定牌替换为'", card_panding_card[2], card_panding_card[3], "的", card_panding_card[1], "'"}
	push_message(table.concat(msg))
	msg = nil; --collectgarbage()
end
function _guicai_guidao_huifu()
	funcptr_queue, funcptr_i = pop_zhudong_queue()
end

--  SP姜维：逢亮  --
function skills_fengliang(id)
	if char_juese[id].siwang == true then
		return
	end
	if char_juese[id].tili > 0 then
		return
	end
	
	push_zhudong_queue(table.copy(funcptr_queue), funcptr_i)
	timer.stop()
	funcptr_queue = {}
	funcptr_i = 0

	if char_juese[id].skill["逢亮"] ~= "available" then
		--  不满足逢亮发动条件，执行原有濒死结算  --
		if id ~= char_current_i then
			add_funcptr(_binsi_ai, {id, id})
		else
			add_funcptr(_binsi_zhudong, id)
		end
		add_funcptr(_fengliang_huifu)
		timer.start(0.6)
		return
	end

	add_funcptr(_fengliang_lock, id)
	add_funcptr(_fengliang_sub, id)
	add_funcptr(_fengliang_huifu)

	timer.start(0.6)
end
function _fengliang_lock(id)
	msg = {char_juese[id].name, "触发了技能 '逢亮'"}
	push_message(table.concat(msg))
	char_juese[id].skill["逢亮"] = "locked_whole_game"
end
function _fengliang_sub(id) 
	push_message(char_juese[id].name .. "失去一点体力上限")
	char_juese[id].tili_max = char_juese[id].tili_max - 1
	char_juese[id].tili = math.min(char_juese[id].tili, char_juese[id].tili_max)
	char_juese[id].tili = math.min(2,char_juese[id].tili_max)
	if char_juese[id].skill["挑衅"] ~= nil then
		skill_double[id]["挑衅"] = true
	else
		char_juese[id].skill["挑衅"] = 1
	end
	kunfen_adjusted[id] = true
	table.insert(char_juese[id].skillname,"挑衅")
end
function _fengliang_huifu()
	funcptr_queue, funcptr_i = pop_zhudong_queue()
end

--  曹丕：放逐  --
function skills_fangzhu(va_list)
	local ID, laiyuan
	ID = va_list[1]
	laiyuan = va_list[2]

	push_zhudong_queue(table.copy(funcptr_queue), funcptr_i)
	timer.stop()
	funcptr_queue = {}
	funcptr_i = 0

	if ID == char_current_i then
		skills_fangzhu_enter()
	else
		skills_fangzhu_ai(ID,laiyuan)
	end
end

function skills_fangzhu_enter()
	local old_gamerun_status = gamerun_status
	gamerun_status = "确认操作"
	jiaohu_text = "是否发动 '放逐'?"
	gamerun_OK = false
	
	gamerun_OK_ptr = function()
		funcptr_queue = {}
	
		if gamerun_OK then
			skills_fangzhu_choose_mubiao(old_gamerun_status)
	    else
			set_hints("")
			gamerun_status = old_gamerun_status
			
			_fangzhu_huifu()
			--funcptr_i = funcptr_i + 1
			timer.start(0.6)
		end
		platform.window:invalidate()
	end
	
	platform.window:invalidate()
end
function skills_fangzhu_choose_mubiao(old_gamerun_status)
	funcptr_queue = {}
	id = char_current_i
	skills_enter("请选择翻面目标", "", "放逐", "技能选择-目标")
	gamerun_OK = false
	gamerun_target_selected = char_current_i + 1
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
		if gamerun_target_selected > 5 then
			gamerun_target_selected = 1
		end
	end
	guankan_s = char_current_i

	gamerun_OK_ptr = function()
		if gamerun_OK == true then
			set_hints("")
			gamerun_status = old_gamerun_status

			push_message(char_juese[id].name .. "发动了武将技能 '放逐'")

			_fangzhu_exe({id, gamerun_target_selected})
			add_funcptr(_fangzhu_huifu)
			timer.start(0.6)
		end
	end
end
function skills_fangzhu_ai(ID,ID_mubiao)
	local fanmian_mubiao = ai_judge_fangzhu_mubiao(ID,ID_mubiao)

	if fanmian_mubiao ~= nil then
		add_funcptr(push_message, char_juese[ID].name .. "发动了武将技能 '放逐'")
		_fangzhu_exe({ID, fanmian_mubiao})
	end
	add_funcptr(_fangzhu_huifu)
	timer.start(0.6)
end
function _fangzhu_exe(va_list)
	local ID_s, ID_mubiao
	ID_s = va_list[1]; ID_mubiao = va_list[2]

	local tili_max = char_juese[ID_s].tili_max
	local tili = char_juese[ID_s].tili
	if char_juese[ID_s].skill["放逐"] ~= "available" and char_juese[ID_s].skill["极略"] == "available" and mark_ren[ID_s] > 0 then
		mark_ren[ID_s] = mark_ren[ID_s] - 1
	end
	add_funcptr(char_fanmian, ID_mubiao)
	add_funcptr(push_message, table.concat({char_juese[ID_s].name, "令", char_juese[ID_mubiao].name, "摸", (tili_max - tili), "张牌"}))
	add_funcptr(card_fenfa, {ID_mubiao, math.max(tili_max - tili, 0), true})
end
function _fangzhu_huifu()
	funcptr_queue, funcptr_i = pop_zhudong_queue()
end

--  郭嘉：遗计  --
function skills_yiji_add(ID, tili_deducted)
	for i = 1, tili_deducted do
		add_funcptr(skills_yiji, {ID})
	end
end
function skills_yiji(va_list)
	local ID
	ID = va_list[1]

	skills_push_queue()
	if ID == char_current_i then
		skills_yiji_enter()
	else
		skills_yiji_ai(ID)
	end
end
function skills_yiji_enter()
	local old_gamerun_status = gamerun_status
	gamerun_status = "确认操作"
	jiaohu_text = "是否发动 '遗计'?"
	gamerun_OK = false
	
	gamerun_OK_ptr = function()
		funcptr_queue = {}
	
		if gamerun_OK then
			push_message(char_juese[char_current_i].name .. "发动了武将技能 '遗计'")
			yiji_first_time = true
			skills_yiji_fenfa(old_gamerun_status)
	    else
			set_hints("")
			gamerun_status = old_gamerun_status
			
			skills_pop_queue(true)
			timer.start(0.6)
		end
		platform.window:invalidate()
	end
	
	platform.window:invalidate()
end

function skills_yiji_fenfa(old_gamerun_status)
	yiji_gamerun_status = old_gamerun_status
	if #card_yixi == 0 then
		card_xipai(true)
	end

	txt_messages:setVisible(false)
	gamerun_status = "选项选择"
	choose_name = "遗计"
	msg = table.concat({"'",card_yixi[1][2],card_yixi[1][3],"的",card_yixi[1][1],"'"})
	jiaohu_text = "是否给出"..msg.."?"
	choose_option = {"是","否"}
	
	gamerun_guankan_selected = 1
	item_disrow = 0
	
	gamerun_item = function(i)
		funcptr_queue = {}
		if i == 2 then
			txt_messages:setVisible(true)
			_yiji_exe({char_current_i,char_current_i})
			gamerun_status = yiji_gamerun_status
			platform.window:invalidate()
		else
			skills_yiji_choose_mubiao(old_gamerun_status)
			platform.window:invalidate()
		end
	end
	
	platform.window:invalidate()
end
function skills_yiji_choose_mubiao(old_gamerun_status)
	funcptr_queue = {}
	id = char_current_i
	txt_messages:setVisible(true)
	skills_enter("请选择摸牌目标", "", "遗计", "技能选择-目标B")
	gamerun_OK = false
	gamerun_target_selected = char_current_i
	guankan_s = -1

	gamerun_OK_ptr = function()
		if gamerun_OK == true then
			set_hints("")
			gamerun_status = old_gamerun_status
			jiaohu_text = ""
			_yiji_exe({id, gamerun_target_selected})
			platform.window:invalidate()
		end
	end
	platform.window:invalidate()
end
function skills_yiji_ai(ID)
	local bupai_mubiao = ai_judge_yiji_mubiao(ID)

	if bupai_mubiao ~= nil then
		add_funcptr(push_message, char_juese[ID].name .. "发动了武将技能 '遗计'")
		add_funcptr(_yiji_exe_ai, {ID, bupai_mubiao})
		add_funcptr(_yiji_exe_ai, {ID, bupai_mubiao})
	end

	add_funcptr(skills_pop_queue)
	skills_skip_subqueue()
	timer.start(0.6)
end
function _yiji_exe_ai(va_list)
	local ID_s, ID_mubiao
	ID_s = va_list[1]; ID_mubiao = va_list[2]

	push_message(table.concat({char_juese[ID_s].name, "令", char_juese[ID_mubiao].name, "获得牌堆顶的一张牌"}))
	card_insert(ID_mubiao, card_yixi[1])
	table.remove(card_yixi, 1)
end
function _yiji_exe(va_list)
	local ID_s, ID_mubiao
	ID_s = va_list[1]; ID_mubiao = va_list[2]

	gamerun_status = "手牌生效中"
	set_hints("")
	push_message(table.concat({char_juese[ID_s].name, "令", char_juese[ID_mubiao].name, "获得牌堆顶的一张牌"}))
	card_insert(ID_mubiao, card_yixi[1])
	table.remove(card_yixi, 1)

	if yiji_first_time == false then
		funcptr_queue = {}
		add_funcptr(skills_pop_queue)
		consent_func_queue(0.6)
	else
		funcptr_queue = {}
		yiji_first_time = false
		add_funcptr(skills_yiji_fenfa,yiji_gamerun_status)
		consent_func_queue(0.6)
	end
end
function _yiji_huifu()
	funcptr_queue, funcptr_i = pop_zhudong_queue()
end

--  荀彧：节命  --
function skills_jieming_add(ID, tili_deducted)
	for i = 1, tili_deducted do
		add_funcptr(skills_jieming, {ID})
	end
end
function skills_jieming(va_list)
	local ID
	ID = va_list[1]

	push_zhudong_queue(table.copy(funcptr_queue), funcptr_i)
	timer.stop()
	funcptr_queue = {}
	funcptr_i = 0

	if ID == char_current_i then
		skills_jieming_enter()
	else
		skills_jieming_ai(ID)
	end
end
function skills_jieming_enter()
	local old_gamerun_status = gamerun_status
	gamerun_status = "确认操作"
	jiaohu_text = "是否发动 '节命'?"
	gamerun_OK = false
	
	gamerun_OK_ptr = function()
		funcptr_queue = {}
	
		if gamerun_OK then
			skills_jieming_choose_mubiao(old_gamerun_status)
	    else
			set_hints("")
			gamerun_status = old_gamerun_status
			
			_jieming_huifu()
			--funcptr_i = funcptr_i + 1
			timer.start(0.6)
		end
		platform.window:invalidate()
	end
	
	platform.window:invalidate()
end
function skills_jieming_choose_mubiao(old_gamerun_status)
	funcptr_queue = {}
	id = char_current_i
	skills_enter("请选择补牌目标", "", "节命", "技能选择-目标B")
	gamerun_OK = false
	gamerun_target_selected = char_current_i
	guankan_s = -1

	gamerun_OK_ptr = function()
		if gamerun_OK == true then
			set_hints("")
			gamerun_status = old_gamerun_status

			push_message(char_juese[id].name .. "发动了武将技能 '节命'")

			_jieming_exe({id, gamerun_target_selected})
			add_funcptr(_jieming_huifu)
			timer.start(0.6)
		end
	end
end
function skills_jieming_ai(ID)
	local bupai_mubiao = ai_judge_jieming_mubiao(ID)

	if bupai_mubiao ~= nil then
		add_funcptr(push_message, char_juese[ID].name .. "发动了武将技能 '节命'")
		_jieming_exe({ID, bupai_mubiao})
	end
	add_funcptr(_jieming_huifu)
	timer.start(0.6)
end
function _jieming_exe(va_list)
	local ID_s, ID_mubiao
	ID_s = va_list[1]; ID_mubiao = va_list[2]

	local tili_max = char_juese[ID_mubiao].tili_max
	local n_shoupai = #char_juese[ID_mubiao].shoupai
	if tili_max > 5 then
		tili_max = 5
	end

	add_funcptr(push_message, table.concat({char_juese[ID_s].name, "令", char_juese[ID_mubiao].name, "将手牌补至", tili_max, "张"}))
	add_funcptr(card_fenfa, {ID_mubiao, math.max(tili_max - n_shoupai, 0), true})
end
function _jieming_huifu()
	funcptr_queue, funcptr_i = pop_zhudong_queue()
end

--  甄姬：洛神  --
function skills_luoshen(ID)
	push_zhudong_queue(table.copy(funcptr_queue), funcptr_i)
	timer.stop()
	funcptr_queue = {}
	funcptr_i = 0

	if ID == char_current_i then
		local old_gamerun_status = gamerun_status
		skills_luoshen_enter(old_gamerun_status)
	else
		skills_luoshen_ai(ID)
	end
end
function skills_luoshen_ai(ID)
	skills_luoshen_exe(ID, nil)
end
function skills_luoshen_enter(old_gamerun_status)
	funcptr_queue = {}
	funcptr_i = 0

	gamerun_status = "确认操作"
	jiaohu_text = "是否发动 '洛神'?"
	gamerun_OK = false
	
	gamerun_OK_ptr = function()
		if gamerun_OK then
			gamerun_status = "手牌生效中"
			set_hints("")

			skills_luoshen_exe(char_current_i, old_gamerun_status)
	    else
			set_hints("")
			gamerun_status = old_gamerun_status
			
			_luoshen_huifu()
			--funcptr_i = funcptr_i + 1
			timer.start(0.2)
		end
		platform.window:invalidate()
	end
	
	platform.window:invalidate()
end
function skills_luoshen_exe(ID, old_gamerun_status)
	push_message(table.concat({char_juese[ID].name .. "发动了武将技能 '洛神'"}))
	add_funcptr(_ganglie_fan_panding, ID)

	--  如场上有司马懿或张角，询问其改判技能  --
	skills_guicai_guidao_ask(ID, nil, ID, "洛神")

	--  曹丕颂威  --
	add_funcptr(skills_judge_songwei_in_queue, ID)
	
	add_funcptr(_luoshen_jiesuan, {ID, old_gamerun_status})
	timer.start(0.6)
end
function _luoshen_fan_panding(ID)		--  洛神：翻开判定牌
	--  翻开判定牌  --
	if #card_yixi == 0 then
	    card_xipai(true)
	end
    card_panding_card = card_yixi[1]
	table.remove(card_yixi, 1)
	push_message(table.concat({char_juese[ID].name .. "的判定牌是'", card_panding_card[2], card_panding_card[3], "的", card_panding_card[1], "'"}))
end
function _luoshen_jiesuan(va_list)		--  洛神：结算判定牌
	local ID, old_gamerun_status
	ID = va_list[1]; old_gamerun_status = va_list[2]

	local yanse, huase, dianshu = ai_judge_cardinfo(ID, {card_panding_card})
	if huase == "黑桃" or huase == "草花" then
		push_message(char_juese[ID].name .. "的 '洛神' 判定成功")
		card_insert(ID, card_panding_card)

		if ID == char_current_i then
			timer.stop()
			skills_luoshen_enter(old_gamerun_status)
		else
			funcptr_queue = {}
			funcptr_i = 0
			skills_luoshen_ai(ID)
			timer.start(0.6)
		end
	else
		push_message(char_juese[ID].name .. "的 '洛神' 判定失败")
		
		skills_card_qi_panding(ID)
		add_funcptr(_luoshen_huifu)
		timer.stop()
		timer.start(0.2)
	end
end
function _luoshen_huifu()
	funcptr_queue, funcptr_i = pop_zhudong_queue()
end

--  曹操：奸雄  --
function skills_jianxiong(ID)
	if #card_jiesuan[1] == 0 then
		return
	end

	push_zhudong_queue(table.copy(funcptr_queue), funcptr_i)
	timer.stop()
	funcptr_queue = {}
	funcptr_i = 0

	if ID == char_current_i then
		skills_jianxiong_enter()
	else
		skills_jianxiong_ai(ID)
	end
end
function skills_jianxiong_ai(ID)
	_jianxiong_exe(ID)
end
function skills_jianxiong_enter()
	local old_gamerun_status = gamerun_status
	gamerun_status = "确认操作"
	jiaohu_text = "是否发动 '奸雄'?"
	gamerun_OK = false
	
	gamerun_OK_ptr = function()
		funcptr_queue = {}
		gamerun_status = old_gamerun_status
		set_hints("")

		if gamerun_OK then
			_jianxiong_exe(char_current_i)
	    else
			_jianxiong_huifu()
			--funcptr_i = funcptr_i + 1
			timer.start(0.6)
		end
		platform.window:invalidate()
	end
	
	platform.window:invalidate()
end
function _jianxiong_exe(ID)
	push_message(char_juese[ID].name .. "发动了武将技能 '奸雄'")
	add_funcptr(_jianxiong_get_card, ID)
	add_funcptr(_jianxiong_huifu)
	timer.start(0.6)
end
function _jianxiong_get_card(ID)
	local msg
	msg = char_juese[ID].name .. "获得了"
	for i = 1, #card_jiesuan[1] do
		local card = card_jiesuan[1][i]
		msg = msg .. table.concat({"'", card[2], card[3], "的", card[1], "'"})
		if i ~= #card_jiesuan[1] then
			msg = msg .. "，"
		end
	end
	push_message(msg)

	for i = 1, #card_jiesuan[1] do
		card_insert(ID, card_jiesuan[1][i])
	end
	card_jiesuan[1] = {}
end
function _jianxiong_huifu()
	funcptr_queue, funcptr_i = pop_zhudong_queue()
end

--  夏侯渊：神速  --
function skills_shensu(va_list)
	local ID = va_list[1]
	local is_panding = va_list[2]

	if is_panding == false and (game_skip_chupai == true or ai_card_stat(ID,false,true) == 0) then
		return
	end

	if ID == char_current_i then
		skills_shensu_enter(is_panding)
	else
		skills_shensu_ai(ID, is_panding)
	end
end
function skills_shensu_enter(is_panding)
	local old_gamerun_status = gamerun_status

	push_zhudong_queue(table.copy(funcptr_queue), funcptr_i)
	timer.stop()
	funcptr_queue = {}
	funcptr_i = 0

	gamerun_status = "选项选择"
	choose_name = "神速"
	if is_panding == true then
		jiaohu_text = "是否跳过判定和摸牌阶段?"
	else
		jiaohu_text = "是否跳过出牌阶段?"
	end
	choose_option = {"是", "否"}

	txt_messages:setVisible(false)
	gamerun_guankan_selected = 1
	item_disrow = 0
	
	gamerun_item = function(i)
		txt_messages:setVisible(true)
		funcptr_queue = {}
		gamerun_status = old_gamerun_status
		set_hints("")

		if i == 1 then
			skills_shensu_choose_mubiao(is_panding)
	    else
			_shensu_huifu()
			--funcptr_i = funcptr_i + 1
			timer.start(0.6)
		end
		platform.window:invalidate()
	end
	
	platform.window:invalidate()
end
function skills_shensu_ai(ID, is_panding)
	local ID_shoupai, ID_zhuangbei, ID_mubiao = ai_judge_shensu(ID, is_panding)
	if #ID_mubiao == 0 then
		return
	end

	push_zhudong_queue(table.copy(funcptr_queue), funcptr_i)
	timer.stop()
	funcptr_queue = {}
	funcptr_i = 0

	char_distance_infinity = true
	_shensu_exe(ID_shoupai, ID, ID_mubiao[1], ID_zhuangbei, is_panding)

	return true
end
function skills_shensu_choose_mubiao(is_panding)
	char_distance_infinity = true
	gamerun_wuqi_into_hand(char_current_i)

	skills_enter("请选择一张装备牌", "请选择杀的目标", "杀", "技能选择-单牌")
	if is_panding then
		skills_enter_target()
	end
	
	gamerun_OK_ptr = function()
		if gamerun_status == "技能选择-目标" then
			if gamerun_OK == true then
				_shensu_exe(card_highlighted, char_current_i, gamerun_target_selected, nil, is_panding)
			end
			return
		end

		if gamerun_status == "技能选择-单牌" then
			if gamerun_OK == false then
				char_distance_infinity = false
				_shensu_huifu()
				--funcptr_i = funcptr_i + 1
				timer.start(0.6)
			end
		end
	end
	
	gamerun_tab_ptr = function()
		if (table.getn2(card_selected) == 1 and (card_get_leixing(char_juese[char_current_i].shoupai[card_highlighted][1]) == "武器" or card_get_leixing(char_juese[char_current_i].shoupai[card_highlighted][1]) == "防具" or card_get_leixing(char_juese[char_current_i].shoupai[card_highlighted][1]) == "+1马" or card_get_leixing(char_juese[char_current_i].shoupai[card_highlighted][1]) == "-1马")) and is_panding ~= true then
			skills_enter_target()
		end
	end
	
	return true
end
function _shensu_exe(ID_shoupai, ID_s, ID_mubiao, ai_qi_zhuangbei_id, is_panding)
	funcptr_queue = {}
	funcptr_i = 0
	
	if not is_panding then
		if ID_s == char_current_i then
			local card = char_juese[ID_s].shoupai[ID_shoupai]
			card_add_qipai(card)
			card_remove({ID_s, ID_shoupai})
			gamerun_wuqi_out_hand(char_current_i)

			push_message(table.concat({char_juese[ID_s].name, "弃掉了'", card[2], card[3], "的", card[1], "'"}))
			skills_losecard(ID_s)
		else
			ai_withdraw(ID_s, ID_shoupai, ai_qi_zhuangbei_id, false)
			skills_losecard(ID_s)
		end
		game_skip_chupai = true
	else
		game_skip_panding = true
		game_skip_mopai = true
	end

	add_funcptr(push_message, char_juese[ID_s].name .. "发动了武将技能 '神速'")
	gamerun_shensu = true

	--  插入虚拟无色无点牌  --
	table.insert(char_juese[ID_s].shoupai, {"杀", "", ""})
	if card_sha({#char_juese[ID_s].shoupai}, ID_s, {ID_mubiao}, false) then
		skills_cs()
		timer.start(0.6)
	end
end
function _shensu_huifu()
	funcptr_queue, funcptr_i = pop_zhudong_queue()
end

--  张郃：巧变  --
function skills_qiaobian(va_list)
	local ID = va_list[1]
	local jieduan = va_list[2]

	if jieduan == "判定" and game_skip_panding == true then
		return
	end
	if jieduan == "摸牌" and game_skip_mopai == true then
		return
	end
	if jieduan == "出牌" and game_skip_chupai == true then
		return
	end
	
	if ai_card_stat(ID,true,true) == 0 then
		return
	end

	if ID == char_current_i then
		skills_qiaobian_enter(jieduan)
	else
		skills_qiaobian_ai(ID, jieduan)
	end
end
function skills_qiaobian_enter(jieduan)
	local old_gamerun_status = gamerun_status
	if jieduan ~= "弃牌" then
		push_zhudong_queue(table.copy(funcptr_queue), funcptr_i)
		timer.stop()
		funcptr_queue = {}
		funcptr_i = 0
	end
	gamerun_status = "选项选择"
	choose_name = "巧变"
	if jieduan == "判定" then
		jiaohu_text = "是否跳过判定阶段?"
	elseif jieduan == "摸牌" then
		jiaohu_text = "是否跳过摸牌阶段?"
	elseif jieduan == "出牌" then
		jiaohu_text = "是否跳过出牌阶段?"
	elseif jieduan == "弃牌" then
		jiaohu_text = "是否跳过弃牌阶段?"
	end
	choose_option = {"是", "否"}

	txt_messages:setVisible(false)
	gamerun_guankan_selected = 1
	item_disrow = 0
	
	gamerun_item = function(i)
		txt_messages:setVisible(true)
		funcptr_queue = {}
		gamerun_status = old_gamerun_status
		set_hints("")

		if i == 1 then
			skills_qiaobian_withdraw(jieduan)
	    else
			if jieduan ~= "弃牌" then
				_qiaobian_huifu()
				--funcptr_i = funcptr_i + 1
				timer.start(0.6)
			else
				gamerun_huihe_set("弃牌")
				if char_acting_i == char_current_i then
					gamerun_enter_qipai()
				else
					_ai_qipai_exe(char_acting_i)
					timer.start(0.2)
				end
			end
		end
		platform.window:invalidate()
	end
	
	platform.window:invalidate()
end
function skills_qiaobian_ai(ID, jieduan)
	local ID_shoupai, ID_mubiao = ai_judge_qiaobian(ID, jieduan)
	if #ID_shoupai == 0 then
		if jieduan == "弃牌" then
			_ai_qipai_exe(char_acting_i)
			timer.start(0.2)
			return
		else
			return
		end
	end

	push_zhudong_queue(table.copy(funcptr_queue), funcptr_i)
	timer.stop()
	funcptr_queue = {}
	funcptr_i = 0
	if jieduan == "判定" or jieduan == "弃牌" then
		_qiaobian_exe(ID_shoupai, ID, jieduan)
	elseif jieduan == "摸牌" then
		_qiaobian_exe(ID_shoupai, ID, jieduan)
		if #ID_mubiao > 1 then
			guankan_s, gamerun_target_selected = ID_mubiao[1], ID_mubiao[2]
			_qiaobian_mopai_exe(ID, true)
		else
			gamerun_target_selected = ID_mubiao[1]
			_qiaobian_mopai_exe(ID, false)
		end
	elseif jieduan == "出牌" then
		_qiaobian_exe(ID_shoupai, ID, jieduan)
		skills_qiaobian_chupai_set(ID_mubiao)
	end
	return true
end
function skills_qiaobian_withdraw(jieduan)

	skills_enter("请选择一张牌", "", "巧变", "技能选择-单牌")
	
	gamerun_OK_ptr = function()
		if gamerun_OK == true then
			_qiaobian_exe(card_highlighted, char_current_i, jieduan)
		elseif gamerun_OK == false then
			_qiaobian_huifu()
			--funcptr_i = funcptr_i + 1
			timer.start(0.6)
		end
		return true
	end
	
	return true
end
function _qiaobian_exe(ID_shoupai, ID_s, jieduan)
	funcptr_queue = {}
	funcptr_i = 0
	if ID_s == char_current_i then
		local card = char_juese[ID_s].shoupai[ID_shoupai]
		card_add_qipai(card)
		card_remove({ID_s, ID_shoupai})

		push_message(table.concat({char_juese[ID_s].name, "弃掉了'", card[2], card[3], "的", card[1], "'"}))
		skills_losecard(ID_s)
	else
		ai_withdraw(ID_s, ID_shoupai, {}, false)
		skills_losecard(ID_s)
	end
	push_message(char_juese[ID_s].name .. "发动了武将技能 '巧变'")
	if jieduan == "判定" then
		gamerun_status = ""
		set_hints("")
		game_skip_panding = true
		skills_cs()
		_qiaobian_huifu()
		timer.start(0.6)
		platform.window:invalidate()
	elseif jieduan == "摸牌" then
		game_skip_mopai = true
		local total_shoupai = 0
		for i = 1, 5 do
			if char_juese[i].siwang ~= true and i ~= ID_s then
				total_shoupai = total_shoupai + # char_juese[i].shoupai
			end
		end
		if ID_s == char_current_i then
			if total_shoupai ~= 0 then
				_qiaobian_mopai_target1(ID_s)
			else
				_qiaobian_huifu()
				skills_cs()
				timer.start(0.6)
			end
		end
	elseif jieduan == "出牌" then
		game_skip_chupai = true
		local local_difference, last_one = false, nil
		for i = 1, 5 do
			if char_juese[i].siwang ~= true then
				if last_one == nil then
					last_one = i
				else
					if #char_juese[i].wuqi ~= #char_juese[last_one].wuqi then
						local_difference = true
					elseif #char_juese[i].fangju ~= #char_juese[last_one].fangju then
						local_difference = true
					elseif #char_juese[i].gongma ~= #char_juese[last_one].gongma then
						local_difference = true
					elseif #char_juese[i].fangma ~= #char_juese[last_one].fangma then
						local_difference = true
					elseif #char_juese[i].panding ~= #char_juese[last_one].panding then
						local_difference = true
					end
				end
			end
		end
		if ID_s == char_current_i then
			if local_difference == true then
				_qiaobian_chupai_target1(ID_s)
			else
				_qiaobian_huifu()
				skills_cs()
				timer.start(0.6)
			end
		end
	else
		funcptr_queue = {}
		--_qiaobian_huifu()
		skills_cs()
		set_hints("")
		gamerun_huihe_jieshu(true)
		timer.start(0.2)
	end
end
function _qiaobian_mopai_target1(ID_s)
	skills_enter("请选择目标A", "", "巧变", "技能选择-目标")
	gamerun_select_target("init")
	gamerun_OK = false

	gamerun_OK_ptr = function()
		if gamerun_OK then
			guankan_s = gamerun_target_selected
			_qiaobian_mopai_target2(ID_s)
		end
	end
end
function _qiaobian_mopai_target2(ID_s)
	skills_enter("'确定': 选择B '取消': 仅A", "", "巧变", "技能选择-目标B")
	gamerun_select_target("init")
	gamerun_OK = false

	gamerun_OK_ptr = function()
		if gamerun_OK then
			_qiaobian_mopai_exe(ID_s, true)
		else
			_qiaobian_mopai_exe(ID_s, false)
		end
	end
end
function _qiaobian_mopai_exe(ID_s, double)
	gamerun_status = ""
	char_qiaobian = true
	
	add_funcptr(_qiaobian_mopai_sub1, {ID_s, gamerun_target_selected})
	skills_losecard(gamerun_target_selected)

	if double then
		add_funcptr(_qiaobian_mopai_sub1, {ID_s, guankan_s})
		skills_losecard(guankan_s)
	end
	
	add_funcptr(_qiaobian_huifu, nil)
	timer.start(0.2)
end
function _qiaobian_mopai_sub1(va_list)
	local ID_s, ID_mubiao
	local t, card
	ID_s = va_list[1]; ID_mubiao = va_list[2]
	
	push_message(table.concat({char_juese[ID_s].name.."获得", char_juese[ID_mubiao].name, "的一张手牌"}))
	
	t = math.random(#char_juese[ID_mubiao].shoupai)
	card = char_juese[ID_mubiao].shoupai[t]
	card_remove({ID_mubiao, t})
	card_insert(ID_s, card)
end
function _qiaobian_chupai_target1(ID_s)
	skills_enter("请选择目标A", "", "巧变", "技能选择-目标")
	gamerun_select_target("init")
	gamerun_OK = false
	gamerun_target_selected = ID_s
	guankan_s = -1
	
	gamerun_OK_ptr = function()
		if gamerun_OK then
			guankan_s = gamerun_target_selected
			_qiaobian_chupai_target2(ID_s)
		end
	end
end
function _qiaobian_chupai_target2(ID_s)
	skills_enter("请选择目标B", "", "巧变", "技能选择-目标B")
	gamerun_select_target("init")
	gamerun_OK = false
	
	gamerun_OK_ptr = function()
		if gamerun_OK and (#char_juese[guankan_s].wuqi ~= #char_juese[gamerun_target_selected].wuqi or #char_juese[guankan_s].fangju ~= #char_juese[gamerun_target_selected].fangju or #char_juese[guankan_s].gongma ~= #char_juese[gamerun_target_selected].gongma or #char_juese[guankan_s].fangma ~= #char_juese[gamerun_target_selected].fangma or #char_juese[guankan_s].panding ~= #char_juese[gamerun_target_selected].panding) then
			_qiaobian_chupai_exe(ID_s, guankan_s, gamerun_target_selected)
		end
	end
end
function _qiaobian_chupai_exe(ID_s, guankan_s, gamerun_target_selected)
	qiaobian_chupai_up, qiaobian_chupai_down = {},{}
	gamerun_status = "牌堆操作"
	choose_name = "巧变"
	table.insert(qiaobian_chupai_up,char_juese[guankan_s].wuqi)
	table.insert(qiaobian_chupai_up,char_juese[guankan_s].fangju)
	table.insert(qiaobian_chupai_up,char_juese[guankan_s].gongma)
	table.insert(qiaobian_chupai_up,char_juese[guankan_s].fangma)
	for i = 1,#char_juese[guankan_s].panding do
		table.insert(qiaobian_chupai_up,char_juese[guankan_s].panding[i])
	end
	table.insert(qiaobian_chupai_down,char_juese[gamerun_target_selected].wuqi)
	table.insert(qiaobian_chupai_down,char_juese[gamerun_target_selected].fangju)
	table.insert(qiaobian_chupai_down,char_juese[gamerun_target_selected].gongma)
	table.insert(qiaobian_chupai_down,char_juese[gamerun_target_selected].fangma)
	for i = 1,#char_juese[gamerun_target_selected].panding do
		table.insert(qiaobian_chupai_down,char_juese[gamerun_target_selected].panding[i])
	end
	for i = 1, #qiaobian_chupai_up do
		if #qiaobian_chupai_up[i] == 0 then
			qiaobian_chupai_up[i] = {"空", "", ""}
		end
	end
	for i = 1, #qiaobian_chupai_down do
		if #qiaobian_chupai_down[i] == 0 then
			qiaobian_chupai_down[i] = {"空", "", ""}
		end
	end
	qiaobian_up, qiaobian_down = guankan_s, gamerun_target_selected
	card_dealed_1, card_dealed_2 = qiaobian_chupai_up, qiaobian_chupai_down
	txt_messages:setVisible(false)
	gamerun_guankan_selected = 1
	card_dealed_selected = 0
	card_paidui_dealed = 1
	gamerun_deal = function()
		
	end
	platform.window:invalidate()
end
function _qiaobian_huifu()
	funcptr_queue, funcptr_i = pop_zhudong_queue()
end

function skills_qiaobian_chupai_set(va_list)
	local ID_s, ID_mubiao, ID_card
	local t, card
	ID_s = va_list[1]; ID_mubiao = va_list[2]; ID_card = va_list[3]
	gamerun_status = ""
	txt_messages:setVisible(true)
	if ID_card == 1 then
		push_message(table.concat({char_juese[ID_s].name.."获得", char_juese[ID_mubiao].name, "的武器"}))
		char_juese[ID_s].wuqi, char_juese[ID_mubiao].wuqi = char_juese[ID_mubiao].wuqi, char_juese[ID_s].wuqi
		skills_losecard(ID_s)
		skills_losecard(ID_mubiao)
	elseif ID_card == 2 then
		push_message(table.concat({char_juese[ID_s].name.."获得", char_juese[ID_mubiao].name, "的防具"}))

		local s_fangju = table.copy(char_juese[ID_s].fangju)
		local mubiao_fangju = table.copy(char_juese[ID_mubiao].fangju)
		card_arm_fangju(ID_s, mubiao_fangju)
		card_arm_fangju(ID_mubiao, s_fangju)

		skills_losecard(ID_s)
		skills_losecard(ID_mubiao)
	elseif ID_card == 3 then
		push_message(table.concat({char_juese[ID_s].name.."获得", char_juese[ID_mubiao].name, "的-1马"}))
		char_juese[ID_s].gongma, char_juese[ID_mubiao].gongma = char_juese[ID_mubiao].gongma, char_juese[ID_s].gongma
		skills_losecard(ID_s)
		skills_losecard(ID_mubiao)
	elseif ID_card == 4 then
		push_message(table.concat({char_juese[ID_s].name.."获得", char_juese[ID_mubiao].name, "的+1马"}))
		char_juese[ID_s].fangma, char_juese[ID_mubiao].fangma = char_juese[ID_mubiao].fangma, char_juese[ID_s].fangma
		skills_losecard(ID_s)
		skills_losecard(ID_mubiao)
	else
		push_message(table.concat({char_juese[ID_mubiao].name, "判定区的一张牌被转移给"..char_juese[ID_s].name}))
		card = char_juese[ID_mubiao].panding[ID_card - 4]
		table.remove(char_juese[ID_mubiao].panding,ID_card - 4)
		table.insert(char_juese[ID_s].panding, card)
	end
	--[[funcptr_queue, funcptr_i = pop_zhudong_queue()
	funcptr_i = funcptr_i + 1
	timer.start(0.2)]]
	add_funcptr(_qiaobian_huifu, nil)
	timer.start(0.2)
end

--  曹丕：颂威  --
function skills_judge_songwei(ID)
	local yanse, huase, dianshu = ai_judge_cardinfo(ID, {card_panding_card})

	if yanse == "黑色" and char_juese[ID].shili == "魏" then
		for i = 1, 5 do
			if char_juese[i].skill["颂威"] == "available" and i ~= ID and char_juese[i].siwang == false then
				add_funcptr(skills_songwei, {ID, i})
			end
		end
	end
end
function skills_judge_songwei_in_queue(ID)
	push_zhudong_queue(table.copy(funcptr_queue), funcptr_i)
	timer.stop()
	funcptr_queue = {}
	funcptr_i = 0

	local yanse, huase, dianshu = ai_judge_cardinfo(ID, {card_panding_card})

	if yanse == "黑色" and char_juese[ID].shili == "魏" then
		for i = 1, 5 do
			if char_juese[i].skill["颂威"] == "available" and i ~= ID and char_juese[i].siwang == false then
				add_funcptr(skills_songwei, {ID, i})
			end
		end
	end

	add_funcptr(_songwei_huifu)
	timer.start(0.2)
end
function skills_songwei(va_list)
	local ID, ID_zhugong
	ID = va_list[1]; ID_zhugong = va_list[2]

	if ID == char_current_i then
		skills_songwei_enter(ID_zhugong)
	else
		skills_songwei_ai(ID, ID_zhugong)
	end
end
function skills_songwei_ai(ID, ID_zhugong)
	if ai_judge_songwei(ID, ID_zhugong) == false then
		return
	end

	push_zhudong_queue(table.copy(funcptr_queue), funcptr_i)
	timer.stop()
	funcptr_queue = {}
	funcptr_i = 0

	_songwei_exe(ID, ID_zhugong)
	timer.start(0.6)
end
function skills_songwei_enter(ID_zhugong)
	local old_gamerun_status = gamerun_status

	push_zhudong_queue(table.copy(funcptr_queue), funcptr_i)
	timer.stop()
	funcptr_queue = {}
	funcptr_i = 0

	gamerun_status = "确认操作"
	jiaohu_text = table.concat({"是否响应", char_juese[ID_zhugong].name, "的'颂威'?"})
	gamerun_OK = false
	gamerun_OK_ptr = function()
		gamerun_status = old_gamerun_status
		funcptr_queue = {}
		set_hints("")

		if gamerun_OK == true then
			_songwei_exe(char_current_i, ID_zhugong)
		else
			_songwei_huifu()
			--funcptr_i = funcptr_i + 1
		end
		timer.start(0.6)
	end
	
	platform.window:invalidate()
end
function _songwei_exe(ID, ID_zhugong)
	push_message(table.concat({char_juese[ID].name, "响应了", char_juese[ID_zhugong].name, "的武将技能 '颂威'"}))
	add_funcptr(card_fenfa, {ID_zhugong, 1, true})
	add_funcptr(_songwei_huifu)
end
function _songwei_huifu()
	timer.start(0.6)
	funcptr_queue, funcptr_i = pop_zhudong_queue()
end

--  曹操：护驾  --
function skills_hujia_req_side(va_list)
	local ID_req, mode, va
	ID_req = va_list[1]; mode = va_list[2]; va = va_list[3]

	if ID_req == char_current_i then
		skills_hujia_req_side_enter(mode, va)
	else
		skills_hujia_req_side_ai(ID_req, mode, va)
	end
end
function skills_hujia_req_side_ai(ID_req, mode, va)
	if ai_judge_hujia_req(ID_req) == false then
		skills_skip_subqueue()
		return
	end

	push_zhudong_queue(table.copy(funcptr_queue), funcptr_i)
	timer.stop()
	funcptr_queue = {}
	funcptr_i = 0

	skills_hujia_add(ID_req, mode, va)
	timer.start(0.6)
end
function skills_hujia_req_side_enter(mode, va)
	local old_gamerun_status = gamerun_status

	push_zhudong_queue(table.copy(funcptr_queue), funcptr_i)
	timer.stop()
	funcptr_queue = {}
	funcptr_i = 0

	gamerun_status = "确认操作"
	jiaohu_text = "是否发动 '护驾'?"
	gamerun_OK = false
	gamerun_OK_ptr = function()
		set_hints("")
		gamerun_status = old_gamerun_status

		if gamerun_OK == true then
			skills_hujia_add(char_current_i, mode, va)
		else
			_hujia_huifu()
		end
		timer.start(0.6)
	end
	
	platform.window:invalidate()
end
function skills_hujia_add(ID_req, mode, va)
	push_message(table.concat({char_juese[ID_req].name, "发动了武将技能 '护驾'"}))
	for i = 1, 5 do
		if char_juese[i].shili == "魏" and ID_req ~= i and char_juese[i].siwang == false then
			add_funcptr(skills_hujia, {ID_req, i, mode, va})
		end
	end
	add_funcptr(_hujia_huifu)
end
function skills_hujia(va_list)
	local ID_req, ID_res, mode, va
	ID_req = va_list[1]; ID_res = va_list[2]; mode = va_list[3]; va = va_list[4]

	if ID_res == char_current_i then
		skills_hujia_enter(ID_req, mode, va)
	else
		skills_hujia_ai(ID_req, ID_res, mode, va)
	end
end
function skills_hujia_ai(ID_req, ID_res, mode, va)
	if ai_judge_hujia(_hujia_get_ids(va, mode), ID_req, ID_res) == false then
		push_message(table.concat({char_juese[ID_res].name, "不响应"}))
		return
	end

	local arm_bagua = false
	if #char_juese[ID_res].fangju > 0 then
		if char_juese[ID_res].fangju[1] == "八卦阵" then
			arm_bagua = true
		end
	end

	local c_pos
	if arm_bagua == false then
		c_pos = ai_chazhao_shan(ID_res, char_juese[ID_res].shoupai)
		if c_pos < 0 then
			push_message(table.concat({char_juese[ID_res].name, "不响应"}))
			return
		end
	end

	push_zhudong_queue(table.copy(funcptr_queue), funcptr_i)
	timer.stop()
	funcptr_queue = {}
	funcptr_i = 0

	push_message(table.concat({char_juese[ID_res].name, "响应"}))

	if arm_bagua == false then
		_hujia_exe(ID_req, ID_res, c_pos, mode, va)
	else
		_hujia_bagua(ID_req, ID_res, mode, va, "手牌生效中")
	end
	timer.start(0.6)
end
function skills_hujia_enter(ID_req, mode, va)
	local old_gamerun_status = gamerun_status

	push_zhudong_queue(table.copy(funcptr_queue), funcptr_i)
	timer.stop()
	funcptr_queue = {}
	funcptr_i = 0

	gamerun_status = "确认操作"
	jiaohu_text = table.concat({"是否响应", char_juese[ID_req].name, "的'护驾'?"})
	gamerun_OK = false
	gamerun_OK_ptr = function()
		funcptr_queue = {}
		set_hints("")
		gamerun_status = old_gamerun_status

		if gamerun_OK == true then
			push_message(table.concat({char_juese[char_current_i].name, "响应"}))

			local arm_bagua = false
			if #char_juese[char_current_i].fangju > 0 then
				if char_juese[char_current_i].fangju[1] == "八卦阵" then
					arm_bagua = true
				end
			end

			if arm_bagua == false then
				_hujia_select_card(ID_req, mode, va, old_gamerun_status)
			else
				_hujia_bagua(ID_req, char_current_i, mode, va, old_gamerun_status)
			end
		else
			push_message(table.concat({char_juese[char_current_i].name, "不响应"}))
			_hujia_huifu()
		end
		timer.start(0.6)
	end
	
	platform.window:invalidate()
end
function _hujia_bagua(ID_req, ID_res, mode, va, old_gamerun_status)
	add_funcptr(card_arm_bagua, {ID_res, nil})
	add_funcptr(_hujia_bagua_get_result, {ID_req, ID_res, mode, va, old_gamerun_status})
end
function _hujia_bagua_get_result(va_list)
	local ID_req, ID_res, mode, va, old_gamerun_status
	ID_req = va_list[1]; ID_res = va_list[2]; mode = va_list[3]; va = va_list[4]; old_gamerun_status = va_list[5]

	if _bagua_jiesuan(ID_res) then
		_hujia_exe(ID_req, ID_res, -1, mode, va)
		timer.start(0.6)
	else
		if ID_res == char_current_i then
			_hujia_select_card(ID_req, mode, va, old_gamerun_status)
		else
			_hujia_determine_shan(ID_req, ID_res, mode, va)
		end
	end
end
function _hujia_determine_shan(ID_req, ID_res, mode, va)
	local c_pos = ai_chazhao_shan(ID_res, char_juese[ID_res].shoupai)
	if c_pos < 0 then
		push_message(table.concat({char_juese[ID_res].name, "放弃"}))
		_hujia_huifu()
	else
		_hujia_exe(ID_req, ID_res, c_pos, mode, va)
	end
	timer.start(0.6)
end
function _hujia_select_card(ID_req, mode, va, old_gamerun_status)
	skills_enter("您可出1张闪", "", "护驾", "技能选择-单牌")
	gamerun_OK_ptr = function()
		if gamerun_OK == true then
			if table.getn2(card_selected) == 1 then
				if card_judge_if_shan(char_current_i, card_highlighted) then
					gamerun_status = old_gamerun_status
					set_hints("")

					_hujia_exe(ID_req, char_current_i, card_highlighted, mode, va)

					card_selected = {}
					card_highlighted = 1
				end
			end
		else
			gamerun_status = old_gamerun_status
			set_hints("")
			push_message(table.concat({char_juese[char_current_i].name, "放弃"}))
			_hujia_huifu()
		end
		timer.start(0.6)
	end
	
	gamerun_tab_ptr = nil
end
function _hujia_exe(ID_req, ID_res, ID_shoupai, mode, va)
	--  弹出第一层：护驾响应  --
	_hujia_huifu()

	--  弹出第二层：护驾请求  --
	_hujia_huifu()

	--  清空原有函数队列  --
	funcptr_queue = {}
	funcptr_i = 0

	if ID_shoupai ~= -1 then
		add_funcptr(_sha_shan, {ID_res, ID_shoupai})
		skills_losecard(ID_res)
	end
	
	if mode == "杀" then
		local card_shoupai, ID_s, ID_mubiao, iscur, wushuang_flag
		card_shoupai = va[1]; ID_s = va[2]; ID_mubiao = va[3]; iscur = va[4]; wushuang_flag = va[5]
		_sha_shan_replaced(card_shoupai, ID_s, ID_mubiao, iscur, wushuang_flag)
	elseif mode == "万箭齐发" then
		local ID_s, ID_mubiao
		ID_s = va[1]; ID_mubiao = va[2]
		_wanjian_shan_replaced(ID_s, ID_mubiao)
	end
end
function _hujia_get_ids(va, mode)
	if mode == "杀" then
		return va[2]
	elseif mode == "万箭齐发" then
		return va[1]
	end
	return nil
end
function _hujia_huifu()
	funcptr_queue, funcptr_i = pop_zhudong_queue()
end

--  邓艾：屯田  --
function skills_tuntian(ID)
	local n_pai = ai_card_stat(ID, true, false)
	local last_n_pai = char_juese[ID].last_n_pai
	char_juese[ID].last_n_pai = n_pai

	if ID == char_acting_i then
		_baiyin_skip()
		return
	end

	if n_pai < last_n_pai then
		n_pai = last_n_pai - n_pai
	else
		_baiyin_skip()
		return
	end

	push_zhudong_queue(table.copy(funcptr_queue), funcptr_i)
	timer.stop()
	funcptr_queue = {}
	funcptr_i = 0

	if ID == char_current_i then
		local old_gamerun_status = gamerun_status
		skills_tuntian_enter(old_gamerun_status)
	else
		skills_tuntian_ai(ID)
	end
end
function skills_tuntian_ai(ID)
	skills_tuntian_exe(ID, nil)
end
function skills_tuntian_enter(old_gamerun_status)
	funcptr_queue = {}
	funcptr_i = 0

	gamerun_status = "确认操作"
	jiaohu_text = "是否发动 '屯田'?"
	gamerun_OK = false
	
	gamerun_OK_ptr = function()
		if gamerun_OK then
			gamerun_status = "手牌生效中"
			set_hints("")

			skills_tuntian_exe(char_current_i, old_gamerun_status)
	    else
			set_hints("")
			gamerun_status = old_gamerun_status
			
			_luoshen_huifu()
			timer.start(0.2)
		end
		platform.window:invalidate()
	end
	
	platform.window:invalidate()
end
function skills_tuntian_exe(ID, old_gamerun_status)
	push_message(table.concat({char_juese[ID].name .. "发动了武将技能 '屯田'"}))
	add_funcptr(_tuntian_fan_panding, ID)

	--  如场上有司马懿或张角，询问其改判技能  --
	skills_guicai_guidao_ask(ID, nil, ID, "屯田")
	
	add_funcptr(_tuntian_jiesuan, {ID, old_gamerun_status})
	timer.start(0.6)
end
function _tuntian_fan_panding(ID)
	--  翻开判定牌  --
	if #card_yixi == 0 then
	    card_xipai(true)
	end
    card_panding_card = card_yixi[1]
	table.remove(card_yixi, 1)
	push_message(table.concat({char_juese[ID].name .. "的判定牌是'", card_panding_card[2], card_panding_card[3], "的", card_panding_card[1], "'"}))
end
function _tuntian_jiesuan(va_list)
	local ID, old_gamerun_status
	ID = va_list[1]; old_gamerun_status = va_list[2]

	local yanse, huase, dianshu = ai_judge_cardinfo(ID, {card_panding_card})

	--  曹丕颂威  --
	skills_judge_songwei(ID)

	if huase ~= "红桃" then
		push_message(char_juese[ID].name .. "的 '屯田' 判定成功")
		add_funcptr(_tuntian_get_tian, {ID, card_panding_card})
	else
		push_message(char_juese[ID].name .. "的 '屯田' 判定失败")
		skills_card_qi_panding(ID)
	end

	add_funcptr(_luoshen_huifu)
	timer.stop()
	timer.start(0.6)
end
function _tuntian_get_tian(va_list)
	local ID, card
	ID = va_list[1]; card = va_list[2]

	push_message(table.concat({char_juese[ID].name, "获得了'田'牌'", card[2], card[3], "的", card[1], "'"}))
	table.insert(card_tian[ID], card)
end
function _tuntian_siwang_qipai(ID)		--  屯田：死亡后弃掉所有'田'
	for i = #card_tian[ID], 1, -1 do
		add_funcptr(_tuntian_qipai_exe, {ID, i})
	end
end
function _tuntian_qipai_exe(va_list)
	local ID, ID_tian
	ID = va_list[1]; ID_tian = va_list[2]

	local card = card_tian[ID][ID_tian]
	push_message(table.concat({char_juese[ID].name, "丢弃'田'牌'", card[2], card[3], "的", card[1], "'"}))
	table.remove(card_tian[ID], ID_tian)
	card_add_qipai(card)
end

--  邓艾：凿险  --
function skills_zaoxian()
	push_message(char_juese[char_acting_i].name.."触发了武将技能 '凿险'")
	
	char_juese[char_acting_i].tili_max = char_juese[char_acting_i].tili_max - 1
	char_juese[char_acting_i].tili = math.min(char_juese[char_acting_i].tili, char_juese[char_acting_i].tili_max)
	push_message(char_juese[char_acting_i].name .. "失去1点体力上限")
	
	if char_juese[char_acting_i].skill["急袭"] ~= nil then
		skill_double[char_acting_i]["急袭"] = true
	else
		char_juese[char_acting_i].skill["急袭"] = "available"
	end
	table.insert(char_juese[char_acting_i].skillname, "急袭")

	char_juese[char_acting_i].skill["凿险"] = "locked_whole_game"
end

--  邓艾：急袭  --
function skills_jixi_enter()
	if #card_tian[char_current_i] == 0 then
		return false
	end

	timer.stop()
	funcptr_queue = {}
	funcptr_i = 0

	local msg = table.concat({"请选择目标 (剩余", #card_tian[char_current_i], ")"})

	skills_enter(msg, "", "顺手牵羊", "技能选择-目标")
	gamerun_select_target("init")
	gamerun_OK = false
	
	gamerun_OK_ptr = function()
		if _jixi_select_tian(char_current_i, gamerun_target_selected) then
			skills_cs()
		end
	end

	return true
end
function skills_jixi_ai(ID_s, ID_mubiao, ID_tian)
	if #card_tian[ID_s] == 0 or card_if_d_limit("顺手牵羊", ID_s, ID_mubiao, nil) == false then
		return false
	end

	_jixi_exe(ID_s, ID_mubiao, ID_tian)
	return true
end
function _jixi_select_tian(ID_s, ID_mubiao)
	if card_if_d_limit("顺手牵羊", ID_s, ID_mubiao, nil) == false then
		return false
	end

	wugucards = table.copy(card_tian[char_current_i])

	gamerun_status = "牌堆选择-急袭"
	jiaohu_text = "请选择要使用的田牌"
	gamerun_guankan_selected = 1

	txt_messages:setVisible(false)
	platform.window:invalidate()

	return true
end
function _jixi_exe(ID_s, ID_mubiao, ID_tian)
	set_hints("")
	gamerun_status = "手牌生效中"
	txt_messages:setVisible(true)

	local card = card_tian[ID_s][ID_tian]
	table.remove(card_tian[ID_s], ID_tian)
	card_insert(ID_s, card)

	--  贾诩帷幕的情况  --
	if card_if_d_limit("顺手牵羊", ID_s, ID_mubiao, {#char_juese[ID_s].shoupai}) == false then
		table.remove(char_juese[ID_s].shoupai)
		table.insert(card_tian[ID_s], card)

		add_funcptr(_chai_sub2)
		timer.start(0.6)
		return
	end

	wugucards = {}
	add_funcptr(push_message, char_juese[ID_s].name .. "发动了武将技能 '急袭'")

	if card_shun({#char_juese[ID_s].shoupai}, ID_s, ID_mubiao) then
		timer.start(0.6)
	else
		--  不可能发生！ --
		table.remove(char_juese[ID_s].shoupai)
		card_add_qipai(card)
	end
end
