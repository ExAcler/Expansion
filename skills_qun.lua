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
			if huashen_skill[ID] == "挑衅" or huashen_skill[ID] == "反间" or huashen_skill[ID] == "驱虎" or huashen_skill[ID] == "制衡" or huashen_skill[ID] == "结姻" or huashen_skill[ID] == "天义" or huashen_skill[ID] == "缔盟" or huashen_skill[ID] == "离间" or huashen_skill[ID] == "离魂" or huashen_skill[ID] == "青囊" or huashen_skill[ID] == "攻心" then
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
			funcptr_i = funcptr_i + 1
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
		add_funcptr(_kuanggu_sub1, ID_zhugong)
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
