--  AI决定是否发动烈弓  --
function ai_judge_liegong(ID_s, ID_mubiao)
	if ID_s == char_current_i then
		return true
	end

	if ai_judge_same_identity(ID_s, ID_mubiao, true) == 1 then
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

	if ai_judge_same_identity(ID_s, ID_mubiao, true) == 1 then
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
	return true
end

--  AI决定观星的手牌操作  --
--  返回参数1为放在牌堆顶的牌，参数2为放在牌堆底的牌  --
function ai_judge_guanxing_operation(ID, guankan_paidui)
	local guanxing_discard = {}
	local guanxing_self, guanxing_next = {}, {}
	local panding_operated = false
	local shandian = false

	--  己方判定牌控制  --
	for i = #char_juese[ID].panding, 1, -1 do
		local leixing = _panding_get_leixing(ID, i)
		local yanse, huase, dianshu = ai_judge_cardinfo(ID, {guankan_paidui[1]})
		local pos

		if leixing == "乐不思蜀" then
			panding_operated, pos = _ai_guanxing_panding(guankan_paidui, 1, ID, ID, huase, "红桃", true)
		elseif leixing == "兵粮寸断" then
			panding_operated, pos = _ai_guanxing_panding(guankan_paidui, 1, ID, ID, huase, "草花", true)
		elseif leixing == "闪电" then
			panding_operated, pos = _ai_guanxing_panding(guankan_paidui, 1, ID, ID, huase, "黑桃", false)
			shandian = true
		end

		table.insert(guanxing_self, guankan_paidui[pos])
		table.remove(guankan_paidui, pos)

		if pos ~= 1 then
			table.insert(guankan_paidui, guankan_paidui[1])
			table.remove(guankan_paidui, 1)
		end

		if #guankan_paidui == 0 then
			return _ai_guanxing_finalize(ID, false, guanxing_self, guanxing_next, guankan_paidui, guanxing_discard)
		end
	end

	--  己方手牌控制 (进入待定区)  --
	for i = 1, 2 do
		table.insert(guanxing_discard, guankan_paidui[1])
		table.remove(guankan_paidui, 1)

		if #guankan_paidui == 0 then
			return _ai_guanxing_finalize(ID, false, guanxing_self, guanxing_next, guankan_paidui, guanxing_discard)
		end
	end

	for i = 1, #guanxing_discard do
		table.insert(guankan_paidui, guanxing_discard[i])
	end
	guanxing_discard = {}

	--  下家判定牌控制  --
	local next = ID + 1
	if next > 5 then
		next = 1
	end

	local n = #char_juese[next].panding
	if n == 0 and shandian then
		n = 1
		shandian = true
	else
		shandian = false
	end

	for i = n, 1, -1 do
		local leixing
		if shandian then
			leixing = "闪电"
		else
			leixing = _panding_get_leixing(next, i)
		end

		local yanse, huase, dianshu = ai_judge_cardinfo(next, {guankan_paidui[1]})
		local pos

		if leixing == "乐不思蜀" then
			panding_operated, pos = _ai_guanxing_panding(guankan_paidui, 1, ID, next, huase, "红桃", true)
		elseif leixing == "兵粮寸断" then
			panding_operated, pos = _ai_guanxing_panding(guankan_paidui, 1, ID, next, huase, "草花", true)
		elseif leixing == "闪电" then
			panding_operated, pos = _ai_guanxing_panding(guankan_paidui, 1, ID, next, huase, "黑桃", false)
		end

		table.insert(guanxing_next, guankan_paidui[pos])
		table.remove(guankan_paidui, pos)

		if pos ~= 1 then
			table.insert(guankan_paidui, guankan_paidui[1])
			table.remove(guankan_paidui, 1)
		end

		if #guankan_paidui == 0 then
			return _ai_guanxing_finalize(ID, true, guanxing_self, guanxing_next, guankan_paidui, guanxing_discard)
		end
	end

	return _ai_guanxing_finalize(ID, #char_juese[next].panding > 0, guanxing_self, guanxing_next, guankan_paidui, guanxing_discard)
end
function _ai_guanxing_self_judge_keep(ID, card, had_sha)		--  观星AI：判断是否要选择当前牌为自己的手牌
	local card_treated = card[1]
	
	if card_treated == "杀" or card_treated == "火杀" or card_treated == "雷杀" then
		local targets = ai_judge_target(ID, "火杀", {{"火杀", "红桃", "K"}}, 1)
		if #targets == 0 then
			--  够不到任何人则不要再拿杀  --
			return false, had_sha
		elseif char_juese[ID].wuqi[1] == "诸葛弩" then

		elseif had_sha then
			--  有杀则不要再拿杀  --
			return false, had_sha
		else
			had_sha = true
		end
	elseif card_get_leixing(card_treated) == "防具" and #char_juese[ID].fangju ~= 0 and ai_judge_withdraw_fangju(ID, true) == false then
		--  有防具则不要再拿防具  --
		return false, had_sha
	end

	return true, had_sha
end
function _ai_guanxing_finalize(ID, next_panding, guanxing_self, guanxing_next, guankan_paidui, guanxing_discard)
	local guanxing_up, guanxing_down = {}, {}

	--  己方手牌控制  --
	local cards_sha = ai_card_search(ID, "杀", 1)
	local cards_tao = ai_card_search(ID, "桃", #char_juese[ID].shoupai)
	local had_sha = false
	local tao_num = #cards_tao
	if #cards_sha > 0 then
		had_sha = true
	end

	local keep_card = {}
	local keep_tao = {}

	for i = #guankan_paidui, 1, -1 do
		local keep
		local card_treated = guankan_paidui[i][1]
		keep, had_sha = _ai_guanxing_self_judge_keep(ID, guankan_paidui[i], had_sha)
		
		if keep == true then
			if card_treated == "杀" or card_treated == "火杀" or card_treated == "雷杀" then
				table.insert(keep_card, guankan_paidui[i])
			elseif card_treated == "桃" and tao_num < char_juese[ID].tili_max - char_juese[ID].tili then
				table.insert(keep_tao, guankan_paidui[1])
				tao_num = tao_num + 1
			else
				table.insert(keep_card, 1, guankan_paidui[i])
			end
			table.remove(guankan_paidui, i)
		end
	end

	if #guanxing_self < 2 + #char_juese[ID].panding then
		for i = #keep_tao, 1, -1 do
			table.insert(guanxing_self, keep_tao[i])
			table.remove(keep_tao, i)
			if #guanxing_self == 2 + #char_juese[ID].panding then
				break
			end
		end
	end

	for i = 1, #keep_tao do
		table.insert(guankan_paidui, keep_tao[i])
	end
	keep_tao = {}

	if #guanxing_self < 2 + #char_juese[ID].panding then
		for i = #keep_card, 1, -1 do
			table.insert(guanxing_self, keep_card[i])
			table.remove(keep_card, i)
			if #guanxing_self == 2 + #char_juese[ID].panding then
				break
			end
		end
	end

	for i = 1, #keep_card do
		table.insert(guankan_paidui, keep_card[i])
	end
	keep_card = {}

	--  如果有操作下家判定，则修复牌位置  --
	if next_panding then
		while #guanxing_self < 2 + #char_juese[ID].panding do
			local pos = math.random(#guankan_paidui)
			table.insert(guanxing_self, guankan_paidui[pos])
			table.remove(guankan_paidui, pos)
		end
	end

	for i = 1, #guanxing_discard do
		table.insert(guankan_paidui, guanxing_discard[i])
	end

	for i = 1, #guankan_paidui do
		table.insert(guanxing_down, guankan_paidui[i])
	end

	for i = 1, #guanxing_self do
		table.insert(guanxing_up, guanxing_self[i])
	end

	for i = 1, #guanxing_next do
		table.insert(guanxing_up, guanxing_next[i])
	end

	return guanxing_up, guanxing_down
end
function _ai_guanxing_panding(guankan_paidui, panding_pos, ID_s, ID_d, huase, desired_huase, ineffect)		--  观星AI：判断是否替换判定牌
	--  panding_pos为原判定牌在牌堆中的位置，desired_huase为改判需要的花色，ineffect表示判定到需要的花色是否是救队友
	--  返回参数1为是否改判，返回参数2为要从牌堆中拿出替换的牌

	local hslist = {"红桃", "黑桃", "草花", "方块"}
	local cards

	local identity1, identity2
	if ineffect then
		identity1 = 2
		identity2 = 1
	else
		identity1 = 1
		identity2 = 2
	end

	if ai_judge_same_identity(ID_s, ID_d, true) == identity1 then
		if huase == desired_huase then
			for i = 1, #hslist do
				if hslist[i] ~= desired_huase then
					cards = ai_card_search(ID_d, hslist[i], 1, guankan_paidui)
					if #cards > 0 then
						break
					end
				end
			end
			if #cards > 0 then
				return true, cards[1]
			else
				return false, panding_pos
			end
		else
			return false, panding_pos
		end
	elseif ai_judge_same_identity(ID_s, ID_d, true) == identity2 then
		if huase ~= desired_huase then
			local cards = ai_card_search(ID_d, desired_huase, 1, guankan_paidui)
			if #cards > 0 then
				return true, cards[1]
			else
				return false, panding_pos
			end
		else
			return false, panding_pos
		end
	end

	return false, panding_pos
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
	cards = random_pick(cards, 1)
	if #cards == 0 then
		return false, 0, 0
	end

	local attack_mubiao = ai_basic_judge_mubiao(ID, 4, false, true, true)
	attack_mubiao = ai_get_in_range(ID, attack_mubiao)

	for i = #attack_mubiao, 1, -1 do
		if char_juese[attack_mubiao[i]].fangju[1] == "藤甲" and char_juese[ID].wuqi[1] ~= "青釭剑" then
			table.remove(attack_mubiao, i)
		end
	end

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
	cards = random_pick(cards, 1)
	if #cards == 0 then
		return false, 0, 0
	end

	local attack_mubiao = ai_basic_judge_mubiao(ID, 4, false, true, true)
	attack_mubiao = ai_get_in_range(ID, attack_mubiao)

	for i = #attack_mubiao, 1, -1 do
		if char_juese[attack_mubiao[i]].fangju[1] == "藤甲" and char_juese[ID].wuqi[1] ~= "青釭剑" then
			table.remove(attack_mubiao, i)
		end
	end

	if #attack_mubiao == 0 then
		return false, 0, 0
	end

	local mindef_ID = ai_judge_minimum_def(attack_mubiao)
	return true, cards[1], mindef_ID
end

--  AI决定是否发动激将  --
--  true发动，false不发动  --
function ai_judge_jijiang_req(ID_req)
	local c_pos = ai_chazhao_sha(ID_req, char_juese[ID_req].shoupai)
	if c_pos < 0 then
		return true
	else
		return false
	end
end

--  AI决定是否响应激将  --
function ai_judge_jijiang(ID_laiyuan, ID_mubiao, ID_req, ID_res, mode)
	if ai_judge_same_identity(ID_res, ID_req, true) ~= 1 or ID_mubiao == ID_res then
		return false
	end

	local percent
	if mode == "南蛮入侵" or mode == "决斗" then
		if char_juese[ID_req].shenfen == "主公" then
			percent = 20 + 30 * (char_juese[ID_req].tili_max - char_juese[ID_req].tili)
		else
			percent = 20 + 10 * (char_juese[ID_req].tili_max - char_juese[ID_req].tili)
		end
		if percent < 0 then
			percent = 0
		end
		if percent > 100 then
			percent = 100
		end
	else
		percent = 50
	end

	if ai_judge_random_percent(percent) == 1 then
		return true
	else
		return false
	end
end

--  AI决定是否发动连环的连环效果  --
--  返回是否发动、手牌ID、目标列表  --
function ai_judge_lianhuan_lian(ID)
	local cards = ai_card_search(ID, "草花", 1)
	if #cards == 0 then
		return false, 0, {}
	end

	local lianhuan_cards = ai_card_search(ID, "铁索连环", 1)
	if #lianhuan_cards > 0 then
		return false, 0, {}
	end

	local shoupai = {"铁索连环", "黑桃", "3"}
	local attack_mubiao = ai_judge_target(ID, shoupai[1], {shoupai}, 2)

	if #attack_mubiao < 1 then
		return false, 0, {}
	else
		return true, cards[1], attack_mubiao
	end
end

--  AI决定是否发动连环的重铸效果  --
--  返回是否发动、手牌ID  --
function ai_judge_lianhuan_chongzhu(ID)
	local cards = ai_card_search(ID, "草花", 1)
	if #cards == 0 then
		return false, 0
	end
	return true, cards[1]
end

--  AI决定是否发动烈刃  --
function ai_judge_lieren(ID_s, ID_mubiao)
	if ai_judge_same_identity(ID_s, ID_mubiao) == 1 then
		return false
	end

	local cards = ai_card_search(ID_s, "随意", #char_juese[ID_s].shoupai)

	for i = #cards, 1, -1 do
		local yanse, huase, dianshu = ai_judge_cardinfo(ID_s, {char_juese[ID_s].shoupai[cards[i]]})
		dianshu = _pindian_convert_dianshu(dianshu)

		if dianshu >= 1 and dianshu <= 4 then
			table.remove(cards, i)
		end
	end

	if #cards == 0 or char_juese[ID_s].tili <= 1 then
		return false
	end

	if ai_judge_random_percent(75) == 1 then
		return true
	else
		return false
	end
end

--  AI决定志继选择  --
function ai_judge_zhiji(ID)
	if char_juese[ID].tili >= char_juese[ID].tili_max - 1 then
		return 2
	end

	if ai_judge_random_percent(25 * (char_juese[ID].tili_max - char_juese[ID].tili)) == 1 then
		return 1
	else
		return 2
	end
end

--  AI决定是否发动火计  --
--  返回是否发动、手牌ID、目标  --
function ai_judge_huoji(ID)
	local cards_black = ai_card_search(ID, "黑色", #char_juese[ID].shoupai)
	local cards_red = ai_card_search(ID, "红色", #char_juese[ID].shoupai)
	local has_shan = false
	local use = false

	for i = #cards_black, 1, -1 do
		if card_judge_if_shan(ID, cards_black[i]) == true and has_shan == false then
			has_shan = true
			break
		end
	end

	for i = #cards_red, 1, -1 do
		if card_judge_if_shan(ID, cards_red[i]) == true and has_shan == false then
			table.remove(cards_red, i)
			has_shan = true
		elseif char_juese[ID].shoupai[cards_red[i]][1] == "火攻" then
			table.remove(cards_red, i)
		elseif char_juese[ID].shoupai[cards_red[i]][1] == "无中生有" then
			table.remove(cards_red, i)
		end
	end

	local huase_stat = {["草花"] = 0, ["黑桃"] = 0, ["方块"] = 0, ["红桃"] = 0}
	for i = 1, #cards_red do
		local yanse, huase, dianshu = ai_judge_cardinfo(ID, {char_juese[ID].shoupai[cards_red[i]]})
		huase_stat[huase] = huase_stat[huase] + 1
	end
	for i = 1, #cards_black do
		local yanse, huase, dianshu = ai_judge_cardinfo(ID, {char_juese[ID].shoupai[cards_black[i]]})
		huase_stat[huase] = huase_stat[huase] + 1
	end

	local n_huase = 0
	local prefer = nil
	if huase_stat["草花"] > 0 then
		n_huase = n_huase + 1
	end
	if huase_stat["黑桃"] > 0 then
		n_huase = n_huase + 1
	end
	if huase_stat["红桃"] > 0 then
		n_huase = n_huase + 1
		if huase_stat["红桃"] > 1 then
			prefer = "红桃"
		end
	end
	if huase_stat["方块"] > 0 then
		n_huase = n_huase + 1
		if huase_stat["方块"] > 1 then
			prefer = "方块"
		end
	end
	if n_huase >= 3 then
		use = true
	end

	if prefer ~= nil then
		for i = #cards_red, 1, -1 do
			local yanse, huase, dianshu = ai_judge_cardinfo(ID, {char_juese[ID].shoupai[cards_red[i]]})
			if huase ~= prefer then
				table.remove(cards_red, i)
			end
		end
	end
	while #cards_red > 1 do
		table.remove(cards_red, math.random(#cards_red))
	end
	if #cards_red == 0 then
		return false, 0, 0
	end

	local attack_mubiao = ai_judge_target(ID, "火攻", {{"火攻", "方块", "Q"}}, 4)
	local mubiao = nil

	for i = 1, #attack_mubiao do
		if #char_juese[attack_mubiao[i]].fangju > 0 then
			if char_juese[attack_mubiao[i]].fangju[1] == "藤甲" then
				if ai_judge_random_percent(75) == 1 then
					mubiao = attack_mubiao[i]
				end
			end
		end
	end

	if #attack_mubiao == 0 then
		return false, 0, 0
	end

	if mubiao == nil then
		mubiao = attack_mubiao[math.random(#attack_mubiao)]
	end

	if use == true then
		return true, cards_red[1], mubiao
	else
		return false, 0, 0
	end
end

--  AI决定是否在出牌阶段发动激将  --
--  返回是否发动、目标  --
function ai_judge_jijiang_zhudong(ID)
	local friends = ai_basic_judge_mubiao(ID, 4, true, true, false)
	local has_shu = false
	for i = 1, #friends do
		if char_juese[friends[i]].shili == "蜀" then
			has_shu = true
			break
		end
	end

	if has_shu == false then
		return false, 0
	end

	local shoupai = {"杀", "黑桃", "7"}
	local attack_mubiao = ai_judge_target(ID, "杀", shoupai, 1)

	return true, attack_mubiao[1]
end

--  AI决定是否发动挑衅  --
--  返回是否发动、目标  --
function ai_judge_tiaoxin(ID)
	local attack_mubiao = ai_basic_judge_mubiao(ID, 4, false, true, true)

	for i = #attack_mubiao, 1, -1 do
		if card_if_d_limit("挑衅", ID, attack_mubiao[i]) == false then
			table.remove(attack_mubiao, i)
		elseif ai_card_stat(attack_mubiao[i], true, false) == 0 then
			table.remove(attack_mubiao, i)
		elseif #char_juese[attack_mubiao[i]].shoupai >= 2 then
			table.remove(attack_mubiao, i)
		end
	end

	if #attack_mubiao == 0 then
		return false, 0
	end

	attack_mubiao = random_pick(attack_mubiao, 1)
	return true, attack_mubiao[1]
end

--  AI决定响应挑衅的目标  --
--  返回含有杀目标的列表，如为空则表示不响应  --
function ai_judge_tiaoxin_sha_target(ID, ID_req)
	local n_targets = 1
	if gamerun_judge_fangtian(ID) == true then
		n_targets = 3
	end

	if n_targets == 1 then
		return {ID_req}
	end

	local attack_mubiao = ai_basic_judge_mubiao(ID, 4, false, true, true)
	for i = #attack_mubiao, 1, -1 do
		if attack_mubiao[i] == ID_req then
			table.remove(attack_mubiao, i)
			break
		end
	end

	attack_mubiao = random_pick(attack_mubiao, 2)
	table.insert(attack_mubiao, 1, ID_req)
	return attack_mubiao
end
