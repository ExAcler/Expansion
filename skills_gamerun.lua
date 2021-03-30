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
	["离魂"] = function() return skills_lihun_enter() end,
	["极略"] = function() return skills_jilve_enter() end,
	["攻心"] = function() return skills_gongxin_enter() end
}

--  主公技触发函数表  --
skills_lord_func =
{
	["黄天"] = function(ID_zhugong) return skills_huangtian_enter(ID_zhugong) end,
	["制霸"] = function(ID_zhugong) return skills_zhiba(char_current_i, ID_zhugong) end
}

--  清除技能选择状态  --
function skills_cs()    
	gamerun_skill_selected = 0
	gamerun_tab_ptr = nil
	gamerun_OK_ptr = nil
	gamerun_OK = false
	gamerun_armskill_selected = false
	gamerun_lordskill_selected = false
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
	gamerun_armskill_selected = false
	gamerun_lordskill_selected = false
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

--  进入选择主公技状态  --
function skills_judge_lordskill(ID_s, ID_zhugong)
	local skill_table = {}
	
	if ID_s == ID_zhugong then
		return {}
	end

	if char_juese[ID_zhugong].skill["黄天"] == "available" and lordskill_used[ID_zhugong]["黄天"] ~= 1 and char_juese[ID_s].shili == "群" then
		table.insert(skill_table, "黄天")
	end

	if char_juese[ID_zhugong].skill["制霸"] == "available" and lordskill_used[ID_zhugong]["制霸"] ~= 1 and char_juese[ID_s].shili == "吴" then
		table.insert(skill_table, "制霸")
	end

	return skill_table
end
function skills_lordskill_select_enter()
	gamerun_lordskill_selected = true
	skills_enter("请选择角色", "", "主公技", "技能选择-目标")
	gamerun_select_target("init")

	gamerun_OK_ptr = function()
		if gamerun_status == "技能选择-目标" and gamerun_OK == true then
			local lordskills = skills_judge_lordskill(char_current_i, gamerun_target_selected)
			if #lordskills > 0 then
				gamerun_lordskill_selected = false
				_lordskill_choose(gamerun_target_selected)
			end
			return
		end
	end
end
function _lordskill_choose(ID)
	gamerun_status = "选项选择"
	choose_name = "选择主公技"
	jiaohu_text = table.concat({"您想响应", char_juese[ID].name, "的哪项主公技?"})
	choose_option = skills_judge_lordskill(char_current_i, ID)
	table.insert(choose_option, "放弃")

	txt_messages:setVisible(false)
	gamerun_guankan_selected = 1
	item_disrow = 0
	
	gamerun_item = function(i)
		txt_messages:setVisible(true)
		set_hints("")

		if choose_option[i] == "放弃" then
			_lordskill_fangqi()
		else
			local skillname = choose_option[i]
			if skills_lord_func[skillname] ~= nil then
				if skills_lord_func[skillname](ID) == false then
					_lordskill_fangqi()
				end
			else
				_lordskill_fangqi()
			end
		end
	end

	platform.window:invalidate()
end
function _lordskill_fangqi()
	gamerun_status = ""
	set_hints("请您出牌")
	skills_cs()
end
