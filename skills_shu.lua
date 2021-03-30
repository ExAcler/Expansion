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
		if char_juese[ID].skill["集智"] ~= "available" and char_juese[ID].skill["极略"] == "available" and mark_ren[ID] > 0 then
			mark_ren[ID] = mark_ren[ID] - 1
		end
	end
	jiaohu_text = ""
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

--  卧龙诸葛：八阵  --
function skills_bazhen(ID_s)
	push_message(char_juese[ID_s].name .. "触发了武将技能 '八阵'")
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
	
	msg = {char_juese[ID_req].name.."发动了武将技能 '挑衅' (对", char_juese[ID_d].name, ")"}
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

--  祝融：巨象  --
function skills_juxiang(ID)
	push_message(char_juese[ID].name .. "触发了武将技能 '巨象'，获得了南蛮入侵")
end

--  刘禅：放权  --
function skills_fangquan(ID)
	if game_skip_chupai == true then
		return
	end
	if ID == char_current_i then
		skills_fangquan_enter()
	else
		skills_fangquan_ai(ID)
	end
end
function skills_fangquan_enter()
	local old_gamerun_status = gamerun_status

	push_zhudong_queue(table.copy(funcptr_queue), funcptr_i)
	timer.stop()
	funcptr_queue = {}
	funcptr_i = 0

	gamerun_status = "选项选择"
	choose_name = "放权"
	jiaohu_text = "是否跳过出牌阶段?"
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
			_fangquan_exe(char_current_i)
	    else
			_fangquan_huifu()
			funcptr_i = funcptr_i + 1
			timer.start(0.6)
		end
		platform.window:invalidate()
	end
	
	platform.window:invalidate()
end
function skills_fangquan_ai(ID)
	ID_mubiao = ai_judge_fangquan(ID)
	if #ID_mubiao == 0 then
		return
	else
		ai_fangquan_judged = ID_mubiao[1]
	end

	push_zhudong_queue(table.copy(funcptr_queue), funcptr_i)
	timer.stop()
	funcptr_queue = {}
	funcptr_i = 0
	_fangquan_exe(ID)

	return true
end
function _fangquan_exe(ID_s)
	gamerun_status = "手牌生效中"
	funcptr_queue = {}
	funcptr_i = 0
	game_skip_chupai = true
	add_funcptr(push_message, char_juese[ID_s].name .. "发动了武将技能 '放权'")
	gamerun_fangquan = true
	add_funcptr(_fangquan_huifu, nil)
	timer.start(0.6)
end
function skills_fangquan_2(ID)
	gamerun_fangquan = false
	if #char_juese[ID].shoupai == 0 then
		return
	end
	if ID == char_current_i then
		skills_fangquan_enter_2()
	else
		local shoupai = ai_judge_withdraw(ID, 1, true)
		if #shoupai > 0 then
			push_zhudong_queue(table.copy(funcptr_queue), funcptr_i)
			timer.stop()
			funcptr_queue = {}
			funcptr_i = 0
			_fangquan_exe_2(ID, ai_fangquan_judged, shoupai)
		else
			return
		end
	end
end
function skills_fangquan_enter_2()
	local old_gamerun_status = gamerun_status

	push_zhudong_queue(table.copy(funcptr_queue), funcptr_i)
	timer.stop()
	funcptr_queue = {}
	funcptr_i = 0

	gamerun_status = "选项选择"
	choose_name = "放权"
	jiaohu_text = "是否弃手牌给他人额外回合?"
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
			skills_fangquan_choose_mubiao()
	    else
			_fangquan_huifu()
			funcptr_i = funcptr_i + 1
			timer.start(0.6)
		end
		platform.window:invalidate()
	end
	
	platform.window:invalidate()
end
function skills_fangquan_choose_mubiao()
	skills_enter("请选择一张手牌", "请选择额外回合目标", "放权", "技能选择-单牌")
	
	gamerun_OK_ptr = function()
		if gamerun_status == "技能选择-目标" then
			if gamerun_OK == true then
				jiaohu_text = ""
				_fangquan_exe_2(char_current_i, gamerun_target_selected, card_highlighted)
			end
			return
		end

		if gamerun_status == "技能选择-单牌" then
			if gamerun_OK == false then
				_fangquan_huifu()
				funcptr_i = funcptr_i + 1
				timer.start(0.6)
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
function _fangquan_exe_2(ID_s, ID_mubiao, ID_shoupai)
	gamerun_status = "手牌生效中"
	funcptr_queue = {}
	funcptr_i = 0
	if ID_s == char_current_i then
		local card = char_juese[ID_s].shoupai[ID_shoupai]
		card_add_qipai(card)
		card_remove({ID_s, ID_shoupai})
		push_message(table.concat({char_juese[ID_s].name, "弃掉了'", card[2], card[3], "的", card[1], "'"}))
		skills_losecard(ID_s, 0, true)
	else
		ai_withdraw(ID_s, ID_shoupai, {}, false)
		skills_losecard(ID_s, 0, true)
	end
	push_message(table.concat({char_juese[ID_mubiao].name, "获得了额外的回合"}))
	table.insert(extra_turn, ID_mubiao)
	add_funcptr(_fangquan_huifu, nil)
	ai_fangquan_judged = nil
	skills_cs()
	timer.start(0.6)
end
function _fangquan_huifu()
	funcptr_queue, funcptr_i = pop_zhudong_queue()
end

--  孟获：再起  --
function skills_zaiqi(ID)
	if char_juese[ID].tili == char_juese[ID].tili_max then
		return
	end

	if ID == char_current_i then
		skills_zaiqi_enter()
	else
		skills_zaiqi_ai(ID)
	end
end
function skills_zaiqi_ai(ID)
	if ai_judge_zaiqi(ID) == false then
		return
	end

	push_zhudong_queue(table.copy(funcptr_queue), funcptr_i)
	timer.stop()
	funcptr_queue = {}
	funcptr_i = 0

	_zaiqi_exe(ID)
end
function skills_zaiqi_enter()
	push_zhudong_queue(table.copy(funcptr_queue), funcptr_i)
	timer.stop()
	funcptr_queue = {}
	funcptr_i = 0

	local old_gamerun_status = gamerun_status
	gamerun_status = "确认操作"
	jiaohu_text = "是否发动 '再起'?"
	gamerun_OK = false
	
	gamerun_OK_ptr = function()
		funcptr_queue = {}
		gamerun_status = old_gamerun_status
		set_hints("")

		if gamerun_OK then
			_zaiqi_exe(char_current_i)
	    else
			_zaiqi_huifu()
			funcptr_i = funcptr_i + 1
			timer.start(0.2)
		end
		platform.window:invalidate()
	end
	
	platform.window:invalidate()
end
function _zaiqi_exe(ID)
	wugucards = {}
	game_skip_mopai = true
	push_message(table.concat({char_juese[ID].name, "发动了武将技能 '再起'"}))

	local lost_tili = char_juese[ID].tili_max - char_juese[ID].tili
	for i = 1, lost_tili do
		add_funcptr(_zaiqi_into_paidui, ID)
	end
	add_funcptr(_zaiqi_get_from_paidui, ID)
	timer.start(0.6)
end
function _zaiqi_into_paidui(ID)
	if #card_yixi == 0 then
	    card_xipai(true)
	end

    local card = card_yixi[1]
	push_message(table.concat({char_juese[ID].name, "展示了牌堆顶的'", card[2], card[3], "的", card[1], "'"}))
	
	table.remove(card_yixi, 1)
	table.insert(wugucards, card)
end
function _zaiqi_get_from_paidui(ID)
	local tili_add = 0
	local shoupai_add = 0

	for i = #wugucards, 1, -1 do
		local yanse, huase, dianshu = ai_judge_cardinfo(ID, {wugucards[i]})

		if huase == "红桃" then
			tili_add = tili_add + 1
			card_add_qipai(wugucards[i])
			table.remove(wugucards, i)
		else
			shoupai_add = shoupai_add + 1
			table.insert(char_juese[ID].shoupai, wugucards[i])
			table.remove(wugucards, i)
		end
	end
	wugucards = {}

	if tili_add > 0 then
		push_message(table.concat({char_juese[ID].name, "回复", tili_add, "点体力"}))
		char_juese[ID].tili = math.min(char_juese[ID].tili + tili_add, char_juese[ID].tili_max)
	end

	if shoupai_add > 0 then
		push_message(table.concat({char_juese[ID].name, "获得了", shoupai_add, "张牌"}))
	end

	_zaiqi_huifu()
end
function _zaiqi_huifu()
	funcptr_queue, funcptr_i = pop_zhudong_queue()
end