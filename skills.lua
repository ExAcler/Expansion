
--  主动技触发函数表  --
skills_func = 
{
	["奇袭"] = function() return skills_qixi_enter() end, 
	["青囊"] = function() return skills_qingnang_enter() end, 
	["火计"] = function() return skills_huoji_enter() end, 
	["苦肉"] = function() return skills_kurou_enter() end, 
	["酒池"] = function() return skills_jiuchi_enter() end, 
	["倾国"] = function() return skills_qingguo_enter() end, 
	["武圣"] = function() return skills_wusheng_enter() end, 
	["龙胆"] = function() return skills_longdan_enter() end, 
	["国色"] = function() return skills_guose_enter() end, 
	["断粮"] = function() return skills_duanliang_enter() end, 
	["乱击"] = function() return skills_luanji_enter() end, 
	["结姻"] = function() return skills_jieyin_enter() end, 
	["直谏"] = function() return skills_zhijian_enter() end, 
	["制衡"] = function() return skills_zhiheng_enter() end, 
	["反间"] = function() return skills_fanjian_enter() end, 
	["挑衅"] = function() return skills_tiaoxin_enter() end, 
	["仁德"] = function() return skills_rende_enter() end, 
	["强袭"] = function() return skills_qiangxi_enter() end, 
	["连环"] = function() return skills_lianhuan_enter() end, 
	["缔盟"] = function() return skills_dimeng_enter() end, 
	["天义"] = function() return skills_tianyi_enter() end, 
	["驱虎"] = function() return skills_quhu_enter() end, 
	["离间"] = function() return skills_lijian_enter() end, 
	["离魂"] = function() return skills_lihun_enter() end
}

--  黄月英：集智  --
function skills_jizhi(ID)
	if ID == char_current_i then
		push_zhudong_queue(table.copy(funcptr_queue), funcptr_i)
		timer.stop()
		funcptr_queue = {}
		funcptr_i = 0
		skills_jizhi_enter(ID)
	else
		skills_jizhi_set(ID, ai_judge_jizhi(ID))
	end
end
function skills_jizhi_enter(ID)
	gamerun_status = "确认操作"
	jiaohu_text = "是否发动 '集智'?"
	gamerun_OK = false
	gamerun_OK_ptr = function()
		funcptr_queue = {}
		skills_jizhi_set(char_current_i,gamerun_OK)
		
		gamerun_status = ""
		funcptr_queue, funcptr_i = pop_zhudong_queue()
		funcptr_i = funcptr_i + 1
		timer.start(0.2)
	end
	
	platform.window:invalidate()
end
function skills_jizhi_set(ID,gamerun_OK)
	if gamerun_OK then
		push_message(char_juese[ID].name .. "发动了武将技能 '集智'")
		card_fenfa({ID, 1, true})
	end
	jiaohu_text = ""
end

--  孙尚香：枭姬  --
function skills_xiaoji(ID)
	local n_arm = ai_arm_stat(ID)
	local last_n_arm = char_juese[ID].last_n_arm
	char_juese[ID].last_n_arm = n_arm

	if n_arm < last_n_arm then
		n_arm = last_n_arm - n_arm
	else
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
		funcptr_i = funcptr_i + 1
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
		funcptr_i = funcptr_i + 1
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
		funcptr_i = funcptr_i + 1

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

--  张春华：伤逝  --
function skills_shangshi(ID, not_in_queue)
	if #char_juese[ID].shoupai >= char_juese[ID].tili_max - char_juese[ID].tili then
		if char_juese[ID].skill["连营"] == "available" and #char_juese[ID].shoupai == 0 then
			skills_lianying(ID, true)
		end
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
		funcptr_i = funcptr_i + 1

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

--  灵雎：焚心 --
function skills_fenxin(va_list)
	local ID, ID_mubiao = va_list[1] ,va_list[2]
	if ID == char_current_i then
		push_zhudong_queue(table.copy(funcptr_queue), funcptr_i)
		timer.stop()
		funcptr_queue = {}
		funcptr_i = 0
		skills_fenxin_enter(ID, ID_mubiao)
	else
		skills_fenxin_set(ID, ai_judge_fenxin(ID))
	end
end
function skills_fenxin_enter(ID, ID_mubiao)
	gamerun_status = "选项选择"
	choose_name = "焚心"
	jiaohu_text = "是否使用 '焚心' 与"..char_juese[ID_mubiao].name.."换身份?"
	choose_option = {"发动","不发动"}
	txt_messages:setVisible(false)
	gamerun_guankan_selected = 1
	item_disrow = 0
	gamerun_item = function(i)
		print(i)
		funcptr_queue = {}
		txt_messages:setVisible(true)
		skills_fenxin_set(char_current_i, ID_mubiao, i)
		
		gamerun_status = ""
		funcptr_queue, funcptr_i = pop_zhudong_queue()
		funcptr_i = funcptr_i + 1
		timer.start(0.2)
	end
	
	platform.window:invalidate()
end
function skills_fenxin_set(ID, ID_mubiao, option)
	if option == 1 then
		push_message(char_juese[ID].name .. "发动了武将技能 '焚心' ")
		char_juese[ID].skill["焚心"] = "locked_whole_game"
		char_juese[ID].shenfen, char_juese[ID_mubiao].shenfen = char_juese[ID_mubiao].shenfen, char_juese[ID].shenfen
		char_juese[ID].isantigovernment, char_juese[ID_mubiao].isantigovernment = char_juese[ID_mubiao].isantigovernment, char_juese[ID].isantigovernment
		char_juese[ID].antigovernment, char_juese[ID_mubiao].antigovernment = char_juese[ID_mubiao].antigovernment, char_juese[ID].antigovernment
		char_juese[ID].antigovernmentmax, char_juese[ID_mubiao].antigovernmentmax = char_juese[ID_mubiao].antigovernmentmax, char_juese[ID].antigovernmentmax
		char_juese[ID].antigovernmentmin, char_juese[ID_mubiao].antigovernmentmin = char_juese[ID_mubiao].antigovernmentmin, char_juese[ID].antigovernmentmin
		char_juese[ID].isblackjack, char_juese[ID_mubiao].isblackjack = char_juese[ID_mubiao].isblackjack, char_juese[ID].isblackjack
	end
	fenxin_pending = nil
end

--  蔡文姬：断肠 --
function skills_duanchang(va_list)
	local ID, ID_shanghai = va_list[1] ,va_list[2]
	push_message(char_juese[ID].name .. "触发了武将技能 '断肠' ")
	push_message(char_juese[ID_shanghai].name .. "失去所有武将技能")
	char_juese[ID_shanghai].skill = {}
	char_juese[ID_shanghai].skillname = {}
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

--  姜维：志继  --
function skills_zhiji(ID)
	push_message(char_juese[char_acting_i].name.."触发了武将技能 '志继'")
	if ID == char_current_i then
		push_zhudong_queue(table.copy(funcptr_queue), funcptr_i)
		timer.stop()
		funcptr_queue = {}
		funcptr_i = 0
		if char_juese[char_acting_i].tili < char_juese[char_acting_i].tili_max then
			skills_zhiji_enter(ID)
		else
			skills_zhiji_set(char_acting_i, 2)
			gamerun_status = ""
			funcptr_queue, funcptr_i = pop_zhudong_queue()
			funcptr_i = funcptr_i + 1
			timer.start(0.2)
		end
	else
		skills_zhiji_set(ID, ai_judge_zhiji(ID))
	end
end
function skills_zhiji_enter(ID)
	gamerun_status = "选项选择"
	choose_name = "志继"
	jiaohu_text = "请选择回复一点体力或摸两张牌"
	choose_option = {"回复一点体力","摸两张牌"}
	txt_messages:setVisible(false)
	gamerun_guankan_selected = 1
	item_disrow = 0
	gamerun_item = function(i)
		funcptr_queue = {}
		txt_messages:setVisible(true)
		skills_zhiji_set(char_acting_i, i)
		
		gamerun_status = ""
		funcptr_queue, funcptr_i = pop_zhudong_queue()
		funcptr_i = funcptr_i + 1
		timer.start(0.2)
	end
	
	platform.window:invalidate()
end
function skills_zhiji_set(ID, option)
	if option == 1 then
		push_message(char_juese[ID].name .. "选择回复一点体力")
		_tao_sub({ID, false})
	elseif option == 2 then
		push_message(char_juese[ID].name .. "选择摸两张牌")
		card_fenfa({char_acting_i,2,false})
	end
	push_message(char_juese[ID].name .. "失去一点体力上限")
	char_juese[char_acting_i].tili_max = char_juese[char_acting_i].tili_max - 1
	char_juese[char_acting_i].tili = math.min(char_juese[char_acting_i].tili, char_juese[char_acting_i].tili_max)
	if char_juese[char_acting_i].skill["观星"] ~= nil then
		skill_double[char_acting_i]["观星"] = true
	else
		char_juese[char_acting_i].skill["观星"] = "available"
	end
	table.insert(char_juese[char_acting_i].skillname,"观星")
	char_juese[char_acting_i].skill["志继"] = "locked_whole_game"
end

--  太史慈：天义  --
function skills_tianyi_ai(ID_s, ID_mubiao)	--  AI发动天义
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
	add_funcptr(card_pindian, {ID_s, ID_mubiao, win})
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
		add_funcptr(card_pindian, {char_current_i, gamerun_target_selected, win_fp})
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
				char_tili_deduct({1, ID_to_shanghai, ID_mubiao, "普通", ID_to_shanghai, nil, true})
			end
		else
			char_tili_deduct({1, ID_s, ID_mubiao, "普通", ID_s, nil, true})
		end

		add_funcptr(_pindian_huifu)
		timer.start(0.6)
	end

	add_funcptr(push_message, char_juese[ID_s].name .. "发动了武将技能 '驱虎'")
	add_funcptr(push_message, table.concat({char_juese[ID_s].name, "与", char_juese[ID_mubiao].name, "进行拼点"}))
	add_funcptr(card_pindian, {ID_s, ID_mubiao, win})
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
		add_funcptr(card_pindian, {char_current_i, gamerun_target_selected, win_fp})
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
		if card_if_d_limit("驱虎2", guankan_s, gamerun_target_selected) then
			set_hints("")
			gamerun_status = "手牌生效中"

			skills_cs()
			char_tili_deduct({1, gamerun_target_selected, guankan_s, "普通", gamerun_target_selected, nil, true})
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
		return
	end

	push_zhudong_queue(table.copy(funcptr_queue), funcptr_i)
	timer.stop()
	funcptr_queue = {}
	funcptr_i = 0

	if yinghun_choice == 1 then
		add_funcptr(push_message, char_juese[ID].name .. "发动了武将技能 '英魂' 选择摸1弃" .. (char_juese[ID].tili_max-char_juese[ID].tili))
		is_drawx = false
	elseif yinghun_choice == 2 then
		add_funcptr(push_message, char_juese[ID].name .. "发动了武将技能 '英魂' 选择摸" .. (char_juese[ID].tili_max-char_juese[ID].tili) .. "弃1")
		is_drawx = true
	end

	_yinghun_exe(is_drawx, ID, yinghun_mubiao)
	timer.start(0.6)
end
function skills_yinghun_enter(ID)
	timer.stop()
	push_zhudong_queue(table.copy(funcptr_queue), funcptr_i)
	funcptr_queue = {}
	funcptr_i = 0

	gamerun_status = "选项选择"
	choose_name = "英魂"
	jiaohu_text = "是否发动 '英魂' 令其他角色摸牌弃牌?"
	choose_option = {"摸1弃"..(char_juese[char_current_i].tili_max-char_juese[char_current_i].tili),"摸"..(char_juese[char_current_i].tili_max-char_juese[char_current_i].tili).."弃1","不发动"}

	txt_messages:setVisible(false)
	gamerun_guankan_selected = 1
	item_disrow = 0

	gamerun_item = function(i)
		txt_messages:setVisible(true)
		if i == 1 then
			push_message(char_juese[char_current_i].name .. "发动了武将技能 '英魂' 选择摸1弃" .. (char_juese[char_current_i].tili_max-char_juese[char_current_i].tili))
			is_drawx = false
		elseif i == 2 then
			push_message(char_juese[char_current_i].name .. "发动了武将技能 '英魂' 选择摸" .. (char_juese[char_current_i].tili_max-char_juese[char_current_i].tili) .. "弃1")
			is_drawx = true
		else
			set_hints("")
			gamerun_status = ""

			funcptr_queue, funcptr_i = pop_zhudong_queue()
			funcptr_i = funcptr_i + 1
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
	local qipai_id, qi_zhuangbei_id
	if is_drawx then
		card_fenfa({ID_mubiao, char_juese[ID_s].tili_max - char_juese[ID_s].tili, true})
		qipai_id, qi_zhuangbei_id = ai_judge_withdraw(ID_mubiao, 1, true)
	else
		card_fenfa({ID_mubiao, 1, true})
		qipai_id, qi_zhuangbei_id = ai_judge_withdraw(ID_mubiao, char_juese[ID_s].tili_max - char_juese[ID_s].tili, true)
	end
	ai_withdraw(ID_mubiao, qipai_id, qi_zhuangbei_id, true)
	skills_losecard(ID_mubiao, 9999, true)

	is_drawx = nil
	set_hints("")
	gamerun_status = ""
	
	add_funcptr(_yinghun_huifu)
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
		return
	end
	
	if ai_card_stat(ID_mubiao, true, true) == 0 then
		return
	end

	push_zhudong_queue(table.copy(funcptr_queue), funcptr_i)
	timer.stop()
	funcptr_queue = {}
	funcptr_i = 0

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
			push_message(char_juese[ID].name .. "发动了武将技能 '补益'")
			if char_current_i ~= ID_mubiao then
				local card_number = math.random(#char_juese[ID_mubiao].shoupai)
				_buyi_exe({char_current_i, ID_mubiao, card_number})
				add_funcptr(_buyi_huifu_2, nil)
				timer.start(0.6)
			else
				gamerun_status = "主动出牌-补益"
				jiaohu_text = "请展示一张手牌"
				platform.window:invalidate()
			end
	    else
			_buyi_huifu()
			funcptr_i = funcptr_i + 1
			timer.start(0.6)
		end
		platform.window:invalidate()
	end
	platform.window:invalidate()
end
function skills_buyi_ai(ID,ID_mubiao)
	local fanmian_mubiao = ai_judge_buyi_mubiao(ID,ID_mubiao)
	
	if fanmian_mubiao ~= nil then
		push_message(char_juese[ID].name .. "发动了武将技能 '补益'")
		local card_searched, card_chosen = {}
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
	add_funcptr(_buyi_huifu)
	timer.start(0.6)
end
function _buyi_exe(va_list)
	gamerun_status = "手牌生效中"
	set_hints("")
	local ID_s, ID_mubiao, ID_card
	ID_s = va_list[1]; ID_mubiao = va_list[2]; ID_card = va_list[3]
	local card = table.copy(char_juese[ID_mubiao].shoupai[ID_card])
	add_funcptr(_nanman_send_msg, {char_juese[ID_mubiao].name, "展示了'", card[2], card[3], "的", card[1], "'"})
	if card[1] ~= "杀" and card[1] ~= "火杀" and card[1] ~= "雷杀" and card[1] ~= "闪" and card[1] ~= "桃" and card[1] ~= "酒" then
		add_funcptr(_nanman_send_msg, {char_juese[ID_mubiao].name, "弃置了'", card[2], card[3], "的", card[1], "'"})
		add_funcptr(card_shanchu, {ID_mubiao, ID_card})
		add_funcptr(buyi_tili_huifu, ID_mubiao)
	end
end
function _buyi_status_restore()
	gamerun_status = buyi_gamerun_status
	set_hints("")
	_buyi_huifu_2()
end
function _buyi_huifu()
	funcptr_queue, funcptr_i = pop_zhudong_queue()
end
function _buyi_huifu_2()
	funcptr_queue, funcptr_i = pop_zhudong_queue()
	funcptr_i = funcptr_i + 1
end
function buyi_tili_huifu(ID)
	char_juese[ID].tili = char_juese[ID].tili + 1
	push_message(char_juese[ID].name .. "回复了一点体力")
end

--  诸葛亮：观星  --
function skills_guanxing(ID)
	if ID == char_current_i then
		skills_guanxing_enter(ID)
	else
		skills_guanxing_ai(ID)
	end
end
function skills_guanxing_ai(ID)
	local guanxing_choice = ai_judge_guanxing(ID)
	if guanxing_choice == false then
		return
	end
	push_zhudong_queue(table.copy(funcptr_queue), funcptr_i)
	timer.stop()
	funcptr_queue = {}
	funcptr_i = 0

	add_funcptr(push_message, char_juese[ID].name .. "发动了武将技能 '观星'")

	--_guanxing_exe(is_drawx, ID, guanxing_mubiao)
	_guanxing_exe()
	timer.start(0.6)
end
function skills_guanxing_enter(ID)
	timer.stop()
	push_zhudong_queue(table.copy(funcptr_queue), funcptr_i)
	funcptr_queue = {}
	funcptr_i = 0

	gamerun_status = "选项选择"
	choose_name = "观星"
	jiaohu_text = "是否使用 '观星' ?"
	choose_option = {"是","否"}
	
	txt_messages:setVisible(false)
	gamerun_guankan_selected = 1
	item_disrow = 0

	gamerun_item = function(i)
		txt_messages:setVisible(true)
		if i == 1 then
			push_message(char_juese[char_current_i].name .. "发动了武将技能 '观星'")
			is_drawx = false
			funcptr_queue = {}
			funcptr_i = 0
			_guanxing_exe(char_current_i)
			timer.start(0.6)
		else
			set_hints("")
			gamerun_status = ""

			funcptr_queue, funcptr_i = pop_zhudong_queue()
			funcptr_i = funcptr_i + 1
			timer.start(0.6)
			return
		end
		platform.window:invalidate()
	end

	platform.window:invalidate()
end
function _guanxing_exe(ID_s)
	guanxing_up, guanxing_down = {},{}
	gamerun_status = "牌堆操作"
	choose_name = "观星"
	local live = 0
	for i = 1, 5 do
		if char_juese[i].siwang == false then
			live = live + 1
		end
	end
	for i = 1, live do
		if #card_yixi == 0 then
		    card_xipai(true)
		end
		table.insert(guanxing_up,card_yixi[1])
		table.remove(card_yixi, 1)	
	end
	card_dealed_1, card_dealed_2 = guanxing_up, guanxing_down
	txt_messages:setVisible(false)
	gamerun_guankan_selected = 1
	card_dealed_selected = 0
	card_paidui_dealed = 1
	gamerun_deal = function()
		funcptr_queue = {}
		txt_messages:setVisible(true)
		skills_guanxing_set()
		gamerun_status = ""
		funcptr_queue, funcptr_i = pop_zhudong_queue()
		funcptr_i = funcptr_i + 1
		timer.start(0.2)
	end
	platform.window:invalidate()
end
function skills_guanxing_set()
	push_message(char_juese[char_acting_i].name .. "将" .. #card_dealed_1 .. "张牌放在牌堆顶")
	for i = #card_dealed_1,1,-1 do
		table.insert(card_yixi,1,card_dealed_1[i])
	end
	push_message(char_juese[char_acting_i].name .. "将" .. #card_dealed_2 .. "张牌放在牌堆底")
	for i = 1,#card_dealed_2 do
		table.insert(card_yixi,card_dealed_1[i])
	end
end
--function _guanxing_huifu()
	--funcptr_queue, funcptr_i = pop_zhudong_queue()
--end

--  魏延：狂骨  --
function skills_kuanggu(ID_s)
	add_funcptr(push_message, char_juese[ID_s].name .. "触发了武将技能 '狂骨'")
	add_funcptr(_kuanggu_sub1, ID_s)
end
function _kuanggu_sub1(ID_s)
	push_message(char_juese[ID_s].name.."回复1点体力")
	char_juese[ID_s].tili = char_juese[ID_s].tili + 1
end

--  孟获：祸首  --
function skills_huoshou(ID_s)
	add_funcptr(push_message, char_juese[ID_s].name.."触发了武将技能 '祸首'")
end

--  曹丕：行殇  --
function skills_xingshang(va_list)
	local ID_s, ID_siwang, panding
	ID_s = va_list[1]; ID_siwang = va_list[2]; panding = va_list[3]
	
	push_message(char_juese[ID_s].name .. "发动了武将技能 '行殇'")
	push_message(table.concat({char_juese[ID_s].name, "获得了", char_juese[ID_siwang].name, "的所有牌"}))
	
	_xingshang_card_transfer(ID_s, ID_siwang, panding)
end
function _xingshang_card_transfer(ID_s, ID_siwang, panding)    --  行殇：将死亡玩家所有卡牌转移至曹丕
	local i, max_select
	
	max_select = #char_juese[ID_siwang].shoupai
	
	if max_select > 0 then
		for i = 1, max_select do
			if char_juese[ID_siwang].shoupai[i] ~= nil then
				table.insert(char_juese[ID_s].shoupai, char_juese[ID_siwang].shoupai[i])
			end
		end
	end
	char_juese[ID_siwang].shoupai = {}
	
	if panding and #char_juese[ID_siwang].panding ~= 0 then
		for i = 1, #char_juese[ID_siwang].panding do
			if char_juese[ID_siwang].panding[i] ~= nil then
				table.insert(char_juese[ID_s].shoupai, char_juese[ID_siwang].panding[i])
			end
		end
	end
	char_juese[ID_siwang].panding = {}
	
	if #char_juese[ID_siwang].wuqi ~= 0 then
		table.insert(char_juese[ID_s].shoupai, char_juese[ID_siwang].wuqi)
	end
	char_juese[ID_siwang].wuqi = {}
	
	if #char_juese[ID_siwang].fangju ~= 0 then
		table.insert(char_juese[ID_s].shoupai, char_juese[ID_siwang].fangju)
	end
	char_juese[ID_siwang].fangju = {}
	
	if #char_juese[ID_siwang].gongma ~= 0 then
		table.insert(char_juese[ID_s].shoupai, char_juese[ID_siwang].gongma)
	end
	char_juese[ID_siwang].gongma = {}
	
	if #char_juese[ID_siwang].fangma ~= 0 then
		table.insert(char_juese[ID_s].shoupai, char_juese[ID_siwang].fangma)
	end
	char_juese[ID_siwang].fangma = {}
end

--  袁术：庸肆  --
function skills_yongsi(ID)
	if game_skip_mopai == true then
		return
	end
	local shili = {}
	for i = 1, 5 do
		if char_juese[i].siwang ~= true then
			shili[char_juese[i].shili] = 1
		end
	end
	push_message(char_juese[ID].name .. "触发了武将技能 '庸肆' 多摸了"..(table.getn2(shili)).."张牌")
	char_yongsi = table.getn2(shili)
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
		funcptr_i = funcptr_i + 1
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

--  貂蝉：闭月  --
function skills_biyue(ID)
	if ID == char_current_i then
		push_zhudong_queue(table.copy(funcptr_queue), funcptr_i)
		timer.stop()
		funcptr_queue = {}
		funcptr_i = 0
		skills_biyue_enter(ID)
	else
		skills_biyue_set(ID, ai_judge_biyue(ID))
	end
end
function skills_biyue_enter(ID)

	gamerun_status = "确认操作"
	jiaohu_text = "是否发动 '闭月'?"
	gamerun_OK = false
	gamerun_OK_ptr = function()
		funcptr_queue = {}
		skills_biyue_set(char_current_i,gamerun_OK)
		
		gamerun_status = ""
		funcptr_queue, funcptr_i = pop_zhudong_queue()
		funcptr_i = funcptr_i + 1
		timer.start(0.2)
	end
	
	platform.window:invalidate()
end
function skills_biyue_set(ID,gamerun_OK)
	if gamerun_OK then
		push_message(char_juese[ID].name .. "发动了武将技能 '闭月'")
		card_fenfa({ID, 1, true})
	end
	jiaohu_text = ""
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
		funcptr_i = funcptr_i + 1
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

--  袁绍：血裔判断  --
function skills_judge_xueyi(ID)
	local i, extra
	
	extra = 0
	if char_juese[ID].skill["血裔"]~="available" then
		return 0
	end
	
	for i = 1, 5 do
		if char_juese[i].siwang == false and char_juese[i].shili == "群" and i ~= ID then
			extra = extra + 2
		end
	end
	
	return extra
end

--  华佗：急救查找红色手牌  --
function skills_jijiu_chazhao(ID)
	local i, v
	
	for i, v in ipairs(char_juese[ID].shoupai) do
	    if v[2] == "红桃" or v[2] == "方块" then
		    return i
		end
	end
	
	return -1
end

--  卧龙诸葛：八阵  --
function skills_bazhen(ID_s)
	push_message(char_juese[ID_s].name .. "触发了武将技能 '八阵'")
end

--  董卓：崩坏  --
function skills_judge_benghuai(ID)    --  判断是否满足崩坏条件
	local tili = char_juese[ID].tili
	local i
	
	for i = 1, 5 do
		if char_juese[i].tili < tili and char_juese[i].siwang ~= true then
			return true
		end
	end
	
	return false
end
function skills_benghuai()
	push_zhudong_queue(table.copy(funcptr_queue), funcptr_i)
	timer.stop()
	funcptr_queue = {}
	funcptr_i = 0

	if char_acting_i == char_current_i then
		skills_benghuai_enter()
	else
		skills_benghuai_ai()
	end
end
function skills_benghuai_ai()
	add_funcptr(push_message, char_juese[char_acting_i].name .. "触发了武将技能 '崩坏'")
	if ai_judge_benghuai(char_acting_i) == false then
		add_funcptr(_benghuai_reduce_max, char_acting_i)
	else
		char_tili_deduct({1, char_acting_i, -1, "流失", char_acting_i})
	end

	add_funcptr(_skills_benghuai_huifu)
	timer.start(0.6)
end
function skills_benghuai_enter()    --  进入崩坏状态
	gamerun_huihe = "结束"
    gamerun_status = "确认操作"
	if char_juese[char_current_i].tili_max > 1 then
		jiaohu_text = "'确定': 减上限 '取消': 减体力"
	else
		jiaohu_text = "'取消': 减体力"
	end
	
	gamerun_OK_ptr = function()    -- 如果确认发动，执行的函数
		if gamerun_OK == true then
			if char_juese[char_current_i].tili_max > 1 then
				set_hints("")
				
				add_funcptr(push_message, char_juese[char_current_i].name .. "触发了武将技能 '崩坏'")
				add_funcptr(_benghuai_reduce_max, char_current_i)

				add_funcptr(_skills_benghuai_huifu)
				timer.start(0.6)
			end
		else
			set_hints("")
			
			add_funcptr(push_message, char_juese[char_current_i].name .. "触发了武将技能 '崩坏'")
			char_tili_deduct({1, char_current_i, -1, "流失", char_current_i})

			add_funcptr(_skills_benghuai_huifu)
			timer.start(0.6)
		end
	end
	
	platform.window:invalidate()
end
function _benghuai_reduce_max(ID)    --  减少体力上限
	push_message(char_juese[ID].name .. "减少1点体力上限")
	char_juese[ID].tili_max = char_juese[ID].tili_max - 1
	char_juese[ID].tili = math.min(char_juese[ID].tili, char_juese[ID].tili_max)
end
function _skills_benghuai_huifu()
	funcptr_queue, funcptr_i = pop_zhudong_queue()
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
			funcptr_i = funcptr_i + 1
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
		funcptr_i = funcptr_i + 1
		timer.start(0.6)
		return
	else
		funcptr_queue = {}
		add_funcptr(_guixin_sub1,{false, char_current_i, p_next})
		consent_func_queue(0.6)
	end
end

function _guixin_huifu()
	funcptr_queue, funcptr_i = pop_zhudong_queue()
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
			funcptr_i = funcptr_i + 1
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
		skills_losecard(fanmian_mubiao, 9999, true)
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
			funcptr_i = funcptr_i + 1
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
	skills_losecard(char_current_i, 9999, true)

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

--  清除技能选择状态  --
function skills_cs()    
	gamerun_skill_selected = 0
	gamerun_tab_ptr = nil
	gamerun_OK_ptr = nil
	gamerun_OK = false
	skill_text_1 = ""
	skill_text_2 = ""
	last_status = ""
	imp_card = ""
	card_selected = {}
	card_highlighted = 1
	platform.window:invalidate()
end
function skills_cs_2()
	gamerun_skill_selected = 0
	gamerun_tab_ptr = nil
	gamerun_OK_ptr = nil
	gamerun_OK = false
	skill_text_1 = ""
	skill_text_2 = ""
	last_status = ""
	imp_card = ""
end

function skills_judge_black(ID)    --  判断选择的手牌是否为黑色
	if table.getn2(card_selected) ~= 0 then
		local card = char_juese[char_current_i].shoupai[card_highlighted]
		local yanse, huase, dianshu = ai_judge_cardinfo(ID, {card})
		if yanse == "黑色" then
			return true
		end
	end
	return false
end
function skills_judge_red(ID)    --  判断选择的手牌是否为红色
	if table.getn2(card_selected) ~= 0 then
		local card = char_juese[char_current_i].shoupai[card_highlighted]
		local yanse, huase, dianshu = ai_judge_cardinfo(ID, {card})
		if yanse == "红色" then
			return true
		end
	end
	return false
end
function skills_judge_card(name)    --  判断选择的手牌是否为某手牌
	if table.getn2(card_selected) ~= 0 then
		local card = char_juese[char_current_i].shoupai[card_highlighted]
		if card[1] == name then
			return true
		end
	end
	return false
end
function skills_judge_huase(ID, huase)    --  判断选择的手牌是否为某花色
	if table.getn2(card_selected) ~= 0 then
		local card = char_juese[char_current_i].shoupai[card_highlighted]
		local yanse, _huase, dianshu = ai_judge_cardinfo(ID, {card})
		if _huase == huase then
			return true
		end
	end
	return false
end

function skills_enter(text1, text2, imp, status, text3)
	skill_text_1 = text1
	skill_text_2 = text2
	imp_card = imp
	card_selected = {}
	card_highlighted = 1
	last_OK = true
	
	set_hints(skill_text_1)
	gamerun_status = status
	last_status = status
end
function skills_enter_target()
	set_hints(skill_text_2)
	gamerun_status = "技能选择-目标"
	gamerun_select_target("init")
	platform.window:invalidate()
end

--  华佗：青囊  --
function skills_qingnang_enter()
	if #char_juese[char_current_i].shoupai == 0 then return false end

	skills_enter("请选择一张手牌", "使用桃", "桃", "技能选择-单牌")
	
	gamerun_OK_ptr = function()
		skills_qingnang()
	end
	
	gamerun_tab_ptr = function()
		if table.getn2(card_selected) == 0 then
			set_hints(skill_text_2)
		else
			set_hints(skill_text_1)
		end
		platform.window:invalidate()
	end
	
	return true
end
function skills_qingnang()
	if table.getn2(card_selected) ~= 0 then
		funcptr_queue = {}
		if card_tao({card_highlighted, char_current_i, char_current_i, false}) then
			skills_cs()
		    consent_func_queue(0.2)
		end
	end
end

--  卧龙诸葛：火计  --
function skills_huoji_enter()
	if #char_juese[char_current_i].shoupai == 0 then return false end

	skills_enter("请选择红色手牌", "火攻", "火攻", "技能选择-单牌")
	
	gamerun_OK_ptr = function()
		skills_huoji(char_current_i)
	end
	
	gamerun_tab_ptr = function()
		if skills_judge_red(char_current_i) then
			skills_enter_target()
		end
	end
	
	return true
end
function skills_huoji(ID)
	if skills_judge_red(ID) then
		funcptr_queue = {}
		if card_huogong({card_highlighted}, char_current_i, gamerun_target_selected) then
			skills_cs()
		    consent_func_queue(0.6)
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
			skills_kurou()
			skills_cs()
		    consent_func_queue(0.6)
		end
	end
	
	return true
end
function skills_kurou()
	funcptr_queue = {}
	add_funcptr(_kurou_sub1)
	char_tili_deduct({1, char_current_i, char_current_i, "流失", char_current_i})
	add_funcptr(card_fenfa, {char_current_i, 2, true})
	add_funcptr(_kurou_sub2)
end
function _kurou_sub1()
	set_hints("")
	gamerun_status = "手牌生效中"
	push_message(char_juese[char_current_i].name .. "发动了武将技能 '苦肉'")
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

--  董卓：酒池  --
function skills_jiuchi_enter()
	if #char_juese[char_current_i].shoupai == 0 then return false end

	skills_enter("请选择黑色手牌", "使用酒", "酒", "技能选择-单牌")
	
	gamerun_OK_ptr = function()
		skills_jiuchi(char_current_i)
	end
	
	gamerun_tab_ptr = function() end
	
	return true
end
function skills_jiuchi(ID)
	if skills_judge_black(ID) then
		funcptr_queue = {}
		if card_jiu({card_highlighted, char_current_i, false}) then
			skills_cs()
			skills_rst()
		end
	end
end

--  关羽：武圣  --
function skills_wusheng_enter()
	if #char_juese[char_current_i].shoupai == 0 and ai_arm_stat(char_current_i) == 0 then return false end

	gamerun_wuqi_into_hand(char_current_i)
	skills_enter("请选择红色手牌", "杀", "杀", "技能选择-单牌")
	gamerun_OK = false

	gamerun_OK_ptr = function()
		if gamerun_OK == true then
			skills_wusheng(char_current_i)
		end
	end
	
	gamerun_tab_ptr = function()
		if skills_judge_red(char_current_i) then
			skills_enter_target()
		end
	end
	
	return true
end
function skills_wusheng(ID)
	if skills_judge_red(ID) then
		funcptr_queue = {}
		if card_sha({card_highlighted}, char_current_i, {gamerun_target_selected}, true) then
			skills_cs()
		    consent_func_queue(0.6)
		end
	end
end

--  赵云：龙胆  --
function skills_longdan_enter()
	if #char_juese[char_current_i].shoupai == 0 then return false end

	skills_enter("请选择一张闪", "杀", "杀", "技能选择-单牌")
	
	gamerun_OK_ptr = function()
		if gamerun_OK == true then
			skills_longdan()
		end
	end
	
	gamerun_tab_ptr = function()
		if skills_judge_card("闪") then
			skills_enter_target()
		end
	end
	
	return true
end
function skills_longdan()
	funcptr_queue = {}
	if skills_judge_card("闪") then
		if card_sha({card_highlighted}, char_current_i, {gamerun_target_selected}, true) then
			skills_cs()
		    consent_func_queue(0.6)
		end
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

--  黄忠：烈弓  --
function skills_judge_liegong(ID_s, ID_mubiao)    --  判断烈弓发动条件是否满足
	if #char_juese[ID_mubiao].shoupai >= char_juese[ID_s].tili then
		return true
	end
	
	if #char_juese[ID_s].wuqi == 0 then
		if #char_juese[ID_mubiao].shoupai <= 1 then
			return true
		end
	else
		if #char_juese[ID_mubiao].shoupai <= card_wuqi_r[char_juese[ID_s].wuqi[1]] then
			return true
		end
	end
	
	return false
end
function skills_liegong(va_list)
	local ID_s, ID_mubiao, sha_mubiao_i
	ID_s = va_list[1]; ID_mubiao = va_list[2]; sha_mubiao_i = va_list[3]

	--  如果大乔流离了此杀  --
	if char_sha_mubiao[sha_mubiao_i] ~= ID_mubiao then
		ID_mubiao = char_sha_mubiao[sha_mubiao_i]
	end

	if ID_s ~= char_current_i and ai_judge_liegong(ID_s, ID_mubiao) == false then
		return
	end

	if ID_s == char_current_i then
		skills_liegong_enter(ID_mubiao)
	else
		_liegong_exe(ID_s, ID_mubiao)
	end
end
function skills_liegong_enter(ID_mubiao)
	push_zhudong_queue(table.copy(funcptr_queue), funcptr_i)
	timer.stop()
	funcptr_queue = {}
	funcptr_i = 0

    gamerun_status = "确认操作"
	jiaohu_text = table.concat({"是否对", char_juese[ID_mubiao].name, "发动 '烈弓'?"})
	gamerun_OK = false
	
	gamerun_OK_ptr = function()
	    gamerun_status = "手牌生效中"
		set_hints("")
		
		if gamerun_OK then
	    	_liegong_exe(char_current_i, ID_mubiao)
		end
		_liegong_huifu()
		funcptr_i = funcptr_i + 1
		timer.start(0.6)
	end
	
	platform.window:invalidate()
end
function _liegong_exe(ID_s, ID_mubiao)
	push_message(table.concat({char_juese[ID_s].name, "发动了武将技能 '烈弓' (对", char_juese[ID_mubiao].name, ")"}))
	char_liegong[ID_mubiao] = true
end
function _liegong_huifu()
	funcptr_queue, funcptr_i = pop_zhudong_queue()
end

--  马超：铁骑  --
function skills_tieqi(va_list)
	local card_shoupai, ID_shoupai, ID_s, ID_mubiao, sha_mubiao_i
	card_shoupai = va_list[1]; ID_shoupai = va_list[2]; ID_s = va_list[3]; ID_mubiao = va_list[4]; sha_mubiao_i = va_list[5]

	--  如果大乔流离了此杀  --
	if char_sha_mubiao[sha_mubiao_i] ~= ID_mubiao then
		ID_mubiao = char_sha_mubiao[sha_mubiao_i]
	end

	if ID_s ~= char_current_i and ai_judge_tieqi(ID_s, ID_mubiao) == false then
		return
	end

	push_zhudong_queue(table.copy(funcptr_queue), funcptr_i)
	timer.stop()
	funcptr_queue = {}
	funcptr_i = 0

	if ID_s == char_current_i then
		skills_tieqi_enter(card_shoupai, ID_shoupai, ID_s, ID_mubiao)
	else
		_tieqi_exe(card_shoupai, ID_shoupai, ID_s, ID_mubiao)
		timer.start(0.6)
	end
end
function skills_tieqi_enter(card_shoupai, ID_shoupai, ID_s, ID_mubiao)
	card_selected = {}
	card_highlighted = 1

    gamerun_status = "确认操作"
	jiaohu_text = table.concat({"是否对", char_juese[ID_mubiao].name, "发动 '铁骑'?"})
	gamerun_OK = false
	
	gamerun_OK_ptr = function()
	    gamerun_status = "手牌生效中"; set_hints("")
		if gamerun_OK then
			_tieqi_exe(card_shoupai, ID_shoupai, char_current_i, ID_mubiao)
	    else
			_liegong_huifu()
			funcptr_i = funcptr_i + 1
		end
		timer.start(0.6)
	end
	
	platform.window:invalidate()
end
function _tieqi_exe(card_shoupai, ID_shoupai, ID_s, ID_mubiao)
	--_tieqi_temporary_remove_sha(ID_shoupai, ID_s)
	push_message(table.concat({char_juese[ID_s].name, "发动了武将技能 '铁骑' (对", char_juese[ID_mubiao].name, ")"}))
	add_funcptr(_tieqi_fan_panding, ID_s)

	--  如场上有司马懿或张角，询问其改判技能  --
	skills_guicai_guidao_ask(ID_s, ID_mubiao, ID_s, "铁骑")

	add_funcptr(_tieqi_jiesuan, {card_shoupai, ID_shoupai, ID_s, ID_mubiao})
end
function _tieqi_temporary_remove_sha(ID_shoupai, ID_s)		--  铁骑：暂时删除手牌中的杀，防止与改判冲突
	for i = #ID_shoupai, 1, -1 do
		table.remove(char_juese[ID_s].shoupai, ID_shoupai[i])	
	end
end
function _tieqi_insert_sha(card_shoupai, ID_s)		--  铁骑：改判结束之后将杀插入回手牌
	for i = 1, #card_shoupai do
		table.insert(char_juese[ID_s].shoupai, card_shoupai[i])
	end
end
function _tieqi_fan_panding(ID_s)
	--  翻开判定牌  --
	if #card_yixi == 0 then
	    card_xipai(true)
	end
    card_panding_card = card_yixi[1]
	table.remove(card_yixi, 1)
	push_message(table.concat({char_juese[ID_s].name .. "的判定牌是'", card_panding_card[2], card_panding_card[3], "的", card_panding_card[1], "'"}))
end
function _tieqi_jiesuan(va_list)
	local card_shoupai, ID_shoupai, ID_s, ID_mubiao
	card_shoupai = va_list[1]; ID_shoupai = va_list[2]; ID_s = va_list[3]; ID_mubiao = va_list[4]

	timer.stop()
	funcptr_queue = {}
	funcptr_i = 0

	local yanse, huase, dianshu = ai_judge_cardinfo(ID_s, {card_panding_card})
	
	--  曹丕颂威  --
	skills_judge_songwei(ID_s)

	if huase == "红桃" or huase == "方块" then
		push_message(char_juese[ID_s].name .. "的 '铁骑' 判定成功")
		char_liegong[ID_mubiao] = true
	else
		push_message(char_juese[ID_s].name .. "的 '铁骑' 判定失败")
		char_liegong[ID_mubiao] = false
	end
	skills_card_qi_panding(ID_s)

	add_funcptr(_tieqi_insert_sha_exe, {card_shoupai, ID_shoupai, ID_s, ID_mubiao})
	timer.start(0.6)
end
function _tieqi_insert_sha_exe(va_list)
	local card_shoupai, ID_shoupai, ID_s, ID_mubiao
	card_shoupai = va_list[1]; ID_shoupai = va_list[2]; ID_s = va_list[3]; ID_mubiao = va_list[4]

	--[[
	_tieqi_insert_sha(card_shoupai, ID_s)
	ID_shoupai = {}
	for i = #char_juese[ID_s].shoupai - #card_shoupai + 1, #char_juese[ID_s].shoupai do
		table.insert(ID_shoupai, i)
	end
	]]

	timer.stop()
	_liegong_huifu()
	timer.start(0.6)
end

--  袁绍：乱击  --
function skills_luanji_enter()
	if #char_juese[char_current_i].shoupai == 0 then return false end

	skills_enter("请选择两张同花色牌", "使用万箭齐发", "万箭齐发", "技能选择-多牌")
	
	gamerun_OK_ptr = function()
		skills_luanji()
	end
	
	gamerun_tab_ptr = function()
		if skills_judge_luanji() then
			set_hints(skill_text_2)
		else
			set_hints(skill_text_1)
		end
	end
	
	return true
end
function skills_judge_luanji()
	local i, card
	local h1 = 0
	local h2 = 0
	card = char_juese[char_current_i].shoupai
	
	if table.getn2(card_selected) == 2 then
		for i, _ in pairs(card_selected) do
			if h1 == 0 then
				h1 = i
			else
				h2 = i
			end
		end
		if card[h1][2] == card[h2][2] then
			return true
		end
	end
	return false
end
function skills_luanji()
	local i
	local h1 = 0
	local h2 = 0
	
	if skills_judge_luanji() then
		funcptr_queue = {}
		local card_i = skills_get_selected_shoupai()
		
		if card_wanjian(card_i, char_current_i) then
			skills_cs()
		    consent_func_queue(0.6)
		end
	end
end

--  获得当前玩家选择的手牌  --
function skills_get_selected_shoupai()
	local card_i = {}
	for i = -4, #char_juese[char_current_i].shoupai do
		if card_selected[i] ~= nil then
			table.insert(card_i, i)
		end
	end
	return card_i
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
	if skills_judge_jieyin_1() == false or skills_judge_jieyin_2(ID_mubiao) == false then return false end
	funcptr_queue = {}
	
	add_funcptr(_jieyin_sub1, {ID_s, ID_shoupai})
	skills_losecard(ID_s, #ID_shoupai, true)

	if char_juese[ID_s].tili < char_juese[ID_s].tili_max then
		add_funcptr(_tao_sub, {ID_s, false})
	end
	add_funcptr(_tao_sub, {ID_mubiao, false})
	
	return true
end
function _jieyin_sub1(va_list)
	local i
	local ID_s, ID_shoupai
	ID_s = va_list[1]; ID_shoupai = va_list[2]
	
	set_hints("")
	gamerun_status = "手牌生效中"
	
	push_message(char_juese[ID_s].name .. "发动了武将技能 '结姻'")

	for i = #ID_shoupai, 1, -1 do
		card_shanchu({ID_s, ID_shoupai[i]})
	end
	char_juese[ID_s].skill["结姻"] = "locked"
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
	skills_losecard(ID_s, 1, true)

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
		char_juese[ID_mubiao].fangju = card
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

	add_funcptr(_zhiheng_sub1)
	ai_withdraw(ID_s, ID_shoupai, zhuangbei_list, true)
	skills_losecard(ID_s, 9999, true)

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
	add_funcptr(_zhiheng_sub1)
	card_qipai_go()
	skills_losecard(ID, 9999, true)

	char_juese[ID].skill["制衡"] = "locked"
	add_funcptr(card_fenfa, {ID, cards, true})
	add_funcptr(_zhiheng_sub2)
	
	return true
end
function _zhiheng_sub1()
	set_hints("")
	gamerun_status = "手牌生效中"
	push_message(char_juese[char_current_i].name.."发动了武将技能 '制衡'")
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
	skills_losecard(ID_s, 1, true)

	if (card[2] ~= "方块" and fanjian_huase == 1) or (card[2] ~= "红桃" and fanjian_huase == 2) or (card[2] ~= "草花" and fanjian_huase == 3) or (card[2] ~= "黑桃" and fanjian_huase == 4) then
		char_tili_deduct({1, ID_mubiao, ID_s, "普通", ID_mubiao})
	end
end
function _fanjian_sub3(va_list)
	local ID_s, ID_mubiao, t, card
	ID_s = va_list[1]; ID_mubiao = va_list[2]; t = va_list[3]
	card = char_juese[ID_s].shoupai[t]
	
	push_message(table.concat({char_juese[ID_mubiao].name, "获得了 '", card[2], card[3], "的", card[1], "'"}))
	
	table.insert(char_juese[ID_mubiao].shoupai, card)
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

--  姜维：挑衅  --
function skills_tiaoxin_enter()
	skills_enter("请选择目标", "", "挑衅", "技能选择-目标")
	gamerun_select_target("init")
	
	gamerun_OK_ptr = function()
		if skills_tiaoxin(char_current_i, gamerun_target_selected) then
			skills_cs()
			consent_func_queue(0.6)
		end
	end
	
	return true
end
function skills_tiaoxin(ID_req, ID_d)
	local msg, c_pos
	
	if #char_juese[ID_d].wuqi ~= 0 then
	    if char_calc_distance(ID_d, ID_req) > card_wuqi_r[char_juese[ID_d].wuqi[1]] then
	        return false
	    end
	else
	    if char_calc_distance(ID_d, ID_req) > 1 then
	        return false
	    end
	end
	
	funcptr_queue = {}
	gamerun_status = "手牌生效中"
	jiaohu_text = ""
	
	msg = {char_juese[ID_req].name.."发动了武将技能 '挑衅' (对", char_juese[ID_d].name, "}"}
	char_juese[ID_req].skill["挑衅"] = "locked"
	add_funcptr(push_message, table.concat(msg))
	
	c_pos = card_chazhao(ID_d, "杀")
	if c_pos < 0 then
		c_pos = card_chazhao(ID_d, "雷杀")
	end
	if c_pos < 0 then
		c_pos = card_chazhao(ID_d, "火杀")
	end
	if c_pos > -1 then
	    card_sha({c_pos}, ID_d, {ID_req}, false)
	else
	    add_funcptr(_nanman_send_msg, {char_juese[ID_d].name, "放弃"})
		add_funcptr(_chai_sub1, {true, ID_req, ID_d})
	end
	
	return true
end

--  刘备：仁德  --
function skills_rende_ai(ID_s, ID_mubiao, ID_shoupai)
	if #char_juese[ID_s].shoupai == 0 then
		return false
	end

	skills_rende(ID_s, ID_mubiao, ID_shoupai)
	return true
end
function skills_rende_enter()
	if #char_juese[char_current_i].shoupai == 0 then return false end
	skills_enter("请选择手牌并按 '确定'", "请选择目标", "仁德", "技能选择-多牌")
	--last_status = ""
	
	gamerun_OK_ptr = function()
		if gamerun_status == "技能选择-多牌" then
			if table.getn2(card_selected) ~= 0 then
				skills_enter_target()
			end
		else
			if table.getn2(card_selected) == 0 then
				return
			end
			local card_i = skills_get_selected_shoupai()

			if skills_rende(char_current_i, gamerun_target_selected, card_i) then
				skills_cs_2()
				consent_func_queue(0.6)
			end
		end
	end
	
	gamerun_tab_ptr = function() end
	
	return true
end
function skills_rende(ID_s, ID_mubiao, ID_shoupai)
	gamerun_status = "手牌生效中"
	jiaohu_text = ""
	if char_acting_i == char_current_i then
		card_highlighted = 1
		card_selected = {}
	end
	
	funcptr_queue = {}
	add_funcptr(push_message, char_juese[ID_s].name .. "发动了武将技能 '仁德'")
	
	add_funcptr(skills_rende_exe, {ID_s, ID_mubiao, ID_shoupai})
	skills_losecard(ID_s, #ID_shoupai, true)

	add_funcptr(_rende_sub)
	return true
end
function skills_rende_exe(va_list)
	local ID_s, ID_mubiao
	ID_s = va_list[1]; ID_mubiao = va_list[2]; ID_shoupai = va_list[3]
	
	for i = #ID_shoupai, 1, -1 do
		table.insert(char_juese[ID_mubiao].shoupai, char_juese[ID_s].shoupai[ID_shoupai[i]])
		card_remove({ID_s, ID_shoupai[i]})
		if char_rende_given >= 0 then
			char_rende_given = char_rende_given + 1
		end
	end
	
	push_message(table.concat({char_juese[ID_s].name, "将", tostring(#ID_shoupai), "张手牌交给", char_juese[ID_mubiao].name}))
	if char_rende_given >= 2 then
		if char_juese[ID_s].tili < char_juese[ID_s].tili_max then
			_tao_sub({ID_s, true})
		end
		char_rende_given = -1
	end
end
function _rende_sub()
	if char_acting_i == char_current_i then
		card_selected = {}
		card_highlighted = 1
		set_hints("请您出牌")
		gamerun_status = ""
	else
		set_hints("")
		gamerun_status = "AI出牌"

		ai_card_use(char_current_i)
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
		funcptr_i = funcptr_i + 1
		timer.start(0.2)
	end
	
	platform.window:invalidate()
end
function skills_tiandu_set(ID,gamerun_OK,card_panding)
	if gamerun_OK then
		push_message(char_juese[ID].name .. "发动了武将技能 '天妒'")
		table.insert(char_juese[ID].shoupai, card_panding)
		push_message(table.concat({char_juese[ID].name, "获得了'", card_panding[2], card_panding[3], "的", card_panding[1], "'"}))
	else
		card_add_qipai(card_panding)
	end
end

--  典韦：强袭  --
function skills_qiangxi_enter()
	if #char_juese[char_current_i].shoupai == 0 and ai_arm_stat(char_current_i) == 0 then return false end
	
	gamerun_wuqi_into_hand(char_current_i)
	skills_enter("请选择装备牌或'取消'减体力", "请选择目标", "强袭", "技能选择-单牌")
	
	gamerun_OK_ptr = function()
		if gamerun_OK == true then
			if skills_qiangxi(char_current_i, card_highlighted, gamerun_target_selected) then
				skills_cs()
				consent_func_queue(0.6)
			end
		else
			if table.getn2(card_selected) == 0 then
				last_OK = false
				skills_enter_target()
			end
		end
	end
	
	gamerun_tab_ptr = function()
		if skills_judge_zhijian_1(char_current_i, card_highlighted) then
			last_OK = true
			skills_enter_target()
		end
	end
	
	return true
end
function skills_qiangxi(ID_s, ID_shoupai, ID_mubiao)
	if gamerun_status == "技能选择-单牌" then return false end

	if #char_juese[ID_s].wuqi ~= 0 then
	    if char_calc_distance(ID_s, ID_mubiao) > card_wuqi_r[char_juese[ID_s].wuqi[1]] then
	        return false
	    end
	else
	    if char_calc_distance(ID_s, ID_mubiao) > 1 then
	        return false
	    end
	end

	if last_OK == true then
		if skills_judge_zhijian_1(char_current_i, card_highlighted) == false then return false end
	end
	
	funcptr_queue = {}
	gamerun_status = "手牌生效中"
	set_hints("")
	
	add_funcptr(push_message, char_juese[ID_s].name.."发动了武将技能 '强袭'")
	add_funcptr(_qiangxi_sub1, {ID_s, card_highlighted})
	skills_losecard(ID_s, 9999, true)

	if last_OK == false then
		char_tili_deduct({1, ID_s, -1, "流失", ID_s})
	end
	char_tili_deduct({1, ID_mubiao, ID_s, "普通", ID_mubiao})
	add_funcptr(_qiangxi_sub2)
	
	return true
end
function _qiangxi_sub1(va_list)
	local ID, ID_shoupai
	ID = va_list[1]; ID_shoupai = va_list[2]

	char_juese[ID].skill["强袭"] = "locked"
	card_selected = {}
	if last_OK == true then
		local card = char_juese[ID].shoupai[ID_shoupai]
		card_shanchu({ID, ID_shoupai})
	end

	gamerun_wuqi_out_hand(ID)
	card_highlighted = 1
end
function _qiangxi_sub2()
	card_selected = {}
	card_highlighted = 1
	set_hints("请您出牌")
	gamerun_status = ""
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
		funcptr_i = funcptr_i + 1
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
	jiaohu_text = "是否使用 '将驰' 多摸或少摸牌?"
	choose_option = {"多摸一张","少摸一张","不发动"}
	txt_messages:setVisible(false)
	gamerun_guankan_selected = 1
	item_disrow = 0
	gamerun_item = function(i)
		funcptr_queue = {}
		txt_messages:setVisible(true)
		skills_jiangchi_set(char_current_i, i)
		
		gamerun_status = ""
		funcptr_queue, funcptr_i = pop_zhudong_queue()
		funcptr_i = funcptr_i + 1
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

--  左慈：化身 --
function skills_huashen(va_list)
	local ID, jieduan
	ID = va_list[1]; jieduan = va_list[2]

	local old_gamerun_status = gamerun_status

	--  AI不做任何动作 (临时)  --
	if ID ~= char_current_i then
		return
	end

	push_zhudong_queue(table.copy(funcptr_queue), funcptr_i)
	timer.stop()
	funcptr_queue = {}
	funcptr_i = 0

	gamerun_status = "选项选择"
	choose_name = "化身"
	if huashen_wujiang[ID] ~= nil and huashen_skill[ID] ~= nil then
		choose_option = {"不替换"}
	else
		choose_option = {}
	end
	for i = 1,#huashen_paidui[ID] do
		table.insert(choose_option,huashen_paidui[ID][i][4].." "..huashen_paidui[ID][i][1].." "..huashen_paidui[ID][i][2].." "..huashen_paidui[ID][i][3][2].."/"..huashen_paidui[ID][i][3][1])
	end

	txt_messages:setVisible(false)
	gamerun_guankan_selected = 1
	item_disrow = 0
	gamerun_item = function(i)
		funcptr_queue = {}
		txt_messages:setVisible(true)
		if i == 1 and huashen_wujiang[ID] ~= nil and huashen_skill[ID] ~= nil then
			gamerun_status = old_gamerun_status

			_huashen_huifu()
			timer.start(0.2)
		else
			local delta = 0
			if huashen_wujiang[ID] ~= nil and huashen_skill[ID] ~= nil then
				delta = -1
				if skill_double[ID][huashen_skill[ID]] then
					skill_double[ID][huashen_skill[ID]] = nil
				else
					char_juese[ID].skill[huashen_skill] = nil
					for j = 1, #char_juese[ID].skillname do
						if char_juese[ID].skillname[j] == huashen_skill[ID] then
							table.remove(char_juese[ID].skillname,j)
						end
					end
				end
			end
			
			push_message(char_juese[ID].name.."发动了武将技能 '化身' 变成了"..huashen_paidui[ID][i+delta][4])
			huashen_wujiang[ID] = huashen_paidui[ID][i+delta][4]
			char_juese[ID].shili = huashen_paidui[ID][i+delta][1]
			char_juese[ID].xingbie = huashen_paidui[ID][i+delta][2]
			char_skill_item = huashen_paidui[ID][i+delta][5]

			skills_huashen_1(ID, jieduan, old_gamerun_status)
		end
	end
	platform.window:invalidate()
end
function skills_huashen_1(ID, jieduan, old_gamerun_status)
	gamerun_status = "选项选择"
	choose_name = "化身"
	choose_option = {}
	for j = 1,#char_skill_item do
		table.insert(choose_option,char_skill_item[j])
	end
	txt_messages:setVisible(false)
	gamerun_guankan_selected = 1
	item_disrow = 0
	gamerun_item = function(i)
		funcptr_queue = {}
		txt_messages:setVisible(true)
		huashen_skill[ID] = choose_option[i]
		if char_juese[ID].skill[huashen_skill[ID]] == nil then
			if huashen_skill[ID] == "挑衅" or huashen_skill[ID] == "反间" or huashen_skill[ID] == "驱虎" or huashen_skill[ID] == "制衡" or huashen_skill[ID] == "结姻" or huashen_skill[ID] == "天义" or huashen_skill[ID] == "缔盟" or huashen_skill[ID] == "离间" or huashen_skill[ID] == "离魂" or huashen_skill[ID] == "青囊" then
				char_juese[ID].skill[huashen_skill[ID]] = 1
			else
				char_juese[ID].skill[huashen_skill[ID]] = "available"
			end
			table.insert(char_juese[ID].skillname,huashen_skill[ID])
		else
			skill_double[ID][huashen_skill[ID]] = true
		end

		gamerun_status = old_gamerun_status
		_huashen_huifu()
		timer.start(0.2)
	end
	platform.window:invalidate()
end
function _huashen_huifu()
	funcptr_queue, funcptr_i = pop_zhudong_queue()
	funcptr_i = funcptr_i + 1
end

--  左慈：新生 --
function skills_xinsheng(va_list)
	ID = va_list[1]; is_beginning = va_list[2]
	if ID == char_current_i then
		push_zhudong_queue(table.copy(funcptr_queue), funcptr_i)
		timer.stop()
		funcptr_queue = {}
		funcptr_i = 0
		skills_xinsheng_enter(ID)
	else
		skills_xinsheng_set(ID, ai_judge_xinsheng(ID))
	end
end
function skills_xinsheng_enter(ID)

	gamerun_status = "确认操作"
	jiaohu_text = "是否发动 '新生'?"
	gamerun_OK = false
	gamerun_OK_ptr = function()
		funcptr_queue = {}
		skills_xinsheng_set(char_current_i,gamerun_OK,is_beginning)
		
		gamerun_status = ""
		funcptr_queue, funcptr_i = pop_zhudong_queue()
		funcptr_i = funcptr_i + 1
		timer.start(0.2)
	end
	
	platform.window:invalidate()
end
function skills_xinsheng_set(ID,gamerun_OK,is_beginning)
	if gamerun_OK then
		if is_beginning then
		else
			push_message(char_juese[ID].name .. "发动了武将技能 '新生'")
		end
		skills_xinsheng_exe({ID, true})
	end
end
function skills_xinsheng_exe(va_list)
	local ID, is_beginning
	ID = va_list[1]; is_beginning = va_list[2]

	while #char_wujiang_f > 0 do
		local t = math.random(#char_wujiang_f)
		local skill_huashen = {}
		for i = 1, #char_juese_jineng[char_wujiang_f[t]][4] do
			if char_juese_jineng[char_wujiang_f[t]][6][i] ~= "限定" and char_juese_jineng[char_wujiang_f[t]][6][i] ~= "主公" and char_juese_jineng[char_wujiang_f[t]][6][i] ~= "禁止" and char_juese_jineng[char_wujiang_f[t]][6][i] ~= "觉醒" then
				table.insert(skill_huashen,char_juese_jineng[char_wujiang_f[t]][4][i])
			end
		end
		if #skill_huashen > 0 then
			push_message(char_juese[ID].name.."获得了一张武将牌")
			table.insert(huashen_paidui[ID],{char_juese_jineng[char_wujiang_f[t]][2],char_juese_jineng[char_wujiang_f[t]][5],{},char_wujiang_f[t],{}})
			for i = 1,2 do
				table.insert(huashen_paidui[ID][#huashen_paidui[ID]][3],char_juese_jineng[char_wujiang_f[t]][1][i])
			end
			for i = 1,#skill_huashen do
				table.insert(huashen_paidui[ID][#huashen_paidui[ID]][5],skill_huashen[i])
			end
			table.remove(char_wujiang_f,t)
			break
		else
			table.remove(char_wujiang_f,t)
		end
	end
end

function skills_weidi(ID)
	if char_juese[ID].shenfen ~= "主公" then
		local weidi_worked = false
		local weidi_get ={}
		for i = 1,5 do
			if i ~= ID and char_juese[i].shenfen == "主公" then
				for j = 1, #char_juese[i].skillname do
					if char_juese[i].skillname[j] == "激将" or char_juese[i].skillname[j] == "护驾" or char_juese[i].skillname[j] == "救援" or char_juese[i].skillname[j] == "黄天" or char_juese[i].skillname[j] == "血裔" or char_juese[i].skillname[j] == "暴虐" or char_juese[i].skillname[j] == "行殇" or char_juese[i].skillname[j] == "制霸" or char_juese[i].skillname[j] == "若愚" then
						weidi_worked = true
						table.insert(weidi_get, char_juese[i].skillname[j])
					end
				end
			end
		end
		if weidi_worked == true then
			push_message(char_juese[ID].name.."触发了技能 '伪帝' ")
			for i = 1, #weidi_get do
				table.insert(char_juese[ID].skillname, weidi_get[i])
				char_juese[ID].skill[weidi_get[i]] = "available"
			end
		end
	end
end

--  张角：雷击  --
function skills_leiji(va_list)
	local ID_s, _ID_mubiao
	ID_s = va_list[1]; _ID_mubiao = va_list[2]

	if ID == char_current_i then
		skills_leiji_enter()
	else
		skills_leiji_ai(va_list)
	end
end
function skills_leiji_enter()
	push_zhudong_queue(table.copy(funcptr_queue), funcptr_i)
	timer.stop()
	funcptr_queue = {}
	funcptr_i = 0

	local old_gamerun_status = gamerun_status
	gamerun_status = "确认操作"
	jiaohu_text = "是否发动 '雷击'?"
	gamerun_OK = false
	
	gamerun_OK_ptr = function()
		funcptr_queue = {}
	
		if gamerun_OK then
			skills_leiji_choose_mubiao(old_gamerun_status)
	    else
			set_hints("")
			gamerun_status = old_gamerun_status
			
			_leiji_huifu()
			funcptr_i = funcptr_i + 1
			timer.start(0.6)
		end
		platform.window:invalidate()
	end
	
	platform.window:invalidate()
end
function skills_leiji_choose_mubiao(old_gamerun_status)
	funcptr_queue = {}
	id = char_current_i
	skills_enter("请选择目标", "", "雷击", "技能选择-目标")
	gamerun_OK = false
	gamerun_select_target("init")

	gamerun_OK_ptr = function()
		if gamerun_OK == true then
			set_hints("")
			gamerun_status = old_gamerun_status

			_leiji_exe(char_current_i, gamerun_target_selected)
		end
	end
end
function skills_leiji_ai(va_list)
	local ID_s, _ID_mubiao
	ID_s = va_list[1]; _ID_mubiao = va_list[2]
	local ID_mubiao

	if char_juese[ID_s].shenfen == "主公" then
		ID_mubiao = ai_judge_leiji_mubiao(_ID_mubiao)
		if ID_mubiao < 0 then return end
	else
		ID_mubiao = _ID_mubiao
	end

	push_zhudong_queue(table.copy(funcptr_queue), funcptr_i)
	timer.stop()
	funcptr_queue = {}
	funcptr_i = 0
	
    _leiji_exe(ID_s, ID_mubiao)
end
function _leiji_exe(ID_s, ID_mubiao)
	push_message(table.concat({char_juese[ID_s].name .. "发动了武将技能 '雷击' (对", char_juese[ID_mubiao].name, ")"}))
	add_funcptr(_leiji_fan_panding, ID_mubiao)

	--  如场上有司马懿或张角，询问其改判技能  --
	skills_guicai_guidao_ask(ID_s, ID_mubiao, ID_s, "雷击")
	
	add_funcptr(_leiji_jiesuan, {ID_s, ID_mubiao})
	timer.start(0.6)
end
function _leiji_fan_panding(ID_s)
	--  翻开判定牌  --
	if #card_yixi == 0 then
	    card_xipai(true)
	end
    card_panding_card = card_yixi[1]
	table.remove(card_yixi, 1)
	push_message(table.concat({char_juese[ID_s].name .. "的判定牌是'", card_panding_card[2], card_panding_card[3], "的", card_panding_card[1], "'"}))
end
function _leiji_jiesuan(va_list)
	local ID_s, ID_mubiao
	ID_s = va_list[1]; ID_mubiao = va_list[2]

	timer.stop()
	funcptr_queue = {}
	funcptr_i = 0

	local yanse, huase, dianshu = ai_judge_cardinfo(ID_mubiao, {card_panding_card})

	--  曹丕颂威  --
	skills_judge_songwei(ID_s)

	if huase == "黑桃" then
		push_message(char_juese[ID_s].name .. "的 '雷击' 判定成功")
		skills_card_qi_panding(ID_mubiao)
		char_tili_deduct({2, ID_mubiao, ID_s, "雷", ID_mubiao})
	else
		push_message(char_juese[ID_s].name .. "的 '雷击' 判定失败")
		skills_card_qi_panding(ID_mubiao)
	end
	
	add_funcptr(_leiji_huifu)
	timer.start(0.6)
end
function _leiji_huifu()
	funcptr_queue, funcptr_i = pop_zhudong_queue()
end

--  弃判定牌  --
function skills_card_qi_panding(ID)
	if char_juese[ID].skill["天妒"] == "available" then
		add_funcptr(_qi_panding_exe, ID)
	else
		card_add_qipai(card_panding_card)
	end
end
function _qi_panding_exe(ID)
	timer.start(0.2)

	--  郭嘉天妒  --
	if char_juese[ID].skill["天妒"] ~= "available" or char_juese[ID].siwang == true then
		card_add_qipai(card_panding_card)
	else
		skills_tiandu({ID, card_panding_card})
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
		skills_losecard(char_i[i], 1, true)
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
	
		if gamerun_OK then
			_tuxi_target1()
	    else
			gamerun_status = ""
			_tuxi_huifu()
			funcptr_i = funcptr_i + 1
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
	skills_losecard(gamerun_target_selected, 1, true)

	if double then
		add_funcptr(_tuxi_sub1, {char_current_i, guankan_s})
		skills_losecard(guankan_s, 1, true)
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
	table.insert(char_juese[ID_s].shoupai, card)
end
function _tuxi_huifu()
	funcptr_queue, funcptr_i = pop_zhudong_queue()
end

--  庞统：连环  --
function skills_lianhuan_enter()
	if #char_juese[char_current_i].shoupai == 0 then return false end

	skills_enter("请选择草花牌", "'确定': 选择目标A '取消': 重铸", "铁锁连环", "技能选择-单牌")
	
	gamerun_OK_ptr = function()
		if gamerun_status == "技能选择-目标" then
			if gamerun_OK == true then
				--  进入阶段2  --
				guankan_s = gamerun_target_selected
				set_hints("'确定'：选择B '取消'：仅A")
				gamerun_status = "技能选择-目标B"
				gamerun_select_target("init")
				platform.window:invalidate()
			else
				--  重铸  --
				card_lian_chongzhu({card_highlighted, char_current_i})
				card_selected = {}
				card_highlighted = 1
				skills_cs()
				platform.window:invalidate()
			end
			return
		end
		
		if gamerun_status == "技能选择-目标B" then
			if gamerun_OK == true then
				skills_lianhuan(card_highlighted, char_current_i, guankan_s, gamerun_target_selected, true)
			else
				--  仅选择目标A  --
				skills_lianhuan(card_highlighted, char_current_i, gamerun_target_selected, 1, false)
			end
		end
	end
	
	gamerun_tab_ptr = function()
		if skills_judge_huase(char_current_i, "草花") then
			skills_enter_target()
		end
	end
	
	return true
end
function skills_lianhuan(ID_shoupai, ID_s, ID_first, ID_second, doubl)
	if skills_judge_huase(ID_s, "草花") then
		funcptr_queue = {}
		if card_lian_lianhuan({ID_shoupai}, ID_s, ID_first, ID_second, doubl) then
			skills_cs()
			consent_func_queue(0.6)
		end
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
			if skills_dimeng(char_current_i, guankan_s, gamerun_target_selected) then
				skills_cs_2()
				consent_func_queue(0.2)
			end
		end
		
		if gamerun_status == "技能选择-多牌" then
			skills_enter_target()
		end
	end
	
	gamerun_tab_ptr = function() end
	
	return true
end
function skills_dimeng(ID_s, ID_first, ID_second)
	if table.getn2(card_selected) ~= math.abs(#char_juese[ID_first].shoupai - #char_juese[ID_second].shoupai) then
		return false
	end
	
	funcptr_queue = {}
	set_hints("")
	gamerun_status = "手牌生效中"
	add_funcptr(push_message, char_juese[ID_s].name.."发动了武将技能 '缔盟'")
	char_juese[ID_s].skill["缔盟"] = "locked"
	
	if table.getn2(card_selected) > 0 then
		card_qipai_go()
		skills_losecard(ID_s, 9999, true)
	end

	add_funcptr(_dimeng_sub1, {ID_s, ID_first, ID_second})
	add_funcptr(_dimeng_lose_shoupai_1, ID_first)
	skills_losecard(ID_first, 9999, true)
	add_funcptr(_dimeng_lose_shoupai_2, ID_second)
	skills_losecard(ID_second, 9999, true)
	add_funcptr(_dimeng_exchange_shoupai, {ID_first, ID_second})
	add_funcptr(_dimeng_sub2)
	
	return true
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

	card_selected = {}
	card_highlighted = 1
	set_hints("请您出牌")
	gamerun_status = ""
end
function _dimeng_lose_shoupai_1(ID)
	push_message(table.concat({char_juese[ID].name, "失去了所有手牌"}))
	dimeng_shoupai_1 = table.copy(char_juese[ID].shoupai)
	char_juese[ID].shoupai = {}
end
function _dimeng_lose_shoupai_2(ID)
	push_message(table.concat({char_juese[ID].name, "失去了所有手牌"}))
	dimeng_shoupai_2 = table.copy(char_juese[ID].shoupai)
	char_juese[ID].shoupai = {}
end
function _dimeng_exchange_shoupai(va_list)
	local ID_first, ID_second
	ID_first = va_list[1]; ID_second = va_list[2]

	push_message(table.concat({char_juese[ID_first].name, "获得了", char_juese[ID_second].name, "的所有手牌"}))
	for i = 1, #dimeng_shoupai_2 do
		table.insert(char_juese[ID_first].shoupai, dimeng_shoupai_2[i])
	end

	push_message(table.concat({char_juese[ID_second].name, "获得了", char_juese[ID_first].name, "的所有手牌"}))
	for i = 1, #dimeng_shoupai_1 do
		table.insert(char_juese[ID_second].shoupai, dimeng_shoupai_1[i])
	end
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
		push_message(char_juese[id].name .. "放弃改判")
		return
	end

	push_zhudong_queue(table.copy(funcptr_queue), funcptr_i)
	funcptr_queue = {}
	funcptr_i = 0
	timer.stop()

	if skills_judge_guicai_guidao(id) == "鬼才" then
		push_message(char_juese[id].name .. "发动了武将技能 '鬼才'")
	else
		push_message(char_juese[id].name .. "发动了武将技能 '鬼道'")
	end

	local card = char_juese[id].shoupai[card_id]
	
	card_remove({id, card_id})
	skills_losecard(id, 0, true)

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
			push_message(char_juese[id].name .. "放弃改判")
			
			_guicai_guidao_huifu()
			funcptr_i = funcptr_i + 1
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
			skills_losecard(id, 0, true)
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
			push_message(char_juese[id].name .. "放弃改判")
			
			_guicai_guidao_huifu()
			funcptr_i = funcptr_i + 1
			timer.start(0.6)
		end
	end
end
function _guicai_guidao_exe(va_list)
	id = va_list[1]; card = va_list[2]

	if skills_judge_guicai_guidao(id) == "鬼道" then
		--  张角可将原有判定牌收入手牌  --
		table.insert(char_juese[id].shoupai, card_panding_card)
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

--  廖化：伏枥  --
function skills_fuli(id)
	local ID = id
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

	if char_juese[id].skill["伏枥"] ~= 1 then
		_fuli_huifu()
		--funcptr_i = funcptr_i + 1
		timer.start(0.6)
		return
	end
	
	if ID == char_current_i then
		skills_fuli_enter(ID)
	else
		skills_fuli_set(ID, ai_judge_fuli(ID))
	end
end
function skills_fuli_enter(ID)

	gamerun_status = "确认操作"
	jiaohu_text = "是否发动 '伏枥'?"
	gamerun_OK = false
	gamerun_OK_ptr = function()
		funcptr_queue = {}
		skills_fuli_set(char_current_i,gamerun_OK)
		
		gamerun_status = ""
		add_funcptr(_fuli_huifu)
		gamerun_status = ""
		timer.start(0.2)
	end
	
	platform.window:invalidate()
end
function skills_fuli_set(ID,gamerun_OK)
	local id = ID
	if gamerun_OK then
		msg = {char_juese[id].name, "发动了技能 '伏枥'"}
		push_message(table.concat(msg))
		char_juese[id].skill["伏枥"] = "locked_whole_game"
		local shili = {0,0,0,0,0,0}
		for i = 1,5 do
			if char_juese[i].siwang == false then
				if char_juese[i].shili == "蜀" then
					shili[1] = shili[1] + 1
				elseif char_juese[i].shili == "魏" then
					shili[2] = shili[2] + 1
				elseif char_juese[i].shili == "吴" then
					shili[3] = shili[3] + 1
				elseif char_juese[i].shili == "群" then
					shili[4] = shili[4] + 1
				elseif char_juese[i].shili == "晋" then
					shili[5] = shili[5] + 1
				elseif char_juese[i].shili == "神" then
					shili[6] = shili[6] + 1
				end
			end
		end
		local tili = 0
		for i = 1,6 do
			if shili[i] > 0 then
				tili = tili + 1
			end
		end
		char_juese[id].tili = math.min(tili,char_juese[id].tili_max)
		char_fanmian(id)
		if id ~= char_current_i then
			_fuli_huifu()
			timer.start(0.6)
		end
	else
		_fuli_huifu()
		--funcptr_i = funcptr_i + 1
		timer.start(0.6)
	end
	jiaohu_text = ""
end
function _fuli_huifu()
	funcptr_queue, funcptr_i = pop_zhudong_queue()
end

--  庞统：涅槃  --
function skills_niepan(id)
	local ID = id
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

	if char_juese[id].skill["涅槃"] ~= 1 then
		_niepan_huifu()
		--funcptr_i = funcptr_i + 1
		timer.start(0.6)
		return
	end
	
	if ID == char_current_i then
		skills_niepan_enter(ID)
	else
		skills_niepan_ai(ID, ai_judge_niepan(ID))
	end
end
function skills_niepan_ai(id, worked)
	if worked then
		add_funcptr(_niepan_lock, id)
		card_qipai_all(id, true)
		add_funcptr(_niepan_sub, id)
		add_funcptr(_niepan_huifu)
		gamerun_status = ""
		timer.start(0.2)
	else
		_niepan_huifu()
		--funcptr_i = funcptr_i + 1
		timer.start(0.6)
	end
end
function skills_niepan_enter(id)
	gamerun_status = "确认操作"
	jiaohu_text = "是否发动 '涅槃'?"
	gamerun_OK = false
	gamerun_OK_ptr = function()
		if gamerun_OK then
			funcptr_queue = {}
			add_funcptr(_niepan_lock, id)
			card_qipai_all(id, true)
			add_funcptr(_niepan_sub, id)
			add_funcptr(_niepan_huifu)
			gamerun_status = ""
			timer.start(0.2)
		else
			_niepan_huifu()
			funcptr_i = funcptr_i + 1
			timer.start(0.6)
		end
	end
	platform.window:invalidate()
end
function _niepan_lock(id)
	msg = {char_juese[id].name, "发动了技能 '涅槃'"}
	push_message(table.concat(msg))
	char_juese[id].skill["涅槃"] = "locked_whole_game"
end
function _niepan_sub(id) 
	char_juese[id].hengzhi = false
	char_juese[id].fanmian = false
	card_fenfa({id, 3, true})
	char_juese[id].tili = math.min(3,char_juese[id].tili_max)
end
function _niepan_huifu()
	funcptr_queue, funcptr_i = pop_zhudong_queue()
end

-- SP姜维：逢亮  --
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
			funcptr_i = funcptr_i + 1
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

	push_zhudong_queue(table.copy(funcptr_queue), funcptr_i)
	timer.stop()
	funcptr_queue = {}
	funcptr_i = 0

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
			
			_yiji_huifu()
			funcptr_i = funcptr_i + 1
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
		_yiji_exe({ID, bupai_mubiao})
		_yiji_exe({ID, bupai_mubiao})
	end
	add_funcptr(_yiji_huifu)
	timer.start(0.6)
end
function _yiji_exe(va_list)
	local ID_s, ID_mubiao
	ID_s = va_list[1]; ID_mubiao = va_list[2]
	gamerun_status = "手牌生效中"
	set_hints("")
	push_message(table.concat({char_juese[ID_s].name, "令", char_juese[ID_mubiao].name, "获得牌堆顶的一张牌"}))
    table.insert(char_juese[ID_mubiao].shoupai, card_yixi[1])
	table.remove(card_yixi, 1)
	if yiji_first_time == false then
		funcptr_queue = {}
		add_funcptr(_yiji_huifu)
		consent_func_queue(0.6)
	else
		funcptr_queue = {}
		yiji_first_time = false
		add_funcptr(skills_yiji_fenfa,yiji_gamerun_status)
		consent_func_queue(0.6)
	end
	timer.start(0.6)
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
			funcptr_i = funcptr_i + 1
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
			funcptr_i = funcptr_i + 1
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
		table.insert(char_juese[ID].shoupai, card_panding_card)

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
		funcptr_i = funcptr_i + 1
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
		table.insert(char_juese[ID_mubiao].shoupai, char_juese[ID_s].shoupai[ID_shoupai[i]])
		card_remove({ID_s, ID_shoupai[i]})
	end
	
	push_message(table.concat({char_juese[ID_s].name, "将", tostring(#ID_shoupai), "张手牌交给", char_juese[ID_mubiao].name}))
end
function _haoshi_huifu()
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
			funcptr_i = funcptr_i + 1
			timer.start(0.6)
		end
		platform.window:invalidate()
	end
	
	platform.window:invalidate()
end
function _jianxiong_exe(ID)
	push_message(char_juese[ID].name .. "发动了武将技能 '奸雄'")

	local msg
	msg = char_juese[ID].name .. "获得了"
	for i = 1, #card_jiesuan[1] do
		local card = card_jiesuan[1][i]
		msg = msg .. table.concat({"'", card[2], card[3], "的", card[1], "'"})
		if i ~= #card_jiesuan[1] then
			msg = msg .. "，"
		end
	end
	add_funcptr(push_message, msg)

	for i = 1, #card_jiesuan[1] do
		table.insert(char_juese[ID].shoupai, card_jiesuan[1][i])
	end
	card_jiesuan[1] = {}

	add_funcptr(_jianxiong_huifu)
	timer.start(0.6)
end
function _jianxiong_huifu()
	funcptr_queue, funcptr_i = pop_zhudong_queue()
end

--  祝融：巨象  --
function skills_juxiang(ID)
	push_message(char_juese[ID].name .. "触发了武将技能 '巨象'，获得了南蛮入侵")
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
			funcptr_i = funcptr_i + 1
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
				funcptr_i = funcptr_i + 1
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
			skills_losecard(ID_s, 0, true)
		else
			ai_withdraw(ID_s, ID_shoupai, ai_qi_zhuangbei_id, false)
			skills_losecard(ID_s, 0, true)
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
				funcptr_i = funcptr_i + 1
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
			funcptr_i = funcptr_i + 1
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
		skills_losecard(ID_s, 1, false)
	else
		ai_withdraw(ID_s, ID_shoupai, {}, false)
		skills_losecard(ID_s, 1, false)
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
	skills_losecard(gamerun_target_selected, 1, true)

	if double then
		add_funcptr(_qiaobian_mopai_sub1, {ID_s, guankan_s})
		skills_losecard(guankan_s, 1, true)
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
	table.insert(char_juese[ID_s].shoupai, card)
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
		skills_losecard(ID_mubiao, 9999, true)
	elseif ID_card == 2 then
		push_message(table.concat({char_juese[ID_s].name.."获得", char_juese[ID_mubiao].name, "的防具"}))
		char_juese[ID_s].fangju, char_juese[ID_mubiao].fangju = char_juese[ID_mubiao].fangju, char_juese[ID_s].fangju
		skills_losecard(ID_mubiao, 9999, true)
	elseif ID_card == 3 then
		push_message(table.concat({char_juese[ID_s].name.."获得", char_juese[ID_mubiao].name, "的-1马"}))
		char_juese[ID_s].gongma, char_juese[ID_mubiao].gongma = char_juese[ID_mubiao].gongma, char_juese[ID_s].gongma
		skills_losecard(ID_mubiao, 9999, true)
	elseif ID_card == 4 then
		push_message(table.concat({char_juese[ID_s].name.."获得", char_juese[ID_mubiao].name, "的+1马"}))
		char_juese[ID_s].fangma, char_juese[ID_mubiao].fangma = char_juese[ID_mubiao].fangma, char_juese[ID_s].fangma
		skills_losecard(ID_mubiao, 9999, true)
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

--  貂蝉：离间  --
function skills_lijian_ai(ID_shoupai, ID_s, ID_first, ID_second, ai_qi_zhuangbei_id)
	if char_juese[ID_first].xingbie ~= "男" or char_juese[ID_second].xingbie ~= "男" then
		return false
	end

	_lijian_exe(ID_shoupai, ID_s, ID_first, ID_second, ai_qi_zhuangbei_id)
	return true
end
function skills_lijian_enter()
	if #char_juese[char_current_i].shoupai == 0 and ai_arm_stat(char_current_i) == 0 then
		return false
	end

	local n_male = 0
	for i = 1, 5 do
		if i ~= char_current_i and char_juese[i].xingbie == "男" then
			n_male = n_male + 1
		end
	end
	if n_male < 2 then
		return false
	end

	gamerun_wuqi_into_hand(char_current_i)
	skills_enter("请选择一张牌", "请选择目标A", "决斗", "技能选择-单牌")
	
	gamerun_OK_ptr = function()
		if gamerun_status == "技能选择-目标" then
			if char_juese[gamerun_target_selected].xingbie == "男" and gamerun_OK == true then
				--  进入阶段2  --
				guankan_s = gamerun_target_selected
				set_hints("请选择目标B")
				gamerun_status = "技能选择-目标B"
				gamerun_select_target("init")
				platform.window:invalidate()
			end
			return
		end
		
		if gamerun_status == "技能选择-目标B" then
			if char_juese[gamerun_target_selected].xingbie == "男" and gamerun_OK == true then
				_lijian_exe(card_highlighted, char_current_i, guankan_s, gamerun_target_selected)
			end
		end
	end
	
	gamerun_tab_ptr = function()
		if table.getn2(card_selected) == 1 then
			skills_enter_target()
		end
	end
	
	return true
end
function _lijian_exe(ID_shoupai, ID_s, ID_first, ID_second, ai_qi_zhuangbei_id)
	funcptr_queue = {}
	
	if ID_s == char_current_i then
		local card = char_juese[ID_s].shoupai[ID_shoupai]
		card_add_qipai(card)
		card_remove({ID_s, ID_shoupai})
		gamerun_wuqi_out_hand(char_current_i)

		add_funcptr(push_message, table.concat({char_juese[ID_s].name, "弃掉了'", card[2], card[3], "的", card[1], "'"}))
		skills_losecard(ID_s, 1, true)
	else
		ai_withdraw(ID_s, {ID_shoupai}, ai_qi_zhuangbei_id, true)
		skills_losecard(ID_s, 9999, true)
	end

	add_funcptr(push_message, char_juese[ID_s].name .. "发动了武将技能 '离间'")
	char_juese[ID_s].skill["离间"] = "locked"

	--  插入虚拟无色无点牌  --
	table.insert(char_juese[ID_first].shoupai, {"决斗", "", ""})

	card_juedou({#char_juese[ID_first].shoupai}, ID_first, ID_second)
	skills_cs()
	consent_func_queue(0.6)
end

--  SP貂蝉：离魂  --
function skills_lihun_ai(ID_shoupai, ID_s, ID_mubiao)
	if char_juese[ID_mubiao].xingbie ~= "男" then
		return false
	end

	_lihun_exe(ID_shoupai, ID_s, ID_mubiao)
	return true
end
function skills_lihun_enter()
	if #char_juese[char_current_i].shoupai == 0 then
		return false
	end

	local n_male = 0
	for i = 1, 5 do
		if i ~= char_current_i and char_juese[i].xingbie == "男" then
			n_male = n_male + 1
		end
	end
	if n_male < 1 then
		return false
	end

	skills_enter("请选择一张牌", "请选择目标", "离魂", "技能选择-单牌")
	
	gamerun_OK_ptr = function()
		if gamerun_status == "技能选择-目标" then
			if char_juese[gamerun_target_selected].xingbie == "男" and gamerun_OK == true then
				_lihun_exe(card_highlighted, char_current_i, gamerun_target_selected)
				gamerun_status = ""
				set_hints("")
			end
			return
		end
	end
	
	gamerun_tab_ptr = function()
		if table.getn2(card_selected) == 1 then
			skills_enter_target()
		end
	end
	
	return true
end
function _lihun_exe(ID_shoupai, ID_s, ID_mubiao)
	funcptr_queue = {}

	local card = char_juese[ID_s].shoupai[ID_shoupai]
	card_add_qipai(card)
	card_remove({ID_s, ID_shoupai})
	skills_losecard(ID_s, 1, true)
	add_funcptr(push_message, table.concat({char_juese[ID_s].name, "弃掉了'", card[2], card[3], "的", card[1], "'"}))

	add_funcptr(push_message, char_juese[ID_s].name .. "发动了武将技能 '离魂'")
	add_funcptr(push_message, char_juese[ID_s].name .. "获得了" .. char_juese[ID_mubiao].name .. "的所有手牌")
	char_juese[ID_s].skill["离魂"] = "locked"

	for i = #char_juese[ID_mubiao].shoupai, 1, -1 do
		table.insert(char_juese[ID_s].shoupai,char_juese[ID_mubiao].shoupai[i])
		table.remove(char_juese[ID_mubiao].shoupai,i)
	end
	skills_losecard(ID_mubiao, 9999, true)

	char_fanmian(ID_s)
	lihun_target = ID_mubiao
	skills_cs()
	consent_func_queue(0.2)
end
function skills_lihun_stage_2_enter()
	if char_juese[lihun_target].siwang ~= true then
		push_zhudong_queue(table.copy(funcptr_queue), funcptr_i)
		timer.stop()
		funcptr_queue = {}
		funcptr_i = 0

		local n_geipai = math.min(char_juese[lihun_target].tili,ai_card_stat(char_acting_i, true, false))

		skills_enter("您需给出" .. tostring(n_geipai) .. "张牌", "", "离魂", "技能选择-多牌")
		gamerun_OK = false
		gamerun_tab_ptr = nil
		gamerun_wuqi_into_hand(char_acting_i)
		gamerun_OK_ptr = function()
			if gamerun_OK == true then
				if table.getn2(card_selected) ~= n_geipai then
					--gamerun_wuqi_out_hand(char_acting_i)
					return
				end
				local ID_shoupai, ID_zhuangbei = {},{}
				for i = -4, -1, 1 do
					if card_selected[i] ~= nil then
						ID_zhuangbei[-i] = 1
					end
				end
				for i = 1, table.maxn(card_selected), 1 do
					if card_selected[i] ~= nil then
						table.insert(ID_shoupai,i)
					end
				end
				set_hints("")
				gamerun_status = ""

				add_funcptr(_lihun_exe_2, {char_current_i, lihun_target, ID_shoupai, ID_zhuangbei})
				skills_losecard(char_current_i, 9999, true)

				add_funcptr(gamerun_wuqi_out_hand,char_acting_i)
				add_funcptr(_lihun_huifu)
				timer.start(0.2)
			end
		end
	else
		lihun_target = nil
		on.escapeKey()
	end
end
function _lihun_exe_2(va_list)
	local ID_s, ID_mubiao, ID_shoupai, ID_zhuangbei
	ID_s = va_list[1]; ID_mubiao = va_list[2]; ID_shoupai = va_list[3]; ID_zhuangbei = va_list[4]
	card_selected = {}
	local n_zhuangbei = 0
	for i = #ID_shoupai, 1, -1 do
		table.insert(char_juese[ID_mubiao].shoupai, char_juese[ID_s].shoupai[ID_shoupai[i]])
		card_remove({ID_s, ID_shoupai[i]})
	end
	if ID_zhuangbei[1] == 1 then
		table.insert(char_juese[ID_mubiao].shoupai, char_juese[ID_s].wuqi)
		char_juese[ID_s].wuqi = {}
		n_zhuangbei = n_zhuangbei + 1
	end

	if ID_zhuangbei[2] == 1 then
		table.insert(char_juese[ID_mubiao].shoupai, char_juese[ID_s].fangju)
		char_juese[ID_s].fangju = {}
		n_zhuangbei = n_zhuangbei + 1
	end

	if ID_zhuangbei[3] == 1 then
		table.insert(char_juese[ID_mubiao].shoupai, char_juese[ID_s].gongma)
		char_juese[ID_s].gongma = {}
		n_zhuangbei = n_zhuangbei + 1
	end

	if ID_zhuangbei[4] == 1 then
		table.insert(char_juese[ID_mubiao].shoupai, char_juese[ID_s].fangma)
		char_juese[ID_s].fangma = {}
		n_zhuangbei = n_zhuangbei + 1
	end
	push_message(table.concat({char_juese[ID_s].name, "将", tostring(#ID_shoupai+n_zhuangbei), "张牌交给", char_juese[ID_mubiao].name}))
	lihun_target = nil
end
function _lihun_huifu()
	funcptr_queue, funcptr_i = pop_zhudong_queue()
	on.escapeKey()
end


--  小乔：天香  --
function skills_tianxiang(va_list)
	local ID, dianshu, shuxing, deduct_va
	ID = va_list[1]; dianshu = va_list[2]; shuxing = va_list[3]; deduct_va = va_list[4]

	if ID == char_current_i then
		skills_tianxiang_enter(dianshu, shuxing, deduct_va)
	else
		skills_tianxiang_ai(ID, dianshu, shuxing, deduct_va)
	end
end
function skills_tianxiang_ai(ID, dianshu, shuxing, deduct_va)
	local fadong, ID_shoupai, ID_mubiao
	fadong, ID_shoupai, ID_mubiao = ai_judge_tianxiang(ID, dianshu, shuxing)

	if fadong == false then
		return
	end

	push_zhudong_queue(table.copy(funcptr_queue), funcptr_i)
	timer.stop()
	funcptr_queue = {}
	funcptr_i = 0

	_tianxiang_exe(ID_shoupai, ID, ID_mubiao, dianshu, deduct_va)
end
function skills_tianxiang_enter(dianshu, shuxing, deduct_va)
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
			_tianxiang_select_target(dianshu, shuxing, deduct_va, old_gamerun_status)
		else
			gamerun_status = old_gamerun_status
			_tianxiang_huifu()
			funcptr_i = funcptr_i + 1
			timer.start(0.6)
		end
	end

	platform.window:invalidate()
end
function _tianxiang_select_target(dianshu, shuxing, deduct_va, old_gamerun_status)
	skills_enter("请选择红桃牌", "请选择目标", "天香", "技能选择-单牌")
	gamerun_OK_ptr = function()
		if gamerun_status == "技能选择-目标" then
			if gamerun_OK == true then
				if table.getn2(card_selected) == 1 and char_juese[char_current_i].shoupai[card_highlighted][2] == "红桃" then
					_tianxiang_exe(card_highlighted, char_current_i, gamerun_target_selected, dianshu, deduct_va)
				end
			end
			return
		end
		
		if gamerun_status == "技能选择-单牌" then
			if gamerun_OK == false then
				gamerun_status = old_gamerun_status
				set_hints("")
				_tianxiang_huifu()
				funcptr_i = funcptr_i + 1
				timer.start(0.6)
			end
			return
		end
	end
	
	gamerun_tab_ptr = function()
		if table.getn2(card_selected) == 1 and char_juese[char_current_i].shoupai[card_highlighted][2] == "红桃" then
			skills_enter_target()
		end
	end
end
function _tianxiang_exe(ID_shoupai, ID, ID_mubiao, dianshu, deduct_va)
	gamerun_status = "手牌生效中"
	set_hints("")
	card_selected = {}

	add_funcptr(_tianxiang_sub1, {ID_shoupai, ID})
	skills_losecard(ID, 1, true)
	
	add_funcptr(push_message, char_juese[ID].name .. "发动了武将技能 '天香' (对" .. char_juese[ID_mubiao].name .. ")")

	deduct_va[1] = dianshu
	deduct_va[2] = ID_mubiao
	deduct_va[5] = ID_mubiao
	char_tili_deduct(deduct_va)

	add_funcptr(_tianxiang_mopai, ID_mubiao)
	timer.start(0.6)
end
function _tianxiang_sub1(va_list)
	local ID_shoupai, ID
	ID_shoupai = va_list[1]; ID = va_list[2]

	local card = char_juese[ID].shoupai[ID_shoupai]
	card_add_qipai(card)
	card_remove({ID, ID_shoupai})
	push_message(table.concat({char_juese[ID].name, "弃掉了", card[2], card[3], "的", card[1]}))
end
function _tianxiang_huifu()
	funcptr_queue, funcptr_i = pop_zhudong_queue()
end
function _tianxiang_remove_last_deduct()		--  天香：从函数队列中删除上一个伤害队列
	local v_funcptr_queue, v_funcptr_i
	v_funcptr_queue, v_funcptr_i = pop_zhudong_queue()

	local items_to_remove = {}
	local keep_after = false
	for i = 1, #v_funcptr_queue do
		local tag = v_funcptr_queue[i].tag

		if tag ~= nil then
			if string.find(tag, "体力扣减") and keep_after == false then
				keep_after = true
			end

			if string.find(tag, "体力扣减") or keep_after == false then
				table.insert(items_to_remove, i)
			else
				break
			end
		else
			if keep_after == false then
				table.insert(items_to_remove, i)
			else
				break
			end
		end
	end

	for i = #items_to_remove, 1, -1 do
		table.remove(v_funcptr_queue, items_to_remove[i])
	end

	funcptr_queue = v_funcptr_queue
	funcptr_i = 0
end
function _tianxiang_mopai(ID_mubiao)
	local lost_tili = char_juese[ID_mubiao].tili_max - char_juese[ID_mubiao].tili
	card_fenfa({ID_mubiao, lost_tili, true})
	_tianxiang_remove_last_deduct()
end

--  失去手牌触发技能结算  --
function skills_losecard(ID_juese, n_card, in_queue)
	local sub = false

	--  张春华在手牌不足时摸牌  --
	if char_juese[ID_juese].skill["伤逝"] == "available" and #char_juese[ID_juese].shoupai - n_card < char_juese[ID_juese].tili_max - char_juese[ID_juese].tili then
		if in_queue then
			add_funcptr(skills_shangshi, ID_juese)
		else
			skills_shangshi(ID_juese, true)
			sub = true
		end
	end

	--  陆逊在失去最后手牌时摸一张牌  --
	if char_juese[ID_juese].skill["连营"] == "available" and #char_juese[ID_juese].shoupai <= n_card then
		if in_queue then
			add_funcptr(skills_lianying, ID_juese)
		elseif sub == false then
			skills_lianying(ID_juese)
		end
	end

	--  孙尚香在失去装备时摸两张牌  --
	if char_juese[ID_juese].skill["枭姬"] == "available" then
		if in_queue then
			add_funcptr(skills_xiaoji, ID_juese)
		end
	end

	--[[--  凌统在失去装备时弃别人两张牌  --
	if char_juese[ID_juese].skill["旋风"] == "available" then
		if in_queue then
			add_funcptr(skills_xuanfeng, ID_juese)
		end
	end]]
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

	push_zhudong_queue(table.copy(funcptr_queue), funcptr_i)
	timer.stop()
	funcptr_queue = {}
	funcptr_i = 0

	_guzheng_exe({ID_paidui, ID_s, ID_mubiao})
end
function skills_guzheng_enter(ID_mubiao)
	push_zhudong_queue(table.copy(funcptr_queue), funcptr_i)
	timer.stop()
	funcptr_queue = {}
	funcptr_i = 0

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
			_guzheng_huifu()
			funcptr_i = funcptr_i + 1
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
	add_funcptr(_guzheng_huifu)
	timer.start(0.2)
end
function _guzheng_return_card(va_list)
	local ID_paidui, ID_s, ID_mubiao
	ID_paidui = va_list[1]; ID_s = va_list[2]; ID_mubiao = va_list[3]

	local card = wugucards[ID_paidui]

	push_message(table.concat({char_juese[ID_s].name, "将", "'", card[2], card[3], "的", card[1], "'交给", char_juese[ID_mubiao].name}))
	table.insert(char_juese[ID_mubiao].shoupai, card)
	table.remove(wugucards, ID_paidui)
end
function _guzheng_get_cards(va_list)
	local ID_paidui, ID_s, ID_mubiao
	ID_paidui = va_list[1]; ID_s = va_list[2]; ID_mubiao = va_list[3]

	push_message(table.concat({char_juese[ID_s].name, "获得了其余弃牌"}))
	for i = 1, #wugucards do
		table.insert(char_juese[ID_s].shoupai, wugucards[i])
	end
	wugucards = {}
end
function _guzheng_huifu()
	funcptr_queue, funcptr_i = pop_zhudong_queue()
end

--  庞德：猛进  --
function skills_mengjin(va_list)
	local ID_s, ID_mubiao
	ID_s = va_list[1]; ID_mubiao = va_list[2]

	if char_juese[ID_s].siwang == true or char_juese[ID_mubiao].siwang == true or ai_card_stat(ID_mubiao, true, false) == 0 then
		return
	end

	push_zhudong_queue(table.copy(funcptr_queue), funcptr_i)
	timer.stop()
	funcptr_queue = {}
	funcptr_i = 0

	if ID_s == char_current_i then
		fankui_gamerun_status = gamerun_status
		skills_mengjin_enter(ID_mubiao)
	else
		skills_mengjin_ai(ID_s, ID_mubiao)
	end
end
function skills_mengjin_enter(ID_mubiao)
	local old_gamerun_status = gamerun_status
	gamerun_status = "确认操作"
	jiaohu_text = "是否发动 '猛进'?"
	gamerun_OK = false
	
	gamerun_OK_ptr = function()
		funcptr_queue = {}
		gamerun_status = old_gamerun_status; set_hints("")
	
		if gamerun_OK then
			push_message(char_juese[char_current_i].name .. "发动了武将技能 '猛进'")
			_mengjin_exe({char_current_i, ID_mubiao})
	    else
			set_hints("")
			gamerun_status = old_gamerun_status
			
			_fankui_huifu()
			funcptr_i = funcptr_i + 1
			timer.start(0.6)
		end
		platform.window:invalidate()
	end
	platform.window:invalidate()
end
function skills_mengjin_ai(ID, ID_mubiao)
	if ai_card_stat(ID_mubiao, true, false) > 0 then
		push_message(char_juese[ID].name .. "发动了武将技能 '猛进'")
		add_funcptr(_mengjin_exe, {ID, ID_mubiao})
		skills_losecard(ID_mubiao, 9999, true)
	end
	add_funcptr(_fankui_huifu)
	timer.start(0.6)
end
function _mengjin_exe(va_list)
	local ID_s, ID_mubiao
	ID_s = va_list[1]; ID_mubiao = va_list[2]

	if ID_s == char_current_i then
		_mengjin_exe_2({ID_s, ID_mubiao})
	else
		_chai_ai({ID_s, ID_mubiao, true})
	end
end
function _mengjin_exe_2(va_list)
    local i
	local ID_s, ID_d
	ID_s = va_list[1]; ID_d = va_list[2]
	fankui_gamerun_status = gamerun_status
	gamerun_status = "观看手牌-猛进"
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

	push_zhudong_queue(table.copy(funcptr_queue), funcptr_i)
	timer.stop()
	funcptr_queue = {}
	funcptr_i = 0

	_liuli_exe(ID_shoupai, ID_sha, ID_sha_mubiao, ID_transfer, sha_mubiao_i)
end
function skills_liuli_enter(card_shoupai, ID_sha, sha_mubiao_i)
	push_zhudong_queue(table.copy(funcptr_queue), funcptr_i)
	timer.stop()
	funcptr_queue = {}
	funcptr_i = 0

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
			_liuli_huifu()
			funcptr_i = funcptr_i + 1
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
				if table.getn2(card_selected) == 1 and card_if_d_limit("流离", char_current_i, gamerun_target_selected) then
					_liuli_exe(card_highlighted, ID_sha, char_current_i, gamerun_target_selected, sha_mubiao_i)
				end
			end
			return
		end
		
		if gamerun_status == "技能选择-单牌" then
			if gamerun_OK == false then
				gamerun_status = old_gamerun_status
				set_hints("")
				_liuli_huifu()
				funcptr_i = funcptr_i + 1
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
	skills_losecard(ID_sha_mubiao, 1, true)
	
	add_funcptr(push_message, char_juese[ID_sha_mubiao].name .. "发动了武将技能 '流离'")
	add_funcptr(push_message, table.concat({char_juese[ID_sha_mubiao].name .. "将", char_juese[ID_sha].name, "的'杀'转移给", char_juese[ID_transfer].name}))

	char_sha_mubiao[sha_mubiao_i] = ID_transfer

	add_funcptr(_liuli_huifu)
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
function _liuli_huifu()
	funcptr_queue, funcptr_i = pop_zhudong_queue()
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
	timer.start(0.2)
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
			funcptr_i = funcptr_i + 1
		end
		timer.start(0.2)
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
			funcptr_i = funcptr_i + 1
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
	if ai_judge_hujia(ID_req, ID_res) == false then
		push_message(table.concat({char_juese[ID_res].name, "不响应"}))
		return
	end

	local c_pos = ai_chazhao_shan(ID_res, char_juese[ID_res].shoupai)
	if c_pos < 0 then
		push_message(table.concat({char_juese[ID_res].name, "不响应"}))
		return
	end

	push_zhudong_queue(table.copy(funcptr_queue), funcptr_i)
	timer.stop()
	funcptr_queue = {}
	funcptr_i = 0

	_hujia_exe(ID_req, ID_res, c_pos, mode, va)
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

		if gamerun_OK == true then
			_hujia_select_card(ID_req, mode, va, old_gamerun_status)
		else
			gamerun_status = old_gamerun_status
			push_message(table.concat({char_juese[char_current_i].name, "不响应"}))
			_hujia_huifu()
			funcptr_i = funcptr_i + 1
		end
		timer.start(0.6)
	end
	
	platform.window:invalidate()
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
			push_message(table.concat({char_juese[char_current_i].name, "不响应"}))
			_hujia_huifu()
			funcptr_i = funcptr_i + 1
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

	push_message(table.concat({char_juese[ID_res].name, "响应"}))
	add_funcptr(_sha_shan, {ID_res, ID_shoupai})
	
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
function _hujia_huifu()
	funcptr_queue, funcptr_i = pop_zhudong_queue()
end