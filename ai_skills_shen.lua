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
--  返回是否发动、优先攻击的角色  --
function ai_judge_jilve_wansha(ID)
	if char_alive_stat() == 2 then
		return false, 0
	end

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
		return false, 0
	end

	for i = 1, #attack_mubiao do
		if char_juese[attack_mubiao[i]].tili <= 1 then
			return true, attack_mubiao[i]
		end
	end

	return false, 0
end

--  AI决定是否发动琴音  --
--  1回复体力，2失去体力，3不发动  --
function ai_judge_qinyin(ID)
	local enemies = ai_basic_judge_mubiao(ID, 4, false, false, true)
	local allies = ai_basic_judge_mubiao(ID, 4, true, false, true)

	local enemy_blood = 0
	local ally_blood = 0

	local n_enemy_maxblood = 0
	local n_ally_maxblood = 0

	local enemy_dying = false
	local ally_dying = false

	for i = 1, #enemies do
		if char_juese[enemies[i]].siwang == false then
			enemy_blood = enemy_blood + math.min(char_juese[enemies[i]].tili, 5)
			if char_juese[enemies[i]].tili == 1 then
				enemy_dying = true
			elseif char_juese[enemies[i]].tili == char_juese[enemies[i]].tili_max then
				n_enemy_maxblood = n_enemy_maxblood + 1
			end
		end
	end
	for i = 1, #allies do
		if char_juese[allies[i]].siwang == false then
			ally_blood = ally_blood + math.min(char_juese[allies[i]].tili, 5)
			if char_juese[allies[i]].tili == 1 or (char_juese[allies[i]].shenfen == "主公" and char_juese[allies[i]].tili == 2) then
				ally_dying = true
			elseif char_juese[allies[i]].tili == char_juese[allies[i]].tili_max then
				n_ally_maxblood = n_ally_maxblood + 1
			end
		end
	end

	if enemy_dying == true and ally_dying == false then
		return 2
	end

	if enemy_blood / #enemies > ally_blood / #allies then
		if n_enemy_maxblood < #enemies or n_ally_maxblood < #allies then
			return 1
		end
	else
		if ally_dying == false then
			return 2
		end
	end

	return 3
end

--  AI决定是否发动业炎  --
--  返回参数1为是否发动；返回参数2为弃牌ID (为一名角色分配2点以上时)，如为空则为至多1点；返回参数3为 一个表，每项为：{业炎目标ID, 为该目标分配的业炎点数}  --
function ai_judge_yeyan(ID)
	--  大业炎判断  --
	local cards_caohua = ai_card_search(ID, "草花", 1)
	local cards_fangkuai = ai_card_search(ID, "方块", 1)
	local cards_heitao = ai_card_search(ID, "黑桃", 1)
	local cards_hongtao = ai_card_search(ID, "红桃", 1)

	if #cards_caohua < 1 or #cards_fangkuai < 1 or #cards_heitao < 1 or #cards_hongtao < 1 then
		return false, {}, {}
	end

	local cards = {}
	table.insert(cards, cards_caohua[1])
	table.insert(cards, cards_fangkuai[1])
	table.insert(cards, cards_heitao[1])
	table.insert(cards, cards_hongtao[1])
	table.sort(cards)

	local real_allies = {}
	local real_enemies = {}
	local unknown = {}
	for i = 1, 5 do
		if ai_judge_same_identity(ID, i, false) == 1 then
			table.insert(real_allies, i)
		end
		if ai_judge_same_identity(ID, i, false) == 2 then
			table.insert(real_enemies, i)
		end
		if ai_judge_same_identity(ID, i, false) == 3 then
			table.insert(unknown, i)
		end
	end

	if char_juese[ID].shenfen == "主公" and char_juese[ID].tili <= 3 then
		return false, {}, {}
	end
	if char_juese[ID].shenfen == "内奸" and char_juese[ID].tili <= 3 then
		return false, {}, {}
	end
	if char_juese[ID].shenfen == "反贼" and #real_allies == 1 and char_juese[ID].tili <= 3 then
		return false, {}, {}
	end

	local ID_enemy_hengzhi = {}
	local ally_hengzhi = false
	for i = 1, 5 do
		if ai_judge_same_identity(ID, i, true) == 1 then
			if char_juese[i].hengzhi == true then
				ally_hengzhi = true
			end
		else
			if char_juese[i].hengzhi == true then
				table.insert(ID_enemy_hengzhi, i)
			end
		end
	end

	if ally_hengzhi == false and #ID_enemy_hengzhi > 0 then
		local target = random_pick(ID_enemy_hengzhi, 1)

		if char_juese[ID].shenfen == "主公" and (#real_enemies > 2 or #unknown > 0) then
			return false, {}, {}
		elseif char_juese[ID].shenfen == "内奸" and (#real_enemies > 3 or #unknown > 0) and char_alive_stat() > 2 then
			return false, {}, {}
		end

		return true, cards, {{target[1], 3}}
	end

	local attack_mubiao = {}
	for i = 1, 5 do
		if ai_judge_same_identity(ID, i, true) == 2 then
			if char_juese[i].hengzhi == false then
				table.insert(attack_mubiao, i)
			end
		end
	end
	if #attack_mubiao == 0 then
		return false, {}, {}
	end

	local mindef_ID = -1
	local mindef = 1000
	for i = 1, #attack_mubiao do
		if char_juese[attack_mubiao[i]].tili < mindef and char_juese[attack_mubiao[i]].tili >= 2 then
			mindef_ID = attack_mubiao[i]
			mindef = char_juese[attack_mubiao[i]].tili
		end
	end
	if mindef_ID == -1 then
		return false, {}, {}
	end

	if char_juese[ID].shenfen == "主公" and (#real_enemies > 1 or #unknown > 0) then
		return false, {}, {}
	elseif char_juese[ID].shenfen == "内奸" and (#real_enemies > 2 or #unknown > 0) and char_alive_stat() > 2 then
		return false, {}, {}
	end

	return true, cards, {{mindef_ID, 3}}
end
