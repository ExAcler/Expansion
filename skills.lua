
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
}

--  黄月英：集智  --
function skills_jizhi(ID_s)
	push_message(char_juese[ID_s].name.."发动了武将技能 '集智'")
	card_fenfa( {ID_s, 1, true})
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
	if char_juese[char_acting_i].skill["英魂"] ~= nil then
		skill_double = true
	else
		char_juese[char_acting_i].skill["英魂"] = "available"
	end
	table.insert(char_juese[char_acting_i].skillname,"英魂")
	if char_juese[char_acting_i].skill["英姿"] ~= nil then
		skill_double = true
	else
		char_juese[char_acting_i].skill["英姿"] = "available"
	end
	table.insert(char_juese[char_acting_i].skillname,"英姿")
	char_juese[char_acting_i].skill["魂姿"] = "locked_whole_game"
end

--  太史慈：天义  --
--  暂时不能增加出杀目标 --
function skills_tianyi_enter()
	if #char_juese[char_current_i].shoupai == 0 then return false end
	timer.stop()
	funcptr_queue = {}
	skills_enter("请选择目标", "", "天义", "技能选择-目标")
	gamerun_select_target("init")
	gamerun_OK_ptr = function()
		if #char_juese[gamerun_target_selected].shoupai == 0 then return false end

		local win_fp = function(win)
			if win then
				char_juese[char_current_i].skill["天义"] = "locked"
				char_sha_time = char_sha_time + 1
				char_distance_infinity = true
				
				consent_func_queue(0.6)
			else
				char_juese[char_current_i].skill["天义"] = "locked"
				char_sha_able = false
				skills_cs()
				consent_func_queue(0.6)
			end

			skills_cs()
			_quhu_sub2()
		end

		card_pindian(char_current_i, gamerun_target_selected, win_fp)
	end
	return true
end

--  荀彧：驱虎  --
function skills_quhu_enter()
	if #char_juese[char_current_i].shoupai == 0 then return false end
	timer.stop()
	funcptr_queue = {}
	skills_enter("请选择目标", "", "驱虎", "技能选择-目标")
	gamerun_select_target("init")
	gamerun_OK_ptr = function()
		if #char_juese[gamerun_target_selected].shoupai == 0 then return false end

		local win_fp = function(win)
			if win then
				char_juese[char_current_i].skill["驱虎"] = "locked"
				if #ai_judge_in_range(gamerun_target_selected) > 0 then
					guankan_s = gamerun_target_selected
					_quhu_sub1()
				else
					skills_cs()
					_quhu_sub2()
				end
			else
				skills_cs()
				char_juese[char_current_i].skill["驱虎"] = "locked"
				char_tili_deduct({1, char_current_i, gamerun_target_selected, "普通", char_current_i, nil, true})
				add_funcptr(_quhu_sub2)
				consent_func_queue(0.6)
			end
		end

		card_pindian(char_current_i, gamerun_target_selected, win_fp)
	end
	return true
end
function _quhu_sub1()
	skills_enter("请选择伤害的目标", "", "驱虎2", "技能选择-目标B")
	gamerun_select_target("init")
	
	gamerun_OK_ptr = function()
		if card_if_d_limit("驱虎2", guankan_s, gamerun_target_selected) then
			set_hints("")
			gamerun_status = "手牌生效中"

			skills_cs()
			char_tili_deduct({1, gamerun_target_selected, guankan_s, "普通", char_current_i, nil, true})
			add_funcptr(_quhu_sub2)
			consent_func_queue(0.6)
		end
	end
end
function _quhu_sub2()
	gamerun_OK = false
	gamerun_status = ""
	jiaohu_text = "请您出牌"
	platform.window:invalidate()
end

--  孙坚：英魂  --
function skills_yinghun_enter(ID)
	--  AI不做任何动作 (临时)  --
	if ID ~= char_current_i then
		return
	end

	skill_yinghun = coroutine.create(
		function ()
			timer.stop()
			yinghun_queue_xiangying = table.copy(funcptr_queue)
			yinghun_queue_xiangying_i = funcptr_i
			funcptr_queue = {}
			gamerun_status = "选项选择"
			choose_name = "英魂"
			jiaohu_text = "是否使用 '英魂' 令其他角色摸牌弃牌?"
			choose_option = {"摸1弃"..(char_juese[char_current_i].tili_max-char_juese[char_current_i].tili),"摸"..(char_juese[char_current_i].tili_max-char_juese[char_current_i].tili).."弃1","不发动"}
			txt_messages:setVisible(false)
			gamerun_guankan_selected = 1
			item_disrow = 0
			gamerun_item = function(i)
				funcptr_queue = {}
				txt_messages:setVisible(true)
				if i == 1 then
					add_funcptr(push_message, char_juese[char_current_i].name.."发动了武将技能 '英魂'选择摸1弃"..(char_juese[char_current_i].tili_max-char_juese[char_current_i].tili))
					is_drawx = false
				elseif i == 2 then
					add_funcptr(push_message, char_juese[char_current_i].name.."发动了武将技能 '将驰'选择摸"..(char_juese[char_current_i].tili_max-char_juese[char_current_i].tili).."弃1")
					is_drawx = true
				else
					set_hints("")
					gamerun_status = ""
					funcptr_queue = yinghun_queue_xiangying
					funcptr_i = yinghun_queue_xiangying_i + 1
					timer.start(0.6)
					return
				end
				
				if is_drawx ~= nil then
					gamerun_status = "选择目标-英魂"
					set_hints("请选择目标")
					gamerun_select_target("init")
					platform.window:invalidate()
				end
			end
		end)
	coroutine.resume(skill_yinghun)
	platform.window:invalidate()
end
function _yinghun_exe(is_drawx)
	funcptr_queue = {}
	push_message(char_juese[char_current_i].name .. "发动了武将技能 '英魂'")
	
	local qipai_id, qi_zhuangbei_id
	if is_drawx then
		card_fenfa({gamerun_target_selected, char_juese[char_current_i].tili_max - char_juese[char_current_i].tili, true})
		qipai_id, qi_zhuangbei_id = ai_judge_withdraw(gamerun_target_selected, 1, true)
	else
		card_fenfa({gamerun_target_selected,1,true})
		qipai_id, qi_zhuangbei_id = ai_judge_withdraw(gamerun_target_selected, char_juese[char_current_i].tili_max - char_juese[char_current_i].tili, true)
	end
	ai_withdraw(gamerun_target_selected, qipai_id, qi_zhuangbei_id, false)

	is_drawx = nil
	set_hints("")
	gamerun_status = ""
	funcptr_queue = yinghun_queue_xiangying
	funcptr_i = yinghun_queue_xiangying_i + 1
	timer.start(0.6)
end


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

--  郭嘉：遗计  --
function skills_yiji(ID_s, deduct)
	add_funcptr(push_message, char_juese[ID_s].name.."发动了武将技能 '遗计'")
	add_funcptr(card_fenfa, {ID_s, deduct * 2, true})
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

--  周瑜：英姿  --
function skills_yingzi(ID_s)
	push_message(char_juese[ID_s].name.."发动了武将技能 '英姿'")
end

--  貂蝉：闭月  --
function skills_biyue(ID)
	add_funcptr(push_message, char_juese[ID].name.."发动了武将技能 '闭月'")
	add_funcptr(card_fenfa, {ID, 1, true})
end

--  袁绍：血裔判断  --
function skills_judge_xueyi(ID)
	local i, extra
	
	extra = 0
	if char_juese[ID].skill["血裔"]~="available" or char_juese[ID].shenfen ~= "主公" then
		return 0
	end
	
	for i = 1, 5 do
		if char_juese[i].siwang == false and char_juese[ID].shili == "群" then
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
		if char_juese[i].tili < tili then
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
		char_tili_deduct({1, char_acting_i, nil, "流失", char_acting_i})
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
			
			add_funcptr(push_message, char_juese[char_current_i].name .. "发动了武将技能 '崩坏'")
			char_tili_deduct({1, char_current_i, nil, "流失", char_current_i})

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
function skills_judge_keji(ID)
	if char_juese[char_acting_i].skill["克己"]=="available" then
		if char_yisha then
			return false
		else
			return true
		end
	else
		return false
	end
end

--  孙策：激昂  --
function skills_jiang(ID)
	add_funcptr(push_message, char_juese[ID].name .. "发动了武将技能 '激昂'")
	add_funcptr(card_fenfa, {ID, 1, true})
end

--  神曹操：归心 --
function skills_guixin(ID)
    add_funcptr(push_message, char_juese[ID].name .. "发动了武将技能 '归心'")
	add_funcptr(_guixin_exe, ID)
	add_funcptr(push_message, char_juese[ID].name .. "将武将牌翻面")
	add_funcptr(char_fanmian, ID)
end
function _guixin_exe(ID)
	for i = 1, 5 do
		if i ~= ID and char_juese[i].siwang == false then
			--  简易AI  --
			if #char_juese[i].wuqi > 0 and char_juese[i].wuqi[1] == "诸葛弩" then
				--  拿走诸葛连弩  --
				_guixin_exe_3({ID, i})
			elseif #char_juese[i].fangju > 0 then
				--  拿走防具  --
				_guixin_exe_2({ID, i})
			else
				--  拿走手牌  --
				if #char_juese[i].shoupai > 0 then
					_guixin_exe_1({ID, i})
				end
			end
		end
	end
end
function _guixin_exe_1(va_list)    --  拿走手牌
	local ID, i
	ID = va_list[1]; i = va_list[2]

	local t = math.random(#char_juese[i].shoupai)
	push_message(table.concat({char_juese[ID].name .. "获得", char_juese[i].name, "的一张手牌"}))
	table.insert(char_juese[ID].shoupai, char_juese[i].shoupai[t])
	card_remove({i, t})
end
function _guixin_exe_2(va_list)    --  拿走防具
	local ID, i
	ID = va_list[1]; i = va_list[2]

	local card = char_juese[i].fangju
	push_message(table.concat({char_juese[ID].name .. "获得", char_juese[i].name, "的防具 '", card[2], card[3], "的", card[1], "'"}))
	table.insert(char_juese[ID].shoupai, char_juese[i].fangju)
	char_juese[i].fangju = {}
end
function _guixin_exe_3(va_list)    --  拿走武器
	local ID, i
	ID = va_list[1]; i = va_list[2]

	local card = char_juese[i].wuqi
	push_message(table.concat({char_juese[ID].name .. "获得", char_juese[i].name, "的武器 '", card[2], card[3], "的", card[1], "'"}))
	table.insert(char_juese[ID].shoupai, char_juese[i].wuqi)
	char_juese[i].wuqi = {}
end

--  司马懿：反馈  --
function skills_fankui(ID, laiyuan)
	add_funcptr(push_message, char_juese[ID].name .. "发动了武将技能 '反馈'")
	add_funcptr(_fankui_exe, {ID, laiyuan})
end
function _fankui_exe(va_list)
	local ID, laiyuan
	ID = va_list[1]; laiyuan = va_list[2]

	--  简易AI  --
	--  拿走诸葛连弩  --
	if #char_juese[laiyuan].wuqi > 0 then
		if char_juese[laiyuan].wuqi[1] == "诸葛弩" then
			_fankui_exe_3({ID, laiyuan})
			return
		end
	end
	
	--  拿走防具  --
	if #char_juese[laiyuan].fangju > 0 then
		_fankui_exe_2({ID, laiyuan})
		return
	end
	
	--  拿走手牌  --
	if #char_juese[laiyuan].shoupai > 0 then
		_fankui_exe_1({ID, laiyuan})
		return
	end
end
function _fankui_exe_1(va_list)    --  拿走手牌
	local ID, laiyuan
	ID = va_list[1]; laiyuan = va_list[2]

	local t = math.random(#char_juese[laiyuan].shoupai)
	push_message(table.concat({char_juese[ID].name .. "获得", char_juese[laiyuan].name, "的一张手牌"}))
	table.insert(char_juese[ID].shoupai, char_juese[laiyuan].shoupai[t])
	card_remove({laiyuan, t})
end
function _fankui_exe_2(va_list)    --  拿走防具
	local ID, laiyuan
	ID = va_list[1]; laiyuan = va_list[2]

	local card = char_juese[laiyuan].fangju
	push_message(table.concat({char_juese[ID].name .. "获得", char_juese[laiyuan].name, "的防具 '", card[2], card[3], "的", card[1], "'"}))
	table.insert(char_juese[ID].shoupai, char_juese[laiyuan].fangju)
	char_juese[laiyuan].fangju = {}
end
function _fankui_exe_3(va_list)    --  拿走武器
	local ID, laiyuan
	ID = va_list[1]; laiyuan = va_list[2]

	local card = char_juese[laiyuan].wuqi
	push_message(table.concat({char_juese[ID].name .. "获得", char_juese[laiyuan].name, "的武器 '", card[2], card[3], "的", card[1], "'"}))
	table.insert(char_juese[ID].shoupai, char_juese[laiyuan].wuqi)
	char_juese[laiyuan].wuqi = {}
end

--  甘宁：奇袭  --
function skills_qixi_enter()
	if #char_juese[char_current_i].shoupai == 0 then return false end

	gamerun_wuqi_into_hand(char_current_i)
	skills_enter("请选择黑色手牌", "使用过河拆桥", "过河拆桥", "技能选择-单牌")
	
	gamerun_OK_ptr = function()
		skills_qixi()
	end
	
	gamerun_tab_ptr = function()
		if skills_judge_black() then
			skills_enter_target()
		end
	end
	
	return true
end
function skills_qixi()
	if skills_judge_black() then
		if card_chai(card_highlighted, char_current_i, gamerun_target_selected) then
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

function skills_judge_black()    --  判断选择的手牌是否为黑色
	if table.getn2(card_selected) ~= 0 then
		local card = char_juese[char_current_i].shoupai[card_highlighted]
		if card[2] == "黑桃" or card[2] == "草花" then
			return true
		end
	end
	return false
end
function skills_judge_red()    --  判断选择的手牌是否为红色
	if table.getn2(card_selected) ~= 0 then
		local card = char_juese[char_current_i].shoupai[card_highlighted]
		if card[2] == "红桃" or card[2] == "方块" then
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
function skills_judge_huase(huase)    --  判断选择的手牌是否为某花色
	if table.getn2(card_selected) ~= 0 then
		local card = char_juese[char_current_i].shoupai[card_highlighted]
		if card[2] == huase then
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
		skills_huoji()
	end
	
	gamerun_tab_ptr = function()
		if skills_judge_red() then
			skills_enter_target()
		end
	end
	
	return true
end
function skills_huoji()
	if skills_judge_red() then
		funcptr_queue = {}
		if card_huogong(card_highlighted, char_current_i, gamerun_target_selected) then
			skills_cs()
		    consent_func_queue(0.6)
		end
	end
end

--  黄盖：苦肉  --
function skills_kurou_enter()
	--if char_juese[char_current_i].tili < 1 then return false end

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
	char_tili_deduct({1, char_current_i, char_current_i, "流失"})
	add_funcptr(card_fenfa, {char_current_i, 2, true})
	add_funcptr(_kurou_sub2)
end
function _kurou_sub1()
	set_hints("")
	gamerun_status = "手牌生效中"
	push_message(char_juese[char_current_i].name .. "发动了武将技能 '苦肉'")
end
function _kurou_sub2()
	set_hints("请您出牌")
	gamerun_status = ""
end

--  董卓：酒池  --
function skills_jiuchi_enter()
	if #char_juese[char_current_i].shoupai == 0 then return false end

	skills_enter("请选择黑色手牌", "使用酒", "酒", "技能选择-单牌")
	
	gamerun_OK_ptr = function()
		skills_jiuchi()
	end
	
	gamerun_tab_ptr = function() end
	
	return true
end
function skills_jiuchi()
	if skills_judge_black() then
		funcptr_queue = {}
		if card_jiu({card_highlighted, char_current_i, false}) then
			skills_cs()
			skills_rst()
		end
	end
end

--  关羽：武圣  --
function skills_wusheng_enter()
	if #char_juese[char_current_i].shoupai == 0 then return false end

	skills_enter("请选择红色手牌", "杀", "杀", "技能选择-单牌")
	
	gamerun_OK_ptr = function()
		skills_wusheng()
	end
	
	gamerun_tab_ptr = function()
		if skills_judge_red() then
			skills_enter_target()
		end
	end
	
	return true
end
function skills_wusheng()
	if skills_judge_red() then
		funcptr_queue = {}
		if card_sha(card_highlighted, char_current_i, gamerun_target_selected, true) then
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
		skills_longdan()
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
		if card_sha(card_highlighted, char_current_i, gamerun_target_selected, true) then
			skills_cs()
		    consent_func_queue(0.6)
		end
	end
end

--  大乔：国色  --
function skills_guose_enter()
	if #char_juese[char_current_i].shoupai == 0 then return false end

	gamerun_wuqi_into_hand(char_current_i)
	skills_enter("请选择方块牌", "使用乐不思蜀", "乐不思蜀", "技能选择-单牌")
	
	gamerun_OK_ptr = function()
		skills_guose()
	end
	
	gamerun_tab_ptr = function()
		if skills_judge_huase("方块") then
			skills_enter_target()
		end
	end
	
	return true
end
function skills_guose()
	if skills_judge_huase("方块") then
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
	if #char_juese[char_current_i].shoupai == 0 then return false end

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
function skills_liegong_enter(card_shoupai, ID_shoupai, ID_s, ID_mubiao)
    gamerun_status = "确认操作"
	jiaohu_text = "可按'确定'发动烈弓"
	gamerun_OK = false
	
	gamerun_OK_ptr = function()
	    gamerun_status = ""; set_hints("")
		if gamerun_OK then
	        funcptr_queue = {}
			skills_liegong(card_shoupai, ID_shoupai, ID_s, ID_mubiao)
		    consent_func_queue(0.6)
	    else
			funcptr_queue = {}
			_liegong_sha(card_shoupai, ID_shoupai, ID_s, ID_mubiao)
			consent_func_queue(0.6)
		end
	end
	
	platform.window:invalidate()
end
function skills_liegong(card_shoupai, ID_shoupai, ID_s, ID_mubiao)
	add_funcptr(push_message, char_juese[ID_s].name.."发动了武将技能 '烈弓'")
	char_liegong = true
	_liegong_sha(card_shoupai, ID_shoupai, ID_s, ID_mubiao)
end
function _liegong_sha(card_shoupai, ID_shoupai, ID_s, ID_mubiao)
	if #char_juese[ID_s].wuqi ~= 0 then
		if _sha_judge_zhuque_cixiong(ID_shoupai, card_shoupai, ID_s, ID_mubiao) == false then
			_sha_go(ID_shoupai, card_shoupai, ID_s, ID_mubiao, iscur)
		end
	else
		_sha_go(ID_shoupai, card_shoupai, ID_s, ID_mubiao, iscur)
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
	
		for i, _ in pairs(card_selected) do
			if h1 == 0 then
				h1 = i
			else
				h2 = i
			end
		end
		
		if card_wanjian({h1, h2}, char_current_i) then
			skills_cs()
		    consent_func_queue(0.6)
		end
	end
end

--  孙尚香：结姻  --
function skills_jieyin_enter()
	--if char_juese[char_current_i].tili == char_juese[char_current_i].tili_max then return false end
	if #char_juese[char_current_i].shoupai == 0 then return false end
	
	skills_enter("请选择两张牌", "请选择受伤男性", "结姻", "技能选择-多牌")
	
	gamerun_OK_ptr = function()
		if skills_jieyin(char_current_i, gamerun_target_selected) then
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
function skills_judge_jieyin_2(target)
	if char_juese_jineng[char_juese[target].name][5] == "男" and char_juese[target].tili < char_juese[target].tili_max then
		return true
	end
	return false
end
function skills_jieyin(ID_s, ID_mubiao)
	if skills_judge_jieyin_1() == false or skills_judge_jieyin_2(ID_mubiao) == false then return false end
	funcptr_queue = {}
	
	local h1 = 0
	local h2 = 0
	
	for i, _ in pairs(card_selected) do
		if h1 == 0 then
			h1 = i
		else
			h2 = i
		end
	end
	
	add_funcptr(_jieyin_sub1, {ID_s, h1, h2})
	if char_juese[ID_s].tili < char_juese[ID_s].tili_max then
		add_funcptr(_tao_sub, {ID_s, true})
	end
	add_funcptr(_tao_sub, {ID_mubiao, false})
	--add_funcptr(_skills_rst)
	return true
end
function _jieyin_sub1(va_list)
	local i
	local ID_s, h1, h2
	ID_s = va_list[1]; h1 = va_list[2]; h2 = va_list[3]
	
	set_hints("")
	gamerun_status = "手牌生效中"
	
	push_message(char_juese[ID_s].name.."发动了武将技能 '结姻'")
	card_shanchu({ID_s, h1})
	card_shanchu({ID_s, h2 - 1})
	char_juese[ID_s].skill["结姻"] = "locked"
end

--  张昭张纮：直谏  --
function skills_zhijian_enter()
	if #char_juese[char_current_i].shoupai == 0 then return false end
	
	skills_enter("请选择装备牌", "请选择目标", "直谏", "技能选择-单牌")
	
	gamerun_OK_ptr = function()
		if skills_zhijian(char_current_i, card_highlighted, gamerun_target_selected) then
			skills_cs()
			consent_func_queue(0.6)
		end
	end
	
	gamerun_tab_ptr = function()
		if skills_judge_zhijian_1() then
			skills_enter_target()
		end
	end
	
	return true
end
function skills_judge_zhijian_1()
	local card = char_juese[char_current_i].shoupai[card_highlighted]
	
	if card_get_leixing(card[1]) == "武器" or card_get_leixing(card[1]) == "防具" or card_get_leixing(card[1]) == "+1马" or card_get_leixing(card[1]) == "-1马" then
		return true
	end
	return false
end
function skills_judge_zhijian_2(ID_shoupai, ID_s, ID_mubiao)
	if table.getn2(card_selected) == 0 then return end
	
	if card_get_leixing(char_juese[ID_s].shoupai[ID_shoupai][1]) == "武器" and #char_juese[ID_mubiao].wuqi ~= 0 then
		return false
	end
	
	if card_get_leixing(char_juese[ID_s].shoupai[ID_shoupai][1]) == "防具" and #char_juese[ID_mubiao].fangju ~= 0 then
		return false
	end
	
	if card_get_leixing(char_juese[ID_s].shoupai[ID_shoupai][1]) == "+1马" and #char_juese[ID_mubiao].fangma ~= 0 then
		return false
	end
	
	if card_get_leixing(char_juese[ID_s].shoupai[ID_shoupai][1]) == "-1马" and #char_juese[ID_mubiao].gongmama ~= 0 then
		return false
	end
end
function skills_zhijian(ID_s, ID_shoupai, ID_mubiao)
	if skills_judge_zhijian_2(ID_shoupai, ID_s, ID_mubiao) == false then return false end
	
	funcptr_queue = {}
	add_funcptr(_zhijian_sub1)
	add_funcptr(_zhijian_sub2, {ID_shoupai, ID_s, ID_mubiao})
	add_funcptr(card_fenfa, {ID_s, 1, true})
	add_funcptr(_skills_rst)
	return true
end
function _zhijian_sub1()
	gamerun_status = "手牌使用中"
	set_hints("")
	push_message(char_juese[char_current_i].name.."发动了武将技能 '直谏'")
end
function _zhijian_sub2(va_list)
	local ID_shoupai, ID_s, ID_mubiao
	ID_shoupai = va_list[1]; ID_s = va_list[2]; ID_mubiao = va_list[3]
	
	local card = char_juese[ID_s].shoupai[ID_shoupai]
	
	push_message(table.concat({char_juese[char_current_i].name.."将武器 '", card[1], "' 交给", char_juese[ID_mubiao].name}))
	
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
	card_shanchu({ID_s, ID_shoupai})
end

--  孙权：制衡  --
function skills_zhiheng_enter()
	if #char_juese[char_current_i].shoupai == 0 then return false end
	
	gamerun_wuqi_into_hand(char_current_i)
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
	card_selected = {}
	card_highlighted = 1
	set_hints("请您出牌")
	gamerun_status = ""
end

--  周瑜：反间  --
function skills_fanjian_enter()
	if #char_juese[char_current_i].shoupai == 0 then return false end
	skills_enter("请选择目标", "", "反间", "技能选择-目标")
	gamerun_select_target("init")
	
	gamerun_OK_ptr = function()
		if skills_fanjian(char_current_i, gamerun_target_selected) then
			skills_cs()
			consent_func_queue(0.6)
		end
	end
	
	return true
end
function skills_fanjian(ID_s, ID_mubiao)
	funcptr_queue = {}
	add_funcptr(_fanjian_sub1)
	char_juese[ID_s].skill["反间"] = "locked"
	fanjian_huase = math.random(1,4)
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
function _fanjian_sub1()
	set_hints("")
	gamerun_status = "手牌生效中"
	push_message(char_juese[char_current_i].name.."发动了武将技能 '反间'")
end
function _fanjian_sub2(ID_s, ID_mubiao)
	local t, card
	
	t = math.random(#char_juese[ID_s].shoupai)
	card = char_juese[ID_s].shoupai[t]
	
	add_funcptr(_fanjian_sub3, {ID_s, ID_mubiao, t})
	if (card[2] ~= "方块" and fanjian_huase == 1) or (card[2] ~= "红桃" and fanjian_huase == 2) or (card[2] ~= "草花" and fanjian_huase == 3) or (card[2] ~= "黑桃" and fanjian_huase == 4) then
		char_tili_deduct({1, ID_mubiao, ID_s, "普通"})
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
	card_selected = {}
	card_highlighted = 1
	set_hints("请您出牌")
	gamerun_status = ""
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
	lianhuan_va = nil
	
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
	    card_sha(c_pos, ID_d, ID_req, false)
	else
	    add_funcptr(_nanman_send_msg, {char_juese[ID_d].name, "放弃"})
		add_funcptr(_chai_sub1, {true, ID_req, ID_d})
	end
	
	--add_funcptr(_tiaoxin_sub1)
	return true
end

--  刘备：仁德  --
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
			if skills_rende(char_current_i, gamerun_target_selected) then
				skills_cs_2()
				consent_func_queue(0.6)
			end
		end
	end
	
	gamerun_tab_ptr = function() end
	
	return true
end
function skills_rende(ID_s, ID_mubiao)
	if table.getn2(card_selected) == 0 then return false end

	gamerun_status = "手牌生效中"
	jiaohu_text = ""
	card_highlighted = 1
	
	funcptr_queue = {}
	add_funcptr(push_message, char_juese[ID_s].name.."发动了武将技能 '仁德'")
	
	add_funcptr(skills_rende_exe, {ID_s, ID_mubiao})
	add_funcptr(_rende_sub)
	return true
end
function skills_rende_exe(va_list)
	local ID_s, ID_mubiao
	ID_s = va_list[1]; ID_mubiao = va_list[2]
	
	local i, v, j, max_select
	v = card_selected
	--collectgarbage()
	
	max_select = #char_juese[ID_s].shoupai
	j = 0
	
	for i = 1, max_select do
	    if v[i] ~= nil then
			table.insert(char_juese[ID_mubiao].shoupai, char_juese[ID_s].shoupai[i - j])
	        card_remove({ID_s, i - j})
			if char_rende_given >= 0 then
				char_rende_given = char_rende_given + 1
			end
		    j = j + 1
		end
	end
	
	push_message(table.concat({"刘备将", tostring(j), "张手牌交给", char_juese[ID_mubiao].name}))
	if char_rende_given >= 2 then
		if char_juese[ID_s].tili < char_juese[ID_s].tili_max then
			_tao_sub({ID_s, true})
		end
		char_rende_given = -1
	end
	
	card_selected = {}
end
function _rende_sub()
	card_selected = {}
	card_highlighted = 1
	set_hints("请您出牌")
	gamerun_status = ""
end

--  郭嘉：天妒  --
function skills_tiandu_add(va_list)
	local ID, card_panding
	ID = va_list[1]; card_panding = va_list[2]
	
	--push_message(char_juese[ID].name.."获得了判定牌")
	table.insert(char_juese[ID].shoupai, card_panding)
end

--  典韦：强袭  --
function skills_qiangxi_enter()
	if #char_juese[char_current_i].shoupai == 0 then return false end
	
	skills_enter("选择装备牌并'确定',或'取消'扣减体力", "请选择目标", "强袭", "技能选择-单牌")
	
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
		if skills_judge_zhijian_1() then
			last_OK = true
			skills_enter_target()
		end
	end
	
	return true
end
function skills_qiangxi(ID_s, ID_shoupai, ID_mubiao)
	if gamerun_status == "技能选择-单牌" then return false end

	if #char_juese[ID_mubiao].wuqi ~= 0 then
	    if char_calc_distance(ID_s, ID_mubiao) > card_wuqi_r[char_juese[ID_s].wuqi[1]] then
	        return false
	    end
	else
	    if char_calc_distance(ID_s, ID_mubiao) > 1 then
	        return false
	    end
	end

	if last_OK == true then
		if skills_judge_zhijian_1() == false then return false end
	end
	
	funcptr_queue = {}
	gamerun_status = "手牌生效中"
	set_hints("")
	
	add_funcptr(_qiangxi_sub1, {ID_s, card_highlighted})
	if last_OK == false then
		char_tili_deduct({1, ID_s, nil, "普通"})
	end
	char_tili_deduct({1, ID_mubiao, ID_s, "普通"})
	add_funcptr(_qiangxi_sub2)
	
	return true
end
function _qiangxi_sub1(va_list)
	local ID, ID_shoupai
	ID = va_list[1]; ID_shoupai = va_list[2]

	push_message(char_juese[ID].name.."发动了武将技能 '强袭'")
	char_juese[ID_s].skill["强袭"] = "locked"
	card_selected = {}
	if last_OK == true then
		local card = char_juese[ID].shoupai[ID_shoupai]
		push_message(table.concat({"典韦丢弃 '", card[2], card[3], "的", card[1], "'"}))
		card_shanchu({ID, ID_shoupai})
	end
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
	jiaohu_text = "是否使用 '将驰'多摸或少摸牌?"
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
	if huashen_wujiang ~= nil and huashen_skill ~= nil then
		choose_option = {"不替换"}
	else
		choose_option = {}
	end
	for i = 1,#huashen_paidui do
		table.insert(choose_option,huashen_paidui[i][4].." "..huashen_paidui[i][1].." "..huashen_paidui[i][2].." "..huashen_paidui[i][3][2].."/"..huashen_paidui[i][3][1])
	end

	txt_messages:setVisible(false)
	gamerun_guankan_selected = 1
	item_disrow = 0
	gamerun_item = function(i)
		funcptr_queue = {}
		txt_messages:setVisible(true)
		if i == 1 and huashen_wujiang ~= nil and huashen_skill ~= nil then
			gamerun_status = old_gamerun_status

			_huashen_huifu()
			timer.start(0.2)
		else
			local delta = 0
			if huashen_wujiang ~= nil and huashen_skill ~= nil then
				delta = -1
				if skill_double then
					skill_double = nil
				else
					char_juese[ID].skill[huashen_skill] = nil
					for j = 1, #char_juese[ID].skillname do
						if char_juese[ID].skillname[j] == huashen_skill then
							table.remove(char_juese[ID].skillname,j)
						end
					end
				end
			end
			
			push_message(char_juese[ID].name.."发动了武将技能 '化身' 变成了"..huashen_paidui[i+delta][4])
			huashen_wujiang = huashen_paidui[i+delta][4]
			char_juese[ID].shili = huashen_paidui[i+delta][1]
			char_juese[ID].xingbie = huashen_paidui[i+delta][2]
			char_skill_item = huashen_paidui[i+delta][5]

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
		huashen_skill = choose_option[i]
		if char_juese[ID].skill[huashen_skill] == nil then
			if huashen_skill == "挑衅" or huashen_skill == "反间" or huashen_skill == "驱虎" or huashen_skill == "制衡" or huashen_skill == "结姻" or huashen_skill == "天义" or huashen_skill == "缔盟" or huashen_skill == "离间" or huashen_skill == "青囊" then
				char_juese[ID].skill[huashen_skill] = 1
			else
				char_juese[ID].skill[huashen_skill] = "available"
			end
			table.insert(char_juese[ID].skillname,huashen_skill)
		else
			skill_double = true
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
			if is_beginning then
				push_message(char_juese[ID].name.."获得了一张武将牌")
			else
				push_message(char_juese[ID].name.."发动了武将技能 '新生' 获得了一张武将牌")
			end
			table.insert(huashen_paidui,{char_juese_jineng[char_wujiang_f[t]][2],char_juese_jineng[char_wujiang_f[t]][5],{},char_wujiang_f[t],{}})
			for i = 1,2 do
				table.insert(huashen_paidui[#huashen_paidui][3],char_juese_jineng[char_wujiang_f[t]][1][i])
			end
			for i = 1,#skill_huashen do
				table.insert(huashen_paidui[#huashen_paidui][5],skill_huashen[i])
			end
			table.remove(char_wujiang_f,t)
			break
		else
			table.remove(char_wujiang_f,t)
		end
	end
end

--  张角：雷击  --
function skills_leiji(va_list)
	local ID_s, _ID_mubiao
	ID_s = va_list[1]; _ID_mubiao = va_list[2]
	local ID_mubiao

	push_zhudong_queue(table.copy(funcptr_queue), funcptr_i)
	timer.stop()
	funcptr_queue = {}
	funcptr_i = 0

	if char_juese[ID_s].shenfen == "主公" then
		ID_mubiao = ai_judge_leiji_mubiao(_ID_mubiao)
		if ID_mubiao < 0 then return end
	else
		ID_mubiao = _ID_mubiao
	end
	
    push_message(table.concat({char_juese[ID_s].name .. "发动了武将技能 '雷击' (对", char_juese[ID_mubiao].name, ")"}))
	add_funcptr(_leiji_fan_panding, ID_s)

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

	if card_panding_card[2] == "黑桃" then
	    --  判定成功  --
		timer.stop()
		funcptr_queue = {}
		funcptr_i = 0

		push_message(char_juese[ID_s].name .. "的 '雷击' 判定成功")
		char_tili_deduct({2, ID_mubiao, ID_s, "雷"})
		card_add_qipai(card_panding_card)

		add_funcptr(_leiji_huifu)
		timer.start(0.6)
	else
		push_message(char_juese[ID_s].name .. "的 '雷击' 判定失败")
		card_add_qipai(card_panding_card)
		_leiji_huifu()
	end
end
function _leiji_huifu()
	funcptr_queue, funcptr_i = pop_zhudong_queue()
end

--  夏侯惇：刚烈  --
function skills_ganglie(va_list)
	local ID_s, ID_mubiao
	ID_s = va_list[1]; ID_mubiao = va_list[2]

	push_zhudong_queue(table.copy(funcptr_queue), funcptr_i)
	timer.stop()
	funcptr_queue = {}
	funcptr_i = 0

    push_message(table.concat({char_juese[ID_s].name .. "发动了武将技能 '刚烈'"}))
	add_funcptr(_ganglie_fan_panding, ID_s)

	--  如场上有司马懿或张角，询问其改判技能  --
	skills_guicai_guidao_ask(ID_s, ID_mubiao, ID_s, "刚烈")
	
	add_funcptr(_ganglie_jiesuan, {ID_s, ID_mubiao})
	timer.start(0.6)
end
function skills_enter_ganglie(ID_s)
	funcptr_queue = {}
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

	if card_panding_card[2] ~= "红桃" then
		if ID_mubiao == char_current_i then
			skills_enter_ganglie(ID_s)
			guankan_s = ID_s
			guankan_d = ID_mubiao
		else
			_ganglie_exe_ai(ID_s, ID_mubiao)
		end
		card_add_qipai(card_panding_card)
	else
		push_message(char_juese[ID_s].name .. "的 '刚烈' 判定失败")
		card_add_qipai(card_panding_card)
		_ganglie_huifu()
	end
end
function _ganglie_huifu()	--  刚烈：恢复己方中断前函数队列
	funcptr_queue, funcptr_i = pop_zhudong_queue()
	timer.start(0.6)
end
function _ganglie_exe_ai(ID_s, ID_mubiao)	--  刚烈：AI做出决定
	timer.stop()
	funcptr_queue = {}
	funcptr_i = 0

	push_message(char_juese[ID_s].name .. "的 '刚烈' 判定成功")

	char_tili_deduct({1, ID_mubiao, ID_s, "普通"})
	add_funcptr(_ganglie_huifu)

	timer.start(0.6)
end
function _ganglie_exe_1()    --  刚烈：弃置两张牌
	gamerun_status = "手牌生效中"
	set_hints("")
	card_highlighted = 1
	
	card_qipai_go()
	add_funcptr(_ganglie_huifu)
end
function _ganglie_exe_2()    --  刚烈：失去1点体力
	gamerun_status = "手牌生效中"
	set_hints("")
	card_selected = {}; card_highlighted = 1
	
	char_tili_deduct({1, guankan_d, guankan_s, "普通"})
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
	
	for i = 1, char_i do
		add_funcptr(_tuxi_sub1, {ID, char_i[i]})
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
			gamerun_status = "选择目标"
			set_hints("请选择目标A")
			gamerun_select_target("init")
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
function _tuxi_exe(double)
	gamerun_status = ""
	push_message(char_juese[char_current_i].name.."发动了武将技能 '突袭'")
	
	if double then
		add_funcptr(_tuxi_sub1, {char_current_i, gamerun_target_selected})
		add_funcptr(_tuxi_sub1, {char_current_i, guankan_s})
	else
		add_funcptr(_tuxi_sub1, {char_current_i, gamerun_target_selected})
	end
	
	add_funcptr(_tuxi_huifu, nil)
	timer.start(0.2)
end
function _tuxi_sub1(va_list)
	local ID_s, ID_mubiao
	local t, card
	ID_s = va_list[1]; ID_mubiao = va_list[2]
	
	push_message(table.concat({char_juese[char_current_i].name.."获得", char_juese[ID_mubiao].name, "的一张手牌"}))
	
	t = math.random(#char_juese[ID_mubiao].shoupai)
	card = char_juese[ID_mubiao].shoupai[t]
	card_shanchu({ID_mubiao, t})
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
		if skills_judge_huase("草花") then
			skills_enter_target()
		end
	end
	
	return true
end
function skills_lianhuan(ID_shoupai, ID_s, ID_first, ID_second, doubl)
	if skills_judge_huase("草花") then
		funcptr_queue = {}
		if card_lian_lianhuan(ID_shoupai, ID_s, ID_first, ID_second, doubl) then
			skills_cs()
			consent_func_queue(0.6)
		end
	end
end

--  鲁肃：缔盟  --
function skills_dimeng_enter()
	if #char_juese[char_current_i].shoupai == 0 then return false end

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
	end
	add_funcptr(_dimeng_sub1, {ID_first, ID_second})
	add_funcptr(_dimeng_sub2)
	
	return true
end
function _dimeng_sub1(va_list)
	local ID_s, ID_mubiao
	local temp
	ID_first = va_list[1]; ID_second = va_list[2]
	
	push_message(table.concat({char_juese[char_current_i].name.."交换了", char_juese[ID_first].name, "和", char_juese[ID_second].name, "的手牌"}))
	temp = table.copy(char_juese[ID_first].shoupai)
	char_juese[ID_first].shoupai = {}; --collectgarbage()
	char_juese[ID_first].shoupai = table.copy(char_juese[ID_second].shoupai)
	char_juese[ID_second].shoupai = {}; --collectgarbage()
	char_juese[ID_second].shoupai = table.copy(temp)
	temp = {}; --collectgarbage()
end
function _dimeng_sub2()
	card_selected = {}
	card_highlighted = 1
	set_hints("请您出牌")
	gamerun_status = ""
end

--  司马懿：鬼才 / 张角：鬼道  --
function skills_guicai_guidao_ask(id, ID_laiyuan, ID_mubiao, panding_leixing)		--  从当前角色开始，逆时针询问是否发动鬼才或鬼道
	local cur = id
	local i

	for i = 1, 5 do
		if skills_judge_guicai_guidao(cur) ~= "" then
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
	skills_enter("请选择手牌并按 '确定'", "", "鬼才", "技能选择-单牌")
	gamerun_OK = false

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
	if char_juese[char_current_i].siwang == true then
		return
	end

	push_zhudong_queue(table.copy(funcptr_queue), funcptr_i)
	timer.stop()
	funcptr_queue = {}
	funcptr_i = 0

	if char_juese[id].skill["伏枥"] ~= 1 then
		--  不满足伏枥发动条件，执行原有濒死结算  --
		if id == char_current_i then
			add_funcptr(_binsi_ai, {id, id})
		else
			add_funcptr(_binsi_zhudong, id)
		end
		add_funcptr(_fuli_huifu)
		timer.start(0.6)
		return
	end

	add_funcptr(_fuli_lock, id)
	add_funcptr(_fuli_sub, id)
	add_funcptr(_fuli_huifu)

	timer.start(0.6)
end
function _fuli_lock(id)
	msg = {char_juese[id].name, "发动了技能 '伏枥'"}
	push_message(table.concat(msg))
	char_juese[id].skill["伏枥"] = "locked_whole_game"
end
function _fuli_sub(id) 
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
end
function _fuli_huifu()
	funcptr_queue, funcptr_i = pop_zhudong_queue()
end

--  庞统：涅槃  --
function skills_niepan(id)
	if char_juese[char_current_i].siwang == true then
		return
	end

	push_zhudong_queue(table.copy(funcptr_queue), funcptr_i)
	timer.stop()
	funcptr_queue = {}
	funcptr_i = 0

	if char_juese[id].skill["涅槃"] ~= 1 then
		--  不满足涅槃发动条件，执行原有濒死结算  --
		if id ~= char_current_i then
			add_funcptr(_binsi_ai, {id, id})
		else
			add_funcptr(_binsi_zhudong, id)
		end
		add_funcptr(_niepan_huifu)
		timer.start(0.6)
		return
	end

	add_funcptr(_niepan_lock, id)
	card_qipai_all(id, true)
	add_funcptr(_niepan_sub, id)
	add_funcptr(_niepan_huifu)

	timer.start(0.6)
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

--  张春华：伤逝  --
function skills_shangshi(id)
	add_funcptr(push_message, char_juese[id].name .. "发动了武将技能 '伤逝'")
	add_funcptr(shangshi_sub, id)
end
function _shangshi_sub(id)
	if table.maxn(char_juese[id].shoupai) < char_juese[id].tili_max - char_juese[id].tili then
		card_fenfa({id, char_juese[id].tili_max - char_juese[id].tili - table.maxn(#char_juese[id].shoupai), true})
	end
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
	add_funcptr(push_message, table.concat({char_juese[ID_mubiao].name, "将武将牌翻面"}))
	add_funcptr(char_fanmian, ID_mubiao)
	add_funcptr(push_message, table.concat({char_juese[ID_s].name, "令", char_juese[ID_mubiao].name, "摸", (tili_max - tili), "张牌"}))
	add_funcptr(card_fenfa, {ID_mubiao, math.max(tili_max - tili, 0), true})
end
function _fangzhu_huifu()
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

	if card_panding_card[2] == "黑桃" or card_panding_card[2] == "草花" then
		push_message(char_juese[ID].name .. "的 '洛神' 判定成功")
		table.insert(char_juese[ID].shoupai, card_panding_card)

		if ID == char_current_i then
			timer.stop()
			skills_luoshen_enter(old_gamerun_status)
		else
			funcptr_queue = {}
			funcptr_i = 0
			skills_luoshen_ai(ID, nil)
			timer.start(0.6)
		end
	else
		push_message(char_juese[ID].name .. "的 '洛神' 判定失败")
		card_add_qipai(card_panding_card)
		_luoshen_huifu()
		timer.stop()
		timer.start(0.2)
	end
end
function _luoshen_huifu()
	funcptr_queue, funcptr_i = pop_zhudong_queue()
end
