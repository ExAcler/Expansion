--  AI决定是否发动烈弓  --
function ai_judge_liegong(ID_s, ID_mubiao)
	if ID_s == char_current_i then
		return true
	end

	if ai_judge_same_identity(ID_s, ID_mubiao, false) == 1 then
		--  杀被流离等导致目标非自己所愿的情况  --
		return false
	else
		return true
	end
end

--  AI决定是否发动铁骑  --
function ai_judge_tieqi(ID_s, ID_mubiao)
	if ID_s == char_current_i then
		return true
	end

	if ai_judge_same_identity(ID_s, ID_mubiao, false) == 1 then
		return false
	else
		return true
	end
end

--  AI决定是否发动再起  --
function ai_judge_zaiqi(ID)
	if char_juese[ID].tili_max - char_juese[ID].tili < 2 then
		return false
	end

	if ai_judge_random_percent(80) == 1 then
		return true
	else
		return false
	end
end

--  AI决定是否发动伏枥  --
--  true发动，false不发动  --
function ai_judge_fuli(ID)
	local tao = ai_card_search(ID, "桃", 1)
	local jiu = ai_card_search(ID, "酒", 1)
	if char_juese[ID].fanmian == true then
		return true
	elseif #tao + #jiu + char_juese[ID].tili > 0 then
		return false
	else
		return true
	end
end

--  AI决定是否发动涅槃  --
--  true发动，false不发动  --
function ai_judge_niepan(ID)
	local tao = ai_card_search(ID, "桃", 1)
	local jiu = ai_card_search(ID, "酒", 1)
	if #tao + #jiu + char_juese[ID].tili > 0 then
		return false
	else
		return true
	end
end

--  AI决定是否发动集智  --
--  true发动，false不发动  --
function ai_judge_jizhi(ID)
	return true
end

--  AI决定是否发动观星  --
--  true发动，false不发动  --
function ai_judge_guanxing(ID)
	return false
end

--  AI决定是否发动放权  --
function ai_judge_fangquan(ID)
	if #char_juese[ID].shoupai == 0 then
		return {}
	end
	local ID_mubiao = ai_basic_judge_mubiao(ID, 1, true, true, true)
	if ai_judge_random_percent(75 - 25 * ai_withdraw_need(ID)) == 1 then
		return ID_mubiao
	else
		return {}
	end
end

--  AI决定是否发动仁德  --
--  返回是否发动、手牌列表、目标  --
function ai_judge_rende(ID)
	if char_juese[ID].tili == char_juese[ID].tili_max then
		return false, {}, 0
	end

	if #char_juese[ID].shoupai < 2 then
		return false, {}, 0
	end

	local cards, _ = ai_judge_withdraw(ID, 2, false)
	for i = 1, #cards do
		if card_judge_if_shan(ID, cards[i]) then
			return false, {}, 0
		end
	end
	table.sort(cards)

	local ID_mubiao = ai_basic_judge_mubiao(ID, 1, true, true, true)
	if #ID_mubiao == 0 then
		return false, {}, 0
	else
		return true, cards, ID_mubiao[1]
	end
end

--  AI决定是否发动武圣  --
--  返回是否发动、手牌ID、目标  --
function ai_judge_wusheng(ID)
	local cards = ai_card_search(ID, "随意", #char_juese[ID].shoupai)
	local has_shan = false

	for i = #cards, 1, -1 do
		local yanse, huase, dianshu = ai_judge_cardinfo(ID, {char_juese[ID].shoupai[cards[i]]})

		if card_judge_if_shan(ID, cards[i]) and has_shan == false then
			table.remove(cards, i)
			has_shan = true
		elseif yanse ~= "红色" then
			table.remove(cards, i)
		end
	end
	while #cards > 1 do
		table.remove(cards, math.random(#cards))
	end
	if #cards == 0 then
		return false, 0, 0
	end

	local attack_mubiao = ai_basic_judge_mubiao(ID, 4, false, true, true)
	attack_mubiao = ai_get_in_range(ID, attack_mubiao)

	if #attack_mubiao == 0 then
		return false, 0, 0
	end

	local mindef_ID = ai_judge_minimum_def(attack_mubiao)
	return true, cards[1], mindef_ID
end

--  AI决定是否发动龙胆  --
--  返回是否发动、手牌ID、目标  --
function ai_judge_longdan(ID)
	local cards = ai_card_search(ID, "随意", #char_juese[ID].shoupai)
	local has_shan = false

	for i = #cards, 1, -1 do
		if card_judge_if_shan(ID, cards[i]) and has_shan == false then
			table.remove(cards, i)
			has_shan = true
		elseif card_judge_if_sha(ID, cards[i]) == false then
			table.remove(cards, i)
		end
	end
	while #cards > 1 do
		table.remove(cards, math.random(#cards))
	end
	if #cards == 0 then
		return false, 0, 0
	end

	local attack_mubiao = ai_basic_judge_mubiao(ID, 4, false, true, true)
	attack_mubiao = ai_get_in_range(ID, attack_mubiao)

	if #attack_mubiao == 0 then
		return false, 0, 0
	end

	local mindef_ID = ai_judge_minimum_def(attack_mubiao)
	return true, cards[1], mindef_ID
end
