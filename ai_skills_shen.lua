--  AI决定是否发动连破  --
--  true发动，false不发动  --
function ai_judge_lianpo(ID)
	return true
end

--  AI决定是否发动涉猎  --
--  1发动，2不发动  --
function ai_judge_shelie(ID)
	local n_shoupai = 2
	
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

	if n_shoupai <= 3 then
		return 1
	elseif n_shoupai >= 5 then
		return 2
	else
		if ai_judge_random_percent(50) == 1 then
			return 1
		else
			return 2
		end
	end
end

--  AI决定是否发动攻心  --
--  返回发动对象、发动对象操作后的手牌、选出的红桃牌、红桃牌的去处  --
function ai_judge_gongxin_mubiao(ID)
	local ID_mubiao = ai_basic_judge_mubiao(ID, 1, false)
	if #ID_mubiao > 0 then
		ID_mubiao = ID_mubiao[1]
	else
		return nil,{},{},nil
	end
	if #char_juese[ID_mubiao].shoupai == 0 then
		return nil,{},{},nil
	else
		card_dealed_1 = char_juese[ID_mubiao].shoupai
		card_dealed_2 = {}
		local i = #card_dealed_1
		while i >= 1 do
			if card_dealed_1[i][2] == "红桃" then
				table.insert(card_dealed_2,card_dealed_1[i])
				table.remove(card_dealed_1,i)
				break
			else
				i = i - 1
			end
		end
		if #card_dealed_2 == 0 then
			return ID_mubiao, card_dealed_1, card_dealed_2, nil
		else
			if ai_judge_random_percent(60) == 1 then
				return ID_mubiao, card_dealed_1, card_dealed_2, 2
			else
				return ID_mubiao, card_dealed_1, card_dealed_2, 1
			end
		end
	end
end

--  AI决定是否归心  --
function ai_judge_guixin(ID_s)
	local gain = -3
	for i = 1, 5 do
		if i ~= ID_s and char_juese[i].siwang ~= true and ai_card_stat(i,true,true) > 0 then
			gain = gain + 2
		end
	end
	if guixin_left > 0 then
		return true
	elseif char_juese[ID_s].fanmian == true then
		return true
	elseif gain > 0 then
		return true
	else
		return false
	end
end

--  AI决定是否发动极略获得完杀  --
function ai_judge_jilve_wansha(ID)
	local attack_mubiao = ai_basic_judge_mubiao(ID, 4, false, true, true)
	
	local has_attack_card = false
	for i = 1, #char_juese[ID].shoupai do
		if card_judge_if_sha(ID, i) then
			for i = 1, #attack_mubiao do
				if card_if_d_limit("杀", ID, attack_mubiao[i], i) then
					has_attack_card = true
					break
				end
			end
			if has_attack_card == true then
				break
			end
		elseif char_juese[ID].shoupai[i][1] == "决斗" then
			has_attack_card = true
			break
		elseif char_juese[ID].shoupai[i][1] == "火攻" then
			has_attack_card = true
			break
		end
	end
	if has_attack_card == false then
		return false
	end

	for i = 1, #attack_mubiao do
		if char_juese[attack_mubiao[i]].tili <= 1 then
			return true
		end
	end

	return false
end
