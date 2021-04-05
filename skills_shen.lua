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
	choose_option = {"制衡","完杀","不发动"}
	if ai_judge_random_percent(80) == 1 and mark_ren[ID_s] > 0 and char_juese[ID_s].skill["制衡"] == nil then
		skills_jilve_set(ID_s, 1)
	elseif ai_judge_random_percent(20) == 1 and mark_ren[ID_s] > 0 and char_juese[ID_s].skill["完杀"] == nil then
		skills_jilve_set(ID_s, 2)
	end
	return true
end
function skills_jilve_enter()
	gamerun_status = "选项选择"
	choose_name = "极略"
	jiaohu_text = "是否使用 '极略' 获得制衡或完杀?"
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
		skills_jilve_set(char_current_i, i)
	end
	
	platform.window:invalidate()
end
function skills_jilve_set(ID, option)
	if choose_option[option] == "制衡" then
		push_message(char_juese[ID].name .. "发动了武将技能 '极略' 获得技能制衡")
		if char_juese[ID].skill["制衡"] ~= nil then
			skill_double[ID]["制衡"] = true
		else
			char_juese[ID].skill["制衡"] = 1
		end
		table.insert(char_juese[ID].skillname,"制衡")
		table.insert(skill_temp[ID],"制衡")
		mark_ren[ID] = mark_ren[ID] - 1
	elseif choose_option[option] == "完杀" then
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
		return
	end
	push_zhudong_queue(table.copy(funcptr_queue), funcptr_i)
	timer.stop()
	funcptr_queue = {}
	funcptr_i = 0

	push_message(char_juese[ID].name .. "发动了武将技能 '涉猎'")
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
	skills_shelie_set()
	gamerun_status = ""
	funcptr_queue, funcptr_i = pop_zhudong_queue()
	--funcptr_i = funcptr_i + 1
	timer.start(0.6)
end
function skills_shelie_enter(ID)
	timer.stop()
	push_zhudong_queue(table.copy(funcptr_queue), funcptr_i)
	funcptr_queue = {}
	funcptr_i = 0

	gamerun_status = "选项选择"
	choose_name = "涉猎"
	jiaohu_text = "是否使用 '涉猎'?"
	choose_option = {"是","否"}
	
	txt_messages:setVisible(false)
	gamerun_guankan_selected = 1
	item_disrow = 0

	gamerun_item = function(i)
		txt_messages:setVisible(true)
		if i == 1 then
			push_message(char_juese[char_current_i].name .. "发动了武将技能 '涉猎'")
			is_drawx = false
			funcptr_queue = {}
			funcptr_i = 0
			_shelie_exe(char_current_i)
			timer.start(0.6)
		else
			set_hints("")
			gamerun_status = ""

			funcptr_queue, funcptr_i = pop_zhudong_queue()
			--funcptr_i = funcptr_i + 1
			timer.start(0.6)
			return
		end
		platform.window:invalidate()
	end

	platform.window:invalidate()
end
function _shelie_exe(ID_s)
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
			txt_messages:setVisible(true)
			skills_shelie_set()
			gamerun_status = ""
			funcptr_queue, funcptr_i = pop_zhudong_queue()
			--funcptr_i = funcptr_i + 1
			timer.start(0.2)
		end
	end
	platform.window:invalidate()
end
function skills_shelie_set()
	for i = #card_dealed_1,1,-1 do
		card_add_qipai(card_dealed_1[i])
		push_message(char_juese[char_acting_i].name .. "弃置了'" .. card_dealed_1[i][2] .. card_dealed_1[i][3] .. "'的'"..card_dealed_1[i][1].."'")
	end
	for i = 1,#card_dealed_2 do
		card_insert(char_acting_i, card_dealed_2[i])
		push_message(char_juese[char_acting_i].name .. "获得了'" .. card_dealed_2[i][2] .. card_dealed_2[i][3] .. "'的'"..card_dealed_2[i][1].."'")
	end
	game_skip_mopai = true
end

--  神司马懿：连破  --
function skills_lianpo(ID)
	if ID == char_current_i then
		push_zhudong_queue(table.copy(funcptr_queue), funcptr_i)
		timer.stop()
		funcptr_queue = {}
		funcptr_i = 0
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
		skills_lianpo_set(char_current_i,gamerun_OK)
		
		gamerun_status = ""
		funcptr_queue, funcptr_i = pop_zhudong_queue()
		--funcptr_i = funcptr_i + 1
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
	push_message(char_juese[ID].name .. "触发了武将技能 '忍戒'")
	push_message(char_juese[ID].name .. "获得了" .. number .. "个忍标记")
	mark_ren[ID] = mark_ren[ID] + number
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

	push_zhudong_queue(table.copy(funcptr_queue), funcptr_i)
	timer.stop()
	funcptr_queue = {}
	funcptr_i = 0

	if ID == char_current_i then
		skills_guixin_enter()
	else
		skills_guixin_ai(ID)
	end
end

function skills_guixin_enter()
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
			
			_guixin_huifu()
			--funcptr_i = funcptr_i + 1
			timer.start(0.6)
		end
		platform.window:invalidate()
	end
	platform.window:invalidate()
end
function skills_guixin_ai(ID)
	local fanmian_mubiao = ai_judge_guixin(ID)
	
	if fanmian_mubiao ~= false then
		push_message(char_juese[ID].name .. "发动了武将技能 '归心'")
		_guixin_exe({ID})
	end
	_guixin_huifu()
	timer.start(0.6)
end
function _guixin_exe(va_list)
	local ID_s
	ID_s = va_list[1]

	if ID_s == char_current_i then
		for i = 1, 5 do
			if i ~= ID_s and char_juese[i].siwang ~= true and ai_card_stat(i,true,true) > 0 then
				set_hints("")
				push_message(char_juese[ID_s].name .. "发动了武将技能 '归心'")
				guixin_gamerun_status = gamerun_status
				_guixin_sub1({false, ID_s, i})
				return
			end
		end
	else
		for i = 1, 5 do
			if i ~= ID_s and char_juese[i].siwang ~= true and ai_card_stat(i,true,true) > 0 then
				_shun_ai({ID_s, i})
				skills_losecard(i, 9999, true)
			end
		end
		char_fanmian(ID_s)
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
	gamerun_status = ""
	for i = p, 5 do
		if i ~= char_current_i and char_juese[i].siwang ~= true and ai_card_stat(i,true,true) > 0 and p_next == nil then
			p_next = i
		end
	end
	if p_next == nil or p > 5 then
		gamerun_status = guixin_gamerun_status
		char_fanmian(char_current_i)
		_guixin_huifu()
		--funcptr_i = funcptr_i + 1
		timer.start(0.6)
		return
	else
		funcptr_queue = {}
		funcptr_i = 0
		add_funcptr(_guixin_sub1,{false, char_current_i, p_next})
		timer.start(0.6)
	end
end

function _guixin_huifu()
	funcptr_queue, funcptr_i = pop_zhudong_queue()
end

--  神吕蒙：攻心  --
function skills_gongxin_ai(ID_s)
	local ID_mubiao, card_dealed_1, card_dealed_2, option = ai_judge_gongxin_mubiao(ID_s)
	if ID_mubiao ~= nil then
		push_message(char_juese[ID_s].name.."发动了武将技能 '攻心' (对"..char_juese[ID_mubiao].name.. ")")
		push_message(char_juese[ID_s].name .. "查看了"..char_juese[ID_mubiao].name.."的手牌")
		char_juese[ID_s].skill["攻心"] = "locked"
		if #card_dealed_2 ~= 0 then
			skills_gongxin_set(ID_s, ID_mubiao, option)
		else
			set_hints("")
			gamerun_status = "AI出牌"

			ai_card_use(char_acting_i)
			return true
		end
	end
	return false
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
	
	msg = {char_juese[ID_req].name.."发动了武将技能 '攻心' (对", char_juese[ID_d].name, ")"}
	char_juese[ID_req].skill["攻心"] = "locked"
	add_funcptr(push_message, table.concat(msg))
	_gongxin_exe(ID_req, ID_d)
	
	return true
end
function _gongxin_exe(ID_s, ID_mubiao)
	gongxin_up, gongxin_down = {},{}
	gamerun_status = "牌堆操作"
	choose_name = "攻心"
	gongxin_up = char_juese[ID_mubiao].shoupai
	card_dealed_1, card_dealed_2 = gongxin_up, gongxin_down
	txt_messages:setVisible(false)
	gamerun_guankan_selected = 1
	card_dealed_selected = 0
	card_paidui_dealed = 1
	push_message(char_juese[ID_s].name .. "查看了"..char_juese[ID_mubiao].name.."的手牌")
	gamerun_deal = function()
		if #card_dealed_2 == 0 then
			txt_messages:setVisible(true)
			gamerun_status = ""
			timer.start(0.6)
		elseif #card_dealed_2 == 1 then
			if card_dealed_2[1][2] == "红桃" then
				funcptr_queue = {}
				txt_messages:setVisible(true)
				_gongxin_exe_2(ID_s, ID_mubiao)
				timer.start(0.6)
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
		funcptr_queue = {}
		txt_messages:setVisible(true)
		skills_gongxin_set(ID_s, ID_mubiao, i)
		timer.start(0.6)
	end
	platform.window:invalidate()
end
function skills_gongxin_set(ID, ID_mubiao, option)
	if option == 1 then
		push_message(char_juese[ID].name .. "将"..char_juese[ID_mubiao].name.."的一张牌置于牌堆顶")
		table.insert(card_yixi, 1, card_dealed_2[1])
	elseif option == 2 then
		push_message(char_juese[ID].name .. "弃置了"..char_juese[ID_mubiao].name.."的".. card_dealed_2[1][2]..card_dealed_2[1][3].."'的'"..card_dealed_2[1][1])
		card_add_qipai(card_dealed_2[1])
	end
	skills_losecard(ID_mubiao, 1, true)
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
