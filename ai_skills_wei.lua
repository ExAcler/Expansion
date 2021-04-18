--  AI决定是否发动护驾  --
--  true发动，false不发动  --
function ai_judge_hujia_req(ID_req)
	local c_pos = ai_chazhao_shan(ID_req, char_juese[ID_req].shoupai)
	if c_pos < 0 then
		return true
	else
		return false
	end
end

--  AI决定是否响应护驾  --
function ai_judge_hujia(ID_laiyuan, ID_req, ID_res)
	if ai_judge_same_identity(ID_res, ID_req, true) ~= 1 or ID_laiyuan == ID_res then
		return false
	end

	local percent
	if char_juese[ID_req].shenfen == "主公" then
		percent = 20 + 30 * (char_juese[ID_req].tili_max - char_juese[ID_req].tili) - 10 * (char_juese[ID_res].tili_max - char_juese[ID_res].tili)
	else
		percent = 20 + 10 * (char_juese[ID_req].tili_max - char_juese[ID_req].tili) - 10 * (char_juese[ID_res].tili_max - char_juese[ID_res].tili)
	end
	if percent < 0 then
		percent = 0
	end
	if percent > 100 then
		percent = 100
	end

	if ai_judge_random_percent(percent) == 1 then
		return true
	else
		return false
	end
end

--  AI决定是否发动裸衣  --
--  1发动，2不发动  --
function ai_judge_luoyi(ID)
	return 2
end

--  AI决定是否发动困奋  --
--  true发动，false不发动  --
function ai_judge_kunfen(ID)
	return false
end

--  AI决定是否发动据守  --
--  true发动，false不发动  --
function ai_judge_jushou(ID)
	local live = 0
	for i = 1, 5 do
		if char_juese[i].siwang == false then
			live = live + 1
		end
	end
	if char_juese[ID].fanmian == true then
		return true
	elseif live <= 2 then
		return true
	elseif ai_judge_random_percent(150 - 25 * live) == 1 then
		return true
	else
		return false
	end
end

--  AI决定是否发动伤逝  --
--  true发动，false不发动  --
function ai_judge_shangshi(ID)
	return true
end

--  AI决定是否发动天妒  --
--  true发动，false不发动  --
function ai_judge_tiandu(ID)
	return true
end

--  AI决定是否发动将驰  --
--  1多摸一张，2少摸一张，3不发动  --
function ai_judge_jiangchi(ID)
	return 3
end

--  AI决定是否响应颂威  --
function ai_judge_songwei(ID, ID_zhugong)
	if ai_judge_same_identity(ID, ID_zhugong, true) == 1 then
		return true
	else
		return false
	end
end

--  AI决定是否发动神速  --
function ai_judge_shensu(ID, is_panding)
	local ID_shoupai, ID_zhuangbei, ID_mubiao ={}, {}, {}
	
	if is_panding then
		if #char_juese[ID].panding ~= 0 then
			local leed, binged, shaned = false, false, false
			
			for i = 1, #char_juese[ID].panding do
				local leixing = _panding_get_leixing(ID, i)

				if leixing == "乐不思蜀" then
					leed = true
				elseif leixing == "兵粮寸断" then
					binged = true
				elseif leixing == "闪电" then
					shaned = true
				else
					binged = true
				end
			end
			if leed == true then
				if #char_juese[ID].shoupai + 2 < char_juese[ID].tili then
					if ai_judge_random_percent(80) == 1 then
						return {},0,{}
					end
				else
					if ai_judge_random_percent(30) == 1 then
						return {},0,{}
					end
				end
			elseif binged == true then
				if ai_judge_random_percent(60) == 1 then
					return {},0,{}
				end
			else
				if ai_judge_random_percent(80) == 1 then
					return {},0,{}
				end
			end
		else
			if char_juese[ID].shenfen ~= "反贼" then
				local percent = 90

				if #char_juese[ID].shoupai >= 3 and (#char_juese[ID].fangju > 0 or ai_chazhao_shan(ID, char_juese[ID].shoupai) > 0) then
					percent = 50 - 20 * math.min(#char_juese[ID].shoupai - 3, 3)
				end

				if ai_judge_random_percent(percent) == 1 then
					return {}, 0, {}
				end
			else
				local zhugong_id = ai_get_lord_id()
				local percent

				--  如手牌较少，则主公血量越低杀的概率越高  --
				if char_juese[zhugong_id].tili_max >= 5 then
					percent = 90 - 15 * (math.max(5 - char_juese[zhugong_id].tili, 0))
				else
					percent = 90 - 20 * (math.max(4 - char_juese[zhugong_id].tili, 0))
				end

				--  手牌充足且有防御的情况下高概率杀  --
				if #char_juese[ID].shoupai >= 3 and (#char_juese[ID].fangju > 0 or ai_chazhao_shan(ID, char_juese[ID].shoupai) > 0) then
					percent = 50 - 20 * math.min(#char_juese[ID].shoupai - 3, 3)
				end

				if #char_juese[zhugong_id].fangju > 0 then
					if char_juese[zhugong_id].fangju[1] == "藤甲" then
						percent = 0
					end
				end

				if ai_judge_random_percent(percent) == 1 then
					return {}, 0, {}
				else
					--  以80%的概率杀主公，否则可能选择其他目标  --
					if ai_judge_random_percent(80) == 1 then
						return {}, {}, {zhugong_id}
					end
				end
			end
		end
	else
		ID_shoupai = ai_card_search(ID, "装备", 1)
		if #ID_shoupai == 0 then
			if #char_juese[ID].gongma ~= 0 then
				ID_zhuangbei[3] = 1
			elseif #char_juese[ID].fangma ~= 0 then
				ID_zhuangbei[4] = 1
			elseif #char_juese[ID].wuqi ~= 0 then
				ID_zhuangbei[1] = 1
			elseif #char_juese[ID].fangju ~= 0 then
				ID_zhuangbei[2] = 1
			end
		end
	end

	if not is_panding and game_skip_chupai == true then
		return {},0,{}
	elseif #ID_shoupai == 0 and table.getn2(ID_zhuangbei) == 0 and not is_panding then
		return {},0,{}
	end

	if not is_panding and #ID_shoupai ~= 0 and ai_judge_random_percent(40) == 1 then
		return {}, 0, {}
	end

	if not is_panding and table.getn2(ID_zhuangbei) ~= 0 and ai_judge_random_percent(50) == 1 then
		return {}, 0, {}
	end

	ID_mubiao = ai_basic_judge_mubiao(ID, 4, false, true, true)
	for i = #ID_mubiao, 1, -1 do
		if char_juese[ID_mubiao[i]].fangju[1] == "藤甲" and char_juese[ID].wuqi[1] ~= "青釭剑" then
			table.remove(ID_mubiao, i)
		end
	end
	for i = #ID_mubiao, 1, -1 do
		if char_juese[ID_mubiao[i]].skill["空城"] == "available" then
			table.remove(ID_mubiao, i)
		end
	end
	for i = #ID_mubiao, 1, -1 do
		if char_juese[ID_mubiao[i]].skill["雷击"] == "available" and #char_juese[ID_mubiao[i]].shoupai >= 3 then
			table.remove(ID_mubiao, i)
		end
	end

	local sha = ai_card_search(ID, "杀", 1)
	if not is_panding and #sha > 0 then
		local not_in_range = 0

		for i = 1, #ID_mubiao do
			local _, inrange = ai_judge_distance(ID, ID_mubiao[i], 1)
			if inrange == false then
				not_in_range = not_in_range + 1
			end
		end

		if not_in_range < #ID_mubiao then
			return {}, 0, {}
		end
	end

	if #ID_mubiao == 0 then
		return {}, 0, {}
	end

	ID_mubiao = random_pick(ID_mubiao, 1)

	return ID_shoupai, ID_zhuangbei, {ID_mubiao[1]}
end

--  AI决定突袭目标  --
--  返回含有角色ID的表，如为空则表示不发动  --
function ai_judge_tuxi_mubiao(ID)
	local attack_mubiao = ai_basic_judge_mubiao(ID, 2, false, true, false)
	if #attack_mubiao == 2 or (#attack_mubiao == 1 and char_alive_stat() == 2) then
		for i = 1, #attack_mubiao do
			if #char_juese[attack_mubiao[i]].shoupai == 0 then
				return {}
			end
		end

		local percent = 75
		if #attack_mubiao == 1 then
			percent = 50
		end

		if ai_judge_random_percent(percent) == 1 then
			return attack_mubiao
		else
			return {}
		end
	else
		return {}
	end
end

--  AI决定巧变目标  --
--  判定、弃牌：返回弃置的牌表，如弃置的牌表为空则表示不发动  --
--  摸牌：返回弃置的牌表与含有角色ID的表，如弃置的牌表为空则表示不发动  --
--  出牌：返回弃置的牌表与含有角色ID与转移物位置的表，如弃置的牌表为空则表示不发动  --
function ai_judge_qiaobian(ID, jieduan)
	if #char_juese[ID].shoupai == 0 then
		return {}
	end
	if jieduan == "判定" then
		local qipai
		if #char_juese[ID].panding >= 1 and ai_judge_random_percent(50) == 1 then
			qipai = ai_judge_withdraw(ID, 1, true)
			return qipai
		end
	elseif jieduan == "摸牌" then
		local attack_mubiao = ai_basic_judge_mubiao(ID, 2, false, true, false)
		local qipai
		if #attack_mubiao == 2 or (#attack_mubiao == 1 and char_alive_stat() == 2) then
			for i = 1, #attack_mubiao do
				if #char_juese[attack_mubiao[i]].shoupai == 0 then
					return {}
				end
			end
			qipai = ai_judge_withdraw(ID, 1, true)
			local percent = 50
			if #attack_mubiao == 1 then
				percent = 20
			end

			if ai_judge_random_percent(percent) == 1 then
				return qipai, attack_mubiao
			else
				return {},{}
			end
		else
			return {},{}
		end
	elseif jieduan == "出牌" then
		local attack_mubiao = ai_basic_judge_mubiao(ID, 1, false, false, false)
		local help_mubiao = ai_basic_judge_mubiao(ID, 1, true, true, false)
		qipai = ai_judge_withdraw(ID, 1, true)
		if #attack_mubiao == 1 and #help_mubiao == 1 then
			local leed, binged, shaned = 0, 0, 0
			local leed_2, binged_2, shaned_2 = 0, 0, 0
			for i = 1, #char_juese[help_mubiao[1]].panding do
				local leixing = _panding_get_leixing(help_mubiao[1], i)

				if leixing == "乐不思蜀" then
					leed = i
				elseif leixing == "兵粮寸断" then
					binged = i
				elseif leixing == "闪电" then
					shaned = i
				else
					binged = i
				end
			end
			for i = 1, #char_juese[attack_mubiao[1]].panding do
				local leixing = _panding_get_leixing(attack_mubiao[1], i)

				if leixing == "乐不思蜀" then
					leed_2 = i
				elseif leixing == "兵粮寸断" then
					binged_2 = i
				elseif leixing == "闪电" then
					shaned_2 = i
				else
					binged_2 = i
				end
			end
			if leed ~= 0 and leed_2 == 0 and char_juese[attack_mubiao[1]].skill["谦逊"] ~= "available" then
				if ai_judge_random_percent(90) == 1 then
					return qipai, {attack_mubiao[1], help_mubiao[1], leed + 4}
				else
					return {},{}
				end
			end
			if binged ~= 0 and binged_2 == 0 and char_juese[attack_mubiao[1]].skill["帷幕"] ~= "available" then
				if ai_judge_random_percent(80) == 1 then
					return qipai, {attack_mubiao[1], help_mubiao[1], binged + 4}
				else
					return {},{}
				end
			end
			if shaned ~= 0 and shaned_2 == 0 and (char_juese[attack_mubiao[1]].skill["帷幕"] ~= "available" or ai_judge_cardinfo(help_mubiao[1],{char_juese[help_mubiao[1]].panding[shaned]}) ~= "黑色") then
				if ai_judge_random_percent(20) == 1 then
					return qipai, {attack_mubiao[1], help_mubiao[1], shaned + 4}
				else
					return {},{}
				end
			end
			if #char_juese[attack_mubiao[1]].fangju ~= 0 and #char_juese[help_mubiao[1]].fangju == 0 then
				if ai_judge_random_percent(90) == 1 then
					return qipai, {help_mubiao[1], attack_mubiao[1], 2}
				else
					return {},{}
				end
			end
			if #char_juese[attack_mubiao[1]].fangma ~= 0 and #char_juese[help_mubiao[1]].fangma == 0 then
				if ai_judge_random_percent(70) == 1 then
					return qipai, {help_mubiao[1], attack_mubiao[1], 1}
				else
					return {},{}
				end
			end
			if #char_juese[attack_mubiao[1]].gongma ~= 0 and #char_juese[help_mubiao[1]].gongma == 0 then
				if ai_judge_random_percent(40) == 1 then
					return qipai, {help_mubiao[1], attack_mubiao[1], 3}
				else
					return {},{}
				end
			end
			if #char_juese[attack_mubiao[1]].wuqi ~= 0 and #char_juese[help_mubiao[1]].wuqi == 0 then
				if ai_judge_random_percent(40) == 1 then
					return qipai, {help_mubiao[1], attack_mubiao[1], 1}
				else
					return {},{}
				end
			end
		end
	elseif jieduan == "弃牌" then
		local qipai
		if ai_withdraw_need(ID) >= 1 then
			qipai = ai_judge_withdraw(ID, 1, true)
			return qipai
		end
	end
	return {}
end

--  AI决定是否发动断粮  --
--  返回是否发动、手牌ID、目标  --
function ai_judge_duanliang(ID)
	local cards_jiben = ai_card_search(ID, "基本", #char_juese[ID].shoupai)
	local cards_arm = ai_card_search(ID, "装备", #char_juese[ID].shoupai)
	local s = char_juese[ID].shoupai

	for i = #cards_jiben, 1, -1 do
		local ys, hs, ds = ai_judge_cardinfo(ID, {s[cards_jiben[i]]})
		if ys ~= "黑色" then
			table.remove(cards_jiben, i)
		end
	end
	cards_jiben = random_pick(cards_jiben, 1)

	for i = #cards_arm, 1, -1 do
		local ys, hs, ds = ai_judge_cardinfo(ID, {s[cards_jiben[i]]})
		if ys ~= "黑色" then
			table.remove(cards_arm, i)
		end
	end
	cards_arm = random_pick(cards_arm, 1)

	local selected_card
	if #cards_jiben == 0 and #cards_arm == 0 then
		return false, 0, 0
	elseif #cards_arm == 0 then
		selected_card = cards_jiben[1]
	else
		selected_card = cards_arm[1]
	end

	local targets = ai_judge_target(ID, "兵粮寸断", {s[selected_card]}, 1)
	if #targets == 0 then
		return false, 0, 0
	else
		return true, selected_card, targets[1]
	end
end

--  AI修改判定牌策略  --
function ai_judge_change_panding(id, ID_laiyuan, ID_mubiao, panding_leixing)
	local skill_available = skills_judge_guicai_guidao(id)

	if id == ID_mubiao then
		--  延时类锦囊自救  --
		if panding_leixing == "乐不思蜀" and card_panding_card[2] ~= "红桃" and skill_available ~= "鬼道" then
			local card_id = card_chazhao_with_huase(id, "红桃")
			if card_id < 0 then
				return nil
			else
				return card_id
			end
		end

		if panding_leixing == "兵粮寸断" and card_panding_card[2] ~= "草花" then
			local card_id = card_chazhao_with_huase(id, "草花")
			if card_id < 0 then
				return nil
			else
				return card_id
			end
		end

		if panding_leixing == "闪电" and card_panding_card[2] == "黑桃" and card_panding_card[3] >= "2" and card_panding_card[3] <= "9" then
			local card_id = card_chazhao_with_huase(id, "草花")
			if card_id < 0 and skill_available ~= "鬼道" then
				card_id = card_chazhao_with_huase(id, "红桃")
			end
			if card_id < 0 and skill_available ~= "鬼道" then
				card_id = card_chazhao_with_huase(id, "方块")
			end

			if card_id < 0 then
				return nil
			else
				return card_id
			end
		end

		--  张角发动雷击，改判使其一定生效  --
		if panding_leixing == "雷击" and card_panding_card[2] ~= "黑桃" then
			local card_id = card_chazhao_with_huase(id, "黑桃")
			if card_id < 0 then
				return nil
			else
				return card_id
			end
		end

		return nil
	end

	if id == ID_laiyuan then
		--  八卦阵，改判使其失效  --
		if panding_leixing == "八卦阵" and card_panding_card[2] == "红桃" or card_panding_card[2] == "方块" and ai_judge_same_identity(id, ID_mubiao, false) == 2 then
			local card_id = card_chazhao_with_huase(id, "草花")
			if card_id < 0 then
				card_id = card_chazhao_with_huase(id, "黑桃")
			end

			if card_id < 0 then
				return nil
			else
				return card_id
			end
		end

		--  被夏侯惇刚烈，改判使其失效  --
		if panding_leixing == "刚烈" and card_panding_card[2] ~= "红桃" and skill_available ~= "鬼道" then
			local card_id = card_chazhao_with_huase(id, "红桃")
			if card_id < 0 then
				return nil
			else
				return card_id
			end
		end

		--  被张角雷击，改判使其失效  --
		if panding_leixing == "雷击" and card_panding_card[2] == "黑桃" then
			local card_id = card_chazhao_with_huase(id, "草花")
			if card_id < 0 and skill_available ~= "鬼道" then
				card_id = card_chazhao_with_huase(id, "红桃")
			end
			if card_id < 0 and skill_available ~= "鬼道" then
				card_id = card_chazhao_with_huase(id, "方块")
			end

			if card_id < 0 then
				return nil
			else
				return card_id
			end
		end

		--  被马超铁骑，改判使其失效  --
		if panding_leixing == "铁骑" and (card_panding_card[2] == "红桃" or card_panding_card[2] == "方块") then
			local card_id = card_chazhao_with_huase(id, "草花")
			if card_id < 0 then
				card_id = card_chazhao_with_huase(id, "黑桃")
			end
			if card_id < 0 then
				return nil
			else
				return card_id
			end
		end
		
		return nil
	end

	return nil
end

--  AI决定节命的补牌目标  --
function ai_judge_jieming_mubiao(ID_s)
	local ID = ID_s

	local tili_max = char_juese[ID].tili_max
	local n_shoupai = #char_juese[ID].shoupai
	if tili_max > 5 then
		tili_max = 5
	end

	--  优先选择给自己补牌  --
	if tili_max - n_shoupai > 0 then
		return ID
	else
		for i = 1, 5 do
			if i == ID then
				
			elseif char_juese[i].siwang == true then
			
			elseif char_juese[ID].shenfen == "内奸" then
				
			elseif char_juese[ID].shenfen == "主公" or char_juese[ID].shenfen == "忠臣" then
				if char_juese[i].shenfen == "主公" or (char_juese[i].isantigovernment == false and char_juese[i].isblackjack ~= true) then
					if math.min(char_juese[i].tili_max, 5) > #char_juese[i].shoupai then
						return i
					end
				end
			elseif char_juese[ID].shenfen == "反贼" then
				if char_juese[i].isantigovernment == true and char_juese[i].isblackjack ~= true then
					if math.min(char_juese[i].tili_max, 5) > #char_juese[i].shoupai then
						return i
					end
				end
			end
		end
	end

	return nil
end

--  AI决定放逐的翻面目标  --
function ai_judge_fangzhu_mubiao(ID_s,ID_mubiao)
	
	local tili_max = char_juese[ID_s].tili_max
	local tili = char_juese[ID_s].tili
	local benefit = 0
	if tili_max - tili > 3 then
		benefit = 1
	elseif tili_max - tili < 3 then
		benefit = 0
	else
		benefit = ai_judge_random_percent(50)
	end
	for i = 1 ,5 do
		if ID_mubiao ~= nil then
			if i == ID_s then
				
			elseif char_juese[i].siwang == true then
				
			elseif char_juese[ID_s].shenfen == "主公" or char_juese[ID_s].shenfen == "忠臣" or (char_juese[ID_s].shenfen == "内奸" and ai_judge_blackjack(ID_s) == true) then
				if char_juese[i].shenfen == "主公" or (char_juese[i].isantigovernment == false and char_juese[i].isblackjack ~= true) then
					if benefit == 1 then
						return i
					elseif char_juese[i].fanmian == true then
						return i
					end
				else
					if char_juese[i].fanmian == true then
						
					elseif benefit == 0 then
						return i
					end
				end
			elseif char_juese[ID_s].shenfen == "反贼" then
				if char_juese[i].isantigovernment == true and char_juese[i].isblackjack ~= true then
					if benefit == 1 then
						return i
					elseif char_juese[i].fanmian == true then
						return i
					end
				else
					if char_juese[i].fanmian == true then
						
					elseif benefit == 0 then
						return i
					end
				end
			end
		end
	end
	return nil
end

-- AI决定是否反馈 --
function ai_judge_fankui_mubiao(ID_s, ID_mubiao)
	if ID_mubiao ~= nil then
		if ID_s == ID_mubiao then
			return ID_mubiao
		elseif char_juese[ID_mubiao].siwang == true then
			
		elseif char_juese[ID_s].shenfen == "主公" or char_juese[ID_s].shenfen == "忠臣" or (char_juese[ID_s].shenfen == "内奸" and ai_judge_blackjack(ID_s) == true) then
			if char_juese[ID_mubiao].shenfen == "主公" or (char_juese[ID_mubiao].isantigovernment == false and char_juese[ID_mubiao].isblackjack ~= true) then
				
			else
				return ID_mubiao
			end
		elseif char_juese[ID_s].shenfen == "反贼" then
			if char_juese[ID_mubiao].isantigovernment == true and char_juese[ID_mubiao].isblackjack ~= true then
				
			else
				return ID_mubiao
			end
		elseif char_juese[ID_s].shenfen == "内奸" then
			return ID_mubiao
		end
	end
	return nil
end

--  AI决定是否刚烈  --
function ai_judge_ganglie_mubiao(ID_s, ID_mubiao)
	if ID_mubiao ~= nil then
		if ID_s == ID_mubiao then
			
		elseif char_juese[ID_mubiao].siwang == true then
			
		elseif char_juese[ID_s].shenfen == "主公" or char_juese[ID_s].shenfen == "忠臣" or (char_juese[ID_s].shenfen == "内奸" and ai_judge_blackjack(ID_s) == true) then
			if char_juese[ID_mubiao].shenfen == "主公" or (char_juese[ID_mubiao].isantigovernment == false and char_juese[ID_mubiao].isblackjack ~= true) then
				
			else
				return ID_mubiao
			end
		elseif char_juese[ID_s].shenfen == "反贼" then
			if char_juese[ID_mubiao].isantigovernment == true and char_juese[ID_mubiao].isblackjack ~= true then
				
			else
				return ID_mubiao
			end
		elseif char_juese[ID_s].shenfen == "内奸" then
			return ID_mubiao
		end
	end
	return nil
end

--  AI决定遗计的目标  --
function ai_judge_yiji_mubiao(ID)
	return ID
end

--  AI决定是否发动驱虎  --
--  返回是否发动、手牌ID、目标A、目标B
function ai_judge_quhu(ID)
	local cards = ai_card_search(ID, "随意", #char_juese[ID].shoupai)

	for i = #cards, 1, -1 do
		local yanse, huase, dianshu = ai_judge_cardinfo(ID, {char_juese[ID].shoupai[cards[i]]})
		dianshu = _pindian_convert_dianshu(dianshu)

		if dianshu >= 1 and dianshu <= 9 then
			table.remove(cards, i)
		end
	end

	if #cards == 0 then
		char_juese[ID].skill["驱虎"] = "locked"
		return false, 0, 0, 0
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
	local possible_combinations_enemy = {}
	local possible_combinations_friend = {}

	for ii = 1, #attack_mubiao do
		local chosen_mubiao = attack_mubiao[ii]
		if #char_juese[chosen_mubiao].shoupai > 0 and #char_juese[chosen_mubiao].shoupai <= 4 then
			for i = 1, 5 do
				if i ~= chosen_mubiao and _quhu_find(attack_mubiao, i) then
					if #char_juese[chosen_mubiao].wuqi > 0 then
						if char_calc_distance(chosen_mubiao, i) <= card_wuqi_r[char_juese[chosen_mubiao].wuqi[1]] then
							table.insert(possible_combinations_enemy, {chosen_mubiao, i})
						end
					else
						if char_calc_distance(chosen_mubiao, i) <= 1 then
							table.insert(possible_combinations_enemy, {chosen_mubiao, i})
						end
					end
				end
			end
		end
	end

	for ii = 1, #help_mubiao do
		local chosen_mubiao = help_mubiao[ii]
		if #char_juese[chosen_mubiao].shoupai > 0 then
			for i = 1, 5 do
				if i ~= chosen_mubiao and _quhu_find(attack_mubiao, i) and (char_juese[i].tili == 1 or #char_juese[chosen_mubiao].shoupai >= 3 or #char_juese[chosen_mubiao].fangju > 0) then
					if #char_juese[chosen_mubiao].wuqi > 0 then
						if char_calc_distance(chosen_mubiao, i) <= card_wuqi_r[char_juese[chosen_mubiao].wuqi[1]] then
							table.insert(possible_combinations_friend, {chosen_mubiao, i})
						end
					else
						if char_calc_distance(chosen_mubiao, i) <= 1 then
							table.insert(possible_combinations_friend, {chosen_mubiao, i})
						end
					end
				end
			end
		end
	end

	if #possible_combinations_enemy + #possible_combinations_friend == 0 then
		char_juese[ID].skill["驱虎"] = "locked"
		return false, 0, 0, 0
	end

	local lowest_def_comb = possible_combinations_enemy[1]
	for i = 2, #possible_combinations_enemy do
		if #char_juese[possible_combinations_enemy[i][1]].shoupai < #char_juese[lowest_def_comb[1]].shoupai then
			lowest_def_comb = possible_combinations_enemy[i]
		end
	end

	possible_combinations_friend = random_pick(possible_combinations_friend, 1)

	if #possible_combinations_enemy > 0 then
		return true, cards[1], lowest_def_comb[1], lowest_def_comb[2]
	else
		return true, cards[1], possible_combinations_friend[1][1], possible_combinations_friend[1][2]
	end
end
function _pindian_convert_dianshu(dianshu)
	if dianshu == "A" then
		return 1
	elseif dianshu == "J" then
		return 11
	elseif dianshu == "Q" then
		return 12
	elseif dianshu == "K" then
		return 13
	else
		return tonumber(dianshu)
	end
end

function _quhu_find(attack_mubiao, ID)
	for i = 1, #attack_mubiao do
		if attack_mubiao[i] == ID then
			return true
		end
	end
	return false
end
