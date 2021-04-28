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
	jiaohu_text = "是否发动 '焚心' 与"..char_juese[ID_mubiao].name.."换身份?"
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
		--funcptr_i = funcptr_i + 1
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
	local ID, ID_shanghai = va_list[1], va_list[2]
	skills_push_queue()

	push_message(char_juese[ID].name .. "触发了武将技能 '断肠'")
	add_funcptr(_duanchang_lose_skills, ID_shanghai)
	skills_withdraw_outgame(ID_shanghai)

	if char_buqu[ID_shanghai] == true then
		--  周泰在不屈状态下失去所有技能，立即进入濒死状态  --
		_buqu_lose_all_skills(ID_shanghai)
	end

	add_funcptr(skills_pop_queue)
	timer.start(0.6)
end
function _duanchang_lose_skills(ID_shanghai)
	push_message(char_juese[ID_shanghai].name .. "失去所有武将技能")

	--  左慈变回原来身份  --
	if char_juese[ID_shanghai].skill["化身"] == "available" then
		local name = char_juese[ID_shanghai].name
		char_juese[ID_shanghai].shili = char_juese_jineng[name][2]
		char_juese[ID_shanghai].xingbie = char_juese_jineng[name][5]
	end

	--  袁术失去所有主公技  --
	if char_juese[ID_shanghai].shenfen == "主公" then
		for i = 1, 5 do
			if i ~= ID_shanghai and char_juese[i].skill["伪帝"] == "available" and char_juese[i].siwang == false then
				local lordskill_list = {"激将", "护驾", "救援", "黄天", "血裔", "颂威", "暴虐", "若愚", "制霸"}
				for j = 1, #lordskill_list do
					if char_juese[ID_shanghai].skill[lordskill_list[j]] == "available" and char_juese[i].skill[lordskill_list[j]] == "available" then
						char_juese[i].skill[lordskill_list[j]] = nil
						for k = 1, #char_juese[i].skillname do
							if char_juese[i].skillname[k] == lordskill_list[j] then
								table.remove(char_juese[i].skillname, k)
								break
							end
						end
					end
				end
			end
		end
	end

	char_juese[ID_shanghai].skill = {}
	char_juese[ID_shanghai].skillname = {}
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
		--funcptr_i = funcptr_i + 1
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
		local yanse, huase, dianshu = ai_judge_cardinfo(ID, {v})
	    if yanse == "红色" then
		    return i
		end
	end

	if #char_juese[ID].gongma ~= 0 then
		local yanse, huase, dianshu = ai_judge_cardinfo(ID, {char_juese[ID].gongma})
	    if yanse == "红色" then
		    return -3
		end
	end

	if #char_juese[ID].fangma ~= 0 then
		local yanse, huase, dianshu = ai_judge_cardinfo(ID, {char_juese[ID].fangma})
	    if yanse == "红色" then
		    return -4
		end
	end

	if #char_juese[ID].wuqi ~= 0 then
		local yanse, huase, dianshu = ai_judge_cardinfo(ID, {char_juese[ID].wuqi})
	    if yanse == "红色" then
		    return -1
		end
	end

	if #char_juese[ID].fangju ~= 0 then
		local yanse, huase, dianshu = ai_judge_cardinfo(ID, {char_juese[ID].fangju})
	    if yanse == "红色" then
		    return -2
		end
	end
	
	return -5
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
	skills_push_queue()

	if char_acting_i == char_current_i then
		skills_benghuai_enter()
	else
		skills_benghuai_ai()
	end
end
function skills_benghuai_ai()
	push_message(char_juese[char_acting_i].name .. "触发了武将技能 '崩坏'")
	if ai_judge_benghuai(char_acting_i) == false then
		add_funcptr(_benghuai_reduce_max, char_acting_i)
	else
		char_tili_deduct({1, char_acting_i, -1, "流失", char_acting_i})
	end

	add_funcptr(skills_pop_queue)
	timer.start(0.6)
end
function skills_benghuai_enter()    --  进入崩坏状态
	gamerun_huihe = "结束"
	gamerun_status = "选项选择"
	choose_name = table.concat({"崩坏 (当前体力", char_juese[char_current_i].tili, "/", char_juese[char_current_i].tili_max, ")"})
	jiaohu_text = "请选择要执行的效果"
	if char_juese[char_current_i].tili_max > 1 then
		choose_option = {"失去1点体力", "扣减1点体力上限"}
	else
		choose_option = {"失去1点体力"}
	end
	
	txt_messages:setVisible(false)
	gamerun_guankan_selected = 1
	item_disrow = 0

	gamerun_item = function(i)
		set_hints("")
		gamerun_status = ""
		txt_messages:setVisible(true)

		if i == 2 then
			if char_juese[char_current_i].tili_max > 1 then
				add_funcptr(push_message, char_juese[char_current_i].name .. "触发了武将技能 '崩坏'")
				add_funcptr(_benghuai_reduce_max, char_current_i)

				add_funcptr(skills_pop_queue)
				timer.start(0.6)
			end
		else
			add_funcptr(push_message, char_juese[char_current_i].name .. "触发了武将技能 '崩坏'")
			char_tili_deduct({1, char_current_i, -1, "流失", char_current_i})

			add_funcptr(skills_pop_queue)
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

--  华佗：青囊  --
function skills_qingnang_enter()
	if #char_juese[char_current_i].shoupai == 0 then return false end

	skills_enter("请选择一张手牌", "请选择目标", "青囊", "技能选择-单牌")
	gamerun_OK = false

	gamerun_OK_ptr = function()
		if table.getn2(card_selected) > 0 then
			if skills_qingnang(card_highlighted, char_current_i, gamerun_target_selected) then
				skills_cs()
				card_selected = {}
				card_highlighted = 1
			end
		end
	end
	
	gamerun_tab_ptr = function()
		skills_enter_target()
		gamerun_status = "技能选择-目标B"
		gamerun_target_selected = char_current_i
		guankan_s = -1

		platform.window:invalidate()
	end
	
	return true
end
function skills_qingnang(ID_shoupai, ID_s, ID_mubiao)
	if char_juese[ID_mubiao].tili == char_juese[ID_mubiao].tili_max then
		return false
	end

	funcptr_queue = {}
	funcptr_i = 0

	gamerun_status = "手牌生效中"
	set_hints("")
	char_juese[ID_s].skill["青囊"] = "locked"

	add_funcptr(push_message, table.concat({char_juese[ID_s].name, "发动了武将技能 '青囊'"}))
	add_funcptr(_qingnang_sub2, {ID_shoupai, ID_s})
	char_tili_huifu(ID_mubiao, 1)
	add_funcptr(_fanjian_sub4)
	timer.start(0.6)

	return true
end
function _qingnang_sub2(va_list)
	local ID_shoupai, ID_s
	ID_shoupai = va_list[1]; ID_s = va_list[2]

	local card = char_juese[ID_s].shoupai[ID_shoupai]
	push_message(table.concat({char_juese[ID_s].name, "弃掉了'", card[2], card[3], "的", card[1], "'"}))
	card_add_qipai(card)
	card_remove({ID_s, ID_shoupai})
end

--  董卓：酒池  --
function skills_jiuchi_enter()
	if #char_juese[char_current_i].shoupai == 0 then return false end

	skills_enter("请选择黑桃手牌", "使用酒", "酒", "技能选择-单牌")
	
	gamerun_OK_ptr = function()
		skills_jiuchi(char_current_i)
	end
	
	gamerun_tab_ptr = function() end
	
	return true
end
function skills_jiuchi(ID)
	if table.getn2(card_selected) == 0 then
		return
	end

	local yanse, huase, dianshu = ai_judge_cardinfo(ID, {char_juese[ID].shoupai[card_highlighted]})
	if huase == "黑桃" then
		funcptr_queue = {}
		if card_jiu({card_highlighted, char_current_i, false}) then
			skills_cs()
			skills_rst()
		end
	end
end

--  袁绍：乱击  --
function skills_luanji_ai(ID, ID_shoupai)
	return skills_luanji(ID, ID_shoupai)
end
function skills_luanji_enter()
	if #char_juese[char_current_i].shoupai == 0 then return false end

	skills_enter("请选择两张同花色牌", "使用万箭齐发", "万箭齐发", "技能选择-多牌")
	
	gamerun_OK_ptr = function()
		local ID_shoupai = skills_get_selected_shoupai()
		skills_luanji(char_current_i, ID_shoupai)
	end
	
	gamerun_tab_ptr = function()
		local ID_shoupai = skills_get_selected_shoupai()
		if skills_judge_luanji(char_current_i, ID_shoupai) then
			set_hints(skill_text_2)
		else
			set_hints(skill_text_1)
		end
	end
	
	return true
end
function skills_judge_luanji(ID, ID_shoupai)
	local shoupai = char_juese[ID].shoupai

	if #ID_shoupai == 2 then
		local yanse1, huase1, dianshu1 = ai_judge_cardinfo(ID, {shoupai[ID_shoupai[1]]})
		local yanse2, huase2, dianshu2 = ai_judge_cardinfo(ID, {shoupai[ID_shoupai[2]]})

		if huase1 == huase2 then
			return true
		end
	end
	return false
end
function skills_luanji(ID, ID_shoupai)
	if skills_judge_luanji(ID, ID_shoupai) then
		funcptr_queue = {}
		
		if card_wanjian(ID_shoupai, ID) then
			skills_cs()
		    consent_func_queue(0.6)
			return true
		end
	end
	return false
end

--  左慈：化身 --
function skills_huashen(va_list)
	local ID, jieduan
	ID = va_list[1]; jieduan = va_list[2]

	if ID == char_current_i then
		skills_huashen_enter(ID)
	else
		skills_huashen_ai(ID, jieduan)
	end
end
function skills_huashen_ai(ID, jieduan)
	skills_push_queue()

	local wujiang_skills_gong = {}
	local wujiang_skills_fang = {}
	local wujiang_skills_misc = {}
	local wujiang_skill, option

	for i = 1, #huashen_paidui[ID] do
		for j = 1, #huashen_paidui[ID][i][5] do
			local skillname = huashen_paidui[ID][i][5][j]
			if char_jineng_gong[skillname] == 1 then
				table.insert(wujiang_skills_gong, {i, skillname})
			elseif char_jineng_fang[skillname] == 1 then
				table.insert(wujiang_skills_fang, {i, skillname})
			elseif char_jineng_jin[skillname] ~= 1 then
				table.insert(wujiang_skills_misc, {i, skillname})
			end
		end
	end

	if jieduan == "游戏开始" or jieduan == "回合结束" then
		if #wujiang_skills_fang > 0 then
			wujiang_skill = random_pick(wujiang_skills_fang, 1)[1]
		elseif #wujiang_skills_misc > 0 then
			wujiang_skill = random_pick(wujiang_skills_misc, 1)[1]
		else
			wujiang_skill = random_pick(wujiang_skills_gong, 1)[1]
		end
	elseif jieduan == "回合开始" then
		if #wujiang_skills_gong > 0 then
			wujiang_skill = random_pick(wujiang_skills_gong, 1)[1]
		elseif #wujiang_skills_misc > 0 then
			wujiang_skill = random_pick(wujiang_skills_misc, 1)[1]
		else
			wujiang_skill = random_pick(wujiang_skills_fang, 1)[1]
		end
	end

	option = wujiang_skill[1]
	if huashen_wujiang[ID] ~= nil and huashen_skill[ID] ~= nil then
		option = option + 1
		if huashen_skill[ID] == wujiang_skill[2] then
			skills_pop_queue()
			timer.start(0.2)
			return
		end
	end

	_huashen_bianshen_exe(ID, option, nil, jieduan)
	timer.start(0.2)
end
function skills_huashen_enter(ID)
	skills_push_queue()
	local old_gamerun_status = gamerun_status

	gamerun_status = "选项选择"
	choose_name = "化身"
	jiaohu_text = "请选择要化身的武将"
	if huashen_wujiang[ID] ~= nil and huashen_skill[ID] ~= nil then
		choose_option = {"不替换"}
	else
		choose_option = {}
	end

	for i = 1, #huashen_paidui[ID] do
		table.insert(choose_option, huashen_paidui[ID][i][4].." "..huashen_paidui[ID][i][1].." "..huashen_paidui[ID][i][2].." "..huashen_paidui[ID][i][3][2].."/"..huashen_paidui[ID][i][3][1])
	end

	txt_messages:setVisible(false)
	gamerun_guankan_selected = 1
	item_disrow = 0

	gamerun_item = function(i)
		funcptr_queue = {}
		txt_messages:setVisible(true)
		if i == 1 and huashen_wujiang[ID] ~= nil and huashen_skill[ID] ~= nil then
			gamerun_status = old_gamerun_status
			set_hints("")

			skills_pop_queue(true)
		else
			gamerun_status = ""
			set_hints("")

			_huashen_bianshen_exe(ID, i, old_gamerun_status, nil)
			skills_skip_subqueue()
		end
		timer.start(0.2)
	end
	platform.window:invalidate()
end
function _huashen_bianshen(va_list)
	local ID, i
	ID = va_list[1]; i = va_list[2]

	local delta = 0
	if huashen_wujiang[ID] ~= nil and huashen_skill[ID] ~= nil then
		delta = -1
		if skill_double[ID][huashen_skill[ID]] then
			skill_double[ID][huashen_skill[ID]] = nil
		else
			char_juese[ID].skill[huashen_skill[ID]] = nil
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
end
function _huashen_bianshen_exe(ID, i, old_gamerun_status, jieduan)
	--  变身成新武将  --
	add_funcptr(_huashen_bianshen, {ID, i})

	--  失去原化身所有技能后处理  --
	skills_withdraw_outgame(ID)

	if char_buqu[ID] == true then
		_buqu_lose_all_skills(ID)
	end

	--  选择新武将的技能  --
	if ID == char_current_i then
		add_funcptr(_huashen_skill_select_enter, {ID, old_gamerun_status})
	else
		add_funcptr(_huashen_skill_select_ai, {ID, jieduan})
	end
end
function _huashen_skill_select_ai(va_list)
	local ID, jieduan
	ID = va_list[1]; jieduan = va_list[2]

	timer.stop()
	funcptr_queue = {}
	funcptr_i = 0

	local skills_gong, skills_fang, skills_misc = {}, {}, {}
	local skillname

	for j = 1, #char_skill_item do
		if char_jineng_gong[char_skill_item[j]] == 1 then
			table.insert(skills_gong, char_skill_item[j])
		elseif char_jineng_fang[char_skill_item[j]] == 1 then
			table.insert(skills_fang, char_skill_item[j])
		elseif char_jineng_jin[char_skill_item[j]] ~= 1 then
			table.insert(skills_misc, char_skill_item[j])
		end
	end

	if jieduan == "游戏开始" or jieduan == "回合结束" then
		if #skills_fang > 0 then
			skillname = random_pick(skills_fang, 1)[1]
		elseif #skills_misc > 0 then
			skillname = random_pick(skills_misc, 1)[1]
		else
			skillname = random_pick(skills_gong, 1)[1]
		end
	elseif jieduan == "回合开始" then
		if #skills_gong > 0 then
			skillname = random_pick(skills_gong, 1)[1]
		elseif #skills_misc > 0 then
			skillname = random_pick(skills_misc, 1)[1]
		else
			skillname = random_pick(skills_fang, 1)[1]
		end
	end

	add_funcptr(_huashen_get_skill, {ID, skillname})
	add_funcptr(skills_pop_queue)

	skills_skip_subqueue()
	timer.start(0.2)
end
function _huashen_skill_select_enter(va_list)
	local ID, old_gamerun_status
	ID = va_list[1]; old_gamerun_status = va_list[2]

	timer.stop()
	funcptr_queue = {}
	funcptr_i = 0

	gamerun_status = "选项选择"
	choose_name = "化身"
	jiaohu_text = "请选择一项技能"
	choose_option = {}
	for j = 1, #char_skill_item do
		table.insert(choose_option, char_skill_item[j])
	end

	txt_messages:setVisible(false)
	gamerun_guankan_selected = 1
	item_disrow = 0
	
	gamerun_item = function(i)
		funcptr_queue = {}
		txt_messages:setVisible(true)
		set_hints("")
		gamerun_status = old_gamerun_status
		
		add_funcptr(_huashen_get_skill, {ID, choose_option[i]})
		add_funcptr(skills_pop_queue)

		skills_skip_subqueue()
		timer.start(0.2)
	end
	platform.window:invalidate()
end
function _huashen_get_skill(va_list)
	local ID, skillname
	ID = va_list[1]; skillname = va_list[2]

	huashen_skill[ID] = skillname
	if char_juese[ID].skill[huashen_skill[ID]] == nil then
		if huashen_skill[ID] == "挑衅" or huashen_skill[ID] == "反间" or huashen_skill[ID] == "驱虎" or huashen_skill[ID] == "制衡" or huashen_skill[ID] == "结姻" or huashen_skill[ID] == "天义" or huashen_skill[ID] == "缔盟" or huashen_skill[ID] == "离间" or huashen_skill[ID] == "离魂" or huashen_skill[ID] == "青囊" or huashen_skill[ID] == "攻心" or huashen_skill[ID] == "强袭" or huashen_skill[ID] == "甘露" then
			char_juese[ID].skill[huashen_skill[ID]] = 1
		else
			char_juese[ID].skill[huashen_skill[ID]] = "available"
		end
		table.insert(char_juese[ID].skillname,huashen_skill[ID])
	else
		skill_double[ID][huashen_skill[ID]] = true
	end

	push_message(table.concat({char_juese[ID].name, "声明了武将技能 '", skillname, "'"}))
end

--  左慈：新生 --
function skills_xinsheng(va_list)
	local ID, is_beginning
	ID = va_list[1]; is_beginning = va_list[2]

	if char_juese[ID].siwang == true then
		skills_skip_subqueue()
		return
	end

	skills_push_queue()

	if ID == char_current_i then
		skills_xinsheng_enter(ID)
	else
		skills_xinsheng_set(ID, ai_judge_xinsheng(ID), is_beginning)
	end
end
function skills_xinsheng_enter(ID)
	gamerun_status = "确认操作"
	jiaohu_text = "是否发动 '新生'?"
	gamerun_OK = false
	gamerun_OK_ptr = function()
		gamerun_status = "手牌生效中"
		set_hints("")
		skills_xinsheng_set(char_current_i,gamerun_OK,is_beginning)
	end
	
	platform.window:invalidate()
end
function skills_xinsheng_set(ID, gamerun_OK, is_beginning)
	if gamerun_OK then
		if is_beginning == false then
			add_funcptr(push_message, char_juese[ID].name .. "发动了武将技能 '新生'")
		end
		add_funcptr(skills_xinsheng_exe, {ID, true})	
	end
	add_funcptr(skills_pop_queue)

	skills_skip_subqueue()
	timer.start(0.2)
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

--  袁术：伪帝  --
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
			push_message(char_juese[ID].name.."触发了武将技能 '伪帝'")
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

	if ID_s == char_current_i then
		skills_leiji_enter()
	else
		skills_leiji_ai(va_list)
	end
end
function skills_leiji_enter()
	skills_push_queue()

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
			
			skills_pop_queue(true)
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
	local ID_s, ID_mubiao
	ID_s = va_list[1]; ID_mubiao = va_list[2]

	local fadong, mubiao = ai_judge_leiji_mubiao(ID_s, ID_mubiao)
	if fadong == false then
		skills_skip_subqueue()
		return
	end

	skills_push_queue()
    _leiji_exe(ID_s, mubiao)
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
	skills_judge_songwei(ID_mubiao)

	if huase == "黑桃" then
		push_message(char_juese[ID_s].name .. "的 '雷击' 判定成功")
		skills_card_qi_panding(ID_mubiao)
		char_tili_deduct({2, ID_mubiao, ID_s, "雷", ID_mubiao})
	else
		push_message(char_juese[ID_s].name .. "的 '雷击' 判定失败")
		skills_card_qi_panding(ID_mubiao)
	end
	
	add_funcptr(skills_pop_queue)
	timer.start(0.6)
end
function _leiji_huifu()
	funcptr_queue, funcptr_i = pop_zhudong_queue()
end

--  貂蝉：离间  --
function skills_lijian_ai(ID_shoupai, ID_s, ID_first, ID_second, ai_qi_zhuangbei_id)
	if char_juese[ID_first].xingbie ~= "男" or char_juese[ID_second].xingbie ~= "男" or card_if_d_limit("决斗", ID_first, ID_second, nil) == false then
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
			if char_juese[gamerun_target_selected].xingbie == "男" and card_if_d_limit("决斗", guankan_s, gamerun_target_selected, nil) and gamerun_OK == true then
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
		skills_losecard(ID_s)
	else
		ai_withdraw(ID_s, {ID_shoupai}, ai_qi_zhuangbei_id, true)
		skills_losecard(ID_s)
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

				skills_cs()
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

	add_funcptr(push_message, char_juese[ID_s].name .. "发动了武将技能 '离魂'")
	add_funcptr(_lihun_sub1, {ID_shoupai, ID_s})
	skills_losecard(ID_s)

	add_funcptr(char_fanmian, ID_s)
	add_funcptr(_lihun_sub2, {ID_s, ID_mubiao})
	skills_losecard(ID_mubiao)

	char_juese[ID_s].skill["离魂"] = "locked"

	lihun_target = ID_mubiao
	
	add_funcptr(_lihun_sub3)
	consent_func_queue(0.6)
end
function _lihun_sub1(va_list)
	local ID_shoupai, ID_s
	ID_shoupai = va_list[1]; ID_s = va_list[2]

	local card = char_juese[ID_s].shoupai[ID_shoupai]
	card_add_qipai(card)
	card_remove({ID_s, ID_shoupai})
	push_message(table.concat({char_juese[ID_s].name, "弃掉了'", card[2], card[3], "的", card[1], "'"}))
end
function _lihun_sub2(va_list)
	local ID_s, ID_mubiao
	ID_s = va_list[1]; ID_mubiao = va_list[2]

	for i = #char_juese[ID_mubiao].shoupai, 1, -1 do
		card_insert(ID_s, char_juese[ID_mubiao].shoupai[i])
		table.remove(char_juese[ID_mubiao].shoupai, i)
	end

	push_message(char_juese[ID_s].name .. "获得了" .. char_juese[ID_mubiao].name .. "的所有手牌")
end
function _lihun_sub3()
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
function skills_lihun_stage_2_ai()
	if char_juese[lihun_target].siwang ~= true then
		local n_geipai = math.min(char_juese[lihun_target].tili, ai_card_stat(char_acting_i, true, false))
		local qipai_id, qi_zhuangbei_id = ai_judge_withdraw(char_acting_i, n_geipai, true)

		add_funcptr(_lihun_exe_2, {char_acting_i, lihun_target, qipai_id, qi_zhuangbei_id})
		skills_losecard(char_current_i)

		add_funcptr(_lihun_huifu)
		timer.start(0.2)
	else
		lihun_target = nil
		ai_stage_qipai(char_acting_i)
	end
end
function skills_lihun_stage_2_enter()
	if char_juese[lihun_target].siwang ~= true then
		local n_geipai = math.min(char_juese[lihun_target].tili, ai_card_stat(char_acting_i, true, false))

		skills_enter("您需给出" .. tostring(n_geipai) .. "张牌", "", "离魂", "技能选择-多牌")
		gamerun_OK = false
		gamerun_tab_ptr = nil
		gamerun_wuqi_into_hand(char_acting_i)

		gamerun_OK_ptr = function()
			if gamerun_OK == true then
				if table.getn2(card_selected) ~= n_geipai then
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
				skills_losecard(char_current_i)

				add_funcptr(gamerun_wuqi_out_hand_queued, char_acting_i)
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
		card_insert(ID_mubiao, char_juese[ID_s].shoupai[ID_shoupai[i]])
		card_remove({ID_s, ID_shoupai[i]})
	end
	if ID_zhuangbei[1] == 1 then
		card_insert(ID_mubiao, char_juese[ID_s].wuqi)
		char_juese[ID_s].wuqi = {}
		n_zhuangbei = n_zhuangbei + 1
	end

	if ID_zhuangbei[2] == 1 then
		card_insert(ID_mubiao, char_juese[ID_s].fangju)
		char_juese[ID_s].fangju = {}
		n_zhuangbei = n_zhuangbei + 1
	end

	if ID_zhuangbei[3] == 1 then
		card_insert(ID_mubiao, char_juese[ID_s].gongma)
		char_juese[ID_s].gongma = {}
		n_zhuangbei = n_zhuangbei + 1
	end

	if ID_zhuangbei[4] == 1 then
		card_insert(ID_mubiao, char_juese[ID_s].fangma)
		char_juese[ID_s].fangma = {}
		n_zhuangbei = n_zhuangbei + 1
	end
	push_message(table.concat({char_juese[ID_s].name, "将", tostring(#ID_shoupai+n_zhuangbei), "张牌交给", char_juese[ID_mubiao].name}))
	lihun_target = nil
end
function _lihun_huifu()
	if char_acting_i == char_current_i then
		on.escapeKey()
	else
		ai_stage_qipai(char_acting_i)
	end
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
			--funcptr_i = funcptr_i + 1
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
		skills_losecard(ID_mubiao)
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

--  董卓：暴虐  --
function skills_judge_baonue(ID)
	if char_juese[ID].shili == "群" then
		for i = 1, 5 do
			if char_juese[i].skill["暴虐"] == "available" and i ~= ID and char_juese[i].siwang == false and char_juese[i].tili < char_juese[i].tili_max then
				add_funcptr(skills_baonue, {ID, i})
				soldblood = true
			end
		end
	end
end
function skills_baonue(va_list)
	local ID, ID_zhugong
	ID = va_list[1]; ID_zhugong = va_list[2]

	if ID == char_current_i then
		skills_baonue_enter(ID_zhugong)
	else
		skills_baonue_ai(ID, ID_zhugong)
	end
end
function skills_baonue_ai(ID, ID_zhugong)
	if ai_judge_baonue(ID, ID_zhugong) == false then
		return
	end

	push_zhudong_queue(table.copy(funcptr_queue), funcptr_i)
	timer.stop()
	funcptr_queue = {}
	funcptr_i = 0

	_baonue_exe(ID, ID_zhugong)
	timer.start(0.6)
end
function skills_baonue_enter(ID_zhugong)
	local old_gamerun_status = gamerun_status

	push_zhudong_queue(table.copy(funcptr_queue), funcptr_i)
	timer.stop()
	funcptr_queue = {}
	funcptr_i = 0

	gamerun_status = "确认操作"
	jiaohu_text = table.concat({"是否响应", char_juese[ID_zhugong].name, "的'暴虐'?"})
	gamerun_OK = false
	gamerun_OK_ptr = function()
		gamerun_status = old_gamerun_status
		funcptr_queue = {}
		set_hints("")

		if gamerun_OK == true then
			_baonue_exe(char_current_i, ID_zhugong)
		else
			_baonue_huifu()
			--funcptr_i = funcptr_i + 1
		end
		timer.start(0.6)
	end
	
	platform.window:invalidate()
end
function _baonue_exe(ID, ID_zhugong)
	push_message(table.concat({char_juese[ID].name .. "响应了", char_juese[ID_zhugong].name, "的武将技能 '暴虐'"}))
	add_funcptr(_baonue_fan_panding, ID)

	--  如场上有司马懿或张角，询问其改判技能  --
	skills_guicai_guidao_ask(ID, ID, ID_zhugong, "暴虐")
	
	add_funcptr(_baonue_jiesuan, {ID, ID_zhugong})
	timer.start(0.6)
end
function _baonue_fan_panding(ID_s)
	--  翻开判定牌  --
	if #card_yixi == 0 then
	    card_xipai(true)
	end
    card_panding_card = card_yixi[1]
	table.remove(card_yixi, 1)
	push_message(table.concat({char_juese[ID_s].name .. "的判定牌是'", card_panding_card[2], card_panding_card[3], "的", card_panding_card[1], "'"}))
end
function _baonue_jiesuan(va_list)
	local ID, ID_zhugong
	ID = va_list[1]; ID_zhugong = va_list[2]

	timer.stop()
	funcptr_queue = {}
	funcptr_i = 0

	local yanse, huase, dianshu = ai_judge_cardinfo(ID, {card_panding_card})

	--  曹丕颂威  --
	skills_judge_songwei(ID)

	if huase == "黑桃" then
		push_message(char_juese[ID_zhugong].name .. "的 '暴虐' 判定成功")
		skills_card_qi_panding(ID)
		char_tili_huifu(ID_zhugong, 1)
	else
		push_message(char_juese[ID_zhugong].name .. "的 '暴虐' 判定失败")
		skills_card_qi_panding(ID)
	end
	
	add_funcptr(_baonue_huifu)
	timer.start(0.6)
end
function _baonue_huifu()
	funcptr_queue, funcptr_i = pop_zhudong_queue()
end

--  张角：黄天  --
function skills_huangtian_judge(ID_shoupai, ID_s)
	if #char_juese[ID_s].shoupai == 0 then
		return false
	end

	if card_judge_if_shan(ID_s, ID_shoupai) == false and char_juese[ID_s].shoupai[ID_shoupai][1] ~= "闪电" then
		return false
	end
	return true
end
function skills_huangtian_ai(ID_shoupai, ID_s, ID_zhugong)
	if skills_huangtian_judge(ID_shoupai, ID_s) == false then
		return false
	end

	_huangtian_exe(ID_shoupai, ID_s, ID_zhugong)
	return true
end
function skills_huangtian_enter(ID_zhugong)
	if #char_juese[char_current_i].shoupai == 0 then
		return false
	end

	skills_enter("请选择闪或闪电", "", "黄天", "技能选择-单牌")
	gamerun_OK = false
	
	gamerun_OK_ptr = function()
		if gamerun_OK == true then
			if skills_huangtian_judge(char_current_i, ID_zhugong) then
				_huangtian_exe(card_highlighted, char_current_i, ID_zhugong)
				card_selected = {}
				card_highlighted = 1
			end
		else
			_lordskill_fangqi()
		end
	end
	
	gamerun_tab_ptr = nil
	
	return true
end
function _huangtian_exe(ID_shoupai, ID_s, ID_zhugong)
	funcptr_queue = {}
	funcptr_i = 0

	gamerun_status = "手牌生效中"
	set_hints("")

	add_funcptr(push_message, table.concat({char_juese[ID_s].name .. "响应了", char_juese[ID_zhugong].name, "的武将技能 '黄天'"}))
	add_funcptr(_huangtian_geipai, {ID_shoupai, ID_s, ID_zhugong})
	skills_losecard(ID_s)
	
	lordskill_used[ID_zhugong]["黄天"] = 1
	add_funcptr(_fanjian_sub4)
	timer.start(0.6)
end
function _huangtian_geipai(va_list)
	local ID_shoupai, ID_s, ID_zhugong
	ID_shoupai = va_list[1]; ID_s = va_list[2]; ID_zhugong = va_list[3]

	local card = char_juese[ID_s].shoupai[ID_shoupai]
	push_message(table.concat({char_juese[ID_s].name, "将'", card[2], card[3], "的", card[1], "'交给", char_juese[ID_zhugong].name}))

	card_remove({ID_s, ID_shoupai})
	card_insert(ID_zhugong, card)
end

--  灵雎：竭缘  --
function skills_jieyuan(mode)
	local deduct_va = deduct_va_stack[#deduct_va_stack]
	local id, laiyuan, dianshu, shuxing
	local ID, ID_counterpart
	dianshu = deduct_va[1]; id = deduct_va[2]; laiyuan = deduct_va[3]; shuxing = deduct_va[4]

	dianshu = _deduct_count(deduct_va)
	if mode == "受到伤害" then
		ID = id
		ID_counterpart = laiyuan
	else
		ID = laiyuan
		ID_counterpart = id
	end

	if char_juese[ID_counterpart].tili < char_juese[ID].tili then
		_baiyin_skip()
		return
	end

	if ID == char_current_i then
		skills_jieyuan_enter(ID_counterpart, dianshu, shuxing, mode)
	else
		skills_jieyuan_ai(ID, ID_counterpart, dianshu, shuxing, mode)
	end
end
function skills_jieyuan_ai(ID, ID_counterpart, dianshu, shuxing, mode)
	local fadong, ID_shoupai
	fadong, ID_shoupai = ai_judge_jieyuan(ID, ID_counterpart, dianshu, shuxing, mode)

	if fadong == false then
		_baiyin_skip()
		return
	end

	push_zhudong_queue(table.copy(funcptr_queue), funcptr_i)
	timer.stop()
	funcptr_queue = {}
	funcptr_i = 0

	_jieyuan_exe(ID_shoupai, ID, dianshu, mode)
end
function skills_jieyuan_enter(ID_counterpart, dianshu, shuxing, mode)
	push_zhudong_queue(table.copy(funcptr_queue), funcptr_i)
	timer.stop()
	funcptr_queue = {}
	funcptr_i = 0

	local old_gamerun_status = gamerun_status
	gamerun_status = "选项选择"

	if mode == "受到伤害" then
		choose_name = table.concat({"您将受到", dianshu, "点", shuxing, "属性伤害"})
		jiaohu_text = "是否发动'竭缘'使该伤害-1?"
	else
		choose_name = table.concat({"您将对", char_juese[ID_counterpart].name ,"造成伤害"})
		jiaohu_text = "是否发动'竭缘'使该伤害+1?"
	end

	choose_option = {"是", "否"}

	txt_messages:setVisible(false)
	gamerun_guankan_selected = 1
	item_disrow = 0
	
	gamerun_item = function(i)
		txt_messages:setVisible(true)
		set_hints("")

		if i == 1 then
			_jieyuan_select(dianshu, shuxing, mode, old_gamerun_status)
		else
			gamerun_status = old_gamerun_status
			_tianxiang_huifu()
			timer.start(0.6)
		end
	end

	platform.window:invalidate()
end
function _jieyuan_select(dianshu, shuxing, mode, old_gamerun_status)
	if mode == "受到伤害" then
		skills_enter("请选择红色手牌", "", "竭缘", "技能选择-单牌")
	else
		skills_enter("请选择黑色手牌", "", "竭缘", "技能选择-单牌")
	end
		
	gamerun_OK = false
	gamerun_OK_ptr = function()
		if gamerun_OK == true then
			if table.getn2(card_selected) == 1 then
				local yanse, huase, dianshu = ai_judge_cardinfo(char_current_i, {char_juese[char_current_i].shoupai[card_highlighted]})
				local desired

				if mode == "受到伤害" then
					desired = "红色"
				else
					desired = "黑色"
				end

				if yanse == desired then
					_jieyuan_exe(card_highlighted, char_current_i, dianshu, mode)
				end
			end
		else
			gamerun_status = old_gamerun_status
			set_hints("")
			_tianxiang_huifu()
			timer.start(0.6)
		end
	end
	
	gamerun_tab_ptr = nil
	platform.window:invalidate()
end
function _jieyuan_exe(ID_shoupai, ID, dianshu, mode)
	gamerun_status = "手牌生效中"
	set_hints("")
	card_selected = {}

	add_funcptr(_jieyuan_sub1, {ID_shoupai, ID})
	skills_losecard(ID)
	add_funcptr(push_message, char_juese[ID].name .. "发动了武将技能 '竭缘'")
	
	if mode == "受到伤害" then
		add_funcptr(push_message, char_juese[ID].name .. "令伤害减少1点")
		deduct_va_stack[#deduct_va_stack][1] = deduct_va_stack[#deduct_va_stack][1] - 1
	else
		add_funcptr(push_message, char_juese[ID].name .. "令伤害增加1点")
		deduct_va_stack[#deduct_va_stack][1] = deduct_va_stack[#deduct_va_stack][1] + 1
	end

	add_funcptr(skills_pop_queue)
	_baiyin_skip()
	timer.start(0.6)
end
function _jieyuan_sub1(va_list)
	local ID_shoupai, ID
	ID_shoupai = va_list[1]; ID = va_list[2]

	local card = char_juese[ID].shoupai[ID_shoupai]
	card_add_qipai(card)
	card_remove({ID, ID_shoupai})
	push_message(table.concat({char_juese[ID].name, "弃掉了'", card[2], card[3], "的", card[1], "'"}))
end

--  蔡文姬：悲歌  --
function skills_beige(va_list)
	local ID_s, ID_mubiao, ID_laiyuan
	ID_s = va_list[1]; ID_mubiao = va_list[2]; ID_laiyuan = va_list[3]

	if #char_juese[ID_s].shoupai == 0 then
		skills_skip_subqueue()
		return
	end

	if ID_s == char_current_i then
		skills_beige_enter(ID_mubiao, ID_laiyuan)
	else
		skills_beige_ai(ID_s, ID_mubiao, ID_laiyuan)
	end
end
function skills_beige_ai(ID_s, ID_mubiao, ID_laiyuan)
	local fadong, ID_shoupai = ai_judge_beige(ID_s, ID_mubiao, ID_laiyuan)
	if fadong == false then
		skills_skip_subqueue()
		return
	end

	skills_push_queue()
	_beige_exe(ID_shoupai, ID_s, ID_mubiao, ID_laiyuan)
end
function skills_beige_enter(ID_mubiao, ID_laiyuan)
	skills_push_queue()

	local old_gamerun_status = gamerun_status
	gamerun_status = "确认操作"
	jiaohu_text = "是否发动 '悲歌'?"
	gamerun_OK = false
	
	gamerun_OK_ptr = function()
		funcptr_queue = {}
		gamerun_status = old_gamerun_status
		set_hints("")

		if gamerun_OK then
			_beige_select_card(ID_mubiao, ID_laiyuan, old_gamerun_status)
	    else
			skills_pop_queue(true)
			timer.start(0.6)
		end
		platform.window:invalidate()
	end
	
	platform.window:invalidate()
end
function _beige_select_card(ID_mubiao, ID_laiyuan, old_gamerun_status)
	skills_enter("请选择一张牌", "", "悲歌", "技能选择-单牌")
	gamerun_OK_ptr = function()
		if gamerun_OK == true then
			if table.getn2(card_selected) == 1 then
				gamerun_status = "手牌生效中"
				set_hints("")
				
				_beige_exe(card_highlighted, char_current_i, ID_mubiao, ID_laiyuan)
				card_selected = {}
				card_highlighted = 1
			end
		else
			gamerun_status = old_gamerun_status
			set_hints("")
			skills_pop_queue(true)
			timer.start(0.6)
		end
	end

	platform.window:invalidate()
end
function _beige_exe(ID_shoupai, ID_s, ID_mubiao, ID_laiyuan)
	add_funcptr(_beige_qipai, {ID_shoupai, ID_s})
	skills_losecard(ID_s)
	add_funcptr(push_message, char_juese[ID_s].name .. "发动了武将技能 '悲歌'")

	add_funcptr(_beige_fan_panding, ID_mubiao)

	--  如场上有司马懿或张角，询问其改判技能  --
	skills_guicai_guidao_ask(ID_mubiao, ID_s, ID_mubiao, "悲歌")
	
	add_funcptr(_beige_jiesuan, {ID_s, ID_mubiao, ID_laiyuan})

	skills_skip_subqueue()
	timer.start(0.6)
end
function _beige_qipai(va_list)
	local ID_shoupai, ID
	ID_shoupai = va_list[1]; ID = va_list[2]

	local card = char_juese[ID].shoupai[ID_shoupai]
	card_add_qipai(card)
	card_remove({ID, ID_shoupai})
	push_message(table.concat({char_juese[ID].name, "弃掉了'", card[2], card[3], "的", card[1], "'"}))
end
function _beige_fan_panding(ID_s)
	--  翻开判定牌  --
	if #card_yixi == 0 then
	    card_xipai(true)
	end
    card_panding_card = card_yixi[1]
	table.remove(card_yixi, 1)
	push_message(table.concat({char_juese[ID_s].name .. "的判定牌是'", card_panding_card[2], card_panding_card[3], "的", card_panding_card[1], "'"}))
end
function _beige_jiesuan(va_list)
	local ID_s, ID_mubiao, ID_laiyuan
	ID_s = va_list[1]; ID_mubiao = va_list[2]; ID_laiyuan = va_list[3]

	timer.stop()
	funcptr_queue = {}
	funcptr_i = 0

	local yanse, huase, dianshu = ai_judge_cardinfo(ID_mubiao, {card_panding_card})

	--  曹丕颂威  --
	skills_judge_songwei(ID_mubiao)

	if huase == "黑桃" then
		push_message(char_juese[ID_s].name .. "的 '悲歌' 判定结果为黑桃")
		skills_card_qi_panding(ID_mubiao)
		add_funcptr(char_fanmian, ID_laiyuan)
		
	elseif huase == "草花" then
		push_message(char_juese[ID_s].name .. "的 '悲歌' 判定结果为草花")
		skills_card_qi_panding(ID_mubiao)
		if ID_laiyuan == char_current_i then
			add_funcptr(_beige_laiyuan_qipai_enter)
		else
			add_funcptr(_beige_laiyuan_qipai_ai, ID_laiyuan)
		end

	elseif huase == "红桃" then
		push_message(char_juese[ID_s].name .. "的 '悲歌' 判定结果为红桃")
		skills_card_qi_panding(ID_mubiao)
		if char_juese[ID_mubiao].tili < char_juese[ID_mubiao].tili_max then
			char_tili_huifu(ID_mubiao, 1)
		end

	elseif huase == "方块" then
		push_message(char_juese[ID_s].name .. "的 '悲歌' 判定结果为方块")
		skills_card_qi_panding(ID_mubiao)
		add_funcptr(card_fenfa, {ID_mubiao, 2, true})

	else
		skills_card_qi_panding(ID_mubiao)
	end
	
	add_funcptr(skills_pop_queue)
	timer.start(0.6)
end
function _beige_laiyuan_qipai_ai(ID_laiyuan)
	if ai_card_stat(ID_laiyuan, true, false) == 0 then
		skills_skip_subqueue()
		return
	end

	skills_push_queue()
	local qipai_id, qi_zhuangbei_id = ai_judge_withdraw(ID_laiyuan, 2, true)

	ai_withdraw(ID_laiyuan, qipai_id, qi_zhuangbei_id, true)
	skills_losecard(ID_laiyuan)

	add_funcptr(skills_pop_queue)
	skills_skip_subqueue()
	timer.start(0.6)
end
function _beige_laiyuan_qipai_enter()
	skills_push_queue()

	local n_cards = ai_card_stat(char_current_i, true, false)
	if n_cards < 2 then
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
	skills_enter("您须弃2张牌", "", "悲歌2", "技能选择-多牌")
	gamerun_OK_ptr = function()
		if gamerun_OK == true and table.getn2(card_selected) == 2 then
			gamerun_status = "手牌生效中"
			set_hints("")

			card_qipai_go(char_current_i)
			card_selected = {}
			card_highlighted = 1

			add_funcptr(gamerun_wuqi_out_hand_queued)
			skills_losecard(char_current_i)

			add_funcptr(skills_pop_queue)
			timer.start(0.6)
		end
	end
end

--  颜良文丑：双雄  --
function skills_shuangxiong_1(ID)
	if ID == char_current_i then
		skills_shuangxiong_1_enter()
	else
		skills_shuangxiong_1_ai(ID)
	end
end
function skills_shuangxiong_1_ai(ID)
	local fadong = ai_judge_shuangxiong(ID)
	if fadong == false then
		skills_skip_subqueue()
		return
	end

	skills_push_queue()
	_shuangxiong_exe(ID)
end
function skills_shuangxiong_1_enter()
	skills_push_queue()

	local old_gamerun_status = gamerun_status
	gamerun_status = "确认操作"
	jiaohu_text = "是否发动 '双雄'?"
	gamerun_OK = false
	
	gamerun_OK_ptr = function()
		funcptr_queue = {}

		if gamerun_OK then
			_shuangxiong_exe(char_current_i)
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
function _shuangxiong_exe(ID)
	gamerun_status = ""
	set_hints("")

	add_funcptr(push_message, char_juese[ID].name .. "发动了武将技能 '双雄'")
	add_funcptr(_shuangxiong_fan_panding, ID)

	--  如场上有司马懿或张角，询问其改判技能  --
	skills_guicai_guidao_ask(ID, nil, ID, "双雄")
	
	add_funcptr(_shuangxiong_jiesuan, ID)
	skills_skip_subqueue()
	timer.start(0.6)
end
function _shuangxiong_fan_panding(ID_s)
	--  翻开判定牌  --
	if #card_yixi == 0 then
	    card_xipai(true)
	end
    card_panding_card = card_yixi[1]
	table.remove(card_yixi, 1)
	push_message(table.concat({char_juese[ID_s].name .. "的判定牌是'", card_panding_card[2], card_panding_card[3], "的", card_panding_card[1], "'"}))
end
function _shuangxiong_jiesuan(ID)
	timer.stop()
	funcptr_queue = {}
	funcptr_i = 0

	--  曹丕颂威  --
	skills_judge_songwei(ID)

	add_funcptr(_shuangxiong_get_panding, ID)	
	add_funcptr(skills_pop_queue)
	skills_skip_subqueue()
	timer.start(0.6)
end
function _shuangxiong_get_panding(ID)
	local yanse, huase, dianshu = ai_judge_cardinfo(ID, {card_panding_card})
	char_shuangxiong = yanse
	game_skip_mopai = true

	push_message(table.concat({char_juese[ID].name, "获得了'", card_panding_card[2], card_panding_card[3], "的", card_panding_card[1], "'"}))
	card_insert(ID, card_panding_card)
	card_panding_card = {}
end
function skills_judge_shuangxiong_2()
	if table.getn2(card_selected) ~= 1 then
		return false
	end
	local card = char_juese[char_current_i].shoupai[card_highlighted]
	local yanse, huase, dianshu = ai_judge_cardinfo(char_current_i, {card})

	if yanse == char_shuangxiong then
		return false
	end

	return true
end
function skills_shuangxiong_2_enter()
	if char_shuangxiong == nil or #char_juese[char_current_i].shoupai == 0 then
		return false
	end

	skills_enter("请选择一张手牌", "决斗", "决斗", "技能选择-单牌")

	gamerun_OK_ptr = function()
		_shuangxiong_2_exe()
	end

	gamerun_tab_ptr = function()
		if skills_judge_shuangxiong_2() then
			skills_enter_target()
		end
	end

	return true
end
function _shuangxiong_2_exe()
	if skills_judge_shuangxiong_2() == false then
		return
	end

	funcptr_queue = {}
	if card_juedou({card_highlighted}, char_current_i, gamerun_target_selected) then
		skills_cs()
		consent_func_queue(0.6)
	end
end

--  贾诩：乱武  --
function skills_luanwu_judge_if_sha()
	if #char_juese[char_current_i].wuqi ~= 0 then
		if char_juese[char_current_i].wuqi[1] == "丈八矛" then
			if table.getn2(card_selected) == 2 then
				return true
			end
		end
	end

	local cards = skills_get_selected_shoupai()
	if table.getn2(card_selected) == 1 then
		if card_judge_if_sha(char_current_i, cards[1]) then
			return true
		end
	end

	return false
end
function skills_luanwu_calc_min_distance(ID)
	local mindis = 1000
	local j = ID + 1
	if j > 5 then
		j = 1
	end

	for i = 1, 4 do
		if char_juese[j].siwang == false then
			local dis = char_calc_distance(ID, j)
			if dis < mindis then
				mindis = dis
			end
		end

		j = j + 1
		if j > 5 then
			j = 1
		end
	end

	return mindis
end
function skills_luanwu_enter()
	gamerun_status = "确认操作"
	jiaohu_text = "按'确定'发动乱武"
	gamerun_OK = false

	gamerun_OK_ptr = function()
		if gamerun_OK == true then
			funcptr_queue = {}
			gamerun_status = "手牌生效中"
			set_hints("")

			skills_luanwu_add(char_current_i)
			skills_cs()
			consent_func_queue(0.6)
		end
	end

	platform.window:invalidate()
	return true
end
function skills_luanwu_add(ID)
	add_funcptr(_luanwu_sub1, ID)

	local j = ID + 1
	if j > 5 then
		j = 1
	end

	for i = 1, 4 do
		if char_juese[j].siwang == false then
			add_funcptr(_luanwu_exe, j)
		end

		j = j + 1
		if j > 5 then
			j = 1
		end
	end

	add_funcptr(_luanwu_sub2)
end
function _luanwu_sub1(ID)
	gamerun_status = "手牌生效中"
	set_hints("")
	push_message(char_juese[ID].name .. "发动了武将技能 '乱武'")
	char_juese[ID].skill["乱武"] = "locked_whole_game"
end
function _luanwu_sub2()
	if char_acting_i == char_current_i then
		set_hints("请您出牌")
		gamerun_status = ""
	else
		set_hints("")
		gamerun_status = "AI出牌"

		ai_card_use(char_acting_i)
	end
end
function _luanwu_exe(ID)
	if char_juese[ID].siwang == true then
		skills_skip_subqueue()
		return
	end

	skills_push_queue()

	if ID == char_current_i then
		_luanwu_select_target_enter()
	else
		_luanwu_select_target_ai(ID)
	end
end
function _luanwu_select_target_ai(ID)
	local mubiao = ai_judge_luanwu_target(ID)

	if #mubiao == 0 then
		_luanwu_tili_deduct(ID)
	else
		_luanwu_sha_go(ID, mubiao[1])
	end

	skills_skip_subqueue()
	timer.start(0.6)
end
function _luanwu_select_target_enter()
	local mindis = skills_luanwu_calc_min_distance(char_current_i)

	skills_enter("请选择目标或'取消'放弃", "", "乱武", "技能选择-目标")
	gamerun_select_target("init")
	gamerun_OK = false

	gamerun_OK_ptr = function()
		if gamerun_OK == true then
			if card_if_d_limit("乱武", char_current_i, gamerun_target_selected, nil) then
				gamerun_status = "手牌生效中"
				set_hints("")

				card_selected = {}
				card_highlighted = 1

				funcptr_queue = {}
				funcptr_i = 0

				_luanwu_sha_go(char_current_i, gamerun_target_selected)
				timer.start(0.6)
			end
		else
			gamerun_status = "手牌生效中"
			set_hints("")

			_luanwu_tili_deduct(char_current_i)
			timer.start(0.6)
		end
	end

	gamerun_tab_ptr = nil
	platform.window:invalidate()
end
function _luanwu_sha_go(ID_s, ID_mubiao)
	gamerun_sha_queued = true

	--  刘备激将  --
	if char_juese[ID_s].skill["激将"] == "available" then
		add_funcptr(skills_jijiang_req_side, {ID_s, "技能", {-1, ID_s, ID_mubiao}})
	end

	if ID_s == char_current_i then
		add_funcptr(_luanwu_select_sha_enter, ID_mubiao)
	else
		add_funcptr(_luanwu_select_sha_ai, {ID_s, ID_mubiao})
	end
end
function _luanwu_select_sha_ai(va_list)
	local ID_s, ID_mubiao
	ID_s = va_list[1]; ID_mubiao = va_list[2]

	gamerun_sha_queued = false
	funcptr_queue = {}
	funcptr_i = 0

	local ID_shoupai = ai_judge_luanwu_shoupai(ID_s)
	if #ID_shoupai == 0 then
		_luanwu_tili_deduct(ID_s)
	else
		if card_sha(ID_shoupai, ID_s, {ID_mubiao}, false) then
			gamerun_sha_queued = true
		else
			_luanwu_tili_deduct(ID_s)
		end
	end

	skills_skip_subqueue()
	timer.start(0.6)
end
function _luanwu_select_sha_enter(ID_mubiao)
	gamerun_sha_queued = false
	funcptr_queue = {}
	funcptr_i = 0

	skills_enter("请选择要使用的杀", "", "乱武", "技能选择-多牌")
	gamerun_OK = false
	gamerun_OK_ptr = function()
		if gamerun_OK then
			if skills_luanwu_judge_if_sha() then
				local ID_shoupai = skills_get_selected_shoupai()
				card_selected = {}
				card_highlighted = 1

				if card_sha(ID_shoupai, char_current_i, {ID_mubiao}, false) then
					gamerun_sha_queued = true
					skills_cs()
					timer.start(0.6)
				end
			end
		else
			gamerun_status = "手牌生效中"
			set_hints("")

			_luanwu_tili_deduct(char_current_i)
			timer.start(0.6)
		end
	end
	
	gamerun_tab_ptr = nil
	platform.window:invalidate()
end
function _luanwu_tili_deduct(ID)
	add_funcptr(push_message, char_juese[ID].name .. "放弃")
	char_tili_deduct({1, ID, -1, "流失", ID})
	add_funcptr(skills_pop_queue)
end
