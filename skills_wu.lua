--  孙尚香：枭姬  --
function skills_xiaoji(ID)
	local n_arm = ai_arm_stat(ID)
	local last_n_arm = char_juese[ID].last_n_arm
	char_juese[ID].last_n_arm = n_arm

	if n_arm < last_n_arm then
		n_arm = last_n_arm - n_arm
	else
		_baiyin_skip()
		return
	end

	if ID == char_current_i then
		push_zhudong_queue(table.copy(funcptr_queue), funcptr_i)
		timer.stop()
		funcptr_queue = {}
		funcptr_i = 0
		skills_xiaoji_enter(ID, n_arm)
	else
		skills_xiaoji_set(ID, n_arm, ai_judge_xiaoji(ID))
	end
end
function skills_xiaoji_enter(ID, n_arm)
	gamerun_status = "确认操作"
	jiaohu_text = "是否发动 '枭姬'?"
	gamerun_OK = false
	gamerun_OK_ptr = function()
		funcptr_queue = {}
		skills_xiaoji_set(char_current_i, n_arm, gamerun_OK)
		
		gamerun_status = ""
		funcptr_queue, funcptr_i = pop_zhudong_queue()
		--funcptr_i = funcptr_i + 1
		timer.start(0.2)
	end
	
	platform.window:invalidate()
end
function skills_xiaoji_set(ID, n_arm, gamerun_OK)
	if gamerun_OK then
		push_message(char_juese[ID].name .. "发动了武将技能 '枭姬'")
		card_fenfa({ID, 2 * n_arm, true})
	end
	jiaohu_text = ""
end

--  孙策：激昂  --
function skills_jiang(ID)
	if ID == char_current_i then
		push_zhudong_queue(table.copy(funcptr_queue), funcptr_i)
		timer.stop()
		funcptr_queue = {}
		funcptr_i = 0
		skills_jiang_enter(ID)
	else
		skills_jiang_set(ID, ai_judge_jiang(ID))
	end
end
function skills_jiang_enter(ID)

	gamerun_status = "确认操作"
	jiaohu_text = "是否发动 '激昂'?"
	gamerun_OK = false
	gamerun_OK_ptr = function()
		funcptr_queue = {}
		skills_jiang_set(char_current_i,gamerun_OK)
		
		gamerun_status = ""
		funcptr_queue, funcptr_i = pop_zhudong_queue()
		--funcptr_i = funcptr_i + 1
		timer.start(0.2)
	end
	
	platform.window:invalidate()
end
function skills_jiang_set(ID,gamerun_OK)
	if gamerun_OK then
		push_message(char_juese[ID].name .. "发动了武将技能 '激昂'")
		card_fenfa({ID, 1, true})
	end
	jiaohu_text = ""
end

--  陆逊：连营  --
function skills_lianying(ID, not_in_queue)
	if #char_juese[ID].shoupai ~= 0 then
		skills_skip_subqueue()
		return
	end

	if ID == char_current_i then
		push_zhudong_queue(table.copy(funcptr_queue), funcptr_i)
		timer.stop()
		funcptr_queue = {}
		funcptr_i = 0
		skills_lianying_enter(ID, not_in_queue)
	else
		skills_lianying_set(ID, ai_judge_lianying(ID))
		if not_in_queue then
			_lianying_shangshi_status_restore()
		end
	end
end
function skills_lianying_enter(ID, not_in_queue)
	local old_gamerun_status = gamerun_status

	gamerun_status = "确认操作"
	jiaohu_text = "是否发动 '连营'?"
	gamerun_OK = false
	gamerun_OK_ptr = function()
		funcptr_queue = {}
		skills_lianying_set(char_current_i,gamerun_OK)
		
		gamerun_status = old_gamerun_status
		set_hints("")
		funcptr_queue, funcptr_i = pop_zhudong_queue()
		--funcptr_i = funcptr_i + 1

		if not_in_queue then
			_lianying_shangshi_status_restore()
		else
			timer.start(0.2)
		end
	end
	
	platform.window:invalidate()
end
function skills_lianying_set(ID,gamerun_OK)
	if gamerun_OK then
		push_message(char_juese[ID].name .. "发动了武将技能 '连营'")
		card_fenfa({ID, 1, true})
	end
	jiaohu_text = ""
end
function _lianying_shangshi_status_restore()
	if char_acting_i == char_current_i then
		gamerun_status = ""
		jiaohu_text = "请您出牌"
	else
		gamerun_status = "AI出牌"
		jiaohu_text = ""
	end
end

--  孙策：魂姿  --
function skills_hunzi()
	push_message(char_juese[char_acting_i].name.."触发了武将技能 '魂姿'")
	
	char_juese[char_acting_i].tili_max = char_juese[char_acting_i].tili_max - 1
	char_juese[char_acting_i].tili = math.min(char_juese[char_acting_i].tili, char_juese[char_acting_i].tili_max)
	push_message(char_juese[char_acting_i].name .. "失去一点体力上限")
	
	if char_juese[char_acting_i].skill["英魂"] ~= nil then
		skill_double[char_acting_i]["英魂"] = true
	else
		char_juese[char_acting_i].skill["英魂"] = "available"
	end
	table.insert(char_juese[char_acting_i].skillname,"英魂")

	if char_juese[char_acting_i].skill["英姿"] ~= nil then
		skill_double[char_acting_i]["英姿"] = true
	else
		char_juese[char_acting_i].skill["英姿"] = "available"
	end
	table.insert(char_juese[char_acting_i].skillname,"英姿")

	char_juese[char_acting_i].skill["魂姿"] = "locked_whole_game"
end

--  太史慈：天义  --
function skills_tianyi_ai(ID_s, ID_mubiao, chosen_pindian_card_id)	--  AI发动天义
	if #char_juese[ID_s].shoupai == 0 or #char_juese[ID_mubiao].shoupai == 0 then
		return false
	end

	local win = function(s_win, mubiao_win)
		if ID_s == char_current_i or ID_mubiao == char_current_i then
			skills_cs()
		end
		char_juese[ID_s].skill["天义"] = "locked"
		skills_tianyi_set(s_win)
	end

	add_funcptr(push_message, char_juese[ID_s].name .. "发动了武将技能 '天义'")
	add_funcptr(push_message, table.concat({char_juese[ID_s].name, "与", char_juese[ID_mubiao].name, "进行拼点"}))
	add_funcptr(card_pindian, {ID_s, ID_mubiao, win, false, chosen_pindian_card_id})
	add_funcptr(_quhu_sub2)
	timer.start(0.6)

	return true
end
function skills_tianyi_enter()	--  己方发动天义
	if #char_juese[char_current_i].shoupai == 0 then return false end

	skills_enter("请选择目标", "", "天义", "技能选择-目标")
	gamerun_select_target("init")
	gamerun_OK_ptr = function()
		if #char_juese[gamerun_target_selected].shoupai == 0 then return false end

		gamerun_status = "手牌生效中"
		set_hints("")
		skills_cs()

		local win_fp = function(s_win, mubiao_win)
			char_juese[char_current_i].skill["天义"] = "locked"
			skills_tianyi_set(s_win)
			skills_cs()
		end

		funcptr_queue = {}
		funcptr_i = 0

		add_funcptr(push_message, char_juese[char_current_i].name .. "发动了武将技能 '天义'")
		add_funcptr(push_message, table.concat({char_juese[char_current_i].name, "与", char_juese[gamerun_target_selected].name, "进行拼点"}))
		add_funcptr(card_pindian, {char_current_i, gamerun_target_selected, win_fp, false})
		add_funcptr(_quhu_sub2)
		timer.start(0.6)
	end
	return true
end
function skills_tianyi_set(win)
	if win then
		char_sha_time = char_sha_time + 1
		char_distance_infinity = true
		char_sha_add_target_able = true
		char_sha_additional_target = 1
	else
		char_sha_able = false
	end
end

--  孙坚：英魂  --
function skills_yinghun(ID)
	if ID == char_current_i then
		skills_yinghun_enter(ID)
	else
		skills_yinghun_ai(ID)
	end
end
function skills_yinghun_ai(ID)
	local yinghun_choice, yinghun_mubiao = ai_judge_yinghun(ID)
	if yinghun_choice == 3 then
		skills_skip_subqueue()
		return
	end

	skills_push_queue()
	if yinghun_choice == 1 then
		push_message(char_juese[ID].name .. "发动了武将技能 '英魂'")
		add_funcptr(push_message, table.concat({char_juese[ID].name, "令", char_juese[yinghun_mubiao].name, "摸1张牌并弃", char_juese[ID].tili_max - char_juese[ID].tili, "张牌"}))
		is_drawx = false
	elseif yinghun_choice == 2 then
		push_message(char_juese[ID].name .. "发动了武将技能 '英魂'")
		add_funcptr(push_message, table.concat({char_juese[ID].name, "令", char_juese[yinghun_mubiao].name, "摸", char_juese[ID].tili_max - char_juese[ID].tili, "张牌并弃1张牌"}))
		is_drawx = true
	end

	_yinghun_exe(is_drawx, ID, yinghun_mubiao)
	timer.start(0.6)
end
function skills_yinghun_enter(ID)
	skills_push_queue()

	gamerun_status = "选项选择"
	choose_name = "英魂"
	jiaohu_text = "是否令其他角色摸牌弃牌?"
	choose_option = {"摸1弃"..(char_juese[char_current_i].tili_max-char_juese[char_current_i].tili),"摸"..(char_juese[char_current_i].tili_max-char_juese[char_current_i].tili).."弃1","不发动"}

	txt_messages:setVisible(false)
	gamerun_guankan_selected = 1
	item_disrow = 0

	gamerun_item = function(i)
		txt_messages:setVisible(true)
		if i == 1 then
			push_message(char_juese[char_current_i].name .. "发动了武将技能 '英魂'")
			is_drawx = false
		elseif i == 2 then
			push_message(char_juese[char_current_i].name .. "发动了武将技能 '英魂'")
			is_drawx = true
		else
			set_hints("")
			gamerun_status = ""

			skills_pop_queue(true)
			timer.start(0.6)
			return
		end
				
		if is_drawx ~= nil then
			skills_enter("请选择目标", "", "英魂", "技能选择-目标")
			gamerun_select_target("init")
			gamerun_OK = false

			gamerun_OK_ptr = function()
				if gamerun_OK then
					funcptr_queue = {}
					funcptr_i = 0

					if i == 1 then
						push_message(table.concat({char_juese[char_current_i].name, "令", char_juese[gamerun_target_selected].name, "摸1张牌并弃", char_juese[char_current_i].tili_max - char_juese[char_current_i].tili, "张牌"}))
					elseif i == 2 then
						push_message(table.concat({char_juese[char_current_i].name, "令", char_juese[gamerun_target_selected].name, "摸", char_juese[char_current_i].tili_max - char_juese[char_current_i].tili, "张牌并弃1张牌"}))
					end

					_yinghun_exe(is_drawx, char_current_i, gamerun_target_selected)
					timer.start(0.6)
				end
			end

			platform.window:invalidate()
		end
	end

	platform.window:invalidate()
end
function _yinghun_exe(is_drawx, ID_s, ID_mubiao)
	if is_drawx then
		add_funcptr(card_fenfa, {ID_mubiao, char_juese[ID_s].tili_max - char_juese[ID_s].tili, true})
		if ID_mubiao == char_current_i then
			add_funcptr(_yinghun_qipai_enter, 1)
		else
			add_funcptr(_yinghun_qipai_ai, {ID_s, ID_mubiao, 1})
		end
	else
		add_funcptr(card_fenfa, {ID_mubiao, 1, true})
		if ID_mubiao == char_current_i then
			add_funcptr(_yinghun_qipai_enter, char_juese[ID_s].tili_max - char_juese[ID_s].tili)
		else
			add_funcptr(_yinghun_qipai_ai, {ID_s, ID_mubiao, char_juese[ID_s].tili_max - char_juese[ID_s].tili})
		end
	end
	skills_losecard(ID_mubiao)

	is_drawx = nil
	set_hints("")
	gamerun_status = ""
	
	add_funcptr(skills_pop_queue)
end
function _yinghun_qipai_ai(va_list)
	local ID_s, ID_mubiao, x
	ID_s = va_list[1]; ID_mubiao = va_list[2]; x = va_list[3]
	
	skills_push_queue()

	local qipai_id, qi_zhuangbei_id
	qipai_id, qi_zhuangbei_id = ai_judge_withdraw(ID_mubiao, x, true)

	ai_withdraw(ID_mubiao, qipai_id, qi_zhuangbei_id, true)
	add_funcptr(skills_pop_queue)

	skills_skip_subqueue()
	timer.start(0.6)
end
function _yinghun_qipai_enter(x)
	skills_push_queue()

	local n_cards = ai_card_stat(char_current_i, true, false)
	if n_cards < x then
		if n_cards > 0 then
			card_qipai_all(char_current_i, false)
			skills_losecard(char_current_i)
		end

		add_funcptr(skills_pop_queue)
		skills_skip_subqueue()
		timer.start(0.6)
		return
	end

	gamerun_wuqi_into_hand(char_current_i)
	skills_enter("您须弃" .. tostring(x) .. "张牌", "", "英魂", "技能选择-多牌")
	gamerun_OK_ptr = function()
		if gamerun_OK == true and table.getn2(card_selected) == x then
			gamerun_status = ""
			set_hints("")

			card_qipai_go(char_current_i)
			card_selected = {}
			card_highlighted = 1

			add_funcptr(gamerun_wuqi_out_hand_queued)
			add_funcptr(skills_pop_queue)
			timer.start(0.6)
		end
	end
end
function _yinghun_huifu()
	funcptr_queue, funcptr_i = pop_zhudong_queue()
end

--  吴国太：补益  --
function skills_buyi(va_list)
	local ID_s, ID_mubiao
	ID_s = va_list[1]
	ID_mubiao = va_list[2]
	
	if char_juese[ID_mubiao].tili > 0 then
		skills_skip_subqueue()
		return
	end
	
	if ai_card_stat(ID_mubiao, true, true) == 0 then
		skills_skip_subqueue()
		return
	end

	skills_push_queue()

	if ID_s == char_current_i then
		buyi_gamerun_status = gamerun_status
		skills_buyi_enter(ID_mubiao)
	else
		skills_buyi_ai(ID_s,ID_mubiao)
	end
end
function skills_buyi_enter(ID_mubiao)
	local old_gamerun_status = gamerun_status
	gamerun_status = "确认操作"
	jiaohu_text = "是否发动 '补益'?"
	gamerun_OK = false
	
	gamerun_OK_ptr = function()
		gamerun_status = old_gamerun_status; set_hints("")
		funcptr_queue = {}
	
		if gamerun_OK then
			push_message(char_juese[ID_mubiao].name .. "发动了武将技能 '补益'")
			if char_current_i ~= ID_mubiao then
				local card_number = math.random(#char_juese[ID_mubiao].shoupai)
				_buyi_exe({char_current_i, ID_mubiao, card_number})
				add_funcptr(skills_pop_queue)
				timer.start(0.6)
			else
				gamerun_status = "主动出牌-补益"
				jiaohu_text = "请展示一张手牌"
				platform.window:invalidate()
			end
	    else
			skills_pop_queue(true)
			timer.start(0.6)
		end
		platform.window:invalidate()
	end
	platform.window:invalidate()
end
function skills_buyi_ai(ID, ID_mubiao)
	local fanmian_mubiao = ai_judge_buyi_mubiao(ID,ID_mubiao)
	
	if fanmian_mubiao ~= nil then
		push_message(char_juese[ID].name .. "发动了武将技能 '补益'")
		local card_searched, card_chosen
		if ID ~= ID_mubiao then
			card_chosen = math.random(#char_juese[ID_mubiao].shoupai)
		else
			card_searched = ai_card_search(ID, "装备", 1)
			if #card_searched == 0 then
				card_searched = ai_card_search(ID, "锦囊", 1)
			end
			if #card_searched == 0 then
				card_chosen = math.random(#char_juese[ID_mubiao].shoupai)
			else
				card_chosen = card_searched[1]
			end
		end
		_buyi_exe({ID, fanmian_mubiao, card_chosen})
	end

	add_funcptr(skills_pop_queue)
	skills_skip_subqueue()
	timer.start(0.6)
end
function _buyi_exe(va_list)
	local ID_s, ID_mubiao, ID_card
	ID_s = va_list[1]; ID_mubiao = va_list[2]; ID_card = va_list[3]

	gamerun_status = "手牌生效中"
	set_hints("")

	local card = table.copy(char_juese[ID_mubiao].shoupai[ID_card])
	add_funcptr(_nanman_send_msg, {char_juese[ID_mubiao].name, "展示了'", card[2], card[3], "的", card[1], "'"})
	if card[1] ~= "杀" and card[1] ~= "火杀" and card[1] ~= "雷杀" and card[1] ~= "闪" and card[1] ~= "桃" and card[1] ~= "酒" then
		add_funcptr(_nanman_send_msg, {char_juese[ID_mubiao].name, "弃置了'", card[2], card[3], "的", card[1], "'"})
		card_shanchu({ID_mubiao, ID_card})
		char_tili_huifu(ID_mubiao, 1)
	end
end

--  周瑜：英姿  --
function skills_yingzi(ID)
	if game_skip_mopai == true then
		return
	end

	if ID == char_current_i then
		push_zhudong_queue(table.copy(funcptr_queue), funcptr_i)
		timer.stop()
		funcptr_queue = {}
		funcptr_i = 0
		skills_yingzi_enter(ID)
	else
		skills_yingzi_set(ID, ai_judge_yingzi(ID))
	end
end
function skills_yingzi_enter(ID)

	gamerun_status = "确认操作"
	jiaohu_text = "是否发动 '英姿'?"
	gamerun_OK = false
	gamerun_OK_ptr = function()
		funcptr_queue = {}
		skills_yingzi_set(char_current_i,gamerun_OK)
		
		gamerun_status = ""
		funcptr_queue, funcptr_i = pop_zhudong_queue()
		--funcptr_i = funcptr_i + 1
		timer.start(0.2)
	end
	
	platform.window:invalidate()
end
function skills_yingzi_set(ID,gamerun_OK)
	if gamerun_OK then
		push_message(char_juese[ID].name .. "发动了武将技能 '英姿' 多摸了一张牌")
		char_yingzi = true
	end
	jiaohu_text = ""
end

--  吕蒙：克己  --
function skills_keji(ID)
	funcptr_queue = {}
	funcptr_i = 0
	if ID == char_current_i then
		skills_keji_enter(ID)
	else
		skills_keji_set(ID, ai_judge_keji(ID))
	end
end
function skills_keji_enter(ID)
	gamerun_status = "确认操作"
	jiaohu_text = "是否发动 '克己'?"
	gamerun_OK = false
	gamerun_OK_ptr = function()
		funcptr_queue = {}
		skills_keji_set(char_current_i,gamerun_OK)
	end
	
	platform.window:invalidate()
end
function skills_keji_set(ID,gamerun_OK)
	if gamerun_OK then
		push_message(char_juese[ID].name .. "发动了武将技能 '克己'")
		set_hints("")
		gamerun_huihe_jieshu(true)
		timer.start(0.2)
	else
		gamerun_huihe_set("弃牌")
		if ID == char_current_i then
			gamerun_enter_qipai()
		else
			_ai_qipai_exe(ID)
			timer.start(0.2)
		end
	end
end

--  甘宁：奇袭  --
function skills_qixi_enter()
	if #char_juese[char_current_i].shoupai == 0 and ai_arm_stat(char_current_i) == 0 then return false end

	gamerun_wuqi_into_hand(char_current_i)
	skills_enter("请选择黑色手牌", "使用过河拆桥", "过河拆桥", "技能选择-单牌")
	
	gamerun_OK_ptr = function()
		skills_qixi(char_current_i)
	end
	
	gamerun_tab_ptr = function()
		if skills_judge_black(char_current_i) then
			skills_enter_target()
		end
	end
	
	return true
end
function skills_qixi(ID)
	if skills_judge_black(ID) then
		funcptr_queue = {}

		if card_chai({card_highlighted}, char_current_i, gamerun_target_selected) then
			--gamerun_wuqi_out_hand(char_current_i)
			skills_cs()
		    consent_func_queue(0.2)
		end
	end
end

--  黄盖：苦肉  --
function skills_kurou_enter()
	skill_text_1 = "按'确定'发动苦肉"
	
	set_hints(skill_text_1)
	gamerun_status = "确认操作"
	
	gamerun_OK_ptr = function()
		if gamerun_OK then
			skills_kurou(char_current_i)
			skills_cs()
		    consent_func_queue(0.6)
		end
	end
	
	return true
end
function skills_kurou(ID)
	funcptr_queue = {}
	add_funcptr(_kurou_sub1, ID)
	char_tili_deduct({1, ID, -1, "流失", ID})
	add_funcptr(card_fenfa, {ID, 2, true})
	add_funcptr(_kurou_sub2)
end
function _kurou_sub1(ID)
	set_hints("")
	gamerun_status = "手牌生效中"
	push_message(char_juese[ID].name .. "发动了武将技能 '苦肉'")
end
function _kurou_sub2()
	if char_acting_i == char_current_i then
		set_hints("请您出牌")
		gamerun_status = ""
	else
		set_hints("")
		gamerun_status = "AI出牌"

		ai_card_use(char_acting_i)
	end
end

--  大乔：国色  --
function skills_guose_enter()
	if #char_juese[char_current_i].shoupai == 0 and ai_arm_stat(char_current_i) == 0 then return false end

	gamerun_wuqi_into_hand(char_current_i)
	skills_enter("请选择方块牌", "使用乐不思蜀", "乐不思蜀", "技能选择-单牌")
	
	gamerun_OK_ptr = function()
		skills_guose(char_current_i)
	end
	
	gamerun_tab_ptr = function()
		if skills_judge_huase(char_current_i, "方块") then
			skills_enter_target()
		end
	end
	
	return true
end
function skills_guose(ID)
	if skills_judge_huase(ID, "方块") then
		funcptr_queue = {}
		if card_le({card_highlighted, char_current_i, gamerun_target_selected}) then
			gamerun_wuqi_out_hand(char_current_i)
			skills_cs()
			skills_rst()
		end
	end
end

--  孙尚香：结姻  --
function skills_jieyin_ai(ID_s, ID_mubiao, ID_shoupai)
	if skills_judge_jieyin_2(ID_mubiao) == false or #ID_shoupai ~= 2 then
		return false
	end

	skills_jieyin(ID_s, ID_mubiao, ID_shoupai)
	return true
end
function skills_jieyin_enter()
	if #char_juese[char_current_i].shoupai == 0 then return false end
	
	skills_enter("请选择两张牌", "请选择受伤男性", "结姻", "技能选择-多牌")
	
	gamerun_OK_ptr = function()
		local card_i = skills_get_selected_shoupai()
		if skills_jieyin(char_current_i, gamerun_target_selected, card_i) then
			skills_cs()
			consent_func_queue(0.6)
		end
	end
	
	gamerun_tab_ptr = function()
		if skills_judge_jieyin_1() then
			skills_enter_target()
		end
	end
	
	return true
end
function skills_judge_jieyin_1()
	local i
	
	if table.getn2(card_selected) == 2 then
		return true
	end
	return false
end
function skills_judge_jieyin_2(ID_mubiao)
	if char_juese[ID_mubiao].xingbie == "男" and char_juese[ID_mubiao].tili < char_juese[ID_mubiao].tili_max then
		return true
	end
	return false
end
function skills_jieyin(ID_s, ID_mubiao, ID_shoupai)
	if ID_s == char_current_i and skills_judge_jieyin_1() == false then
		return false
	end
	if skills_judge_jieyin_2(ID_mubiao) == false then
		return false
	end

	funcptr_queue = {}
	
	add_funcptr(_jieyin_sub1, ID_s)
	for i = #ID_shoupai, 1, -1 do
		add_funcptr(_jieyin_sub2, {ID_s, ID_shoupai[i]})
	end
	skills_losecard(ID_s)

	if char_juese[ID_s].tili < char_juese[ID_s].tili_max then
		char_tili_huifu(ID_s, 1)
	end
	char_tili_huifu(ID_mubiao, 1)
	add_funcptr(_fanjian_sub4)

	return true
end
function _jieyin_sub1(ID_s)
	set_hints("")
	gamerun_status = "手牌生效中"
	
	push_message(char_juese[ID_s].name .. "发动了武将技能 '结姻'")
	char_juese[ID_s].skill["结姻"] = "locked"
end
function _jieyin_sub2(va_list)
	local ID_s, ID_shoupai
	ID_s = va_list[1]; ID_shoupai = va_list[2]

	local card = char_juese[ID_s].shoupai[ID_shoupai]
	push_message(table.concat({char_juese[ID_s].name, "弃掉了'", card[2], card[3], "的", card[1], "'"}))
	card_shanchu({ID_s, ID_shoupai})
end

--  张昭张纮：直谏  --
function skills_zhijian_ai(ID_s, ID_mubiao, ID_shoupai)
	if skills_judge_zhijian_1(ID_s, ID_shoupai) == false or skills_judge_zhijian_2(ID_shoupai, ID_s, ID_mubiao) == false then
		return false
	end

	skills_zhijian(ID_s, ID_shoupai, ID_mubiao)
	return true
end
function skills_zhijian_enter()
	if #char_juese[char_current_i].shoupai == 0 then return false end
	
	skills_enter("请选择装备牌", "请选择目标", "直谏", "技能选择-单牌")
	
	gamerun_OK_ptr = function()
		if table.getn2(card_selected) == 0 then
			return
		end

		if skills_zhijian(char_current_i, card_highlighted, gamerun_target_selected) then
			skills_cs()
			consent_func_queue(0.6)
		end
	end
	
	gamerun_tab_ptr = function()
		if skills_judge_zhijian_1(char_current_i, card_highlighted) then
			skills_enter_target()
		end
	end
	
	return true
end
function skills_judge_zhijian_1(ID_s, ID_shoupai)
	local card = char_juese[ID_s].shoupai[ID_shoupai]
	
	if card_get_leixing(card[1]) == "武器" or card_get_leixing(card[1]) == "防具" or card_get_leixing(card[1]) == "+1马" or card_get_leixing(card[1]) == "-1马" then
		return true
	end
	return false
end
function skills_judge_zhijian_2(ID_shoupai, ID_s, ID_mubiao)
	if card_get_leixing(char_juese[ID_s].shoupai[ID_shoupai][1]) == "武器" and #char_juese[ID_mubiao].wuqi ~= 0 then
		return false
	end
	
	if card_get_leixing(char_juese[ID_s].shoupai[ID_shoupai][1]) == "防具" and #char_juese[ID_mubiao].fangju ~= 0 then
		return false
	end
	
	if card_get_leixing(char_juese[ID_s].shoupai[ID_shoupai][1]) == "+1马" and #char_juese[ID_mubiao].fangma ~= 0 then
		return false
	end
	
	if card_get_leixing(char_juese[ID_s].shoupai[ID_shoupai][1]) == "-1马" and #char_juese[ID_mubiao].gongma ~= 0 then
		return false
	end
end
function skills_zhijian(ID_s, ID_shoupai, ID_mubiao)
	if skills_judge_zhijian_2(ID_shoupai, ID_s, ID_mubiao) == false then return false end
	
	funcptr_queue = {}
	add_funcptr(_zhijian_sub1, ID_s)
	add_funcptr(_zhijian_sub2, {ID_shoupai, ID_s, ID_mubiao})
	skills_losecard(ID_s)

	add_funcptr(card_fenfa, {ID_s, 1, true})
	add_funcptr(skills_rst)
	return true
end
function _zhijian_sub1(ID_s)
	gamerun_status = "手牌生效中"
	set_hints("")
	push_message(char_juese[ID_s].name.."发动了武将技能 '直谏'")
end
function _zhijian_sub2(va_list)
	local ID_shoupai, ID_s, ID_mubiao
	ID_shoupai = va_list[1]; ID_s = va_list[2]; ID_mubiao = va_list[3]
	
	local card = char_juese[ID_s].shoupai[ID_shoupai]
	
	push_message(table.concat({char_juese[ID_s].name.."将装备 '", card[1], "' 交给", char_juese[ID_mubiao].name}))
	
	if card_get_leixing(card[1]) == "武器" then
		char_juese[ID_mubiao].wuqi = card
	end
	
	if card_get_leixing(card[1]) == "防具" then
		card_arm_fangju(ID_mubiao, card)
	end
	
	if card_get_leixing(card[1]) == "+1马" then
		char_juese[ID_mubiao].fangma = card
	end
	
	if card_get_leixing(card[1]) == "-1马" then
		char_juese[ID_mubiao].gongma = card
	end
	card_remove({ID_s, ID_shoupai})
end

--  孙权：制衡  --
function skills_zhiheng_ai(ID_s, ID_shoupai, zhuangbei_list)
	local n_cards = #ID_shoupai
	for i = 1, #zhuangbei_list do
		if zhuangbei_list[i] == 1 then
			n_cards = n_cards + 1
		end
	end
	
	if n_cards == 0 then
		return false
	end

	add_funcptr(_zhiheng_sub1, ID_s)
	ai_withdraw(ID_s, ID_shoupai, zhuangbei_list, true)
	skills_losecard(ID_s)

	char_juese[ID_s].skill["制衡"] = "locked"
	add_funcptr(card_fenfa, {ID_s, n_cards, true})
	add_funcptr(_zhiheng_sub2)
	
	return true
end
function skills_zhiheng_enter()
	gamerun_wuqi_into_hand(char_current_i)
	if table.getn2(char_juese[char_current_i].shoupai) == 0 then
		gamerun_wuqi_out_hand(char_current_i)
		return false
	end

	skills_enter("请选择手牌", "", "制衡", "技能选择-多牌")
	
	gamerun_OK_ptr = function()
		if skills_zhiheng(char_current_i) then
			gamerun_wuqi_out_hand(char_current_i)
			skills_cs()
			consent_func_queue(0.2)
		end
	end
	
	gamerun_tab_ptr = function() end
	
	return true
end
function skills_zhiheng(ID)
	local cards = table.getn2(card_selected)
	if cards == 0 then return false end
	
	funcptr_queue = {}
	add_funcptr(_zhiheng_sub1, ID)
	card_qipai_go()
	skills_losecard(ID)

	char_juese[ID].skill["制衡"] = "locked"
	add_funcptr(card_fenfa, {ID, cards, true})
	add_funcptr(_zhiheng_sub2)
	
	return true
end
function _zhiheng_sub1(ID)
	set_hints("")
	gamerun_status = "手牌生效中"
	push_message(char_juese[ID].name.."发动了武将技能 '制衡'")
end
function _zhiheng_sub2()
	if char_acting_i == char_current_i then
		gamerun_wuqi_out_hand(char_current_i)
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

--  周瑜：反间  --
function skills_fanjian_ai(ID_s, ID_mubiao)
	if #char_juese[ID_s].shoupai == 0 then
		return false
	end

	if ID_mubiao == char_current_i then
		add_funcptr(_fanjian_zhudong_enter, {ID_s, ID_mubiao})
	else
		skills_fanjian(ID_s, ID_mubiao, math.random(1, 4))
	end

	return true
end
function _fanjian_zhudong_enter(va_list)
	local ID_s, ID_mubiao
	ID_s = va_list[1]; ID_mubiao = va_list[2]

	gamerun_status = "选项选择"
	choose_name = "反间"
	jiaohu_text = table.concat({char_juese[ID_s].name, "对您发动反间，请选择花色"})
	choose_option = {"方块", "红桃", "草花", "黑桃"}
	txt_messages:setVisible(false)
	gamerun_guankan_selected = 1
	item_disrow = 0

	gamerun_item = function(i)
		txt_messages:setVisible(true)
		gamerun_status = "手牌生效中"
		jiaohu_text = ""
		
		funcptr_queue = {}
		funcptr_i = 0

		skills_fanjian(ID_s, ID_mubiao, i)
		timer.start(0.6)
	end

	platform.window:invalidate()
end
function skills_fanjian_enter()
	if #char_juese[char_current_i].shoupai == 0 then return false end
	skills_enter("请选择目标", "", "反间", "技能选择-目标")
	gamerun_select_target("init")
	
	gamerun_OK_ptr = function()
		if skills_fanjian(char_current_i, gamerun_target_selected, math.random(1, 4)) then
			skills_cs()
			consent_func_queue(0.6)
		end
	end
	
	return true
end
function skills_fanjian(ID_s, ID_mubiao, huase)
	funcptr_queue = {}
	add_funcptr(_fanjian_sub1, {ID_s, ID_mubiao})
	char_juese[ID_s].skill["反间"] = "locked"
	fanjian_huase = huase
	if fanjian_huase == 1 then
		add_funcptr(push_message, table.concat({char_juese[ID_mubiao].name, "选择了方块"}))
	elseif fanjian_huase == 2 then
		add_funcptr(push_message, table.concat({char_juese[ID_mubiao].name, "选择了红桃"}))
	elseif fanjian_huase == 3 then
		add_funcptr(push_message, table.concat({char_juese[ID_mubiao].name, "选择了草花"}))
	elseif fanjian_huase == 4 then
		add_funcptr(push_message, table.concat({char_juese[ID_mubiao].name, "选择了黑桃"}))
	end
	_fanjian_sub2(ID_s, ID_mubiao)
	add_funcptr(_fanjian_sub4)
	return true
end
function _fanjian_sub1(va_list)
	local ID_s, ID_mubiao
	ID_s = va_list[1]; ID_mubiao = va_list[2]

	set_hints("")
	gamerun_status = "手牌生效中"
	push_message(table.concat({char_juese[ID_s].name, "发动了武将技能 '反间' (对", char_juese[ID_mubiao].name, ")"}))
end
function _fanjian_sub2(ID_s, ID_mubiao)
	local t, card
	
	t = math.random(#char_juese[ID_s].shoupai)
	card = char_juese[ID_s].shoupai[t]
	
	add_funcptr(_fanjian_sub3, {ID_s, ID_mubiao, t})
	skills_losecard(ID_s)

	if (card[2] ~= "方块" and fanjian_huase == 1) or (card[2] ~= "红桃" and fanjian_huase == 2) or (card[2] ~= "草花" and fanjian_huase == 3) or (card[2] ~= "黑桃" and fanjian_huase == 4) then
		char_tili_deduct({1, ID_mubiao, ID_s, "普通", ID_mubiao})
	end
end
function _fanjian_sub3(va_list)
	local ID_s, ID_mubiao, t, card
	ID_s = va_list[1]; ID_mubiao = va_list[2]; t = va_list[3]
	card = char_juese[ID_s].shoupai[t]
	
	push_message(table.concat({char_juese[ID_mubiao].name, "获得了 '", card[2], card[3], "的", card[1], "'"}))
	
	card_insert(ID_mubiao, card)
	card_remove({ID_s, t})
end
function _fanjian_sub4()
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

--  鲁肃：缔盟  --
function skills_dimeng_enter()
	if #char_juese[char_current_i].shoupai == 0 and ai_arm_stat(char_current_i) == 0 then return false end

	gamerun_wuqi_into_hand(char_current_i)
	skills_enter("请选择手牌并按 '确定'", "请选择目标A", "缔盟", "技能选择-多牌")
	
	gamerun_OK_ptr = function()
		if gamerun_status == "技能选择-目标" then
			--  进入阶段2  --
			guankan_s = gamerun_target_selected
			set_hints("请选择目标B")
			gamerun_status = "技能选择-目标B"
			gamerun_select_target("init")
			platform.window:invalidate()
			return
		end
		
		if gamerun_status == "技能选择-目标B" then
			if skills_dimeng(guankan_s, gamerun_target_selected) then
				skills_cs_2()
				consent_func_queue(0.6)
			end
		end
		
		if gamerun_status == "技能选择-多牌" then
			skills_enter_target()
		end
	end
	
	gamerun_tab_ptr = function() end
	
	return true
end
function skills_dimeng_ai(ID_shoupai, ID_s, ID_first, ID_second)
	if #ID_shoupai ~= math.abs(#char_juese[ID_first].shoupai - #char_juese[ID_second].shoupai) then
		return false
	end

	set_hints("")
	gamerun_status = "手牌生效中"

	ai_withdraw(ID_s, ID_shoupai, {0, 0, 0, 0, 0}, true)
	_dimeng_exe(ID_s, ID_first, ID_second)
	return true
end
function skills_dimeng(ID_first, ID_second)
	if table.getn2(card_selected) ~= math.abs(#char_juese[ID_first].shoupai - #char_juese[ID_second].shoupai) then
		return false
	end
	
	funcptr_queue = {}
	set_hints("")
	gamerun_status = "手牌生效中"

	if table.getn2(card_selected) > 0 then
		card_qipai_go()
		skills_losecard(char_current_i)
	end

	_dimeng_exe(char_current_i, ID_first, ID_second)
	return true
end
function _dimeng_exe(ID_s, ID_first, ID_second)
	add_funcptr(push_message, char_juese[ID_s].name.."发动了武将技能 '缔盟'")
	char_juese[ID_s].skill["缔盟"] = "locked"

	add_funcptr(_dimeng_sub1, {ID_s, ID_first, ID_second})
	add_funcptr(_dimeng_lose_shoupai_1, ID_first)
	skills_losecard(ID_first)
	add_funcptr(_dimeng_lose_shoupai_2, ID_second)
	skills_losecard(ID_second)
	add_funcptr(_dimeng_exchange_shoupai, {ID_first, ID_second})
	add_funcptr(_dimeng_sub2)
end
function _dimeng_sub1(va_list)
	local ID_s, ID_first, ID_second
	ID_s = va_list[1]; ID_first = va_list[2]; ID_second = va_list[3]

	gamerun_wuqi_out_hand(char_current_i)
	push_message(table.concat({char_juese[ID_s].name, "令", char_juese[ID_first].name, "和", char_juese[ID_second].name, "交换手牌"}))
end
function _dimeng_sub2()
	dimeng_shoupai_1 = nil
	dimeng_shoupai_2 = nil

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
function _dimeng_lose_shoupai_1(ID)
	--push_message(table.concat({char_juese[ID].name, "失去了所有手牌"}))
	dimeng_shoupai_1 = table.copy(char_juese[ID].shoupai)
	char_juese[ID].shoupai = {}

	skills_skip_subqueue()
end
function _dimeng_lose_shoupai_2(ID)
	--push_message(table.concat({char_juese[ID].name, "失去了所有手牌"}))
	dimeng_shoupai_2 = table.copy(char_juese[ID].shoupai)
	char_juese[ID].shoupai = {}

	skills_skip_subqueue()
end
function _dimeng_exchange_shoupai(va_list)
	local ID_first, ID_second
	ID_first = va_list[1]; ID_second = va_list[2]

	--push_message(table.concat({char_juese[ID_first].name, "获得了", char_juese[ID_second].name, "的所有手牌"}))
	for i = 1, #dimeng_shoupai_2 do
		card_insert(ID_first, dimeng_shoupai_2[i])
	end

	--push_message(table.concat({char_juese[ID_second].name, "获得了", char_juese[ID_first].name, "的所有手牌"}))
	for i = 1, #dimeng_shoupai_1 do
		card_insert(ID_second, dimeng_shoupai_1[i])
	end

	skills_skip_subqueue()
end

--  鲁肃：好施  --
function skills_judge_haoshi(ID_mubiao)
	for i = 1, 5 do
		if char_juese[i].siwang == false and #char_juese[i].shoupai < #char_juese[ID_mubiao].shoupai then
			return false
		end
	end
	return true
end
function skills_haoshi_stage_1(ID)
	if game_skip_mopai == true then
		char_haoshi = false
		return
	end

	if ID == char_current_i then
		skills_haoshi_stage_1_enter()
	else
		local choice = ai_judge_haoshi(ID)
		if choice == 1 then
			push_message(char_juese[ID].name .. "发动了武将技能 '好施'")
			char_haoshi = true
		else
			char_haoshi = false
		end
	end
end
function skills_haoshi_stage_1_enter()
	push_zhudong_queue(table.copy(funcptr_queue), funcptr_i)
	timer.stop()
	funcptr_queue = {}
	funcptr_i = 0

	gamerun_status = "选项选择"
	choose_name = "好施"
	jiaohu_text = "是否发动 '好施' 多摸两张牌?"
	choose_option = {"是", "否"}

	txt_messages:setVisible(false)
	gamerun_guankan_selected = 1
	item_disrow = 0
	
	gamerun_item = function(i)
		txt_messages:setVisible(true)
		set_hints("")

		if i == 1 then
			char_haoshi = true
			push_message(char_juese[char_current_i].name .. "发动了武将技能 '好施'")
		else
			char_haoshi = false
		end
		
		gamerun_status = ""
		_haoshi_huifu()
		--funcptr_i = funcptr_i + 1
		timer.start(0.2)
	end

	platform.window:invalidate()
end
function skills_haoshi_stage_2(ID)
	if char_haoshi == false then
		return
	end
	char_haoshi = false

	if #char_juese[ID].shoupai <= 5 then
		return
	end

	if ID == char_current_i then
		skills_haoshi_stage_2_enter()
	else
		local n_geipai = math.floor(#char_juese[ID].shoupai / 2)
		local ID_shoupai, targets
		ID_shoupai, _ = ai_judge_withdraw(ID, n_geipai, true)

		targets = ai_judge_haoshi_mubiao(ID, #char_juese[ID].shoupai, true)
		if #targets == 0 then
			--  ai_judge_haoshi已经排除零目标的情况，不可能！  --
			targets = {ID}
		end

		_haoshi_exe({ID, targets[1], ID_shoupai})
	end
end
function skills_haoshi_stage_2_enter()
	push_zhudong_queue(table.copy(funcptr_queue), funcptr_i)
	timer.stop()
	funcptr_queue = {}
	funcptr_i = 0

	local n_geipai = math.floor(#char_juese[char_current_i].shoupai / 2)

	skills_enter("您需给出" .. tostring(n_geipai) .. "张牌", "", "好施", "技能选择-多牌")
	gamerun_OK = false
	gamerun_tab_ptr = nil

	gamerun_OK_ptr = function()
		if gamerun_OK == true then
			if table.getn2(card_selected) ~= n_geipai then
				return
			end

			local card_i = skills_get_selected_shoupai()
			skills_haoshi_stage_2_target(card_i)
		end
	end
end
function skills_haoshi_stage_2_target(ID_shoupai)
	skills_enter("请选择目标", "", "好施", "技能选择-目标B")
	gamerun_OK = false
	gamerun_select_target("init")
	guankan_s = char_current_i

	gamerun_OK_ptr = function()
		if gamerun_OK == true and skills_judge_haoshi(gamerun_target_selected) then
			set_hints("")
			gamerun_status = ""

			add_funcptr(_haoshi_exe, {char_current_i, gamerun_target_selected, ID_shoupai})
			add_funcptr(_haoshi_huifu)
			timer.start(0.2)
		end
	end
end
function _haoshi_exe(va_list)
	local ID_s, ID_mubiao, ID_shoupai
	ID_s = va_list[1]; ID_mubiao = va_list[2]; ID_shoupai = va_list[3]

	for i = #ID_shoupai, 1, -1 do
		card_insert(ID_mubiao, char_juese[ID_s].shoupai[ID_shoupai[i]])
		card_remove({ID_s, ID_shoupai[i]})
	end
	
	push_message(table.concat({char_juese[ID_s].name, "将", tostring(#ID_shoupai), "张手牌交给", char_juese[ID_mubiao].name}))
end
function _haoshi_huifu()
	funcptr_queue, funcptr_i = pop_zhudong_queue()
end

--  小乔：天香  --
function skills_tianxiang()
	local deduct_va = deduct_va_stack[#deduct_va_stack]
	local ID, dianshu, shuxing
	dianshu = deduct_va[1]; ID = deduct_va[2]; shuxing = deduct_va[4]
	dianshu = _deduct_count(deduct_va)

	if ID == char_current_i then
		skills_tianxiang_enter(dianshu, shuxing)
	else
		skills_tianxiang_ai(ID, dianshu, shuxing)
	end
end
function skills_tianxiang_ai(ID, dianshu, shuxing)
	local fadong, ID_shoupai, ID_mubiao
	fadong, ID_shoupai, ID_mubiao = ai_judge_tianxiang(ID, dianshu, shuxing)

	if fadong == false then
		skills_skip_subqueue()
		return
	end

	skills_push_queue()
	_tianxiang_exe(ID_shoupai, ID, ID_mubiao, dianshu)
end
function skills_tianxiang_enter(dianshu, shuxing)
	push_zhudong_queue(table.copy(funcptr_queue), funcptr_i)
	timer.stop()
	funcptr_queue = {}
	funcptr_i = 0

	local old_gamerun_status = gamerun_status
	tianxiang_gamerun_status = gamerun_status

	gamerun_status = "选项选择"
	choose_name = "天香"
	jiaohu_text = table.concat({"是否转移", dianshu, "点", shuxing, "属性伤害?"})
	choose_option = {"是", "否"}

	txt_messages:setVisible(false)
	gamerun_guankan_selected = 1
	item_disrow = 0
	
	gamerun_item = function(i)
		txt_messages:setVisible(true)
		set_hints("")

		if i == 1 then
			_tianxiang_select_target(dianshu, shuxing, old_gamerun_status)
		else
			gamerun_status = old_gamerun_status
			skills_pop_queue(true)
			timer.start(0.6)
		end
	end

	platform.window:invalidate()
end
function _tianxiang_select_target(dianshu, shuxing, old_gamerun_status)
	skills_enter("请选择红桃牌", "请选择目标", "天香", "技能选择-单牌")
	gamerun_OK_ptr = function()
		if gamerun_status == "技能选择-目标" then
			if gamerun_OK == true then
				if table.getn2(card_selected) == 1 then
					local yanse, huase, dianshu = ai_judge_cardinfo(char_current_i, {char_juese[char_current_i].shoupai[card_highlighted]})
					if huase == "红桃" then
						_tianxiang_exe(card_highlighted, char_current_i, gamerun_target_selected, dianshu)
					end
				end
			end
			return
		end
		
		if gamerun_status == "技能选择-单牌" then
			if gamerun_OK == false then
				gamerun_status = old_gamerun_status
				set_hints("")
				skills_pop_queue(true)
				timer.start(0.6)
			end
			return
		end
	end
	
	gamerun_tab_ptr = function()
		if table.getn2(card_selected) == 1 then
			local yanse, huase, dianshu = ai_judge_cardinfo(char_current_i, {char_juese[char_current_i].shoupai[card_highlighted]})
			if huase == "红桃" then
				skills_enter_target()
			end
		end
	end
end
function _tianxiang_exe(ID_shoupai, ID, ID_mubiao, dianshu)
	gamerun_status = "手牌生效中"
	set_hints("")
	card_selected = {}

	add_funcptr(_tianxiang_sub1, {ID_shoupai, ID})
	skills_losecard(ID)
	
	add_funcptr(push_message, char_juese[ID].name .. "发动了武将技能 '天香' (对" .. char_juese[ID_mubiao].name .. ")")

	deduct_va_stack[#deduct_va_stack][2] = ID_mubiao
	deduct_va_stack[#deduct_va_stack][5] = ID_mubiao
	deduct_tianxiang_stack[#deduct_tianxiang_stack] = true
	deduct_hengzhi_stack[#deduct_hengzhi_stack] = char_juese[ID_mubiao].hengzhi

	if deduct_id_ignore_stack[#deduct_id_ignore_stack] == ID_mubiao then
		deduct_id_ignore_stack[#deduct_id_ignore_stack] = -1
	end
	
	add_funcptr(skills_pop_queue)
	timer.start(0.6)
end
function _tianxiang_sub1(va_list)
	local ID_shoupai, ID
	ID_shoupai = va_list[1]; ID = va_list[2]

	local card = char_juese[ID].shoupai[ID_shoupai]
	card_add_qipai(card)
	card_remove({ID, ID_shoupai})
	push_message(table.concat({char_juese[ID].name, "弃掉了'", card[2], card[3], "的", card[1], "'"}))
end
function _tianxiang_huifu()
	funcptr_queue, funcptr_i = pop_zhudong_queue()
end
function _tianxiang_mopai(ID_mubiao)
	local lost_tili = char_juese[ID_mubiao].tili_max - char_juese[ID_mubiao].tili
	card_fenfa({ID_mubiao, lost_tili, true})
end

--  张昭张纮：固政  --
function skills_guzheng(va_list)
	local ID_s, ID_mubiao
	ID_s = va_list[1]; ID_mubiao = va_list[2]

	if #wugucards == 0 then
		return
	end

	if ID_s == char_current_i then
		skills_guzheng_enter(ID_mubiao)
	else
		skills_guzheng_ai(ID_s, ID_mubiao)
	end
end
function skills_guzheng_ai(ID_s, ID_mubiao)
	local fadong, ID_paidui = ai_judge_guzheng(ID_s, ID_mubiao)
	if fadong == false then
		return
	end

	skills_push_queue()
	_guzheng_exe({ID_paidui, ID_s, ID_mubiao})
end
function skills_guzheng_enter(ID_mubiao)
	skills_push_queue()

	local old_gamerun_status = gamerun_status
	gamerun_status = "确认操作"
	jiaohu_text = "是否发动 '固政'?"
	gamerun_OK = false
	
	gamerun_OK_ptr = function()
		funcptr_queue = {}
		gamerun_status = old_gamerun_status
		set_hints("")

		if gamerun_OK then
			_guzheng_paidui_select(ID_mubiao)
	    else
			skills_pop_queue(true)
			timer.start(0.2)
		end
		platform.window:invalidate()
	end
	
	platform.window:invalidate()
end
function _guzheng_paidui_select(ID_mubiao)
	gamerun_status = "牌堆选择-固政"
	jiaohu_text = "请选择要返还的牌"
	gamerun_guankan_selected = 1

	guankan_s = ID_mubiao

	txt_messages:setVisible(false)
	platform.window:invalidate()
end
function _guzheng_exe(va_list)
	local ID_paidui, ID_s, ID_mubiao
	ID_paidui = va_list[1]; ID_s = va_list[2]; ID_mubiao = va_list[3]

	txt_messages:setVisible(true)
	gamerun_status = ""
	set_hints("")

	add_funcptr(push_message, char_juese[ID_s].name .. "发动了武将技能 '固政'")
	add_funcptr(_guzheng_return_card, va_list)
	add_funcptr(_guzheng_get_cards, va_list)
	add_funcptr(skills_pop_queue)

	skills_skip_subqueue()
	timer.start(0.6)
end
function _guzheng_return_card(va_list)
	local ID_paidui, ID_s, ID_mubiao
	ID_paidui = va_list[1]; ID_s = va_list[2]; ID_mubiao = va_list[3]

	local card = wugucards[ID_paidui]

	push_message(table.concat({char_juese[ID_s].name, "将", "'", card[2], card[3], "的", card[1], "'交给", char_juese[ID_mubiao].name}))
	card_insert(ID_mubiao, card)
	table.remove(wugucards, ID_paidui)
end
function _guzheng_get_cards(va_list)
	local ID_paidui, ID_s, ID_mubiao
	ID_paidui = va_list[1]; ID_s = va_list[2]; ID_mubiao = va_list[3]

	push_message(table.concat({char_juese[ID_s].name, "获得了其余弃牌"}))
	for i = 1, #wugucards do
		card_insert(ID_s, wugucards[i])
	end
	wugucards = {}
end

--  大乔：流离  --
function skills_liuli(va_list)
	local card_shoupai, ID_sha, ID_sha_mubiao, sha_mubiao_i
	card_shoupai = va_list[1]; ID_sha = va_list[2]; ID_sha_mubiao = va_list[3]; sha_mubiao_i = va_list[4]

	if ID_sha_mubiao == char_current_i then
		skills_liuli_enter(card_shoupai, ID_sha, sha_mubiao_i)
	else
		skills_liuli_ai(ID_sha, ID_sha_mubiao, sha_mubiao_i)
	end
end
function skills_liuli_ai(ID_sha, ID_sha_mubiao, sha_mubiao_i)
	local fadong, ID_shoupai, ID_transfer
	fadong, ID_shoupai, ID_transfer = ai_judge_liuli(ID_sha, ID_sha_mubiao)

	if fadong == false then
		gamerun_wuqi_out_hand(ID_sha_mubiao)
		return
	end

	skills_push_queue()

	_liuli_exe(ID_shoupai, ID_sha, ID_sha_mubiao, ID_transfer, sha_mubiao_i)
end
function skills_liuli_enter(card_shoupai, ID_sha, sha_mubiao_i)
	skills_push_queue()

	local old_gamerun_status = gamerun_status
	local sha_type = _sha_get_leixing(card_shoupai)
	
	gamerun_status = "选项选择"
	choose_name = table.concat({char_juese[ID_sha].name, "对您使用了'", sha_type, "'"})
	jiaohu_text = table.concat({"是否发动 '流离' 转移此杀?"})
	choose_option = {"是", "否"}

	txt_messages:setVisible(false)
	gamerun_guankan_selected = 1
	item_disrow = 0
	
	gamerun_item = function(i)
		txt_messages:setVisible(true)
		set_hints("")

		if i == 1 then
			_liuli_select_target(ID_sha, sha_mubiao_i, old_gamerun_status)
		else
			gamerun_status = old_gamerun_status
			skills_pop_queue(true)
			timer.start(0.6)
		end
	end

	platform.window:invalidate()
end
function _liuli_select_target(ID_sha, sha_mubiao_i, old_gamerun_status)
	gamerun_wuqi_into_hand(char_current_i)
	skills_enter("请选择一张牌", "请选择目标", "流离", "技能选择-单牌")

	gamerun_OK_ptr = function()
		if gamerun_status == "技能选择-目标" then
			if gamerun_OK == true then
				if table.getn2(card_selected) == 1 and card_if_d_limit("流离", char_current_i, gamerun_target_selected, nil) and gamerun_target_selected ~= ID_sha then
					_liuli_exe(card_highlighted, ID_sha, char_current_i, gamerun_target_selected, sha_mubiao_i)
				end
			else
				gamerun_status = old_gamerun_status
				set_hints("")

				skills_pop_queue(true)
				timer.start(0.6)
			end
			return
		end
		
		if gamerun_status == "技能选择-单牌" then
			if gamerun_OK == false then
				gamerun_status = old_gamerun_status
				set_hints("")

				skills_pop_queue(true)
				timer.start(0.6)
			end
			return
		end
	end
	
	gamerun_tab_ptr = function()
		if table.getn2(card_selected) == 1 then
			skills_enter_target()
		end
	end
end
function _liuli_exe(ID_shoupai, ID_sha, ID_sha_mubiao, ID_transfer, sha_mubiao_i)
	gamerun_status = "手牌生效中"
	set_hints("")
	card_selected = {}

	push_message(table.concat({char_juese[ID_sha].name, "'杀'", char_juese[ID_sha_mubiao].name}))

	add_funcptr(_liuli_sub1, {ID_shoupai, ID_sha_mubiao})
	skills_losecard(ID_sha_mubiao)
	
	add_funcptr(push_message, char_juese[ID_sha_mubiao].name .. "发动了武将技能 '流离'")
	add_funcptr(push_message, table.concat({char_juese[ID_sha_mubiao].name .. "将", char_juese[ID_sha].name, "的'杀'转移给", char_juese[ID_transfer].name}))

	char_sha_mubiao[sha_mubiao_i] = ID_transfer

	add_funcptr(skills_pop_queue)
	timer.start(0.6)
end
function _liuli_sub1(va_list)
	local ID_shoupai, ID
	ID_shoupai = va_list[1]; ID = va_list[2]

	local card = char_juese[ID].shoupai[ID_shoupai]
	card_add_qipai(card)
	card_remove({ID, ID_shoupai})
	push_message(table.concat({char_juese[ID].name, "弃掉了", card[2], card[3], "的", card[1]}))

	gamerun_wuqi_out_hand(ID)
end

--  孙策：制霸  --
function skills_zhiba(ID_s, ID_zhugong)
	if #char_juese[ID_s].shoupai == 0 then return false end
	if #char_juese[ID_zhugong].shoupai == 0 then return false end
	
	timer.stop()
	funcptr_queue = {}
	
	gamerun_status = "手牌生效中"
	set_hints("")
	skills_cs()

	lordskill_used[ID_zhugong]["制霸"] = 1

	local win_fp = function(s_win, mubiao_win)
		skills_cs()
		
		if mubiao_win == false then
			card_add_qipai(pindianing[1])
			card_add_qipai(pindianing[2])
			pindianing = {}
		else
			push_message(table.concat({char_juese[ID_zhugong].name, "获得了双方的拼点牌"}))
			card_insert(ID_zhugong, pindianing[1])
			card_insert(ID_zhugong, pindianing[2])
			pindianing = {}
		end
	end

	add_funcptr(push_message, table.concat({char_juese[ID_s].name, "响应了", char_juese[ID_zhugong].name, "的武将技能 '制霸'"}))
	add_funcptr(push_message, table.concat({char_juese[ID_s].name, "与", char_juese[ID_zhugong].name, "进行拼点"}))

	if char_juese[ID_zhugong].skill["魂姿"] ~= "locked_whole_game" then
		pindian_always_high = true
		add_funcptr(card_pindian, {ID_s, ID_zhugong, win_fp, true})
	else
		add_funcptr(_zhiba_confirm, {ID_s, ID_zhugong, win_fp})
	end
	
	add_funcptr(_zhiba_sub1)
	timer.start(0.6)
	
	return true
end
function _zhiba_confirm(va_list)
	local ID_s, ID_zhugong, win_fp
	ID_s = va_list[1]; ID_zhugong = va_list[2]; win_fp = va_list[3]

	skills_push_queue()

	if ID_zhugong == char_current_i then
		_zhiba_confirm_enter(ID_s, ID_zhugong, win_fp)
	else
		_zhiba_confirm_ai(ID_s, ID_zhugong, win_fp)
	end
end
function _zhiba_confirm_ai(ID_s, ID_zhugong, win_fp)
	local reject = false
	if ai_judge_same_identity(ID_zhugong, ID_s, true) ~= 1 then
		reject = true
	end

	if reject then
		add_funcptr(push_message, table.concat({char_juese[ID_zhugong].name, "拒绝拼点"}))
	else
		pindian_always_high = true
		add_funcptr(card_pindian, {ID_s, ID_zhugong, win_fp, true})
	end
	add_funcptr(skills_pop_queue)

	skills_skip_subqueue()
	timer.start(0.6)
end
function _zhiba_confirm_enter(ID_s, ID_zhugong, win_fp)
	gamerun_status = "确认操作"
	set_hints("是否响应此拼点?")
	gamerun_OK = false

	gamerun_OK_ptr = function()
		gamerun_status = "手牌生效中"
		set_hints("")

		if gamerun_OK == true then
			pindian_always_high = true
			add_funcptr(card_pindian, {ID_s, ID_zhugong, win_fp, true})
		else
			add_funcptr(push_message, table.concat({char_juese[ID_zhugong].name, "拒绝拼点"}))
		end

		add_funcptr(skills_pop_queue)
		timer.start(0.6)
	end

	platform.window:invalidate()
end
function _zhiba_sub1()
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

--  周泰：不屈  --
function skills_buqu(ID)		--  不屈：进入不屈状态
	if char_juese[ID].tili > 0 or 1 - char_juese[ID].tili == #card_buqu[ID] then
		return
	end

	push_zhudong_queue(table.copy(funcptr_queue), funcptr_i)
	timer.stop()
	funcptr_queue = {}
	funcptr_i = 0

	if ID == char_current_i then
		skills_buqu_enter()
	else
		_buqu_exe(ID)
	end
end
function skills_buqu_enter()
	local old_gamerun_status = gamerun_status
	gamerun_status = "确认操作"
	jiaohu_text = "是否发动 '不屈'?"
	gamerun_OK = false
	
	gamerun_OK_ptr = function()
		funcptr_queue = {}
		gamerun_status = old_gamerun_status
		set_hints("")

		if gamerun_OK then
			_buqu_exe(char_current_i)
	    else
			_buqu_huifu()
			timer.start(0.6)
		end
		platform.window:invalidate()
	end
	
	platform.window:invalidate()
end
function _buqu_exe(ID)
	local buqu_needed = 1 - char_juese[ID].tili - #card_buqu[ID]

	push_message(char_juese[ID].name .. "发动了武将技能 '不屈'")
	for i = 1, buqu_needed do
		add_funcptr(_buqu_get_new_card, ID)
	end
	add_funcptr(_buqu_jiesuan, ID)
	add_funcptr(_buqu_huifu)
	timer.start(0.6)
end
function _buqu_get_new_card(ID)
	if #card_yixi == 0 then
	    card_xipai(true)
	end

	local card = card_yixi[1]
    table.insert(card_buqu[ID], card)
	table.remove(card_yixi, 1)
	push_message(table.concat({char_juese[ID].name .. "获得了不屈牌'", card[2], card[3], "的", card[1], "'"}))
end
function _buqu_check_condition(ID)
	local dianshu_present = {}

	for i = 1, #card_buqu[ID] do
		local dianshu = card_buqu[ID][i][3]
		if dianshu_present[dianshu] ~= nil then
			return false
		else
			dianshu_present[dianshu] = true
		end
	end

	return true
end
function _buqu_jiesuan(ID)
	if _buqu_check_condition(ID) then
		if char_buqu[ID] == false then
			push_message(char_juese[ID].name .. "进入不屈状态")
			char_buqu[ID] = true
		else
			push_message(char_juese[ID].name .. "的不屈状态维持成功")
		end
	else
		push_message(char_juese[ID].name .. "的不屈状态维持失败")
	end
	
	_buqu_enter_binsi(ID)
end
function _buqu_enter_binsi(ID)		--  不屈：不屈结算后重新进入濒死结算
	_buqu_huifu()
	funcptr_queue = {}
	funcptr_i = 0

	char_binsi({true, true})
end
function skills_buqu_remove_card(ID)		--  不屈：体力恢复后移除不屈牌
	local remove_needed = binsi_tili_recovered

	if remove_needed == 0 then
		_baiyin_skip()
		return
	end

	push_zhudong_queue(table.copy(funcptr_queue), funcptr_i)
	timer.stop()
	funcptr_queue = {}
	funcptr_i = 0

	for i = 1, remove_needed do
		add_funcptr(_buqu_remove_card, ID)
	end

	add_funcptr(_buqu_huifu)
	timer.start(0.6)
end
function _buqu_remove_card(ID)
	if #card_buqu[ID] == 0 then
		--  已脱离不屈状态  --
		char_buqu[ID] = false
		return
	end

	if ID == char_current_i then
		_buqu_remove_card_enter()
	else
		_buqu_remove_card_ai(ID)
	end
end
function _buqu_remove_card_enter()
	push_zhudong_queue(table.copy(funcptr_queue), funcptr_i)
	timer.stop()
	funcptr_queue = {}
	funcptr_i = 0

	wugucards = table.copy(card_buqu[char_current_i])

	gamerun_status = "牌堆选择-不屈"
	jiaohu_text = "请选择要移除的不屈牌"
	gamerun_guankan_selected = 1

	txt_messages:setVisible(false)
	platform.window:invalidate()
end
function _buqu_remove_card_ai(ID)
	_buqu_remove_card_exe(ID, #card_buqu[ID])
end
function _buqu_remove_card_exe(ID, ID_buqu)
	set_hints("")
	gamerun_status = "手牌生效中"
	txt_messages:setVisible(true)

	wugucards = {}
	local card = card_buqu[ID][ID_buqu]
	push_message(table.concat({char_juese[ID].name, "移除了不屈牌'", card[2], card[3], "的", card[1], "'"}))
	table.remove(card_buqu[ID], ID_buqu)
	card_add_qipai(card)

	if #card_buqu[ID] == 0 then
		char_buqu[ID] = false
	end

	if ID == char_current_i then
		_buqu_huifu()
		timer.start(0.6)
	end
end
function _buqu_siwang_qipai(ID)		--  不屈：死亡后弃掉所有不屈牌
	for i = #card_buqu[ID], 1, -1 do
		add_funcptr(_buqu_qipai_exe, {ID, i})
	end
end
function _buqu_qipai_exe(va_list)
	local ID, ID_buqu
	ID = va_list[1]; ID_buqu = va_list[2]

	local card = card_buqu[ID][ID_buqu]
	push_message(table.concat({char_juese[ID].name, "丢弃不屈牌'", card[2], card[3], "的", card[1], "'"}))
	table.remove(card_buqu[ID], ID_buqu)
	card_add_qipai(card)
end
function _buqu_lose_all_skills(ID)		--  不屈：被断肠后立即进入濒死状态
	char_buqu[ID] = false
	add_funcptr(char_binsi_2, {1, ID, -1, "普通", true, false})
end
function _buqu_huifu()
	funcptr_queue, funcptr_i = pop_zhudong_queue()
end

--  凌统：旋风  --
function skills_xuanfeng(va_list)
	local ID, huihe
	ID = va_list[1]; huihe = va_list[2]

	if huihe == "出牌" then
		local n_arm = ai_arm_stat(ID)
		local last_n_arm = char_juese[ID].last_n_arm
		char_juese[ID].last_n_arm = n_arm

		if n_arm < last_n_arm then
			n_arm = last_n_arm - n_arm
		else
			skills_skip_subqueue()
			return
		end
	end

	if ID == char_current_i then
		skills_xuanfeng_enter(ID)
	else
		_xuanfeng_exe_ai(ID)
	end
end
function skills_xuanfeng_enter(ID)
	skills_push_queue()
	local old_gamerun_status = gamerun_status

	gamerun_status = "确认操作"
	jiaohu_text = "是否发动 '旋风'?"
	gamerun_OK = false
	gamerun_OK_ptr = function()
		if gamerun_OK == true then
			_xuanfeng_exe()
		else
			gamerun_status = old_gamerun_status
			set_hints("")

			skills_pop_queue(true)
			timer.start(0.6)
		end
	end
	
	platform.window:invalidate()
end
function _xuanfeng_exe_ai(ID)
	local mubiao = ai_judge_xuanfeng(ID)
	if #mubiao == 0 then
		skills_skip_subqueue()
		return
	end

	skills_push_queue()

	add_funcptr(push_message, char_juese[ID].name .. "发动了武将技能 '旋风'")
	if #mubiao == 1 then
		local time = 1
		if ai_card_stat(mubiao[1], true, false) > 1 then
			time = 2
		end
		for i = 1, time do
			add_funcptr(_chai_ai, {ID, mubiao[1], true})
			skills_losecard(mubiao[1])
		end
	else
		for i = 1, #mubiao do
			add_funcptr(_chai_ai, {ID, mubiao[i], true})
			skills_losecard(mubiao[i])
		end
	end

	add_funcptr(skills_pop_queue)
	skills_skip_subqueue()
	timer.start(0.6)
end
function _xuanfeng_exe()
	gamerun_status = "手牌生效中"
	set_hints("")

	add_funcptr(push_message, char_juese[char_current_i].name .. "发动了武将技能 '旋风'")
	add_funcptr(_xuanfeng_select_target, "观看手牌-旋风1")
	timer.start(0.6)
end
function _xuanfeng_select_target(status)
	funcptr_queue = {}
	funcptr_i = 0

	skills_enter("请选择目标", "", "旋风", "技能选择-目标")
	gamerun_select_target("init")
	gamerun_OK = false

	gamerun_OK_ptr = function()
		if gamerun_OK == true then
			if ai_card_stat(gamerun_target_selected, true, false) > 0 then
				_xuanfeng_chai_exe(char_current_i, gamerun_target_selected, status)
			end
		else
			gamerun_status = "手牌生效中"
			set_hints("")

			skills_pop_queue(true)
			timer.start(0.6)
		end
	end

	gamerun_tab_ptr = nil
	platform.window:invalidate()
end
function _xuanfeng_chai_post()
	add_funcptr(skills_pop_queue)
end
function _xuanfeng_chai_exe(ID_s, ID_d, status)
	set_hints("")
	gamerun_status = status
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

--  吴国太：甘露  --
function skills_judge_ganlu(ID_s, ID_first, ID_second)
	local tili_lost = char_juese[ID_s].tili_max - char_juese[ID_s].tili
	local n_arm_first = ai_arm_stat(ID_first)
	local n_arm_second = ai_arm_stat(ID_second)

	if n_arm_first == 0 and n_arm_second == 0 then
		return false
	end

	if math.abs(n_arm_first - n_arm_second) > tili_lost then
		return false
	end

	return true
end
function skills_ganlu_enter()
	skills_enter("请选择目标A", "", "甘露", "技能选择-目标")
	gamerun_select_target("init")
	
	gamerun_OK_ptr = function()
		if gamerun_status == "技能选择-目标" and gamerun_OK == true then
			--  进入阶段2  --
			guankan_s = gamerun_target_selected
			set_hints("请选择目标B")
			gamerun_status = "技能选择-目标B"
			gamerun_select_target("init")
			platform.window:invalidate()
			return
		end
		
		if gamerun_status == "技能选择-目标B" then
			if skills_ganlu(char_current_i, guankan_s, gamerun_target_selected) and gamerun_OK == true then
				skills_cs_2()
				consent_func_queue(0.6)
			end
		end
	end
	
	gamerun_tab_ptr = function() end
	
	return true
end
function skills_ganlu(ID_s, ID_first, ID_second)
	if skills_judge_ganlu(ID_s, ID_first, ID_second) == false then
		return false
	end
	
	funcptr_queue = {}
	set_hints("")
	gamerun_status = "手牌生效中"
	add_funcptr(push_message, char_juese[ID_s].name .. "发动了武将技能 '甘露'")
	char_juese[ID_s].skill["甘露"] = "locked"

	add_funcptr(_ganlu_sub1, {ID_s, ID_first, ID_second})
	add_funcptr(_ganlu_lose_arm_1, ID_first)
	skills_losecard(ID_first)
	add_funcptr(_ganlu_lose_arm_2, ID_second)
	skills_losecard(ID_second)
	add_funcptr(_ganlu_exchange_arm, {ID_first, ID_second})
	add_funcptr(_ganlu_sub2)
	
	return true
end
function _ganlu_sub1(va_list)
	local ID_s, ID_first, ID_second
	ID_s = va_list[1]; ID_first = va_list[2]; ID_second = va_list[3]

	push_message(table.concat({char_juese[ID_s].name, "令", char_juese[ID_first].name, "和", char_juese[ID_second].name, "交换装备区的牌"}))
end
function _ganlu_sub2()
	ganlu_arm_1 = nil
	ganlu_arm_2 = nil

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
function _ganlu_lose_arm_1(ID)
	ganlu_arm_1 = {}

	table.insert(ganlu_arm_1, table.copy(char_juese[ID].wuqi))
	table.insert(ganlu_arm_1, table.copy(char_juese[ID].fangju))
	table.insert(ganlu_arm_1, table.copy(char_juese[ID].gongma))
	table.insert(ganlu_arm_1, table.copy(char_juese[ID].fangma))

	char_juese[ID].wuqi = {}
	char_juese[ID].fangju = {}
	char_juese[ID].gongma = {}
	char_juese[ID].fangma = {}

	skills_skip_subqueue()
end
function _ganlu_lose_arm_2(ID)
	ganlu_arm_2 = {}

	table.insert(ganlu_arm_2, table.copy(char_juese[ID].wuqi))
	table.insert(ganlu_arm_2, table.copy(char_juese[ID].fangju))
	table.insert(ganlu_arm_2, table.copy(char_juese[ID].gongma))
	table.insert(ganlu_arm_2, table.copy(char_juese[ID].fangma))

	char_juese[ID].wuqi = {}
	char_juese[ID].fangju = {}
	char_juese[ID].gongma = {}
	char_juese[ID].fangma = {}

	skills_skip_subqueue()
end
function _ganlu_exchange_arm(va_list)
	local ID_first, ID_second
	ID_first = va_list[1]; ID_second = va_list[2]

	char_juese[ID_first].wuqi = ganlu_arm_2[1]
	card_arm_fangju(ID_first, ganlu_arm_2[2])
	char_juese[ID_first].gongma = ganlu_arm_2[3]
	char_juese[ID_first].fangma = ganlu_arm_2[4]

	char_juese[ID_second].wuqi = ganlu_arm_1[1]
	card_arm_fangju(ID_second, ganlu_arm_1[2])
	char_juese[ID_second].gongma = ganlu_arm_1[3]
	char_juese[ID_second].fangma = ganlu_arm_1[4]

	skills_skip_subqueue()
end
