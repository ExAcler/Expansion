--  神司马懿：拜印  --
function skills_baiyin()
	push_message(char_juese[char_acting_i].name.."触发了武将技能 '拜印'")
	
	char_juese[char_acting_i].tili_max = char_juese[char_acting_i].tili_max - 1
	char_juese[char_acting_i].tili = math.min(char_juese[char_acting_i].tili, char_juese[char_acting_i].tili_max)
	push_message(char_juese[char_acting_i].name .. "失去一点体力上限")
	
	if char_juese[char_acting_i].skill["极略"] ~= nil then
		skill_double[char_acting_i]["极略"] = true
	else
		char_juese[char_acting_i].skill["极略"] = "available"
	end
	table.insert(char_juese[char_acting_i].skillname,"极略")
	char_juese[char_acting_i].skill["拜印"] = "locked_whole_game"
end

--  神司马懿：极略  --
function skills_jilve_ai(ID_s)
	local wansha_fadong, ID_priority = ai_judge_jilve_wansha(ID_s)

	if wansha_fadong == true and mark_ren[ID_s] > 0 and char_juese[ID_s].skill["完杀"] == nil then
		add_funcptr(skills_jilve_set, {ID_s, "完杀"})
		ai_attack_priority = ID_priority
		return true
	end

	if mark_ren[ID_s] > 0 and char_juese[ID_s].skill["制衡"] == nil then
		if ai_judge_random_percent(70) == 1 then
			add_funcptr(skills_jilve_set, {ID_s, "制衡"})
			return true
		else
			ai_skills_discard["极略"] = true
			return false
		end
	end

	return false
end
function skills_jilve_enter()
	gamerun_status = "选项选择"
	choose_name = "极略"
	jiaohu_text = "是否弃1个'忍'获得制衡或完杀?"
	choose_option = {}
	if char_juese[char_acting_i].skill["制衡"] == nil then
		table.insert(choose_option, "制衡")
	end
	if char_juese[char_acting_i].skill["完杀"] == nil then
		table.insert(choose_option, "完杀")
	end
	table.insert(choose_option, "不发动")

	txt_messages:setVisible(false)
	gamerun_guankan_selected = 1
	item_disrow = 0

	gamerun_item = function(i)
		skills_jilve_set({char_current_i, choose_option[i]})
	end
	
	platform.window:invalidate()
end
function skills_jilve_set(va_list)
	local ID, option
	ID = va_list[1]; option = va_list[2]

	if option == "制衡" then
		push_message(char_juese[ID].name .. "发动了武将技能 '极略' 获得技能制衡")
		if char_juese[ID].skill["制衡"] ~= nil then
			skill_double[ID]["制衡"] = true
		else
			char_juese[ID].skill["制衡"] = 1
		end
		table.insert(char_juese[ID].skillname,"制衡")
		table.insert(skill_temp[ID],"制衡")
		mark_ren[ID] = mark_ren[ID] - 1
	elseif option == "完杀" then
		push_message(char_juese[ID].name .. "发动了武将技能 '极略' 获得技能完杀")
		if char_juese[ID].skill["完杀"] ~= nil then
			skill_double[ID]["完杀"] = true
		else
			char_juese[ID].skill["完杀"] = "available"
		end
		table.insert(char_juese[ID].skillname,"完杀")
		table.insert(skill_temp[ID],"完杀")
		mark_ren[ID] = mark_ren[ID] - 1
	end

	txt_messages:setVisible(true)
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

--  神吕蒙：涉猎  --
function skills_shelie(ID)
	if game_skip_mopai == true then
		skills_skip_subqueue()
		return 
	end

	if ID == char_current_i then
		skills_shelie_enter(ID)
	else
		skills_shelie_ai(ID)
	end
end
function skills_shelie_ai(ID)
	local shelie_choice = ai_judge_shelie(ID)
	if shelie_choice == 2 then
		skills_skip_subqueue()
		return
	end
	
	skills_push_queue()
	
	push_message(char_juese[ID].name .. "发动了武将技能 '涉猎'")
	add_funcptr(_shelie_from_paidui)
	
	add_funcptr(skills_shelie_set)
	timer.start(0.6)
end
function _shelie_from_paidui()
	shelie_up, shelie_down = {},{}
	sheliecardsdisplay = ""
	for i = 1, 5 do
		if #card_yixi == 0 then
		    card_xipai(true)
		end
		table.insert(shelie_up,card_yixi[1])
		if sheliecardsdisplay ~= "" then
			sheliecardsdisplay = sheliecardsdisplay .. ";" .. shelie_up[#shelie_up][2] .. " " .. shelie_up[#shelie_up][3] .. "的" .. shelie_up[#shelie_up][1]
		else
			sheliecardsdisplay = "牌堆顶展示的牌:" .. shelie_up[#shelie_up][2] .. " " .. shelie_up[#shelie_up][3] .. "的" .. shelie_up[#shelie_up][1]
		end
		table.remove(card_yixi, 1)	
	end
	push_message(sheliecardsdisplay)

	card_dealed_1, card_dealed_2 = shelie_up, shelie_down
	local i = #card_dealed_1
	while i >= 1 do
		if card_dealed_1[i][2] == "黑桃" then
			table.insert(card_dealed_2, card_dealed_1[i])
			table.remove(card_dealed_1, i)
			break
		else
			i = i - 1
		end
	end
	local i = #card_dealed_1
	while i >= 1 do
		if card_dealed_1[i][2] == "草花" then
			table.insert(card_dealed_2, card_dealed_1[i])
			table.remove(card_dealed_1, i)
			break
		else
			i = i - 1
		end
	end
	local i = #card_dealed_1
	while i >= 1 do
		if card_dealed_1[i][2] == "红桃" then
			table.insert(card_dealed_2, card_dealed_1[i])
			table.remove(card_dealed_1, i)
			break
		else
			i = i - 1
		end
	end
	local i = #card_dealed_1
	while i >= 1 do
		if card_dealed_1[i][2] == "方块" then
			table.insert(card_dealed_2, card_dealed_1[i])
			table.remove(card_dealed_1, i)
			break
		else
			i = i - 1
		end
	end
end
function skills_shelie_enter(ID)
	skills_push_queue()

	gamerun_status = "选项选择"
	choose_name = "涉猎"
	jiaohu_text = "是否发动 '涉猎'?"
	choose_option = {"是","否"}
	
	txt_messages:setVisible(false)
	gamerun_guankan_selected = 1
	item_disrow = 0

	gamerun_item = function(i)
		txt_messages:setVisible(true)
		gamerun_status = ""
		set_hints("")

		if i == 1 then
			is_drawx = false
			funcptr_queue = {}
			funcptr_i = 0

			push_message(char_juese[char_current_i].name .. "发动了武将技能 '涉猎'")
			add_funcptr(_shelie_exe, char_current_i)
			timer.start(0.6)
		else
			skills_pop_queue(true)
			timer.start(0.6)
			return
		end
		platform.window:invalidate()
	end

	platform.window:invalidate()
end
function _shelie_exe(ID_s)
	funcptr_queue = {}
	funcptr_i = 0

	shelie_up, shelie_down = {},{}
	gamerun_status = "牌堆操作"
	choose_name = "涉猎"

	sheliecardsdisplay = ""
	for i = 1, 5 do
		if #card_yixi == 0 then
		    card_xipai(true)
		end
		table.insert(shelie_up,card_yixi[1])
		if sheliecardsdisplay ~= "" then
			sheliecardsdisplay = sheliecardsdisplay .. ";" .. shelie_up[#shelie_up][2] .. " " .. shelie_up[#shelie_up][3] .. "的" .. shelie_up[#shelie_up][1]
		else
			sheliecardsdisplay = "牌堆顶展示的牌:" .. shelie_up[#shelie_up][2] .. " " .. shelie_up[#shelie_up][3] .. "的" .. shelie_up[#shelie_up][1]
		end
		table.remove(card_yixi, 1)	
	end
	push_message(sheliecardsdisplay)

	card_dealed_1, card_dealed_2 = shelie_up, shelie_down
	txt_messages:setVisible(false)
	gamerun_guankan_selected = 1
	card_dealed_selected = 0
	card_paidui_dealed = 1

	gamerun_deal = function()
		local huase = {0,0,0,0}
		for i = 1,#card_dealed_2 do
			if card_dealed_2[i][2] == "黑桃" then
				huase[1] = huase[1] + 1
			elseif card_dealed_2[i][2] == "草花" then
				huase[2] = huase[2] + 1
			elseif card_dealed_2[i][2] == "红桃" then
				huase[3] = huase[3] + 1
			elseif card_dealed_2[i][2] == "方块" then
				huase[4] = huase[4] + 1
			end
		end
		if huase[1] < 2 and huase[2] < 2 and huase[3] < 2 and huase[4] < 2 then
			funcptr_queue = {}
			gamerun_status = ""
			txt_messages:setVisible(true)

			add_funcptr(skills_shelie_set)
			timer.start(0.6)
		end
	end
	platform.window:invalidate()
end
function skills_shelie_set()
	timer.stop()
	funcptr_queue = {}
	funcptr_i = 0

	for i = #card_dealed_1,1,-1 do
		add_funcptr(_shelie_withdraw_card, i)
	end
	for i = 1,#card_dealed_2 do
		add_funcptr(_shelie_get_card, i)
	end
	game_skip_mopai = true

	add_funcptr(skills_pop_queue)
	skills_skip_subqueue()
	timer.start(0.6)
end
function _shelie_withdraw_card(i)
	card_add_qipai(card_dealed_1[i])
	push_message(char_juese[char_acting_i].name .. "弃置了'" .. card_dealed_1[i][2] .. card_dealed_1[i][3] .. "'的'"..card_dealed_1[i][1].."'")
end
function _shelie_get_card(i)
	card_insert(char_acting_i, card_dealed_2[i])
	push_message(char_juese[char_acting_i].name .. "获得了'" .. card_dealed_2[i][2] .. card_dealed_2[i][3] .. "'的'"..card_dealed_2[i][1].."'")
end

--  神司马懿：连破  --
function skills_lianpo(ID)
	if ID == char_current_i then
		skills_push_queue()
		skills_lianpo_enter(ID)
	else
		skills_lianpo_set(ID, ai_judge_lianpo(ID))
	end
end
function skills_lianpo_enter(ID)
	gamerun_status = "确认操作"
	jiaohu_text = "是否发动 '连破'?"
	gamerun_OK = false
	gamerun_OK_ptr = function()
		funcptr_queue = {}
		gamerun_status = ""

		skills_lianpo_set(char_current_i,gamerun_OK)
		
		add_funcptr(skills_pop_queue)
		timer.start(0.2)
	end
	
	platform.window:invalidate()
end
function skills_lianpo_set(ID,gamerun_OK)
	if gamerun_OK then
		push_message(char_juese[ID].name .. "发动了武将技能 '连破'")
		table.insert(extra_turn, ID)
	end
	jiaohu_text = ""
end

--  神司马懿：忍戒  --
function skills_renjie(va_list)
	local ID, number = va_list[1], va_list[2]
	skills_push_queue()

	push_message(char_juese[ID].name .. "触发了武将技能 '忍戒'")
	add_funcptr(push_message, char_juese[ID].name .. "获得了" .. number .. "个忍标记")
	mark_ren[ID] = mark_ren[ID] + number

	add_funcptr(skills_pop_queue)
	timer.start(0.6)
end

--  神曹操：归心 --
function skills_guixin_add(ID, tili_deducted)
	guixin_left = 0
	for i = 1, tili_deducted do
		add_funcptr(skills_guixin, {ID})
		guixin_left = guixin_left + 1
	end
end
function skills_guixin(va_list)
	local ID
	ID = va_list[1]

	if char_juese[ID].siwang == true then
		skills_skip_subqueue()
		return
	end

	if ID == char_current_i then
		skills_guixin_enter()
	else
		skills_guixin_ai(ID)
	end
end
function skills_guixin_enter()
	skills_push_queue()

	local old_gamerun_status = gamerun_status
	gamerun_status = "确认操作"
	jiaohu_text = "是否发动 '归心'?"
	gamerun_OK = false
	
	gamerun_OK_ptr = function()
		funcptr_queue = {}
	
		if gamerun_OK then
			_guixin_exe({char_current_i})
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
function skills_guixin_ai(ID)
	local fadong = ai_judge_guixin(ID)
	if fadong == false then
		skills_skip_subqueue()
		return
	end

	skills_push_queue()
	push_message(char_juese[ID].name .. "发动了武将技能 '归心'")

	_guixin_exe({ID})
	timer.start(0.6)
end
function _guixin_exe(va_list)
	local ID_s
	ID_s = va_list[1]

	if ID_s == char_current_i then
		for i = 1, 5 do
			if i ~= ID_s and char_juese[i].siwang ~= true and ai_card_stat(i,true,true) > 0 then
				set_hints("")
				guixin_gamerun_status = gamerun_status

				add_funcptr(push_message, char_juese[ID_s].name .. "发动了武将技能 '归心'")
				add_funcptr(_guixin_sub1, {false, ID_s, i})
				timer.start(0.6)
				return
			end
		end

		--  其他角色没有任何牌的情况  --
		add_funcptr(skills_pop_queue)
		timer.start(0.6)
	else
		for i = 1, 5 do
			if i ~= ID_s and char_juese[i].siwang ~= true and ai_card_stat(i,true,true) > 0 then
				add_funcptr(_shun_ai, {ID_s, i})
				skills_losecard(i)
			end
		end
		add_funcptr(char_fanmian, ID_s)
		add_funcptr(skills_pop_queue)
	end
end
function _guixin_sub1(va_list)    --  归心效果初始化
	_chai_sub1(va_list)
	gamerun_status = "观看手牌-归心"
end
function _guixin_sub2(va_list)
	local p = va_list[3] + 1
	local p_next = nil
	local flag = true

	gamerun_status = "手牌生效中"
	funcptr_queue = {}
	funcptr_i = 0

	for i = p, 5 do
		if i ~= char_current_i and char_juese[i].siwang ~= true and ai_card_stat(i,true,true) > 0 and p_next == nil then
			p_next = i
		end
	end
	
	if p_next == nil or p > 5 then
		gamerun_status = guixin_gamerun_status
		add_funcptr(char_fanmian, char_current_i)
		add_funcptr(skills_pop_queue)
	else
		add_funcptr(_guixin_sub1, {false, char_current_i, p_next})
	end

	skills_skip_subqueue()
	timer.start(0.6)
end

--  神吕蒙：攻心  --
function skills_gongxin_ai(ID_s)
	local ID_mubiao, card_dealed_1, card_dealed_2, option = ai_judge_gongxin_mubiao(ID_s)
	if ID_mubiao == nil then
		return false
	end

	add_funcptr(push_message, char_juese[ID_s].name.."发动了武将技能 '攻心' (对"..char_juese[ID_mubiao].name.. ")")
	add_funcptr(push_message, char_juese[ID_s].name .. "查看了"..char_juese[ID_mubiao].name.."的手牌")
	char_juese[ID_s].skill["攻心"] = "locked"
	
	if #card_dealed_2 ~= 0 then
		add_funcptr(skills_gongxin_set, {ID_s, ID_mubiao, option})
		skills_losecard(ID_mubiao)
		add_funcptr(_gongxin_sub1)
	else
		add_funcptr(_gongxin_sub1)
	end

	return true
end
function skills_gongxin_enter()
	skills_enter("请选择目标", "", "攻心", "技能选择-目标")
	gamerun_select_target("init")
	
	gamerun_OK_ptr = function()
		if skills_gongxin(char_current_i, gamerun_target_selected) then
			skills_cs()
			consent_func_queue(0.6)
		end
	end
	
	return true
end
function skills_gongxin(ID_req, ID_d)
	local msg, c_pos
	
	if #char_juese[ID_d].shoupai == 0 then
	    return false
	end
	
	funcptr_queue = {}
	gamerun_status = "手牌生效中"
	jiaohu_text = ""
	
	char_juese[ID_req].skill["攻心"] = "locked"
	add_funcptr(push_message, table.concat({char_juese[ID_req].name.."发动了武将技能 '攻心' (对", char_juese[ID_d].name, ")"}))
	add_funcptr(push_message, char_juese[ID_req].name .. "查看了"..char_juese[ID_d].name.."的手牌")
	add_funcptr(_gongxin_exe, {ID_req, ID_d})
	
	return true
end
function _gongxin_exe(va_list)
	local ID_s, ID_mubiao
	ID_s = va_list[1]; ID_mubiao = va_list[2]

	funcptr_queue = {}
	funcptr_i = 0

	gongxin_up, gongxin_down = {},{}
	gamerun_status = "牌堆操作"
	choose_name = "攻心"

	gongxin_up = char_juese[ID_mubiao].shoupai
	card_dealed_1, card_dealed_2 = gongxin_up, gongxin_down

	txt_messages:setVisible(false)
	gamerun_guankan_selected = 1
	card_dealed_selected = 0
	card_paidui_dealed = 1
	
	gamerun_deal = function()
		if #card_dealed_2 == 0 then
			txt_messages:setVisible(true)
			gamerun_status = "手牌生效中"

			add_funcptr(_gongxin_sub1)
			timer.start(0.6)
		elseif #card_dealed_2 == 1 then
			if card_dealed_2[1][2] == "红桃" then
				funcptr_queue = {}
				txt_messages:setVisible(true)
				_gongxin_exe_2(ID_s, ID_mubiao)
			end
		end
	end

	platform.window:invalidate()
end
function _gongxin_exe_2(ID_s, ID_mubiao)
	gamerun_status = "选项选择"
	choose_name = "攻心"
	jiaohu_text = "将'"..card_dealed_2[1][2]..card_dealed_2[1][3].."'的'"..card_dealed_2[1][1].."'置于?"
	choose_option = {"牌堆顶","弃牌堆"}
	txt_messages:setVisible(false)

	gamerun_guankan_selected = 1
	item_disrow = 0

	gamerun_item = function(i)
		gamerun_status = "手牌生效中"
		set_hints("")
		funcptr_queue = {}
		txt_messages:setVisible(true)

		add_funcptr(skills_gongxin_set, {ID_s, ID_mubiao, i})
		skills_losecard(ID_mubiao)
		add_funcptr(_gongxin_sub1)
		timer.start(0.6)
	end
	platform.window:invalidate()
end
function skills_gongxin_set(va_list)
	local ID, ID_mubiao, option
	ID = va_list[1]; ID_mubiao = va_list[2]; option = va_list[3]

	if option == 1 then
		push_message(char_juese[ID].name .. "将"..char_juese[ID_mubiao].name.."的一张牌置于牌堆顶")
		table.insert(card_yixi, 1, card_dealed_2[1])
	elseif option == 2 then
		push_message(char_juese[ID].name .. "弃置了"..char_juese[ID_mubiao].name.."的".. card_dealed_2[1][2]..card_dealed_2[1][3].."'的'"..card_dealed_2[1][1])
		card_add_qipai(card_dealed_2[1])
	end
end
function _gongxin_sub1()
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

--  神周瑜：琴音  --
function skills_qinyin(ID)
	if ID == char_current_i then
		skills_qinyin_enter()
	else
		skills_qinyin_ai(ID)
	end
end
function skills_qinyin_ai(ID)
	local choice = ai_judge_qinyin(ID)
	if choice == 3 then
		skills_skip_subqueue()
		return
	end

	skills_push_queue()
	if choice == 1 then
		_qinyin_exe(ID, "回复体力")
	else
		_qinyin_exe(ID, "失去体力")
	end

	skills_skip_subqueue()
	timer.start(0.6)
end
function skills_qinyin_enter()
	skills_push_queue()

	gamerun_status = "选项选择"
	choose_name = "琴音"
	jiaohu_text = "是否令所有角色增减体力?"
	choose_option = {"回复一点体力", "失去一点体力", "不发动"}
	
	txt_messages:setVisible(false)
	gamerun_guankan_selected = 1
	item_disrow = 0

	gamerun_item = function(i)
		txt_messages:setVisible(true)
		gamerun_status = ""
		set_hints("")

		funcptr_queue = {}
		funcptr_i = 0

		if i == 1 then
			_qinyin_exe(char_current_i, "回复体力")
		elseif i == 2 then
			_qinyin_exe(char_current_i, "失去体力")
		else
			skills_pop_queue(true)
		end

		timer.start(0.6)
		platform.window:invalidate()
	end

	platform.window:invalidate()
end
function _qinyin_exe(ID, mode)
	local cur = ID
	if mode == "失去体力" then
		deduct_no_end_huihe = true
	end

	add_funcptr(push_message, char_juese[ID].name .. "发动了武将技能 '琴音'")

	for i = 1, 5 do
		if char_juese[cur].siwang == false then
			if mode == "回复体力" then
				if char_juese[cur].tili < char_juese[cur].tili_max then
					char_tili_huifu(cur, 1)
				end
			elseif mode == "失去体力" then
				char_tili_deduct({1, cur, -1, "流失", cur})
			end
		end

		cur = cur + 1
		if cur > 5 then
			cur = 1
		end
	end

	add_funcptr(char_judge_siwang_skip_all_stages)
	add_funcptr(skills_pop_queue)
end

--  神周瑜：业炎  --
function skills_judge_yeyan(ID, ID_shoupai)
	local hslist = {["黑桃"] = 0, ["草花"] = 0, ["红桃"] = 0, ["方块"] = 0}

	for i = 1, #ID_shoupai do
		local yanse, huase, dianshu = ai_judge_cardinfo(ID, {char_juese[ID].shoupai[ID_shoupai[i]]})
		hslist[huase] = hslist[huase] + 1
	end

	if hslist["黑桃"] == 1 and hslist["草花"] == 1 and hslist["红桃"] == 1 and hslist["方块"] == 1 then
		return true
	else
		return false
	end
end
function skills_yeyan_ai(ID, ID_shoupai, fenpei)
	if #ID_shoupai > 0 and skills_judge_yeyan(ID, ID_shoupai) == false then
		return false
	end

	yeyan_dianshu_left = nil
	yeyan_maximum_dianshu = nil
	yeyan_mubiao = table.copy(fenpei)
	yeyan_shoupai = nil

	funcptr_queue = {}
	funcptr_i = 0

	if #ID_shoupai > 0 then
		yeyan_maximum_dianshu = 3
		yeyan_shoupai = table.copy(ID_shoupai)
	else
		yeyan_maximum_dianshu = 1
	end

	_yeyan_exe(ID)
	return true
end
function skills_yeyan_enter()
	yeyan_dianshu_left = nil
	yeyan_maximum_dianshu = nil
	yeyan_mubiao = nil
	yeyan_shoupai = nil

	gamerun_status = "选项选择"
	choose_name = "业炎"
	jiaohu_text = "至多为每名角色分配几点伤害?"
	choose_option = {"1点", "2点或3点", "取消"}

	funcptr_queue = {}
	funcptr_i = 0
	
	txt_messages:setVisible(false)
	gamerun_guankan_selected = 1
	item_disrow = 0

	gamerun_item = function(i)
		txt_messages:setVisible(true)
		gamerun_status = ""
		set_hints("")

		if i == 1 then
			yeyan_dianshu_left = 3
			yeyan_maximum_dianshu = 1
			yeyan_mubiao = {}

			_yeyan_select_target_enter(1)
		elseif i == 2 then
			_yeyan_select_shoupai_enter()
		else
			gamerun_skill_selected = 0
			skills_rst()
		end

		platform.window:invalidate()
	end

	platform.window:invalidate()
	return true
end
function _yeyan_select_shoupai_enter()
	skills_enter("请选择四张不同花色手牌", "", "业炎", "技能选择-多牌")
	gamerun_OK = false

	gamerun_OK_ptr = function()
		if gamerun_OK == true then
			local ID_shoupai = skills_get_selected_shoupai()
			if skills_judge_yeyan(char_current_i, ID_shoupai) then
				yeyan_dianshu_left = 3
				yeyan_maximum_dianshu = 3
				yeyan_mubiao = {}
				yeyan_shoupai = ID_shoupai

				_yeyan_select_target_enter(1)
			end
		else
			gamerun_skill_selected = 0
			skills_rst()
		end
	end

	gamerun_tab_ptr = nil
end
function _yeyan_judge_target(ID_mubiao)
	if yeyan_mubiao == nil then
		return false
	end

	for i = 1, #yeyan_mubiao do
		if yeyan_mubiao[i][1] == ID_mubiao then
			return false
		end
	end
	return true
end
function _yeyan_select_target_enter(i)
	skills_enter("请选择目标" .. tostring(i), "", "业炎", "技能选择-目标B")
	gamerun_select_target("init")
	guankan_s = -1
	gamerun_OK = false

	gamerun_OK_ptr = function()
		if gamerun_OK == true then
			if _yeyan_judge_target(gamerun_target_selected) then
				if yeyan_maximum_dianshu == 3 then
					_yeyan_select_dianshu_enter(gamerun_target_selected)
				else
					_yeyan_select_if_next_enter(gamerun_target_selected, "1点")
				end
			end
		else
			gamerun_skill_selected = 0
			skills_rst()
		end
	end

	gamerun_tab_ptr = nil
end
function _yeyan_select_dianshu_enter(ID_mubiao)
	gamerun_status = "选项选择"
	choose_name = "业炎"
	jiaohu_text = "为" .. char_juese[ID_mubiao].name .. "分配几点伤害?"
	choose_option = {"取消发动"}

	if yeyan_dianshu_left >= 1 and #yeyan_mubiao ~= 0 then
		table.insert(choose_option, "1点")
	end
	if yeyan_dianshu_left >= 2 then
		table.insert(choose_option, "2点")
	end
	if yeyan_dianshu_left >= 3 then
		table.insert(choose_option, "3点")
	end
	
	txt_messages:setVisible(false)
	gamerun_guankan_selected = 1
	item_disrow = 0

	gamerun_item = function(i)
		txt_messages:setVisible(true)
		gamerun_status = "手牌生效中"
		set_hints("")

		if i ~= 1 then
			_yeyan_select_if_next_enter(ID_mubiao, choose_option[i])
		else
			gamerun_skill_selected = 0
			skills_rst()
		end

		platform.window:invalidate()
	end

	platform.window:invalidate()
end
function _yeyan_select_if_next_enter(ID_mubiao, dianshu_text)
	local dianshu = 1
	if dianshu_text == "1点" then
		dianshu = 1
	elseif dianshu_text == "2点" then
		dianshu = 2
	elseif dianshu_text == "3点" then
		dianshu = 3
	end

	table.insert(yeyan_mubiao, {ID_mubiao, dianshu})
	yeyan_dianshu_left = yeyan_dianshu_left - dianshu

	if yeyan_dianshu_left == 0 then
		_yeyan_exe(char_current_i)
		return
	end

	gamerun_status = "选项选择"
	choose_name = "业炎"
	jiaohu_text = "是否选择下一个目标?"
	choose_option = {"是", "否 (发动业炎)", "取消发动"}
	
	txt_messages:setVisible(false)
	gamerun_guankan_selected = 1
	item_disrow = 0

	gamerun_item = function(i)
		txt_messages:setVisible(true)
		gamerun_status = "手牌生效中"
		set_hints("")

		if i == 1 then
			_yeyan_select_target_enter(#yeyan_mubiao + 1)
		elseif i == 2 then
			_yeyan_exe(char_current_i)
		else
			gamerun_skill_selected = 0
			skills_rst()
		end

		platform.window:invalidate()
	end

	platform.window:invalidate()
end
function _yeyan_exe(ID)
	skills_cs()

	add_funcptr(push_message, char_juese[ID].name .. "发动了武将技能 '业炎'")
	char_juese[ID].skill["业炎"] = "locked_whole_game"
	deduct_no_end_huihe = true

	if yeyan_maximum_dianshu == 3 then
		_yeyan_add_qipai(ID)
		skills_losecard(ID)
		char_tili_deduct({3, ID, -1, "流失", ID})
	end

	for i = 1, #yeyan_mubiao do
		local ID_mubiao = yeyan_mubiao[i][1]
		local dianshu = yeyan_mubiao[i][2]

		char_tili_deduct({dianshu, ID_mubiao, ID, "火", ID_mubiao})
	end

	add_funcptr(char_judge_siwang_skip_all_stages)
	add_funcptr(_fanjian_sub4)

	skills_skip_subqueue()
	timer.start(0.6)
end
function _yeyan_add_qipai(ID)
	for i = #yeyan_shoupai, 1, -1 do
		add_funcptr(_yeyan_qipai, {ID, yeyan_shoupai[i]})
	end
end
function _yeyan_qipai(va_list)
	local ID, ID_shoupai
	ID = va_list[1]; ID_shoupai = va_list[2]

	local card = char_juese[ID].shoupai[ID_shoupai]
	push_message(table.concat({char_juese[ID].name, "弃掉了'", card[2], card[3], "的", card[1], "'"}))
	card_shanchu({ID, ID_shoupai})
end
