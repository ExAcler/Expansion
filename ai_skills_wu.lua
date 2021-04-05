--  AI决定是否发动英姿  --
--  true发动，false不发动  --
function ai_judge_yingzi(ID)
	return true
end

--  AI决定是否发动枭姬  --
--  true发动，false不发动  --
function ai_judge_xiaoji(ID)
	return true
end

--  AI决定是否发动激昂  --
--  true发动，false不发动  --
function ai_judge_jiang(ID)
	return true
end

--  AI决定是否发动连营  --
--  true发动，false不发动  --
function ai_judge_lianying(ID)
	return true
end

--  AI决定是否发动克己  --
--  true发动，false不发动  --
function ai_judge_keji(ID)
	return true
end

--  AI决定是否发动英魂  --
--  返回1摸1弃x，2摸x弃1，3不发动；以及目标  --
function ai_judge_yinghun(ID)
	if char_juese[ID].tili_max - char_juese[ID].tili <= 1 then
		return 3, {}
	end

	local help_mubiao = ai_basic_judge_mubiao(ID, 1, true, true, true)
	local attack_mubiao = ai_basic_judge_mubiao(ID, 1, false, true, true)

	if #help_mubiao == 0 and #attack_mubiao == 0 then
		return 3, {}
	elseif #help_mubiao == 0 then
		return 1, attack_mubiao[1]
	elseif #attack_mubiao == 0 then
		return 2, help_mubiao[1]
	end

	if ai_judge_random_percent(70) == 1 then
		return 1, attack_mubiao[1]
	else
		return 2, help_mubiao[1]
	end
end

--  AI决定流离的发动目标  --
--  返回是否发动、手牌ID、目标  --
function ai_judge_liuli(ID_sha, ID_sha_mubiao)
	local possible_targets = {1, 2, 3, 4, 5}
	for i = #possible_targets, 1, -1 do
		if possible_targets[i] == ID_sha_mubiao then
			table.remove(possible_targets, i)
		else
			local inrange = card_if_d_limit("流离", ID_sha_mubiao, possible_targets[i])
			--local _, inrange = ai_judge_distance(ID_sha_mubiao, possible_targets[i], 1)
			if inrange == false or possible_targets[i] == ID_sha_mubiao or possible_targets[i] == ID_sha then
				table.remove(possible_targets, i)
			end
		end
	end

	local liuli_mubiao = ai_basic_judge_mubiao(ID_sha_mubiao, 1, false, true, true, possible_targets)
	if #liuli_mubiao == 0 then
		return false, 0, 0
	end

	local p = char_juese[ID_sha_mubiao]
	if p.shoupai == 0 and #p.wuqi == 0 and #p.fangju == 0 and #p.gongma == 0 and #p.fangma == 0 then
		return false, 0, 0
	end

	if #p.shoupai ~= 0 then
		local ID_shoupai = math.random(#p.shoupai)
		return true, ID_shoupai, liuli_mubiao[1]
	end

	if ai_chazhao_shan(ID_sha_mubiao, p.shoupai) > 0 then
		return false, 0, 0
	end

	gamerun_wuqi_into_hand(ID_sha_mubiao)
	if #p.wuqi ~= 0 then
		if ai_judge_random_percent(50) == 1 then
			return true, -1, liuli_mubiao[1]
		end
	end

	if #p.fangju ~= 0 then
		if ai_judge_random_percent(50) == 1 then
			return true, -2, liuli_mubiao[1]
		end
	end

	if #p.gongma ~= 0 then
		if ai_judge_random_percent(80) == 1 then
			return true, -3, liuli_mubiao[1]
		end
	end

	if #p.fangma ~= 0 then
		if ai_judge_random_percent(80) == 1 then
			return true, -4, liuli_mubiao[1]
		end
	end

	return false, 0, 0
end

--  AI决定天香的发动目标  --
--  返回是否发动、手牌ID、目标  --
function ai_judge_tianxiang(ID, dianshu, shuxing)
	return false, 0, 0
end

--  AI决定是否发动固政，以及要返还的手牌  --
function ai_judge_guzheng(ID_s, ID_mubiao)
	if #wugucards == 0 then
		return false, 0
	end
	local ID_paidui = math.random(#wugucards)
	
	if ai_judge_same_identity(ID_s, ID_mubiao, true) == 1 then
		return true, ID_paidui
	end

	local percent = 120 - 20 * math.min(#wugucards, 5)
	if ai_judge_random_percent(percent) == 1 then
		return false, 0
	else
		return true, ID_paidui
	end
end

--  AI决定是否发动好施  --
--  1发动，2不发动  --
function ai_judge_haoshi(ID)
	local n_shoupai = #char_juese[ID].shoupai
	n_shoupai = n_shoupai + 4
	
	if char_juese[ID].skill["将驰"] == "available" then
		if ai_judge_jiangchi(ID) == 1 then
			n_shoupai = n_shoupai + 1
		elseif ai_judge_jiangchi(ID) == 2 then
			n_shoupai = n_shoupai - 1
		end
	end
	if char_juese[ID].skill["裸衣"] == "available" and ai_judge_luoyi(ID) == 1 then
		n_shoupai = n_shoupai - 1
	end
	if char_juese[ID].skill["英姿"] == "available" and ai_judge_yingzi(ID) then
		n_shoupai = n_shoupai + 1
	end

	if n_shoupai <= 5 then
		return 1
	end

	local target = ai_judge_haoshi_mubiao(ID, n_shoupai, false)
	if #target == 0 then
		return 2
	else
		if ai_judge_random_percent(50) == 1 then
			return 1
		else
			return 2
		end
	end
end

--  AI决定好施的发动目标  --
function ai_judge_haoshi_mubiao(ID, n_ID_shoupai, at_least_1)
	local possible_target = {1, 2, 3, 4, 5}
	local possible_target_2 = {}

	local shoupais = {}
	for i = 1, 5 do
		if i == ID then
			table.insert(shoupais, n_ID_shoupai)
		else
			table.insert(shoupais, #char_juese[i].shoupai)
		end
	end

	--  找出所有手牌最少的角色  --
	for i = 5, 1, -1 do
		if char_juese[i].siwang == true then
			table.remove(possible_target, i)
		else
			for j = 1, 5 do
				if char_juese[j].siwang == false and shoupais[j] < shoupais[i] then
					print(i)
					table.remove(possible_target, i)
					break
				end
			end
		end
	end

	possible_target_2 = ai_basic_judge_mubiao(ID, 1, true, false, true, possible_target)
	if at_least_1 and #possible_target_2 == 0 and #possible_target > 0 then
		table.insert(possible_target_2, possible_target[math.random(1, #possible_target)])
	end

	return possible_target_2
end

--  AI决定是否发动反间  --
--  返回含有角色ID的表，如为空则表示不发动  --
function ai_judge_fanjian_mubiao(ID)
	if #char_juese[ID].shoupai == 0 then
		char_juese[ID].skill["反间"] = "locked"
		return {}
	end

	local attack_mubiao = ai_basic_judge_mubiao(ID, 1, false, true, true)
	if #attack_mubiao == 0 then
		char_juese[ID].skill["反间"] = "locked"
		return {}
	end

	local percent = (25 * #char_juese[ID].shoupai) - 10
	if ai_judge_random_percent(percent) == 1 then
		return attack_mubiao
	else
		char_juese[ID].skill["反间"] = "locked"
		return {}
	end
end

--  AI决定是否发动国色  --
--  返回是否发动、手牌ID、目标  --
function ai_judge_guose(ID)
	local cards = ai_card_search(ID, "方块", #char_juese[ID].shoupai)
	local s = char_juese[ID].shoupai
	
	if #cards == 0 then
		return false, 0, 0
	end

	local percent = 100
	for i = #cards, 1, -1 do
		if card_judge_if_shan(ID, cards[i]) then
			if ai_judge_random_percent(percent) == 1 then
				table.remove(cards, i)
				percent = 10
			end
		end
	end
	if #cards == 0 then
		return false, 0, 0
	end
	while #cards > 1 do
		table.remove(cards, math.random(#cards))
	end
	
	local targets = ai_judge_target(ID, "乐不思蜀", {s[cards[1]]}, 1)
	if #targets == 0 then
		return false, 0, 0
	end

	return true, cards[1], targets[1]
end

--  AI决定是否发动直谏  --
--  返回是否发动、手牌ID、目标  --
function ai_judge_zhijian(ID)
	local cards = ai_card_search(ID, "装备", #char_juese[ID].shoupai)
	local card_fangju = -1
	local card_fangma = -1
	local card_wuqi = -1
	local card_gongma = -1

	if #cards == 0 then
		return false, 0, 0
	end

	for i = 1, #cards do
		local s = char_juese[ID].shoupai
		if card_get_leixing(s[cards[i]][1]) == "防具" and card_fangju < 0 then
			card_fangju = cards[i]
		elseif card_get_leixing(s[cards[i]][1]) == "+1马" and card_fangma < 0 then
			card_fangma = cards[i]
		elseif card_get_leixing(s[cards[i]][1]) == "武器" and card_wuqi < 0 then
			card_wuqi = cards[i]
		elseif card_get_leixing(s[cards[i]][1]) == "-1马" and card_gongma < 0 then
			card_gongma = cards[i]
		end
	end

	local help_mubiao = ai_basic_judge_mubiao(ID, 4, true, true, true)

	if card_fangju > 0 then
		local mubiao = _judge_zhijian_mubiao_for("防具", card_fangju, ID, help_mubiao)
		if mubiao > 0 then
			return true, card_fangju, mubiao
		end
	end

	if card_fangma > 0 then
		local mubiao = _judge_zhijian_mubiao_for("+1马", card_fangma, ID, help_mubiao)
		if mubiao > 0 then
			return true, card_fangma, mubiao
		end
	end

	if card_wuqi > 0 then
		local mubiao = _judge_zhijian_mubiao_for("武器", card_wuqi, ID, help_mubiao)
		if mubiao > 0 then
			return true, card_wuqi, mubiao
		end
	end

	if card_gongma > 0 then
		local mubiao = _judge_zhijian_mubiao_for("-1马", card_gongma, ID, help_mubiao)
		if mubiao > 0 then
			return true, card_gongma, mubiao
		end
	end

	return false, 0, 0
end
function _judge_zhijian_mubiao_for(leixing, card_ID, ID, help_mubiao)
	local _help_mubiao = table.copy(help_mubiao)
	for i = #_help_mubiao, 1, -1 do
		if skills_judge_zhijian_2(card_ID, ID, _help_mubiao[i]) == false or (leixing == "防具" and (char_juese[_help_mubiao[i]].skill["八阵"] == "available" or char_juese[_help_mubiao[i]].skill["毅重"] == "available")) then
			table.remove(_help_mubiao, i)
		end
	end
	if #_help_mubiao > 0 then
		if #_help_mubiao == 1 then
			return _help_mubiao[1]
		else
			local mindef_ID = _help_mubiao[1]
			for i = 2, #_help_mubiao do
				if ai_judge_def(_help_mubiao[i], false, false) < ai_judge_def(mindef_ID, false, false) then
					mindef_ID = _help_mubiao[i]
				end
			end
			return mindef_ID
		end
	end

	return -1
end

--  AI决定是否补益  --
function ai_judge_buyi_mubiao(ID_s, ID_mubiao)
	if #char_juese[ID_mubiao].shoupai == 0 then
		return nil
	elseif ID_mubiao ~= nil then
		if ID_s == ID_mubiao then
			return ID_mubiao
		elseif char_juese[ID_mubiao].siwang == true then
			
		elseif char_juese[ID_s].shenfen == "主公" or char_juese[ID_s].shenfen == "忠臣" or (char_juese[ID_s].shenfen == "内奸" and ai_judge_blackjack(ID_s) == true) then
			if char_juese[ID_mubiao].shenfen == "主公" or (char_juese[ID_mubiao].isantigovernment == false and char_juese[ID_mubiao].isblackjack ~= true) then
				return ID_mubiao
			else
				
			end
		elseif char_juese[ID_s].shenfen == "反贼" then
			if char_juese[ID_mubiao].isantigovernment == true and char_juese[ID_mubiao].isblackjack ~= true then
				return ID_mubiao
			else
				
			end
		elseif char_juese[ID_s].shenfen == "内奸" then
			local pk = true
			for i = 1, 5 do
				if char_juese[i].shenfen ~= "主公" and char_juese[i].shenfen ~= "内奸" and char_juese[i].siwang == false then
					pk = false
				end
			end
			if pk == true then
				return nil
			elseif char_juese[ID_mubiao].shenfen == "主公" then
				return ID_mubiao
			else
				
			end
		end
	end
	return nil
end

--  AI决定是否发动制衡  --
--  返回是否发动，手牌列表，弃装备列表  --
function ai_judge_zhiheng(ID)
	local cards = ai_card_search(ID, "随意", #char_juese[ID].shoupai)
	local arms = {0, 0, 0, 0, 0}
	local percent

	percent = 100
	for i = #cards, 1, -1 do
		if card_judge_if_shan(ID, cards[i]) then
			if ai_judge_random_percent(percent) == 1 then
				table.remove(cards, i)
				if percent == 100 then
					percent = math.min(5 + 25 * (char_juese[ID].tili_max - char_juese[ID].tili), 100)
				end
			end
		end
	end

	if #char_juese[ID].fangju > 0 then
		if char_juese[ID].fangju[1] == "白银狮" and char_juese[ID].tili < char_juese[ID].tili_max then
			if ai_judge_random_percent(50) == 1 then
				arms[2] = 1
			end
		end
	end

	local n_cards = #cards
	for i = 1, #arms do
		if arms[i] == 1 then
			n_cards = n_cards + 1
		end
	end

	if n_cards == 0 then
		char_juese[ID].skill["制衡"] = "locked"
		return false, {}, arms
	else
		table.sort(cards)	--  ai_card_search输出倒序，而ai_withdraw希望正序
		return true, cards, arms
	end
end

--  AI决定是否发动苦肉  --
function ai_judge_kurou(ID)
	if char_juese[ID].tili >= char_juese[ID].tili_max - 1 then
		if #char_juese[ID].shoupai < 6 then
			return true
		else
			local percent = math.min(20 + 20 * (#char_juese[ID].shoupai - 6), 100)
			if ai_judge_random_percent(percent) == 0 then
				return true
			else
				ai_skills_discard["苦肉"] = true
			end
		end
	end

	return false
end

--  AI决定是否发动天义  --
--  返回是否发动、手牌ID、目标  --
function ai_judge_tianyi(ID)
	local cards = ai_card_search(ID, "随意", #char_juese[ID].shoupai)
	local has_sha = false
	local has_sha_large_dianshu = false
	local n_sha = 0

	for i = #cards, 1, -1 do
		local yanse, huase, dianshu = ai_judge_cardinfo(ID, {char_juese[ID].shoupai[cards[i]]})

		if (dianshu >= "2" and dianshu <= "9") or dianshu == "A" then
			if card_judge_if_sha(ID, cards[i]) then
				has_sha = true
				n_sha = n_sha + 1
			end
			table.remove(cards, i)
		else	
			if card_judge_if_sha(ID, cards[i]) then
				has_sha_large_dianshu = true
				n_sha = n_sha + 1
			end
		end
	end

	if has_sha == false and has_sha_large_dianshu == false then
		return false, 0, 0
	end

	if has_sha == false and has_sha_large_dianshu == true then
		for i = #cards, 1, -1 do
			if card_judge_if_sha(ID, cards[i]) then
				table.remove(cards, i)
				n_sha = n_sha - 1
				break
			end
		end
	end
	if #cards == 0 then
		return false, 0, 0
	end
	
	local highest = cards[1]
	for i = 2, #cards do
		if _pindian_convert_dianshu(char_juese[ID].shoupai[cards[i]][3]) > _pindian_convert_dianshu(char_juese[ID].shoupai[highest][3]) then
			highest = cards[i]
		end
	end
	
	cards = {highest}

	local attack_mubiao = ai_basic_judge_mubiao(ID, 4, false, true, true)
	local help_mubiao = ai_basic_judge_mubiao(ID, 4, true, true, true)

	if #attack_mubiao == 1 then
		local inrange = card_if_d_limit("杀", ID, attack_mubiao[1])
		if inrange and n_sha < 2 then
			return false, 0, 0
		end
	end

	local lowest_def = attack_mubiao[1]
	for i = 2, #attack_mubiao do
		if #char_juese[attack_mubiao[i]].shoupai < #char_juese[lowest_def].shoupai then
			lowest_def = attack_mubiao[i]
		end
	end

	for i = #help_mubiao, 1, -1 do
		if #char_juese[help_mubiao[i]].shoupai <= 4 then
			table.remove(help_mubiao, i)
		end
	end

	while #help_mubiao > 1 do
		table.remove(help_mubiao, math.random(#help_mubiao))
	end

	if #attack_mubiao + #help_mubiao == 0 then
		return false, 0, 0
	end

	if ai_judge_random_percent(30) == 1 and #help_mubiao > 0 then
		return true, cards[1], help_mubiao[1]
	elseif #attack_mubiao > 0 then
		return true, cards[1], lowest_def
	else
		return false, 0, 0
	end
end

--  AI决定是否发动结姻  --
--  返回是否发动、手牌列表、目标  --
function ai_judge_jieyin(ID)
	local cards = ai_card_search(ID, "随意", #char_juese[ID].shoupai)
	local has_shan = false
	local percent = 30

	for i = #cards, 1, -1 do
		if card_judge_if_shan(ID, cards[i]) and has_shan == false then
			table.remove(cards, i)
			has_shan = true
		elseif card_judge_if_sha(ID, cards[i]) and ai_judge_random_percent(percent) == 1 then
			table.remove(cards, i)
			percent = 0
		end
	end
	while #cards > 2 do
		table.remove(cards, math.random(#cards))
	end
	if #cards < 2 then
		return false, {}, 0
	end
	table.sort(cards)

	local help_mubiao = ai_basic_judge_mubiao(ID, 4, true, true, true)
	local minimum_tili = 100
	for i = #help_mubiao, 1, -1 do
		if char_juese[help_mubiao[i]].xingbie ~= "男" or char_juese[help_mubiao[i]].tili == char_juese[help_mubiao[i]].tili_max then
			table.remove(help_mubiao, i)
		else
			if char_juese[help_mubiao[i]].tili < minimum_tili then
				minimum_tili = char_juese[help_mubiao[i]].tili
			end
		end
	end

	if #help_mubiao == 0 then
		return false, {}, 0
	end

	percent = 90
	if minimum_tili <= 1 then
		percent = 30
	end
	if char_juese[ID].tili == char_juese[ID].tili_max and ai_judge_random_percent(percent) == 1 then
		return false, {}, 0
	end

	if #help_mubiao == 1 then
		return true, cards, help_mubiao[1]
	else
		local mindef_ID = help_mubiao[1]
		for i = 2, #help_mubiao do
			if ai_judge_def(help_mubiao[i], false, false) < ai_judge_def(mindef_ID, false, false) then
				mindef_ID = help_mubiao[i]
			end
		end
		return true, cards, mindef_ID
	end
end
