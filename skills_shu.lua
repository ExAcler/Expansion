--  黄月英：集智  --
function skills_jizhi(ID)
	skills_push_queue()

	if ID == char_current_i then
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
		gamerun_status = "手牌生效中"
		set_hints("")
		
		skills_jizhi_set(char_current_i, gamerun_OK)
	end
	
	platform.window:invalidate()
end
function skills_jizhi_set(ID, gamerun_OK)
	if gamerun_OK then
		if char_juese[ID].skill["集智"] ~= "available" and char_juese[ID].skill["极略"] == "available" and mark_ren[ID] > 0 then
			add_funcptr(push_message, char_juese[ID].name .. "发动了武将技能 '极略' 获得技能集智")
			mark_ren[ID] = mark_ren[ID] - 1
		end

		add_funcptr(push_message, char_juese[ID].name .. "发动了武将技能 '集智'")
		add_funcptr(card_fenfa, {ID, 1, true})
	end
	
	add_funcptr(skills_pop_queue)
	skills_skip_subqueue()
	timer.start(0.6)
end

--  姜维：志继  --
function skills_zhiji(ID)
	skills_push_queue()

	push_message(char_juese[char_acting_i].name.."触发了武将技能 '志继'")
	if ID == char_current_i then
		if char_juese[char_acting_i].tili < char_juese[char_acting_i].tili_max then
			skills_zhiji_enter(ID)
		else
			gamerun_status = ""
			skills_zhiji_set(char_acting_i, 2)
			skills_skip_subqueue()
			timer.start(0.2)
		end
	else
		skills_zhiji_set(ID, ai_judge_zhiji(ID))
		skills_skip_subqueue()
		timer.start(0.2)
	end
end
function skills_zhiji_enter(ID)
	gamerun_status = "选项选择"
	choose_name = "志继"
	jiaohu_text = "请选择要执行的效果"
	choose_option = {"回复一点体力","摸两张牌"}

	txt_messages:setVisible(false)
	gamerun_guankan_selected = 1
	item_disrow = 0

	gamerun_item = function(i)
		funcptr_queue = {}
		gamerun_status = ""
		set_hints("")

		txt_messages:setVisible(true)
		skills_zhiji_set(char_acting_i, i)
		timer.start(0.2)
	end
	
	platform.window:invalidate()
end
function skills_zhiji_set(ID, option)
	if option == 1 then
		add_funcptr(push_message, char_juese[ID].name .. "选择回复一点体力")
		char_tili_huifu(ID, 1)
	elseif option == 2 then
		add_funcptr(push_message, char_juese[ID].name .. "选择摸两张牌")
		add_funcptr(card_fenfa, {char_acting_i, 2, false})
	end
	add_funcptr(_zhiji_sub1, ID)

	if char_juese[char_acting_i].skill["观星"] ~= nil then
		skill_double[char_acting_i]["观星"] = true
	else
		char_juese[char_acting_i].skill["观星"] = "available"
	end
	table.insert(char_juese[char_acting_i].skillname,"观星")
	char_juese[char_acting_i].skill["志继"] = "locked_whole_game"

	add_funcptr(skills_pop_queue)
end
function _zhiji_sub1(ID)
	push_message(char_juese[ID].name .. "失去一点体力上限")
	char_juese[char_acting_i].tili_max = char_juese[char_acting_i].tili_max - 1
	char_juese[char_acting_i].tili = math.min(char_juese[char_acting_i].tili, char_juese[char_acting_i].tili_max)
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
		skills_skip_subqueue()
		return
	end

	skills_push_queue()
	_guanxing_exe_ai(ID)
end
function _guanxing_exe_ai(ID)
	local guanxing = _guanxing_guankan(ID)
	local guanxing_up, guanxing_down = ai_judge_guanxing_operation(ID, guanxing)
	card_dealed_1, card_dealed_2 = guanxing_up, guanxing_down

	add_funcptr(push_message, char_juese[ID].name .. "发动了武将技能 '观星'")
	add_funcptr(_guanxing_set_up, ID)
	add_funcptr(_guanxing_set_down, ID)
	add_funcptr(skills_pop_queue)

	skills_skip_subqueue()
	timer.start(0.6)
end
function skills_guanxing_enter(ID)
	skills_push_queue()

	gamerun_status = "选项选择"
	choose_name = "观星"
	jiaohu_text = "是否发动 '观星'?"
	choose_option = {"是","否"}
	
	txt_messages:setVisible(false)
	gamerun_guankan_selected = 1
	item_disrow = 0

	gamerun_item = function(i)
		txt_messages:setVisible(true)
		set_hints("")
		gamerun_status = ""

		if i == 1 then
			is_drawx = false
			funcptr_queue = {}
			funcptr_i = 0

			add_funcptr(push_message, char_juese[char_current_i].name .. "发动了武将技能 '观星'")
			add_funcptr(_guanxing_exe, char_current_i)
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
function _guanxing_exe(ID_s)
	guanxing_up, guanxing_down = {},{}
	gamerun_status = "牌堆操作"
	choose_name = "观星"
	guanxing_up = _guanxing_guankan(char_current_i)

	card_dealed_1, card_dealed_2 = guanxing_up, guanxing_down
	txt_messages:setVisible(false)
	gamerun_guankan_selected = 1
	card_dealed_selected = 0
	card_paidui_dealed = 1

	gamerun_deal = function()
		funcptr_queue = {}
		funcptr_i = 0

		gamerun_status = ""
		set_hints("")
		txt_messages:setVisible(true)

		skills_guanxing_set(char_current_i)
		timer.start(0.6)
	end
	platform.window:invalidate()
end
function _guanxing_guankan(ID)
	local guankan_paidui = {}
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
		table.insert(guankan_paidui, card_yixi[1])
		table.remove(card_yixi, 1)	
	end

	return guankan_paidui
end
function skills_guanxing_set(ID)
	add_funcptr(_guanxing_set_up, ID)
	add_funcptr(_guanxing_set_down, ID)
	add_funcptr(skills_pop_queue)
end
function _guanxing_set_up(ID)
	push_message(char_juese[ID].name .. "将" .. #card_dealed_1 .. "张牌放在牌堆顶")
	for i = #card_dealed_1,1,-1 do
		table.insert(card_yixi,1,card_dealed_1[i])
	end
end
function _guanxing_set_down(ID)
	push_message(char_juese[ID].name .. "将" .. #card_dealed_2 .. "张牌放在牌堆底")
	for i = 1,#card_dealed_2 do
		table.insert(card_yixi,card_dealed_2[i])
	end
end

--  魏延：狂骨  --
function skills_kuanggu(ID_s, dianshu)
	add_funcptr(push_message, char_juese[ID_s].name .. "触发了武将技能 '狂骨'")
	local _dianshu = math.min(dianshu, char_juese[ID_s].tili_max - char_juese[ID_s].tili)
	char_tili_huifu(ID_s, _dianshu)
end

--  孟获：祸首  --
function skills_huoshou(ID_s)
	add_funcptr(push_message, char_juese[ID_s].name.."触发了武将技能 '祸首'")
end
function _nanman_huoshou(ID_mubiao)
	funcptr_add_tag = "无懈轮询开始"
	add_funcptr(_nanman_huoshou_prepare, ID_mubiao)
	funcptr_add_tag = nil

	add_funcptr(_wuxie_exe)
end
function _nanman_huoshou_prepare(ID_mubiao)
	_nanman_send_msg({char_juese[ID_mubiao].name, "触发了武将技能 '祸首'"})

	wuxie_in_effect = false
	wuxie_queue_jinnang = table.copy(funcptr_queue)
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
		--funcptr_i = funcptr_i + 1
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
			--funcptr_i = funcptr_i + 1
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
	
	local msg = {char_juese[ID_req].name.."发动了武将技能 '挑衅' (对", char_juese[ID_d].name, ")"}
	char_juese[ID_req].skill["挑衅"] = "locked"
	add_funcptr(push_message, table.concat(msg))
	
	_tiaoxin_exe(ID_req, ID_d)
	return true
end
function _tiaoxin_exe(ID_req, ID_d)
	--  刘备激将  --
	if char_juese[ID_d].skill["激将"] == "available" then
		add_funcptr(skills_jijiang_req_side, {ID_d, "技能", {-1, ID_d, ID_req}})
	end

	if ID_d == char_current_i then
		add_funcptr(_tiaoxin_sha_enter, ID_req)
	else
		add_funcptr(_tiaoxin_sha_ai, {ID_req, ID_d})
	end
end
function _tiaoxin_sha_ai(va_list)
	local ID_req, ID_d
	ID_req = va_list[1]; ID_d = va_list[2]
	local targets = ai_judge_tiaoxin_sha_target(ID_d, ID_req)

	funcptr_queue = {}
	funcptr_i = 0

	local ID_shoupai = ai_card_search(ID_d, "杀", 1)
	if #ID_shoupai > 0 then
	    card_sha(ID_shoupai, ID_d, targets, false)
	else
	    _tiaoxin_fangqi(ID_req, ID_d)
	end

	skills_skip_subqueue()
	timer.start(0.6)
end
function _tiaoxin_sha_go(ID_shoupai, ID_s, ID_mubiao)
	if card_sha(ID_shoupai, ID_s, ID_mubiao, false) then
		skills_cs()
		timer.start(0.6)
	end
end
function _tiaoxin_fangqi(ID_req, ID_d)
	add_funcptr(_nanman_send_msg, {char_juese[ID_d].name, "放弃"})

	if ai_card_stat(ID_d, true, false) == 0 then
		add_funcptr(_chai_sub2)
		return
	end

	if ID_req == char_current_i then
		add_funcptr(_chai_sub1, {true, ID_req, ID_d})
	else
		add_funcptr(_chai_ai, {ID_req, ID_d, true})
		skills_losecard(ID_d)
		add_funcptr(_chai_sub2)
	end
end
function _tiaoxin_sha_enter(ID_req)
	local n_targets = 1
	if gamerun_judge_fangtian(char_current_i) then
		n_targets = 3
	end

	funcptr_queue = {}
	funcptr_i = 0

	skills_enter("请您出杀或'取消'放弃", "", "挑衅", "技能选择-多牌")
	gamerun_OK = false
	gamerun_OK_ptr = function()
		if gamerun_OK then
			if skills_luanwu_judge_if_sha() then
				local ID_shoupai = skills_get_selected_shoupai()
				card_selected = {}
				card_highlighted = 1

				if n_targets == 1 then
					_tiaoxin_sha_go(ID_shoupai, char_current_i, {ID_req})
				else
					_tiaoxin_select_additional_targets(ID_shoupai, ID_req)
				end
			end
		else
			gamerun_status = "手牌生效中"
			set_hints("")

			_tiaoxin_fangqi(ID_req, char_current_i)
			timer.start(0.6)
		end
	end
	
	gamerun_tab_ptr = nil
	platform.window:invalidate()
end
function _tiaoxin_select_additional_targets(ID_shoupai, ID_req)
	gamerun_status = "选项选择"
	choose_name = "挑衅"
	jiaohu_text = "是否增加出杀目标?"
	choose_option = {"增加一个", "增加两个", "否"}

	txt_messages:setVisible(false)
	gamerun_guankan_selected = 1
	item_disrow = 0
	
	gamerun_item = function(i)
		txt_messages:setVisible(true)
		funcptr_queue = {}
		gamerun_status = "手牌生效中"
		set_hints("")

		if i == 1 or i == 2 then
			_tiaoxin_add_target_enter(ID_shoupai, i, ID_req)
	    else
			_tiaoxin_sha_go(ID_shoupai, char_current_i, {ID_req})
		end
		platform.window:invalidate()
	end
	
	platform.window:invalidate()
end
function _tiaoxin_add_target_enter(ID_shoupai, n, ID_req)
	if n == 1 then
		skills_enter("请选择目标", "", "挑衅2", "技能选择-目标")
	else
		skills_enter("请选择第一个目标", "", "挑衅2", "技能选择-目标")
	end
	gamerun_select_target("init")
	gamerun_OK = false

	gamerun_OK_ptr = function()
		if gamerun_OK == true and gamerun_target_selected ~= ID_req then
			if n == 1 then
				_tiaoxin_sha_go(ID_shoupai, char_current_i, {ID_req, gamerun_target_selected})
			else
				_tiaoxin_add_target_2_enter(ID_shoupai, ID_req)
			end
		else
			_tiaoxin_sha_go(ID_shoupai, char_current_i, {ID_req})
		end
	end

	gamerun_tab_ptr = nil
	platform.window:invalidate()
end
function _tiaoxin_add_target_2_enter(ID_shoupai, ID_req)
	guankan_s = gamerun_target_selected
	skills_enter("请选择第二个目标", "", "挑衅2", "技能选择-目标B")
	gamerun_select_target("init")
	gamerun_OK = false

	gamerun_OK_ptr = function()
		if gamerun_OK == true and gamerun_target_selected ~= ID_req then
			_tiaoxin_sha_go(ID_shoupai, char_current_i, {ID_req, gamerun_target_selected, guankan_s})
		else
			_tiaoxin_sha_go(ID_shoupai, char_current_i, {ID_req})
		end
	end

	gamerun_tab_ptr = nil
	platform.window:invalidate()
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
	skills_losecard(ID_s)

	add_funcptr(_rende_sub)
	return true
end
function skills_rende_exe(va_list)
	local ID_s, ID_mubiao, ID_shoupai
	ID_s = va_list[1]; ID_mubiao = va_list[2]; ID_shoupai = va_list[3]
	
	skills_push_queue()

	for i = #ID_shoupai, 1, -1 do
		card_insert(ID_mubiao, char_juese[ID_s].shoupai[ID_shoupai[i]])
		card_remove({ID_s, ID_shoupai[i]})
		if char_rende_given >= 0 then
			char_rende_given = char_rende_given + 1
		end
	end
	
	push_message(table.concat({char_juese[ID_s].name, "将", tostring(#ID_shoupai), "张手牌交给", char_juese[ID_mubiao].name}))
	if char_rende_given >= 2 then
		if char_juese[ID_s].tili < char_juese[ID_s].tili_max then
			char_tili_huifu(ID_s, 1)
		end
		char_rende_given = -1
	end

	add_funcptr(skills_pop_queue)
	timer.start(0.6)
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

		ai_card_use(char_acting_i)
	end
end

--  庞统：连环  --
function skills_lianhuan_enter()
	if #char_juese[char_current_i].shoupai == 0 then return false end

	skills_enter("请选择草花牌", "'确定': 选择目标A '取消': 重铸", "铁索连环", "技能选择-单牌")
	
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
		----funcptr_i = funcptr_i + 1
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
		----funcptr_i = funcptr_i + 1
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
			--funcptr_i = funcptr_i + 1
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
	push_message(char_juese[ID].name .. "触发了武将技能 '巨象' 获得了南蛮入侵")
end
function _nanman_juxiang(ID_mubiao)
	funcptr_add_tag = "无懈轮询开始"
	add_funcptr(_nanman_juxiang_prepare, ID_mubiao)
	funcptr_add_tag = nil

	add_funcptr(_wuxie_exe)
end
function _nanman_juxiang_prepare(ID_mubiao)
	_nanman_send_msg({char_juese[ID_mubiao].name, "触发了武将技能 '巨象'"})

	wuxie_in_effect = false
	wuxie_queue_jinnang = table.copy(funcptr_queue)
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
			--funcptr_i = funcptr_i + 1
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
			--funcptr_i = funcptr_i + 1
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
				--funcptr_i = funcptr_i + 1
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
		skills_losecard(ID_s)
	else
		ai_withdraw(ID_s, ID_shoupai, {}, false)
		skills_losecard(ID_s)
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
		skills_skip_subqueue()
		return
	end

	skills_push_queue()
	_zaiqi_exe(ID)
end
function skills_zaiqi_enter()
	skills_push_queue()

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
			skills_pop_queue(true)
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
	timer.stop()
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

	timer.stop()
	funcptr_queue = {}
	funcptr_i = 0

	for i = #wugucards, 1, -1 do
		local yanse, huase, dianshu = ai_judge_cardinfo(ID, {wugucards[i]})

		if huase == "红桃" then
			tili_add = tili_add + 1
			card_add_qipai(wugucards[i])
			table.remove(wugucards, i)
		else
			shoupai_add = shoupai_add + 1
			card_insert(ID, wugucards[i])
			table.remove(wugucards, i)
		end
	end
	wugucards = {}

	if shoupai_add > 0 then
		push_message(table.concat({char_juese[ID].name, "获得了", shoupai_add, "张牌"}))
	end

	if tili_add > 0 then
		char_tili_huifu(ID, math.min(tili_add, char_juese[ID].tili_max - char_juese[ID].tili))
	end

	add_funcptr(skills_pop_queue)
end

--  刘禅：享乐  --
function skills_xiangle(va_list)
	local ID, ID_laiyuan
	ID = va_list[1]; ID_laiyuan = va_list[2]

	push_zhudong_queue(table.copy(funcptr_queue), funcptr_i)
	timer.stop()
	funcptr_queue = {}
	funcptr_i = 0

	push_message(table.concat({char_juese[ID].name, "触发了武将技能 '享乐'"}))
	if ID_laiyuan == char_current_i then
		skills_xiangle_enter(ID)
	else
		skills_xiangle_ai(ID, ID_laiyuan)
	end
end
function skills_xiangle_ai(ID, ID_laiyuan)
	local cards = ai_card_search(ID_laiyuan, "基本", 1)
	if #cards > 0 then
		_xiangle_exe(cards[1], ID, ID_laiyuan)
	else
		_xiangle_huifu()
		funcptr_queue = {}
		funcptr_i = 0

		add_funcptr(push_message, table.concat({char_juese[ID_laiyuan].name, "放弃"}))
		add_funcptr(_sha_sub2)
		timer.start(0.6)
	end
end
function skills_xiangle_enter(ID)
	skills_enter("请弃一张基本牌", "", "享乐", "技能选择-单牌")
	gamerun_OK = false
	
	gamerun_OK_ptr = function()
		if gamerun_OK == true then
			if table.getn2(card_selected) ~= 1 then
				return
			end

			local card = char_juese[char_current_i].shoupai[card_highlighted]
			if card_get_leixing(card[1]) == "基本牌" then
				gamerun_status = "手牌生效中"
				set_hints("")

				_xiangle_exe(card_highlighted, ID, char_current_i)
				card_selected = {}
				card_highlighted = 1
			end
		else
			gamerun_status = "手牌生效中"
			set_hints("")
			push_message(table.concat({char_juese[char_current_i].name, "放弃"}))

			_xiangle_huifu()
			funcptr_queue = {}
			funcptr_i = 0

			add_funcptr(_sha_sub2)
			timer.start(0.6)
		end
	end
	
	gamerun_tab_ptr = nil
end
function _xiangle_exe(ID_shoupai, ID, ID_laiyuan)
	add_funcptr(_xiangle_sub1, {ID_shoupai, ID_laiyuan})
	skills_losecard(ID_laiyuan)
	add_funcptr(_xiangle_huifu)
	timer.start(0.6)
end
function _xiangle_sub1(va_list)
	local ID_shoupai, ID_laiyuan
	ID_shoupai = va_list[1]; ID_laiyuan = va_list[2]

	local card = char_juese[ID_laiyuan].shoupai[ID_shoupai]

	push_message(table.concat({char_juese[ID_laiyuan].name, "弃掉了'", card[2], card[3], "的", card[1], "'"}))
	card_add_qipai(card)
	card_remove({ID_laiyuan, ID_shoupai})
end
function _xiangle_huifu()
	funcptr_queue, funcptr_i = pop_zhudong_queue()
end

--  刘备：激将  --
function skills_jijiang_current_enter()
	skills_enter("请选择杀的目标", "", "杀", "技能选择-目标")
	gamerun_select_target("init")
	gamerun_OK = false

	gamerun_OK_ptr = function()
		if gamerun_OK == true and card_if_d_limit("杀", char_current_i, gamerun_target_selected, nil) then
			gamerun_status = "手牌生效中"
			set_hints("")
			skills_cs()

			add_funcptr(skills_rst)
			skills_push_queue()

			skills_jijiang_add(char_current_i, "杀", {-1, char_current_i, gamerun_target_selected})
			timer.start(0.6)
		end
	end

	platform.window:invalidate()
	return true
end
function skills_jijiang_req_side(va_list)
	local ID_req, mode, va
	ID_req = va_list[1]; mode = va_list[2]; va = va_list[3]

	if ID_req == char_current_i then
		skills_jijiang_req_side_enter(mode, va)
	else
		skills_jijiang_req_side_ai(ID_req, mode, va)
	end
end
function skills_jijiang_req_side_ai(ID_req, mode, va)
	if ai_judge_jijiang_req(ID_req) == false then
		return
	end

	skills_push_queue()

	skills_jijiang_add(ID_req, mode, va)
	timer.start(0.6)
end
function skills_jijiang_req_side_enter(mode, va)
	local old_gamerun_status = gamerun_status

	skills_push_queue()

	gamerun_status = "确认操作"
	jiaohu_text = "是否发动 '激将'?"
	gamerun_OK = false
	gamerun_OK_ptr = function()
		set_hints("")
		gamerun_status = old_gamerun_status

		if gamerun_OK == true then
			skills_jijiang_add(char_current_i, mode, va)
		else
			skills_pop_queue(true)
		end
		timer.start(0.6)
	end
	
	platform.window:invalidate()
end
function skills_jijiang_add(ID_req, mode, va)
	push_message(table.concat({char_juese[ID_req].name, "发动了武将技能 '激将'"}))
	for i = 1, 5 do
		if char_juese[i].shili == "蜀" and ID_req ~= i and char_juese[i].siwang == false then
			add_funcptr(skills_jijiang, {ID_req, i, mode, va})
		end
	end
	add_funcptr(skills_pop_queue)
end
function skills_jijiang(va_list)
	local ID_req, ID_res, mode, va
	ID_req = va_list[1]; ID_res = va_list[2]; mode = va_list[3]; va = va_list[4]

	if ID_res == char_current_i then
		skills_jijiang_enter(ID_req, mode, va)
	else
		skills_jijiang_ai(ID_req, ID_res, mode, va)
	end
end
function skills_jijiang_ai(ID_req, ID_res, mode, va)
	if ai_judge_jijiang(_jijiang_get_ids(va, mode), _jijiang_get_idd(va, mode), ID_req, ID_res, mode) == false then
		push_message(table.concat({char_juese[ID_res].name, "不响应"}))
		return
	end

	local c_pos = ai_chazhao_sha(ID_res, char_juese[ID_res].shoupai)
	if c_pos < 0 then
		push_message(table.concat({char_juese[ID_res].name, "不响应"}))
		return
	end

	skills_push_queue()

	_jijiang_exe(ID_req, ID_res, {c_pos}, mode, va)
	timer.start(0.6)
end
function skills_jijiang_enter(ID_req, mode, va)
	local old_gamerun_status = gamerun_status

	skills_push_queue()

	gamerun_status = "确认操作"
	jiaohu_text = table.concat({"是否响应", char_juese[ID_req].name, "的'激将'?"})
	gamerun_OK = false
	gamerun_OK_ptr = function()
		funcptr_queue = {}
		set_hints("")

		if gamerun_OK == true then
			_jijiang_select_card(ID_req, mode, va, old_gamerun_status)
		else
			gamerun_status = old_gamerun_status
			add_funcptr(push_message, table.concat({char_juese[char_current_i].name, "不响应"}))
			add_funcptr(skills_pop_queue)
		end
		timer.start(0.6)
	end
	
	platform.window:invalidate()
end
function _jijiang_select_card(ID_req, mode, va, old_gamerun_status)
	skills_enter("您可出1张杀", "", "激将", "技能选择-多牌")
	gamerun_OK_ptr = function()
		if gamerun_OK == true then
			local qualified = false
			local c_pos = skills_get_selected_shoupai()
			if #c_pos == 1 then
				if card_judge_if_sha(char_current_i, c_pos[1]) then
					qualified = true
				end
			elseif (mode == "借刀杀人" or mode == "杀" or mode == "技能" or mode == "青龙刀") and #char_juese[char_current_i].wuqi > 0 then
				if char_juese[char_current_i].wuqi[1] == "丈八矛" then
					if #c_pos == 2 then
						qualified = true
					end
				end
			end

			if qualified == false then
				return
			end

			gamerun_status = old_gamerun_status
			set_hints("")
			_jijiang_exe(ID_req, char_current_i, c_pos, mode, va)

			card_selected = {}
			card_highlighted = 1
		else
			gamerun_status = old_gamerun_status
			set_hints("")
			add_funcptr(push_message, table.concat({char_juese[char_current_i].name, "不响应"}))
			add_funcptr(skills_pop_queue)
		end
		timer.start(0.6)
	end
	
	gamerun_tab_ptr = nil
end
function _jijiang_exe(ID_req, ID_res, ID_shoupai, mode, va)
	--  弹出第一层：激将响应  --
	skills_pop_queue(true)

	--  弹出第二层：激将请求  --
	skills_pop_queue(true)

	--  清空原有函数队列  --
	funcptr_queue = {}
	funcptr_i = 0

	push_message(table.concat({char_juese[ID_res].name, "响应"}))
	
	if mode == "决斗" then
		local ID_s, ID_mubiao, wushuang_flag
		ID_s = va[1]; ID_mubiao = va[2]; wushuang_flag = va[3]

		add_funcptr(_juedou_sha, {ID_res, ID_s, ID_shoupai[1]})
		skills_losecard(ID_res)
		_juedou_nextstep(ID_s, ID_mubiao, wushuang_flag)
	elseif mode == "南蛮入侵" then
		add_funcptr(_nanman_sha, {ID_res, ID_shoupai[1]})
		skills_losecard(ID_res)
		add_funcptr(_nanman_zhudong_huifu)
	elseif mode == "借刀杀人" or mode == "杀" or mode == "技能" or mode == "青龙刀" then
		local ID_jiedao_req, ID_s, ID_mubiao
		ID_jiedao_req = va[1]; ID_s = va[2]; ID_mubiao = va[3]

		add_funcptr(_jijiang_geipai, {ID_res, ID_s, ID_shoupai})
		skills_losecard(ID_res)
		add_funcptr(_jijiang_sha, {ID_jiedao_req, ID_s, ID_mubiao, mode, #ID_shoupai})
	end
end
function _jijiang_sha(va_list)
	local ID_req, ID_s, ID_mubiao, mode, n_sha
	ID_req = va_list[1]; ID_s = va_list[2]; ID_mubiao = va_list[3]; mode = va_list[4]; n_sha = va_list[5]

	local ID_shoupai = {}
	local n_shoupai = #char_juese[ID_s].shoupai
	for i = n_shoupai - n_sha + 1, n_shoupai do
		table.insert(ID_shoupai, i)
	end

	if mode == "借刀杀人" then
		_jiedao_sha(ID_shoupai, ID_req, ID_s, ID_mubiao)
	elseif mode == "技能" then
		card_sha(ID_shoupai, ID_s, {ID_mubiao}, false)
	elseif mode == "青龙刀" then
		_sha_qinglong_go(ID_shoupai, ID_s, {ID_mubiao}, ID_req)		--  iscur代ID_req
	else
		card_sha(ID_shoupai, ID_s, {ID_mubiao}, true)
	end
end
function _jijiang_geipai(va_list)
	local ID_s, ID_d, c_pos, msg
	ID_s = va_list[1]; ID_d = va_list[2]; c_pos = va_list[3]
	
	msg = table.concat({char_juese[ID_s].name, "提供了"})

	for i = 1, #c_pos do
		local card = char_juese[ID_s].shoupai[c_pos[i]]
		msg = msg .. table.concat({"'", card[2], card[3], "的", card[1], "'"})
		if i ~= #c_pos then
			msg = msg .. "，"
		end
	end
	push_message(msg)

	for i = #c_pos, 1, -1 do
		table.insert(char_juese[ID_d].shoupai, char_juese[ID_s].shoupai[c_pos[i]])
		card_remove({ID_s, c_pos[i]})
	end
end
function _jijiang_get_ids(va, mode)
	if mode == "决斗" then
		return va[1]
	elseif mode == "南蛮入侵" then
		return va[1]
	elseif mode == "借刀杀人" or mode == "杀" or mode == "技能" or mode == "青龙刀" then
		return va[2]
	end
	return nil
end
function _jijiang_get_idd(va, mode)
	if mode == "决斗" then
		return va[2]
	elseif mode == "南蛮入侵" then
		return va[2]
	elseif mode == "借刀杀人" or mode == "杀" or mode == "技能" or mode == "青龙刀" then
		return va[3]
	end
	return nil
end

--  刘禅：若愚  --
function skills_judge_ruoyu()
	local acting_tili = char_juese[char_acting_i].tili

	for i = 1, 5 do
		if char_juese[i].siwang == false and char_juese[i].tili < acting_tili then
			return false
		end
	end

	return true
end
function skills_ruoyu()
	push_zhudong_queue(table.copy(funcptr_queue), funcptr_i)
	funcptr_queue = {}
	funcptr_i = 0

	push_message(char_juese[char_acting_i].name.."触发了武将技能 '若愚'")
	add_funcptr(_ruoyu_add_tili_max)
	char_tili_huifu(char_acting_i, 1)
	
	if char_juese[char_acting_i].skill["激将"] ~= nil then
		skill_double[char_acting_i]["激将"] = true
	else
		char_juese[char_acting_i].skill["激将"] = "available"
	end
	table.insert(char_juese[char_acting_i].skillname, "激将")

	char_juese[char_acting_i].skill["若愚"] = "locked_whole_game"

	add_funcptr(_hujia_huifu)
	timer.start(0.6)
end
function _ruoyu_add_tili_max()
	char_juese[char_acting_i].tili_max = char_juese[char_acting_i].tili_max + 1
	push_message(char_juese[char_acting_i].name .. "增加1点体力上限")
end

--  祝融：烈刃  --
function skills_lieren(va_list)
	local ID_s, ID_mubiao
	ID_s = va_list[1]; ID_mubiao = va_list[2]

	if #char_juese[ID_s].shoupai == 0 or #char_juese[ID_mubiao].shoupai == 0 then
		skills_skip_subqueue()
		return
	end

	if ID_s == char_current_i then
		skills_lieren_enter(ID_mubiao)
	else
		skills_lieren_ai(ID_s, ID_mubiao)
	end
end
function skills_lieren_ai(ID_s, ID_mubiao)
	if ai_judge_lieren(ID_s, ID_mubiao) == false then
		skills_skip_subqueue()
		return
	end

	skills_push_queue()
	_lieren_exe(ID_s, ID_mubiao)
end
function skills_lieren_enter(ID_mubiao)
	skills_push_queue()

	local old_gamerun_status = gamerun_status
	gamerun_status = "确认操作"
	jiaohu_text = "是否发动 '烈刃'?"
	gamerun_OK = false
	
	gamerun_OK_ptr = function()
		funcptr_queue = {}
		gamerun_status = old_gamerun_status
		set_hints("")

		if gamerun_OK then
			_lieren_exe(char_current_i, ID_mubiao)
	    else
			skills_pop_queue(true)
			timer.start(0.6)
		end
		platform.window:invalidate()
	end
	
	platform.window:invalidate()
end
function _lieren_exe(ID_s, ID_mubiao)
	local win_fp = function(s_win, mubiao_win)
		if s_win == false then
			skills_skip_subqueue()
			return
		end
		skills_cs()
		_lieren_shun(ID_s, ID_mubiao)
	end

	funcptr_queue = {}
	funcptr_i = 0

	add_funcptr(push_message, char_juese[ID_s].name .. "发动了武将技能 '烈刃'")
	add_funcptr(push_message, table.concat({char_juese[ID_s].name, "与", char_juese[ID_mubiao].name, "进行拼点"}))
	add_funcptr(card_pindian, {ID_s, ID_mubiao, win_fp, false})
	add_funcptr(skills_pop_queue)
	timer.start(0.6)
end
function _lieren_shun(ID_s, ID_mubiao)
	if ai_card_stat(ID_mubiao, true, true) == 0 then
		skills_skip_subqueue()
		return
	end

	if ID_s == char_current_i then
		_lieren_shun_exe(ID_s, ID_mubiao)
	else
		_shun_ai({ID_s, ID_mubiao, true})
	end
end
function _lieren_shun_exe(ID_s, ID_d)
	skills_push_queue()

	fankui_gamerun_status = gamerun_status
	gamerun_status = "观看手牌-烈刃"
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
