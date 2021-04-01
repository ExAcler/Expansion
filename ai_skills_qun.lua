--  AI为主公时决定雷击的目标  --
function ai_judge_leiji_mubiao(ID_mubiao)
	local i, v
	
	if char_juese[ID_mubiao].isantigovernment == true then
		return ID_mubiao
	end
	
	for i, v in ipairs(char_juese) do
		if v.siwang == false then
			if v.isantigovernment == true then
				return i
			end
		end
	end
	
	return -1
end

--  AI决定崩坏选择  --
--  true减体力，false减上限  --
function ai_judge_benghuai(ID)
	if char_juese[ID].tili == char_juese[ID].tili_max then
		return true
	else
		if char_juese[ID].tili_max <= 1 then
			return true
		else
			return false
		end
	end
end

--  AI决定是否响应暴虐  --
function ai_judge_baonue(ID, ID_zhugong)
	if ai_judge_same_identity(ID, ID_zhugong, true) == 1 then
		return true
	else
		return false
	end
end

--  AI决定是否发动闭月  --
--  true发动，false不发动  --
function ai_judge_biyue(ID)
	return true
end

--  AI决定是否发动新生  --
--  true发动，false不发动  --
function ai_judge_xinsheng(ID)
	return true
end

--  AI决定是否发动焚心  --
--  1发动，2不发动  --
function ai_judge_fenxin(ID)
	local left, lord_blood = {1,2,1}, 0
	for i = 1, 5 do
		if char_juese[i].siwang == true then
			if char_juese[i].shenfen == "忠臣" then
				left[1] = left[1] - 1
			elseif char_juese[i].shenfen == "反贼" then
				left[2] = left[2] - 1
			elseif char_juese[i].shenfen == "内奸" then
				left[3] = left[3] - 1
			end
		elseif char_juese[i].shenfen == "主公" then
			lord_blood = char_juese[i].tili
		end
	end
	if char_juese[ID] == "忠臣" and left[2] <= 1 and left[3] == 0 and lord_blood <= 2 then
		return ai_judge_random_percent(20) + 1
	elseif char_juese[ID] == "反贼" and left[2] == 1 and left[3] == 0 then
		return 1
	elseif char_juese[ID] == "内奸" and left[2] == 0 and left[1] == 1 then
		return 1
	elseif char_juese[ID] == "内奸" then
		return ai_judge_random_percent(50) + 1
	else
		return ai_judge_random_percent(70) + 1
	end
end

--  AI决定是否发动离间  --
--  返回是否发动、手牌ID、目标  --
function ai_judge_lijian(ID)
	local possible_targets = {1, 2, 3, 4, 5}
	for i = #possible_targets, 1, -1 do
		if char_juese[possible_targets[i]].xingbie ~= "男" or possible_targets[i] == ID then
			table.remove(possible_targets, i)
		end
	end

	local attack_mubiao = ai_basic_judge_mubiao(ID, 2, false, true, true, possible_targets)
	if #attack_mubiao < 2 then
		char_juese[ID].skill["离间"] = "locked"
		return false, 0, 0
	end
	
	local cards = ai_card_search(ID, "随意", #char_juese[ID].shoupai)
	local s = char_juese[ID].shoupai

	local percent = 100
	for i = #cards, 1, -1 do
		if card_judge_if_shan(ID, cards[i]) then
			if ai_judge_random_percent(percent) == 1 then
				table.remove(cards, i)
				percent = 30
			end
		end
	end
	if #cards == 0 then
		char_juese[ID].skill["离间"] = "locked"
		return false, 0, 0
	end
	while #cards > 1 do
		table.remove(cards, math.random(#cards))
	end

	if #char_juese[attack_mubiao[1]].shoupai > #char_juese[attack_mubiao[2]].shoupai then
		local _attack_mubiao = {attack_mubiao[1], attack_mubiao[2]}
		attack_mubiao = _attack_mubiao
	else
		local _attack_mubiao = {attack_mubiao[2], attack_mubiao[1]}
		attack_mubiao = _attack_mubiao
	end

	if #cards == 0 then
		char_juese[ID].skill["离间"] = "locked"
		return false, 0, 0
	else
		return true, cards[1], attack_mubiao
	end
end

--  AI决定是否发动青囊  --
--  返回是否发动、手牌ID、目标  --
function ai_judge_qingnang(ID)
	local cards = ai_card_search(ID, "随意", #char_juese[ID].shoupai)
	local shan_removed = false
	local sha_removed = false

	for i = #cards, 1, -1 do
		if card_judge_if_shan(ID, cards[i]) and shan_removed == false then
			table.remove(cards, i)
			shan_removed = true
		elseif card_judge_if_sha(ID, cards[i]) and sha_removed == false then
			if ai_judge_random_percent(30) == 1 then
				table.remove(cards, i)
			end
			sha_removed = true
		end
	end

	while #cards > 1 do
		table.remove(cards, math.random(#cards))
	end
	if #cards == 0 then
		char_juese[ID].skill["青囊"] = "locked"
		return false, 0, 0
	end

	if char_juese[ID].tili < char_juese[ID].tili_max - 1 and ai_judge_random_percent(80) == 1 then
		return true, cards[1], ID
	end

	local help_mubiao = ai_basic_judge_mubiao(ID, 4, true, false, true)

	for i = #help_mubiao, 1, -1 do
		if char_juese[help_mubiao[i]].tili == char_juese[help_mubiao[i]].tili_max then
			table.remove(help_mubiao, i)
		end
	end
	if #help_mubiao == 0 then
		char_juese[ID].skill["青囊"] = "locked"
		return false, 0, 0
	end

	if #help_mubiao == 1 then
		return true, cards[1], help_mubiao[1]
	else
		local mindef_ID = help_mubiao[1]
		for i = 2, #help_mubiao do
			if ai_judge_def(help_mubiao[i], false, false) < ai_judge_def(mindef_ID, false, false) then
				mindef_ID = help_mubiao[i]
			end
		end
		return true, cards[1], mindef_ID
	end
end
