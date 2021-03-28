--  AI从手牌中查找杀  --
--  返回-1即为没有杀  --
function ai_chazhao_sha(ID, shoupai)
	local c_pos = _sha_card_chazhao(shoupai, "杀")
	if c_pos < 0 then
		c_pos = _sha_card_chazhao(shoupai, "雷杀")
	end
	if c_pos < 0 then
		c_pos = _sha_card_chazhao(shoupai, "火杀")
	end
	return c_pos
end

--  AI从手牌中查找闪  --
--  返回-1即为没有闪  --
function ai_chazhao_shan(ID, shoupai)
	local c_pos = _sha_card_chazhao(shoupai, "闪")
	if c_pos == -1 then
		--  甄姬倾国  --
		if char_juese[ID].skill["倾国"] == "available" then
			c_pos = _sha_chazhao_redblack(ID, shoupai, false)
		end
			
		--  赵云龙胆  --
		if char_juese[ID].skill["龙胆"] == "available" then
			c_pos = _sha_card_chazhao(shoupai, "杀")
			if c_pos == -1 then
				c_pos = _sha_card_chazhao(shoupai, "雷杀")
			end
			if c_pos == -1 then
				c_pos = _sha_card_chazhao(shoupai, "火杀")
			end
		end
	end
	return c_pos
end

--  AI从手牌中查找酒  --
--  返回-1即为没有酒  --
function ai_chazhao_jiu(ID)
	local cards = ai_card_search(ID, "酒", 1)
	if #cards == 0 then
		--  董卓酒池  --
		if char_juese[ID].skill["酒池"] == "available" then
			cards = ai_card_search(ID, "黑桃", 1)
		end
	end

	if #cards == 0 then
		return -1
	else
		return cards[1]
	end
end

--  AI决定是否发动雌雄双股剑  --
function ai_judge_cixiong()
	return true
end

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

--  AI决定是否发动贯石斧  --
function ai_judge_guanshi(ID_s, ID_mubiao)
	if ai_judge_same_identity(ID_s, ID_mubiao, true) == 1 then
		return false
	end

	if #char_juese[ID_s].shoupai > 2 then
		return true
	end

	return false
end

--  AI决定是否发动寒冰剑  --
function ai_judge_hanbing(ID_s, ID_mubiao)
	if #char_juese[ID_mubiao].shoupai >= 2 then
		if char_juese[ID_mubiao].tili == char_juese[ID_mubiao].tili_max and ai_judge_random_percent(70) == 1 then
			return true
		elseif ai_judge_random_percent(30) == 1 then
			return true
		end
	end

	return false
end

--  AI决定是否发动青龙刀  --
function ai_judge_qinglong(ID_s, ID_mubiao)
	if ai_judge_same_identity(ID_s, ID_mubiao, true) == 1 then
		return false
	end

	if ai_chazhao_sha(ID_s, char_juese[ID_s].shoupai) > 0 then
		return true
	end

	return false
end

--  AI决定是否发动朱雀羽扇  --
function ai_judge_zhuque()
	return true
end

--  AI决定是否出桃解救濒死角色  --
function ai_judge_jiejiu(ID_s, ID_jiu)
	local jiejiu = false
	if char_juese[ID_jiu].shenfen == "主公" or char_juese[ID_jiu].shenfen == "忠臣" then
		if char_juese[ID_s].shenfen == "主公" or (char_juese[ID_s].isantigovernment == false and char_juese[ID_s].isblackjack ~= true) then 
			jiejiu = true
		end
	elseif char_juese[ID_jiu].shenfen == "反贼" then
		if char_juese[ID_s].isantigovernment == true and char_juese[ID_s].isblackjack ~= true then 
			jiejiu = true
		end
	elseif char_juese[ID_jiu].shenfen == "内奸" then
		local pk = true
		for i = 1, 5 do
			if char_juese[i].shenfen ~= "主公" and char_juese[i].shenfen ~= "内奸" and char_juese[i].siwang == false then
				pk = false
			end
		end
		if char_juese[ID_s].shenfen == "主公" and pk == true then
			jiejiu = false
		elseif char_juese[ID_s].shenfen == "主公" then
			jiejiu = true
		end
	end
	return jiejiu
end

--  AI决定是否出无懈可击  --
--  凡是敌人拥护的，我们就要去反对；凡是敌人反对的，我们就要去拥护。
function ai_judge_wuxie(id, ID_s, ID_jiu, name)
local help = false
local use = true
	if id == ID_jiu then
		help = true
	elseif char_juese[id].shenfen == "主公" or char_juese[id].shenfen == "忠臣" then
		if char_juese[ID_jiu].shenfen == "主公" or (char_juese[ID_jiu].isantigovernment == false and char_juese[ID_jiu].isblackjack == false) then 
			if char_juese[ID_s].shenfen == "主公" or (char_juese[ID_s].isantigovernment == false and char_juese[ID_s].isblackjack == false) then 
				help = false
			else
				help = true
			end
		end
	elseif char_juese[id].shenfen == "反贼" then
		if char_juese[ID_jiu].isantigovernment == true and char_juese[ID_jiu].isblackjack ~= true then 
			if char_juese[ID_s].isantigovernment == true and char_juese[ID_s].isblackjack ~= true then 
				help = false
			else
				help = true
			end
		elseif char_juese[ID_s].isblackjack == true then 
			use = false
		end
	elseif char_juese[id].shenfen == "内奸" then
		if char_juese[ID_jiu].shenfen == "主公" and char_juese[ID_s].isantigovernment == true and char_juese[ID_jiu].tili == 1 then
			help = true
		else
			use = false
		end
	end
	if use == false then
		return false
	elseif (name == "万箭齐发" or name == "南蛮入侵") and char_juese[ID_jiu].fangju[1] == "藤甲" then
		return false
	elseif name == "万箭齐发" or name == "南蛮入侵" or name == "火攻" or name == "借刀杀人" or name == "决斗" then
		return help
	elseif name == "桃园结义" or name == "五谷丰登" or name == "无中生有" then
		return not help
	elseif (name == "顺手牵羊" or name == "过河拆桥") and #char_juese[ID_jiu].panding > 0 then
		return not help
	elseif name == "顺手牵羊" or name == "过河拆桥" then
		return help
	elseif name == "铁锁连环" and char_juese[ID_jiu].hengzhi then
		return not help
	elseif name == "铁锁连环" or name == "乐不思蜀" or name == "兵粮寸断" or name == "闪电" then
		return help
	elseif name == "无懈可击" then
		return help
	else
		return false
	end
end

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

--  AI决定是否发动护驾  --
--  true发动，false不发动  --
function ai_judge_hujia_req(ID_req)
	local c_pos = ai_chazhao_shan(ID_req, char_juese[ID_req].shoupai)
	if c_pos < 0 then
		return false
	else
		return true
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

--  AI决定是否响应护驾  --
function ai_judge_hujia(ID_req, ID_res)
	if ai_judge_same_identity(ID_res, ID_req, true) ~= 1 then
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

--  AI决定是否响应暴虐  --
function ai_judge_baonue(ID, ID_zhugong)
	if ai_judge_same_identity(ID, ID_zhugong, true) == 1 then
		return true
	else
		return false
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

--  AI决定是否发动裸衣  --
--  1发动，2不发动  --
function ai_judge_luoyi(ID)
	return 2
end

--  AI决定是否发动英姿  --
--  true发动，false不发动  --
function ai_judge_yingzi(ID)
	return true
end

--  AI决定是否发动闭月  --
--  true发动，false不发动  --
function ai_judge_biyue(ID)
	return true
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

--  AI决定是否发动集智  --
--  true发动，false不发动  --
function ai_judge_jizhi(ID)
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

--  AI决定是否发动伤逝  --
--  true发动，false不发动  --
function ai_judge_shangshi(ID)
	return true
end

--  AI决定是否发动新生  --
--  true发动，false不发动  --
function ai_judge_xinsheng(ID)
	return true
end

--  AI决定是否发动天妒  --
--  true发动，false不发动  --
function ai_judge_tiandu(ID)
	return true
end

--  AI决定是否发动克己  --
--  true发动，false不发动  --
function ai_judge_keji(ID)
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

--  AI决定是否发动观星  --
--  true发动，false不发动  --
function ai_judge_guanxing(ID)
	return false
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

--  AI判断对方是否与自己同阵营  --
--  返回1是，返回2否，返回3未知  --
function ai_judge_same_identity(ID, ID_mubiao, blackjack)
	if char_juese[ID].shenfen == "主公" or char_juese[ID].shenfen == "忠臣" then
		if char_juese[ID_mubiao].isantigovernment == false and char_juese[ID_mubiao].isblackjack == false then
			return 1
		elseif char_juese[ID_mubiao].isantigovernment == true or char_juese[ID_mubiao].isblackjack == true then
			return 2
		end
	elseif char_juese[ID].shenfen == "反贼" then
		if char_juese[ID_mubiao].isantigovernment == true and char_juese[ID_mubiao].isblackjack == false then
			return 1
		elseif char_juese[ID_mubiao].isantigovernment == false or char_juese[ID_mubiao].isblackjack == true then
			return 2
		end
	elseif char_juese[ID].shenfen == "内奸" then
		if blackjack then
			if ai_judge_blackjack(ID) then
				if char_juese[ID_mubiao].isantigovernment == false and char_juese[ID_mubiao].isblackjack == false then
					return 1
				elseif char_juese[ID_mubiao].isantigovernment == true or char_juese[ID_mubiao].isblackjack == true then
					return 2
				end
			else
				if char_juese[ID_mubiao].isantigovernment == true and char_juese[ID_mubiao].isblackjack == false then
					return 1
				elseif char_juese[ID_mubiao].isantigovernment == false or char_juese[ID_mubiao].isblackjack == true then
					return 2
				end
			end
		else
			return 2
		end
	end

	return 3
end

--  基本AI技能作用目标决定，完全依照身份  --
function ai_basic_judge_mubiao(ID, required, is_help, exclude_self, exclude_unknown, target_list)
	local possible_target
	if target_list == nil then
		possible_target = {1, 2, 3, 4, 5}
	else
		possible_target = table.copy(target_list)
	end

	if exclude_self == true then
		table.remove(possible_target, ID)
	end

	for i = #possible_target, 1, -1 do
		if char_juese[possible_target[i]].siwang == true then
			table.remove(possible_target, i)
		end
	end

	for i = #possible_target, 1, -1 do
		if exclude_unknown and char_juese[possible_target[i]].isantigovernment == nil then
			table.remove(possible_target, i)
		else
			if char_juese[ID].shenfen == "主公" or char_juese[ID].shenfen == "忠臣" then
				if char_juese[possible_target[i]].isantigovernment == is_help or (is_help == true and char_juese[possible_target[i]].isblackjack == true) then
					table.remove(possible_target, i)
				end
			elseif char_juese[ID].shenfen == "反贼" then
				if char_juese[possible_target[i]].isantigovernment == not is_help or (is_help == true and char_juese[possible_target[i]].isblackjack == true) then
					table.remove(possible_target, i)
				end
			elseif char_juese[ID].shenfen == "内奸" then
				if ai_judge_blackjack(ID) then
					if char_juese[possible_target[i]].isantigovernment == is_help then
						table.remove(possible_target, i)
					end
				else
					if char_juese[possible_target[i]].isantigovernment == not is_help then
						table.remove(possible_target, i)
					end
				end
			end
		end
	end

	while #possible_target > required do
		table.remove(possible_target, math.random(#possible_target))
	end

	return possible_target
end

--  获取主公ID  --
function ai_get_lord_id()
	for i = 1, 5 do
		if char_juese[i].shenfen == "主公" then
			return i
		end
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
		if char_juese[ID_mubiao[i]].fangju[1] == "藤甲" and char_juese[ID].wuqi[1] ~= "青钢剑" then
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

	while #ID_mubiao > 1 do
		table.remove(ID_mubiao, math.random(#ID_mubiao))
	end

	return ID_shoupai, ID_zhuangbei, {ID_mubiao[1]}
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

--  AI计算要弃的牌数  --
function ai_withdraw_need(ID)
	local limit, need = char_juese[ID].tili, 0
	if char_juese[ID].skill["克己"] == "available" and char_yisha == false then
		return 0
	end
	if char_juese[ID].skill["庸肆"] == "available" then
		local shili = {}
		for i = 1, 5 do
			if char_juese[i].siwang ~= true then
				shili[char_juese[i].shili] = 1
			end
		end
		need = need + table.getn2(shili)
	end
	if char_juese[ID].skill["血裔"] == "available" then
		local extra = 0
		for i = 1, 5 do
			if char_juese[i].siwang == false and char_juese[i].shili == "群" and i ~= ID then
				extra = extra + 2
			end
		end
		limit = limit + extra
	end
	return need + math.max(#char_juese[ID].shoupai - limit, 0)
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
				percent = 40
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

	if #cards == 0 then
		char_juese[ID].skill["离间"] = "locked"
		return false, 0, 0
	else
		return true, cards[1], attack_mubiao
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
	while #cards_jiben > 1 do
		table.remove(cards_jiben, math.random(#cards_jiben))
	end

	for i = #cards_arm, 1, -1 do
		local ys, hs, ds = ai_judge_cardinfo(ID, {s[cards_jiben[i]]})
		if ys ~= "黑色" then
			table.remove(cards_arm, i)
		end
	end
	while #cards_arm > 1 do
		table.remove(cards_arm, math.random(#cards_arm))
	end

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

--  明身份临时：AI初始化其反政府属性  --
function ai_init_shenfen()
	for i = 1, 5 do
		if char_juese[i].shenfen == "反贼" then
			char_juese[i].isantigovernment = true
		elseif char_juese[i].shenfen == "主公" then
			char_juese[i].isantigovernment = false
		elseif char_juese[i].shenfen == "忠臣" then
			char_juese[i].isantigovernment = false
		elseif char_juese[i].shenfen == "内奸" then
			char_juese[i].isantigovernment = true
		end
	end
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
				
			elseif char_juese[ID_s].shenfen == "主公" or char_juese[ID_s].shenfen == "忠臣" or (char_juese[ID_s].shenfen == "反贼" and ai_judge_blackjack(ID_s) == true) then
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
			
		elseif char_juese[ID_s].shenfen == "主公" or char_juese[ID_s].shenfen == "忠臣" or (char_juese[ID_s].shenfen == "反贼" and ai_judge_blackjack(ID_mubiao) == true) then
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

-- AI决定是否补益 --
function ai_judge_buyi_mubiao(ID_s, ID_mubiao)
	if #char_juese[ID_mubiao].shoupai == 0 then
		return nil
	elseif ID_mubiao ~= nil then
		if ID_s == ID_mubiao then
			return ID_mubiao
		elseif char_juese[ID_mubiao].siwang == true then
			
		elseif char_juese[ID_s].shenfen == "主公" or char_juese[ID_s].shenfen == "忠臣" or (char_juese[ID_s].shenfen == "反贼" and ai_judge_blackjack(ID_mubiao) == true) then
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

--  AI决定是否刚烈  --
function ai_judge_ganglie_mubiao(ID_s, ID_mubiao)
	if ID_mubiao ~= nil then
		if ID_s == ID_mubiao then
			
		elseif char_juese[ID_mubiao].siwang == true then
			
		elseif char_juese[ID_s].shenfen == "主公" or char_juese[ID_s].shenfen == "忠臣" or (char_juese[ID_s].shenfen == "反贼" and ai_judge_blackjack(ID_mubiao) == true) then
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

-- AI决定是否归心 --
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

function ai_judge_yiji_mubiao(ID)
	return ID
end

--  角色防御系数计算  --
--  ID表示角色ID，is_self表示是否是自己，direct_only表示是否只计算直接防御 (不考虑能被他方杀到)
function ai_judge_def(ID, is_self, direct_only)
	local def
	local possible_attackers = {}

	if is_self == false then
		def = 20 * char_juese[ID].tili + 10 * #char_juese[ID].shoupai
	else
		def = 20 * char_juese[ID].tili
		for i = 1, #char_juese[ID].shoupai do
			if card_judge_if_shan(ID, i) then
				def = def + 30
			else
				def = def + 10
			end
		end
	end

	if #char_juese[ID].shoupai == 0 and char_juese[ID].skill["空城"] == "available" then
		def = def + 70
	end

	if char_juese[ID].skill["谦逊"] == "available" then
		def = def + 40
	end

	if char_juese[ID].isantigovernment ~= nil or is_self then
		for i = 1, 5 do
			if i ~= ID and ai_judge_same_identity(ID, i, false) == 2 then
				table.insert(possible_attackers, i)
			end
		end
	end

	if #char_juese[ID].fangju > 0 then
		if char_juese[ID].fangju[1] == "白银狮" then
			def = def + 20
		elseif char_juese[ID].fangju[1] == "八卦阵" then
			def = def + 70
		elseif char_juese[ID].fangju[1] == "藤甲" then
			local zhuque = false
			for i = 1, #possible_attackers do
				local id_attack = possible_attackers[i]
				if #char_juese[id_attack].wuqi > 0 then
					if char_juese[id_attack].wuqi[1] == "朱雀扇" and char_calc_distance(id_attack, ID) <= card_wuqi_r[char_juese[id_attack].wuqi[1]] then
						zhuque = true
						break
					end
				end
			end

			if zhuque == false then
				def = def + 100
			else
				def = def - 80
			end
		else
			def = def + 100
		end
	else
		if char_juese[ID].skill["八阵"] == "available" or char_juese[ID].skill["毅重"] == "available" then
			def = def + 70
		end
	end

	if #char_juese[ID].fangma > 0 then
		def = def + 50
	end

	if #char_juese[ID].panding > 0 then
		for i = 1, #char_juese[ID].panding do
			if _panding_get_leixing(ID, i) ~= "闪电" then
				def = def - 30
			end
		end
	end

	if direct_only == false then
		for i = 1, #possible_attackers do
			local id_attack = possible_attackers[i]
			if #char_juese[id_attack].wuqi > 0 then
				if char_calc_distance(id_attack, ID) <= card_wuqi_r[char_juese[id_attack].wuqi[1]] then
					def = def - (20 + 10 * math.max(#char_juese[id_attack].shoupai - 4, 0))
				end
			else
				if char_calc_distance(id_attack, ID) <= 1 then
					def = def - (20 + 10 * math.max(#char_juese[id_attack].shoupai - 4, 0))
				end
			end
		end
	end

	def = math.max(def, 0)
	return def
end

-- AI距离与攻击范围测算 --
-- 第一个参数是否在指定距离内，第二个参数返回是否在攻击范围内
function ai_judge_distance(ID_s,ID_d,limdis,weapon_ignore,horse_ignore)
	local distance_shun,distance_ni,indis,range,inrange=math.max(ID_d,ID_s)-math.min(ID_d,ID_s),math.min(ID_d,ID_s)+5-math.max(ID_d,ID_s),false,1,false
	for i = 1,5 do
		if char_juese[i].siwang == true then
			if i < math.max(ID_d,ID_s) and i > math.min(ID_d,ID_s) then
				distance_ni = distance_ni - 1
			else
				distance_shun = distance_shun - 1
			end
		end
	end
	distance = math.min(distance_ni,distance_shun)
	if #char_juese[ID_s].gongma ~= 0 and ID_s ~= ID_d and horse_ignore == nil then
		distance = distance-1
	end
	if #char_juese[ID_d].fangma ~= 0 and ID_s ~= ID_d then
		distance = distance+1
	end
	if char_juese[ID_s].skill["马术"] == "available" and ID_s ~= ID_d then
		distance = distance-1
	end
	if char_juese[ID_s].skill["义从"] == "available" and char_juese[ID_s].tili > 2 and ID_s ~= ID_d then
		distance = distance-1
	end
	if char_juese[ID_d].skill["义从"] == "available" and char_juese[ID_d].tili <= 2 and ID_s ~= ID_d then
		distance = distance+1
	end
	if char_juese[ID_d].skill["飞影"] == "available" and ID_s ~= ID_d then
		distance = distance+1
	end
	if #char_juese[ID_s].wuqi ~= 0 and weapon_ignore == nil then
		range = card_wuqi_r[char_juese[ID_s].wuqi[1]]
	end
	-- distance = distance + delta
	if distance <= limdis then
		indis = true
	end
	if distance <= range then
		inrange = true
	end
	return indis,inrange
end

-- AI内奸场上局势判断 --
--返回false装反,返回true装忠
function ai_judge_blackjack(ID)
	local lord,rebel=200,200
	for i=1,5 do
		if i==ID then
			
		elseif char_juese[i].siwang == true and char_juese[i].shenfen == "忠臣" then
			lord = lord - 100
		elseif char_juese[i].siwang == true and char_juese[i].shenfen == "反贼" then
			rebel = rebel - 100
		elseif char_juese[i].siwang == false and char_juese[i].isantigovernment == true then
			lord = lord + 10 * char_juese[i].tili + 5 * #char_juese[i].shoupai - 20 * #char_juese[i].panding
			if #char_juese[i].wuqi ~= 0 then
				lord = lord + 5
			end
			if #char_juese[i].fangju ~= 0 then
				lord = lord + 5
			end
			if #char_juese[i].gongma ~= 0 then
				lord = lord + 5
			end
			if #char_juese[i].fangma ~= 0 then
				lord = lord + 5
			end
		elseif char_juese[i].siwang == false and char_juese[i].isantigovernment == false then
			rebel = rebel + 10 * char_juese[i].tili + 5 * #char_juese[i].shoupai - 20 * #char_juese[i].panding
			if #char_juese[i].wuqi ~= 0 then
				rebel = rebel + 5
			end
			if #char_juese[i].fangju ~= 0 then
				rebel = rebel + 5
			end
			if #char_juese[i].gongma ~= 0 then
				rebel = rebel + 5
			end
			if #char_juese[i].fangma ~= 0 then
				rebel = rebel + 5
			end
		end
	end
	if lord > rebel then
		return false
	else
		return true
	end
end

-- AI使用牌颜色、花色与点数判断 --
function ai_judge_cardinfo(ID,cards)
	local yanse,huase,dianshu = "无","无",0
	if #cards == 1 then
		huase,dianshu = cards[1][2],cards[1][3]
		if huase == "" then
			huase = "无"
		end
		if dianshu == "" then
			dianshu = 0
		end

		if huase == "黑桃" and char_juese[ID].skill["红颜"] == "available" then
			huase = "红桃"
		end
		if huase == "黑桃" or huase == "草花" then
			yanse = "黑色"
		elseif huase == "方块" or huase == "红桃" then
			yanse = "红色"
		else
			yanse = "无"
		end
	elseif #cards > 1 then
		dianshu = 0
		local huase_included = {0,0,0,0}
		for i=1,#cards do
			if cards[i][2] == "黑桃" and char_juese[ID].skill["红颜"] == "available" then
				huase_included[3] = huase_included[3]+1
			elseif cards[i][2] == "黑桃" then
				huase_included[1] = huase_included[1]+1
			elseif cards[i][2] == "草花" then
				huase_included[2] = huase_included[2]+1
			elseif cards[i][2] == "红桃" then
				huase_included[3] = huase_included[3]+1
			elseif cards[i][2] == "方块" then
				huase_included[4] = huase_included[4]+1
			end
		end
		if huase_included[2] + huase_included[3] + huase_included[4] == 0 then
			huase,yanse = "黑桃","黑色"
		elseif huase_included[1] + huase_included[3] + huase_included[4] == 0 then
			huase,yanse = "草花","黑色"
		elseif huase_included[1] + huase_included[2] + huase_included[4] == 0 then
			huase,yanse = "红桃","红色"
		elseif huase_included[1] + huase_included[2] + huase_included[3] == 0 then
			huase,yanse = "方块","红色"
		elseif huase_included[3] + huase_included[4] == 0 then
			yanse = "黑色"
		elseif huase_included[1] + huase_included[2] == 0 then
			yanse = "红色"
		end
	end
	return yanse,huase,dianshu
end

-- AI攻击范围内有哪些目标 --
function ai_judge_in_range(ID,weapon_ignore,horse_ignore)
	local inrange = {}
	for i = 1,5 do
		if char_juese[ID].siwang == false and i ~= ID then
			local _,ans = ai_judge_distance(ID,i,1,weapon_ignore,horse_ignore)
			if ans then
				table.insert(inrange,i)
			end
		end
	end
	return inrange
end

-- AI使用牌目标选择 --
function ai_judge_target(ID, card_treated, cards, target_number)
	if target_number == nil then
		target_number = 1
	end
	local possible_target = {1,2,3,4,5}
	for i=5,1,-1 do
		if char_juese[possible_target[i]].siwang == true then
			table.remove(possible_target,i)
		elseif card_treated ~= "借刀杀人" and string.find(card_treated,"杀") ~= nil and ai_judge_cardinfo(ID,cards) == "黑色" and char_juese[possible_target[i]].skill["帷幕"] == "available" then
			table.remove(possible_target,i)
		elseif ID == possible_target[i] and card_treated == "铁锁连环" and char_juese[ID].hengzhi == true then
			
		elseif ID == possible_target[i] then
			table.remove(possible_target,i)
		elseif char_juese[ID].shenfen == "主公" or char_juese[ID].shenfen == "忠臣" then
			if char_juese[possible_target[i]].isantigovernment == false and ((#char_juese[possible_target[i]].panding ~= 0 and (card_treated == "顺手牵羊" or card_treated == "过河拆桥")) or (char_juese[possible_target[i]].hengzhi == true and card_treated == "铁锁连环")) then
				
			elseif char_juese[possible_target[i]].isantigovernment == false then
				table.remove(possible_target,i)
			end
		elseif char_juese[ID].shenfen == "反贼" then
			if char_juese[possible_target[i]].isantigovernment == true and ((#char_juese[possible_target[i]].panding ~= 0 and (card_treated == "顺手牵羊" or card_treated == "过河拆桥")) or (char_juese[possible_target[i]].hengzhi == true and card_treated == "铁锁连环")) then
			
			elseif char_juese[possible_target[i]].isantigovernment ~= false then
				table.remove(possible_target,i)
			end
		elseif char_juese[ID].shenfen == "内奸" then
			local pk = true
			for i = 1, 5 do
				if char_juese[i].shenfen ~= "主公" and char_juese[i].shenfen ~= "内奸" and char_juese[i].siwang == false then
					pk = false
				end
			end
			if pk == true then
				
			elseif char_juese[i].shenfen == "主公" and char_juese[i].tili == 1 then
				table.remove(possible_target,i)
			elseif ai_judge_blackjack(ID) == true then
				if char_juese[possible_target[i]].isantigovernment ~= false then
					table.remove(possible_target,i)
				end
			else
				if char_juese[possible_target[i]].isantigovernment == false or char_juese[possible_target[i]].shenfen == "主公" then
					table.remove(possible_target,i)
				end
			end
		end
	end
	if card_treated == "顺手牵羊" then
		--剔除距离不够的目标
		for i=#possible_target,1,-1 do
			if ai_judge_distance(ID,possible_target[i],1) == false and char_juese[ID].skill["奇才"] ~= "available" then
				table.remove(possible_target,i)
			end
		end
		--剔除没有牌的目标
		for i=#possible_target,1,-1 do
			if #char_juese[possible_target[i]].shoupai == 0 and #char_juese[possible_target[i]].wuqi == 0 and #char_juese[possible_target[i]].fangju == 0 and #char_juese[possible_target[i]].gongma == 0 and #char_juese[possible_target[i]].fangma == 0 and #char_juese[possible_target[i]].panding == 0 then
				table.remove(possible_target,i)
			end
		end
		--剔除只有判定区有牌的对手
		for i=#possible_target,1,-1 do
			if #char_juese[possible_target[i]].shoupai == 0 and #char_juese[possible_target[i]].wuqi == 0 and #char_juese[possible_target[i]].fangju == 0 and #char_juese[possible_target[i]].gongma == 0 and #char_juese[possible_target[i]].fangma == 0 and #char_juese[possible_target[i]].panding ~= 0 and (char_juese[ID].shenfen == "主公" or char_juese[ID].shenfen == "忠臣") and char_juese[possible_target[i]].isantigovernment ~= false then
				table.remove(possible_target,i)
			elseif #char_juese[possible_target[i]].shoupai == 0 and #char_juese[possible_target[i]].wuqi == 0 and #char_juese[possible_target[i]].fangju == 0 and #char_juese[possible_target[i]].gongma == 0 and #char_juese[possible_target[i]].fangma == 0 and #char_juese[possible_target[i]].panding ~= 0 and char_juese[ID].shenfen == "反贼" and char_juese[possible_target[i]].isantigovernment ~= true then
				table.remove(possible_target,i)
			end
		end
		--剔除谦逊
		for i=#possible_target,1,-1 do
			if char_juese[possible_target[i]].skill["谦逊"] == "available" then
				table.remove(possible_target,i)
			end
		end
	elseif card_treated == "过河拆桥" then
		--剔除没有牌的目标
		for i=#possible_target,1,-1 do
			if #char_juese[possible_target[i]].shoupai == 0 and #char_juese[possible_target[i]].wuqi == 0 and #char_juese[possible_target[i]].fangju == 0 and #char_juese[possible_target[i]].gongma == 0 and #char_juese[possible_target[i]].fangma == 0 and #char_juese[possible_target[i]].panding == 0 then
				table.remove(possible_target,i)
			end
		end
		--剔除只有判定区有牌的对手
		for i=#possible_target,1,-1 do
			if #char_juese[possible_target[i]].shoupai == 0 and #char_juese[possible_target[i]].wuqi == 0 and #char_juese[possible_target[i]].fangju == 0 and #char_juese[possible_target[i]].gongma == 0 and #char_juese[possible_target[i]].fangma == 0 and #char_juese[possible_target[i]].panding ~= 0 and (char_juese[ID].shenfen == "主公" or char_juese[ID].shenfen == "忠臣") and char_juese[possible_target[i]].isantigovernment ~= false then
				table.remove(possible_target,i)
			elseif #char_juese[possible_target[i]].shoupai == 0 and #char_juese[possible_target[i]].wuqi == 0 and #char_juese[possible_target[i]].fangju == 0 and #char_juese[possible_target[i]].gongma == 0 and #char_juese[possible_target[i]].fangma == 0 and #char_juese[possible_target[i]].panding ~= 0 and char_juese[ID].shenfen == "反贼" and char_juese[possible_target[i]].isantigovernment ~= true then
				table.remove(possible_target,i)
			end
		end
	elseif card_treated == "决斗" then
		--剔除空城
		for i=#possible_target,1,-1 do
			if char_juese[possible_target[i]].skill["空城"] == "available" and #char_juese[possible_target[i]].shoupai == 0 then
				table.remove(possible_target,i)
			end
		end
	elseif card_treated == "火攻" then
		--剔除没有手牌的目标
		for i=#possible_target,1,-1 do
			if #char_juese[possible_target[i]].shoupai == 0 then
				table.remove(possible_target,i)
			end
		end
	elseif card_treated == "借刀杀人" then
		--剔除没有武器的目标
		for i=#possible_target,1,-1 do
			if #char_juese[possible_target[i]].wuqi == 0 then
				table.remove(possible_target,i)
			end
		end
		--剔除够不到人的角色
		for i=#possible_target,1,-1 do
			local jiedao_target = ai_judge_in_range(i)
			if #jiedao_target == 0 then
				table.remove(possible_target,i)
			end
		end
	elseif card_treated == "兵粮寸断" then
		--剔除距离不够的目标
		for i=#possible_target,1,-1 do
			if ai_judge_distance(ID,possible_target[i],2) == true and char_juese[ID].skill["断粮"] == "available" then
				
			elseif ai_judge_distance(ID,possible_target[i],1) == false and char_juese[ID].skill["奇才"] ~= "available" then
				table.remove(possible_target,i)
			end
		end
		--剔除判定区里已有同名牌的目标
		for i=#possible_target,1,-1 do
			for _, v in ipairs(char_juese[possible_target[i]].panding) do
				if v[1] == "兵粮寸断" then
					table.remove(possible_target,i)
				end
			end
		end
	elseif card_treated == "乐不思蜀" then
		--剔除谦逊
		for i=#possible_target,1,-1 do
			if char_juese[possible_target[i]].skill["谦逊"] == "available" then
				table.remove(possible_target,i)
			end
		end
		--剔除判定区里已有同名牌的目标
		for i=#possible_target,1,-1 do
			for _, v in ipairs(char_juese[possible_target[i]].panding) do
				if v[1] == "乐不思蜀" then
					table.remove(possible_target,i)
				end
			end
		end
	elseif card_treated == "铁锁连环" then
		--剔除已经横置的对手
		for i=#possible_target,1,-1 do
			if char_juese[possible_target[i]].hengzhi == true and (char_juese[ID].shenfen == "主公" or char_juese[ID].shenfen == "忠臣") and char_juese[possible_target[i]].isantigovernment ~= false then
				table.remove(possible_target,i)
			elseif char_juese[possible_target[i]].hengzhi == true and char_juese[ID].shenfen == "反贼" and char_juese[possible_target[i]].isantigovernment ~= true then
				table.remove(possible_target,i)
			end
		end
	elseif string.find(card_treated,"杀") ~= nil then
		--剔除距离不够的目标
		for i=#possible_target,1,-1 do
			local _,inrange = ai_judge_distance(ID,possible_target[i],1)
			if inrange == false then
				table.remove(possible_target,i)
			end
		end
		--剔除空城
		for i=#possible_target,1,-1 do
			if char_juese[possible_target[i]].skill["空城"] == "available" and #char_juese[possible_target[i]].shoupai == 0 then
				table.remove(possible_target,i)
			end
		end
		local shuxing = false
		if card_treated == "火杀" or card_treated=="雷杀" then
			shuxing = true
		end
		--剔除牌多的雷击
		for i=#possible_target,1,-1 do
			if char_juese[possible_target[i]].skill["雷击"] == "available" and (#char_juese[possible_target[i]].shoupai >= 3 or char_juese[possible_target[i]].fangju[1] == "藤甲") then
				table.remove(possible_target,i)
			end
		end
		local shuxing = false
		if card_treated == "火杀" or card_treated=="雷杀" then
			shuxing = true
		end
		--剔除普杀藤甲
		for i=#possible_target,1,-1 do
			if char_juese[possible_target[i]].fangju[1] == "藤甲" and shuxing == false and char_juese[ID].wuqi[1] ~= "朱雀扇" and char_juese[ID].wuqi[1] ~= "青钢剑" then
				table.remove(possible_target,i)
			end
		end
		--剔除黑杀仁王、于禁毅重
		for i=#possible_target,1,-1 do
			if (char_juese[possible_target[i]].fangju[1] == "仁王盾" and ai_judge_cardinfo(ID,cards) == "黑色" and char_juese[ID].wuqi[1] ~= "青钢剑") or (#char_juese[possible_target[i]].fangju == 0 and ai_judge_cardinfo(ID,cards) == "黑色" and char_juese[possible_target[i]].skill["毅重"] == "available") then
				table.remove(possible_target,i)
			end
		end
		--剔除能流离给队友的角色
		for i=#possible_target,1,-1 do
			if char_juese[possible_target[i]].skill["流离"] == "available" then
				local liuli_target = ai_judge_in_range(i)
				if (#char_juese[possible_target[i]].shoupai ~= 0 or #char_juese[possible_target[i]].fangju ~= 0 or #char_juese[possible_target[i]].fangma ~= 0) and #liuli_target > 0 and (#liuli_target ~= 1 or liuli_target[1] ~= ID) then
					for j=1,#liuli_target do
						if ((char_juese[ID].shenfen == "主公" or char_juese[ID].shenfen == "忠臣") and char_juese[liuli_target[j]].isantigovernment == false) or (char_juese[ID].shenfen == "反贼" and char_juese[liuli_target[j]].isantigovernment == true) then
							table.remove(possible_target,i)
							break
						end
					end
				else
					if #char_juese[possible_target[i]].gongma ~= 0 then
						local liuli_target = ai_judge_in_range(i,nil,true)
						if  #liuli_target > 0 and (#liuli_target ~= 1 or liuli_target[1] ~= ID) then
							for j=1,#liuli_target do
								if ((char_juese[ID].shenfen == "主公" or char_juese[ID].shenfen == "忠臣") and char_juese[liuli_target[j]].isantigovernment == false) or (char_juese[ID].shenfen == "反贼" and char_juese[liuli_target[j]].isantigovernment == true) then
									table.remove(possible_target,i)
									break
								end
							end
						end
					elseif #char_juese[possible_target[i]].wuqi ~= 0 then
						local liuli_target = ai_judge_in_range(i,true)
						if  #liuli_target > 0 and (#liuli_target ~= 1 or liuli_target[1] ~= ID) then
							for j=1,#liuli_target do
								if ((char_juese[ID].shenfen == "主公" or char_juese[ID].shenfen == "忠臣") and char_juese[liuli_target[j]].isantigovernment == false) or (char_juese[ID].shenfen == "反贼" and char_juese[liuli_target[j]].isantigovernment == true) then
									table.remove(possible_target,i)
									break
								end
							end
						end
					end
				end
			end
		end
	end
	local judge_time = 1
	while #possible_target > target_number and judge_time <= 10 do
		local delete_target = math.random(#possible_target)
		if (char_juese[ID].shenfen == "主公" or char_juese[ID].shenfen == "忠臣") and char_juese[delete_target].isblackjack == true then
			local znz = true
			for i = 1, 5 do
				if char_juese[i].shenfen == "反贼" and char_juese[i].siwang == false then
					znz = false
				end
			end
			if znz then
				
			else
				if ai_judge_random_percent(60) == 1 then
					table.remove(possible_target,delete_target)
				end
			end
		elseif char_juese[ID].shenfen == "反贼" and char_juese[ID].shenfen == "主公" then
			
		else
			table.remove(possible_target,delete_target)
		end
		judge_time = judge_time + 1
	end
	while #possible_target > target_number do
		table.remove(possible_target,math.random(#possible_target))
	end
	return possible_target
end

--  AI计算AOE收益  --
function ai_judge_AOE(ID,card)
	local gain, bonus = -1, 1
	for i = 1, 5 do
		if char_juese[i].siwang == true then
			
		elseif i == ID and card == "桃园结义" or card == "五谷丰登" then
			if card == "桃园结义" and char_juese[i].tili < char_juese[i].tili_max then
				gain = gain + 2
			elseif card == "五谷丰登" then
				gain = gain + 1
			end
		elseif i == ID then
			
		elseif char_juese[ID].shenfen == "主公" or char_juese[ID].shenfen == "忠臣" then
			if char_juese[i].shenfen == "主公" or char_juese[i].isantigovernment == false then 
				if card == "桃园结义" and char_juese[i].tili < char_juese[i].tili_max then
					gain = gain + 2
				elseif card == "五谷丰登" then
					gain = gain + 1
				elseif card == "万箭齐发" then
					if char_juese[i].fangju[1] == "藤甲" then
						
					elseif char_juese[i].fangju[1] == "八卦阵" or (char_juese[i].skill["八阵"] == "available" and #char_juese[i].fangju == 0) then
						if char_juese[i].shenfen == "主公" and char_juese[i].tili < 2 then
							gain = gain - 3 / (#char_juese[i].shoupai + 1)
						else
							gain = gain - 1 / (#char_juese[i].shoupai + 1)
						end
					elseif (char_juese[i].shenfen == "主公" and char_juese[i].tili < 3) or (char_juese[ID].shenfen == "主公" and char_juese[i].tili == 1) then
						bonus = 0
					else
						gain = gain - 2 / #char_juese[i].shoupai
					end
				elseif card == "南蛮入侵" then
					if char_juese[i].fangju[1] == "藤甲" then
						
					elseif char_juese[i].skill["祸首"] == "available" then
						
					elseif char_juese[i].skill["帷幕"] == "available" then
						
					elseif (char_juese[i].shenfen == "主公" and char_juese[i].tili < 3) or (char_juese[ID].shenfen == "主公" and char_juese[i].tili == 1) then
						bonus = 0
					else
						gain = gain - 1.5 / #char_juese[i].shoupai
					end
				end
			else
				if card == "桃园结义" and char_juese[i].tili < char_juese[i].tili_max then
					gain = gain - 2
				elseif card == "五谷丰登" then
					gain = gain - 1
				elseif card == "万箭齐发" then
					if char_juese[i].fangju[1] == "藤甲" or (char_juese[i].skill["八阵"] == "available" and #char_juese[i].fangju == 0) then
						
					elseif char_juese[i].fangju[1] == "八卦阵" then
						gain = gain + 1 / #char_juese[i].shoupai
					else
						gain = gain + 2 / #char_juese[i].shoupai
					end
				elseif card == "南蛮入侵" then
					if char_juese[i].fangju[1] == "藤甲" then
						
					elseif char_juese[i].skill["祸首"] == "available" then
						
					elseif char_juese[i].skill["帷幕"] == "available" then
						
					else
						gain = gain + 1.5 / #char_juese[i].shoupai
					end
				end
			end
		elseif char_juese[ID].shenfen == "反贼" then
			if char_juese[i].isantigovernment == true and char_juese[i].isblackjack ~= true then 
				if card == "桃园结义" and char_juese[i].tili < char_juese[i].tili_max then
					gain = gain + 2
				elseif card == "五谷丰登" then
					gain = gain + 1
				elseif card == "万箭齐发" then
					if char_juese[i].fangju[1] == "藤甲" then
						
					elseif char_juese[i].fangju[1] == "八卦阵" or (char_juese[i].skill["八阵"] == "available" and #char_juese[i].fangju == 0) then
						gain = gain - 1 / (#char_juese[i].shoupai + 1)
					else
						gain = gain - 2 / (#char_juese[i].shoupai + 1)
					end
				elseif card == "南蛮入侵" then
					if char_juese[i].fangju[1] == "藤甲" then
						
					elseif char_juese[i].skill["祸首"] == "available" then
						
					elseif char_juese[i].skill["帷幕"] == "available" then
						
					else
						gain = gain - 1.5 / (#char_juese[i].shoupai + 1)
					end
				end
			else
				if card == "桃园结义" and char_juese[i].tili < char_juese[i].tili_max then
					gain = gain - 2
				elseif card == "五谷丰登" then
					gain = gain - 1
				elseif card == "万箭齐发" then
					if char_juese[i].fangju[1] == "藤甲" then
						
					elseif char_juese[i].fangju[1] == "八卦阵" or (char_juese[i].skill["八阵"] == "available" and #char_juese[i].fangju == 0) then
						if char_juese[i].shenfen == "主公" and char_juese[i].tili < 2 then
							gain = gain + 3 / (#char_juese[i].shoupai + 1)
						else
							gain = gain + 1 / (#char_juese[i].shoupai + 1)
						end
					elseif char_juese[i].shenfen == "主公" and char_juese[i].tili < 3 then
						gain = gain + 3
					else
						gain = gain + 2 / (#char_juese[i].shoupai + 1)
					end
				elseif card == "南蛮入侵" then
					if char_juese[i].fangju[1] == "藤甲" then
						
					elseif char_juese[i].skill["祸首"] == "available" then
						
					elseif char_juese[i].skill["帷幕"] == "available" then
						
					elseif char_juese[i].shenfen == "主公" and char_juese[i].tili < 3 then
						gain = gain + 3
					else
						gain = gain + 1.5 / (#char_juese[i].shoupai)
					end
				end
			end
		elseif char_juese[ID].shenfen == "内奸" then
			local pk = true
			for i = 1, 5 do
				if char_juese[i].shenfen ~= "主公" and char_juese[i].shenfen ~= "内奸" and char_juese[i].siwang == false then
					pk = false
				end
			end
			if card == "桃园结义" and char_juese[ID].tili < char_juese[ID].tili_max then
				gain = 1
			elseif card == "五谷丰登" then
				gain = 0
			elseif card == "万箭齐发" then
				if char_juese[i].shenfen == "主公" and char_juese[i].fangju[1] ~= "藤甲" and (char_juese[i].skill["八阵"] ~= "available" or #char_juese[i].fangju ~= 0) and char_juese[i].tili <= 2 and pk == false then
					bonus = 0
				else
					gain = 2
				end
			elseif card == "南蛮入侵" then
				if char_juese[i].shenfen == "主公" and char_juese[i].fangju[1] ~= "藤甲" and char_juese[i].skill["帷幕"] ~= "available" and char_juese[i].skill["祸首"] ~= "available" and char_juese[i].tili <= 2 and pk == false then
					bonus = 0
				else
					gain = 2
				end
			end
		end
	end
	return bonus * gain
end

--  AI随机选择系数  --
--  以percent的概率返回1  --
function ai_judge_random_percent(percent)
	if math.random() < percent / 100 then
		return 1
	else
		return 0
	end
end

--  AI根据条件查找牌 --
function ai_card_search(ID, kind, required, alt_shoupai)
	local shoupai = char_juese[ID].shoupai
	if alt_shoupai ~= nil then
		shoupai = alt_shoupai
	end
	
	local card_searched = {}
	if kind == "基本" then
		for i = #shoupai,1,-1 do
			if shoupai[i][1] == "杀" or shoupai[i][1] == "火杀" or shoupai[i][1] == "雷杀" or shoupai[i][1] == "闪" or shoupai[i][1] == "桃" or shoupai[i][1] == "酒" then
				table.insert(card_searched,i)
			end
		end
	elseif kind == "锦囊" then
		for i = #shoupai,1,-1 do
			if shoupai[i][1] == "兵粮寸断" or shoupai[i][1] == "过河拆桥" or shoupai[i][1] == "火攻" or shoupai[i][1] == "借刀杀人" or shoupai[i][1] == "决斗" or shoupai[i][1] == "乐不思蜀" or shoupai[i][1] == "南蛮入侵" or shoupai[i][1] == "闪电" or shoupai[i][1] == "顺手牵羊" or shoupai[i][1] == "乐不思蜀" or shoupai[i][1] == "桃园结义" or shoupai[i][1] == "铁锁连环" or shoupai[i][1] == "万箭齐发" or shoupai[i][1] == "五谷丰登" or shoupai[i][1] == "无懈可击" or shoupai[i][1] == "无中生有" then
				table.insert(card_searched,i)
			end
		end
	elseif kind == "非无懈锦囊" then
		for i = #shoupai,1,-1 do
			if shoupai[i][1] == "兵粮寸断" or shoupai[i][1] == "过河拆桥" or shoupai[i][1] == "火攻" or shoupai[i][1] == "借刀杀人" or shoupai[i][1] == "决斗" or shoupai[i][1] == "乐不思蜀" or shoupai[i][1] == "南蛮入侵" or shoupai[i][1] == "闪电" or shoupai[i][1] == "顺手牵羊" or shoupai[i][1] == "乐不思蜀" or shoupai[i][1] == "桃园结义" or shoupai[i][1] == "铁锁连环" or shoupai[i][1] == "万箭齐发" or shoupai[i][1] == "五谷丰登" or shoupai[i][1] == "无中生有" then
				table.insert(card_searched,i)
			end
		end
	elseif kind == "非延时锦囊" then
		for i = #shoupai,1,-1 do
			if shoupai[i][1] == "过河拆桥" or shoupai[i][1] == "火攻" or shoupai[i][1] == "借刀杀人" or shoupai[i][1] == "决斗" or shoupai[i][1] == "乐不思蜀" or shoupai[i][1] == "南蛮入侵" or shoupai[i][1] == "顺手牵羊" or shoupai[i][1] == "桃园结义" or shoupai[i][1] == "铁锁连环" or shoupai[i][1] == "万箭齐发" or shoupai[i][1] == "五谷丰登" or shoupai[i][1] == "无懈可击" or shoupai[i][1] == "无中生有" then
				table.insert(card_searched,i)
			end
		end
	elseif kind == "装备" then
		for i = #shoupai,1,-1 do
			if shoupai[i][1] == "八卦阵" or shoupai[i][1] == "赤兔" or shoupai[i][1] == "雌雄剑" or shoupai[i][1] == "大宛" or shoupai[i][1] == "的卢" or shoupai[i][1] == "方天戟" or shoupai[i][1] == "贯石斧" or shoupai[i][1] == "古锭刀" or shoupai[i][1] == "寒冰剑" or shoupai[i][1] == "骅骝" or shoupai[i][1] == "绝影" or shoupai[i][1] == "诸葛弩" or shoupai[i][1] == "麒麟弓" or shoupai[i][1] == "青钢剑" or shoupai[i][1] == "仁王盾" or shoupai[i][1] == "白银狮" or shoupai[i][1] == "藤甲" or shoupai[i][1] == "青龙刀" or shoupai[i][1] == "朱雀扇" or shoupai[i][1] == "丈八矛" or shoupai[i][1] == "爪黄飞电" or shoupai[i][1] == "紫骍" then
				table.insert(card_searched,i)
			end
		end
	elseif kind == "武器" then
		for i = #shoupai,1,-1 do
			if shoupai[i][1] == "雌雄剑" or shoupai[i][1] == "方天戟" or shoupai[i][1] == "贯石斧" or shoupai[i][1] == "古锭刀" or shoupai[i][1] == "寒冰剑" or shoupai[i][1] == "诸葛弩" or shoupai[i][1] == "麒麟弓" or shoupai[i][1] == "青钢剑" or shoupai[i][1] == "青龙刀" or shoupai[i][1] == "朱雀扇" or shoupai[i][1] == "丈八矛" then
				table.insert(card_searched,i)
			end
		end
	elseif kind == "防具" then
		for i = #shoupai,1,-1 do
			if shoupai[i][1] == "八卦阵" or shoupai[i][1] == "白银狮" or shoupai[i][1] == "藤甲" or shoupai[i][1] == "仁王盾" then
				table.insert(card_searched,i)
			end
		end	
	elseif kind == "+1马" then
		for i = #shoupai,1,-1 do
			if shoupai[i][1] == "的卢" or shoupai[i][1] == "爪黄飞电" or shoupai[i][1] == "骅骝" or shoupai[i][1] == "绝影" then
				table.insert(card_searched,i)
			end
		end	
	elseif kind == "-1马" then
		for i = #shoupai,1,-1 do
			if shoupai[i][1] == "紫骍" or shoupai[i][1] == "赤兔" or shoupai[i][1] == "大宛" then
				table.insert(card_searched,i)
			end
		end	
	elseif kind == "红色" then
		for i = #shoupai,1,-1 do
			local ys,hs,ds = ai_judge_cardinfo(ID,{shoupai[i]})
			if ys == "红色" then
				table.insert(card_searched,i)
			end
		end	
	elseif kind == "黑色" then
		for i = #shoupai,1,-1 do
			local ys,hs,ds = ai_judge_cardinfo(ID,{shoupai[i]})
			if ys == "黑色" then
				table.insert(card_searched,i)
			end
		end	
	elseif kind == "红桃" then
		for i = #shoupai,1,-1 do
			local ys,hs,ds = ai_judge_cardinfo(ID,{shoupai[i]})
			if hs == "红桃" then
				table.insert(card_searched,i)
			end
		end	
	elseif kind == "方块" then
		for i = #shoupai,1,-1 do
			local ys,hs,ds = ai_judge_cardinfo(ID,{shoupai[i]})
			if hs == "方块" then
				table.insert(card_searched,i)
			end
		end	
	elseif kind == "黑桃" then
		for i = #shoupai,1,-1 do
			local ys,hs,ds = ai_judge_cardinfo(ID,{shoupai[i]})
			if hs == "黑桃" then
				table.insert(card_searched,i)
			end
		end	
	elseif kind == "草花" then
		for i = #shoupai,1,-1 do
			local ys,hs,ds = ai_judge_cardinfo(ID,{shoupai[i]})
			if hs == "草花" then
				table.insert(card_searched,i)
			end
		end	
	elseif kind == "随意" then
		for i = #shoupai,1,-1 do
			table.insert(card_searched,i)
		end	
	elseif tonumber(kind) ~= nil then
		if tonumber(kind) > 0 then
			for i = #shoupai,1,-1 do
				local ys,hs,ds = ai_judge_cardinfo(ID,{shoupai[i]})
				if ds >= tonumber(kind) then
					table.insert(card_searched,i)
				end
			end	
		elseif tonumber(kind) < 0 then
			for i = #shoupai,1,-1 do
				local ys,hs,ds = ai_judge_cardinfo(ID,{shoupai[i]})
				if ds <= math.abs(tonumber(kind)) then
					table.insert(card_searched,i)
				end
			end
		end	
	elseif kind == "杀" then
		for i = #shoupai,1,-1 do
			if shoupai[i][1] == "杀" or shoupai[i][1] == "火杀" or shoupai[i][1] == "雷杀" then
				table.insert(card_searched,i)
			end
		end
	elseif kind == "普通杀" then
		for i = #shoupai,1,-1 do
			if shoupai[i][1] == "杀" then
				table.insert(card_searched,i)
			end
		end
	else
		for i = #shoupai,1,-1 do
			if shoupai[i][1] == kind then
				table.insert(card_searched,i)
			end
		end
	end
	while #card_searched > required do
		table.remove(card_searched,math.random(1,#card_searched))
	end
	return card_searched
end

--  区域内牌数统计 --
function ai_card_stat(ID, discard_arm, discard_panding)
	local card = 0
	if discard_arm then
		card = ai_arm_stat(ID)
	end
	if discard_panding then
		card = card + #char_juese[ID].panding
	end
	card = card + table.maxn(char_juese[ID].shoupai)
	return card
end

function ai_arm_stat(ID)
	local card = 0
	if #char_juese[ID].wuqi ~= 0 then
		card = card + 1
	end
	if #char_juese[ID].fangju ~= 0 then
		card = card + 1
	end
	if #char_juese[ID].gongma ~= 0 then
		card = card + 1
	end
	if #char_juese[ID].fangma ~= 0 then
		card = card + 1
	end
	return card
end

--  AI主动弃置牌 --
--  返回值：从小到大排列的应弃牌索引表  --
function ai_judge_withdraw(ID, required, discard_arm)
	local qipai_id = {}
	local qi_zhuangbei_id = {0, 0, 0, 0}

	local shoupai_copy = table.copy(char_juese[ID].shoupai)
	local i
	
	for i = 1, table.maxn(shoupai_copy) do
		shoupai_copy[i][4] = i
	end

	if ai_card_stat(ID, discard_arm) < required then
		for i = 1, table.maxn(shoupai_copy) do
			table.insert(qipai_id, i)
		end

		if discard_arm then
			if #char_juese[ID].wuqi ~= 0 then
				qi_zhuangbei_id[1] = 1
			end
			if #char_juese[ID].fangju ~= 0 then
				qi_zhuangbei_id[2] = 1
			end
			if #char_juese[ID].gongma ~= 0 then
				qi_zhuangbei_id[3] = 1
			end
			if #char_juese[ID].fangma ~= 0 then
				qi_zhuangbei_id[4] = 1
			end
		end
	else
		local withdraw_needed = required
		while withdraw_needed >= 0 do
			local withdrawed = ai_card_search(ID, "非无懈锦囊", withdraw_needed, shoupai_copy)
			for i = 1, #withdrawed do
				table.insert(qipai_id, shoupai_copy[withdrawed[i]][4])
				shoupai_copy[withdrawed[i]][4] = nil
				table.remove(shoupai_copy, withdrawed[i])
				withdraw_needed = withdraw_needed - 1
			end
			if withdraw_needed <= 0 then
				break
			end

			local withdrawed = ai_card_search(ID, "装备", withdraw_needed, shoupai_copy)
			for i = 1, #withdrawed do
				table.insert(qipai_id, shoupai_copy[withdrawed[i]][4])
				shoupai_copy[withdrawed[i]][4] = nil
				table.remove(shoupai_copy, withdrawed[i])
				withdraw_needed = withdraw_needed - 1
			end
			if withdraw_needed <= 0 then
				break
			end

			local withdrawed = ai_card_search(ID, "普通杀", withdraw_needed, shoupai_copy)
			for i = 1, #withdrawed do
				table.insert(qipai_id, shoupai_copy[withdrawed[i]][4])
				shoupai_copy[withdrawed[i]][4] = nil
				table.remove(shoupai_copy, withdrawed[i])
				withdraw_needed = withdraw_needed - 1
			end
			if withdraw_needed <= 0 then
				break
			end

			local withdrawed = ai_card_search(ID, "雷杀", withdraw_needed, shoupai_copy)
			for i = 1, #withdrawed do
				table.insert(qipai_id, shoupai_copy[withdrawed[i]][4])
				shoupai_copy[withdrawed[i]][4] = nil
				table.remove(shoupai_copy, withdrawed[i])
				withdraw_needed = withdraw_needed - 1
			end
			if withdraw_needed <= 0 then
				break
			end

			local withdrawed = ai_card_search(ID, "火杀", withdraw_needed, shoupai_copy)
			for i = 1, #withdrawed do
				table.insert(qipai_id, shoupai_copy[withdrawed[i]][4])
				shoupai_copy[withdrawed[i]][4] = nil
				table.remove(shoupai_copy, withdrawed[i])
				withdraw_needed = withdraw_needed - 1
			end
			if withdraw_needed <= 0 then
				break
			end

			local withdrawed = ai_card_search(ID, "酒", withdraw_needed, shoupai_copy)
			for i = 1, #withdrawed do
				table.insert(qipai_id, shoupai_copy[withdrawed[i]][4])
				shoupai_copy[withdrawed[i]][4] = nil
				table.remove(shoupai_copy, withdrawed[i])
				withdraw_needed = withdraw_needed - 1
			end
			if withdraw_needed <= 0 then
				break
			end

			local withdrawed = ai_card_search(ID, "无懈可击", withdraw_needed, shoupai_copy)
			for i = 1, #withdrawed do
				table.insert(qipai_id, shoupai_copy[withdrawed[i]][4])
				shoupai_copy[withdrawed[i]][4] = nil
				table.remove(shoupai_copy, withdrawed[i])
				withdraw_needed = withdraw_needed - 1
			end
			if withdraw_needed <= 0 then
				break
			end

			local withdrawed = ai_card_search(ID, "闪", withdraw_needed, shoupai_copy)
			for i = 1, #withdrawed do
				table.insert(qipai_id, shoupai_copy[withdrawed[i]][4])
				shoupai_copy[withdrawed[i]][4] = nil
				table.remove(shoupai_copy, withdrawed[i])
				withdraw_needed = withdraw_needed - 1
			end
			if withdraw_needed <= 0 then
				break
			end

			local withdrawed = ai_card_search(ID, "桃", withdraw_needed, shoupai_copy)
			for i = 1, #withdrawed do
				table.insert(qipai_id, shoupai_copy[withdrawed[i]][4])
				shoupai_copy[withdrawed[i]][4] = nil
				table.remove(shoupai_copy, withdrawed[i])
				withdraw_needed = withdraw_needed - 1
			end
			if withdraw_needed <= 0 then
				break
			end

			local withdrawed = ai_card_search(ID, "随便", withdraw_needed, shoupai_copy)
			for i = 1, #withdrawed do
				table.insert(qipai_id, shoupai_copy[withdrawed[i]][4])
				shoupai_copy[withdrawed[i]][4] = nil
				table.remove(shoupai_copy, withdrawed[i])
				withdraw_needed = withdraw_needed - 1
			end
			if withdraw_needed <= 0 then
				break
			end

			if discard_arm then
				if #char_juese[ID].gongma ~= 0 and qi_zhuangbei_id[3] ~= 1 then
					qi_zhuangbei_id[3] = 1
					withdraw_needed = withdraw_needed - 1
				end
				if withdraw_needed <= 0 then
					break
				end

				if #char_juese[ID].wuqi ~= 0 and qi_zhuangbei_id[1] ~= 1 then
					qi_zhuangbei_id[1] = 1
					withdraw_needed = withdraw_needed - 1
				end
				if withdraw_needed <= 0 then
					break
				end

				if #char_juese[ID].fangma ~= 0 and qi_zhuangbei_id[4] ~= 1 then
					qi_zhuangbei_id[4] = 1
					withdraw_needed = withdraw_needed - 1
				end
				if withdraw_needed <= 0 then
					break
				end

				if #char_juese[ID].fangju ~= 0 and qi_zhuangbei_id[2] ~= 1 then
					qi_zhuangbei_id[2] = 1
					withdraw_needed = withdraw_needed - 1
				end
				if withdraw_needed <= 0 then
					break
				end
			end
		end
	end

	table.sort(qipai_id)
	return qipai_id, qi_zhuangbei_id
end

--  AI弃牌 (执行) --
function ai_withdraw(ID, qipai_id, qi_zhuangbei_id, in_queue)
	for i = #qipai_id, 1, -1 do
		if in_queue then
			add_funcptr(_qipai_sub2, {ID, qipai_id[i]})
		else
			_qipai_sub2({ID, qipai_id[i]})
		end
	end

	if qi_zhuangbei_id[1] == 1 then
		if in_queue then
			add_funcptr(_qipai_sub4, ID)
		else
			_qipai_sub4(ID)
		end
	end

	if qi_zhuangbei_id[2] == 1 then
		if in_queue then
			add_funcptr(_qipai_sub5, ID)
		else
			_qipai_sub5(ID)
		end
	end

	if qi_zhuangbei_id[3] == 1 then
		if in_queue then
			add_funcptr(_qipai_sub6, ID)
		else
			_qipai_sub6(ID)
		end
	end

	if qi_zhuangbei_id[4] == 1 then
		if in_queue then
			add_funcptr(_qipai_sub7, ID)
		else
			_qipai_sub7(ID)
		end
	end
end

--  AI弃置/获得其他角色牌 --
function ai_judge_withdraw_other(ID,ID_s,is_zhuangbei_included,is_panding_included,is_gain,is_visible)
	local is_enemy = true
	if char_juese[ID_s].shenfen == "主公" or char_juese[ID_s].shenfen == "忠臣" then
		if char_juese[ID].shenfen == "主公" or char_juese[ID].isantigovernment == false then 
			is_enemy = false
		end
	elseif char_juese[ID_s].shenfen == "反贼" then
		if char_juese[ID].isantigovernment == true and char_juese[ID].isblackjack ~= true then 
			is_enemy = false
		end
	end
	if is_enemy then
		if is_zhuangbei_included == true and (#char_juese[ID].gongma ~= 0 or #char_juese[ID].wuqi ~= 0 or #char_juese[ID].fangma ~= 0 or #char_juese[ID].fangju ~= 0) then
			if #char_juese[ID].fangju ~= 0 then
				if is_gain then
					_napai_sub5(ID,ID_s,nil,true)
				else
					_qipai_sub5(ID,nil,true)
				end
			elseif #char_juese[ID].fangma ~= 0 then
				if is_gain then
					_napai_sub7(ID,ID_s,nil,true)
				else
					_qipai_sub7(ID,nil,true)
				end
			elseif #char_juese[ID].wuqi ~= 0 then
				if is_gain then
					_napai_sub4(ID,ID_s,nil,true)
				else
					_qipai_sub4(ID,nil,true)
				end
			elseif #char_juese[ID].gongma ~= 0 then
				if is_gain then
					_napai_sub6(ID,ID_s,nil,true)
				else
					_qipai_sub6(ID,nil,true)
				end
			end
		else
			if #char_juese[ID].shoupai ~= 0 then
				if is_gain then
					_napai_sub2({ID,ID_s,math.random(#char_juese[ID].shoupai),true})
				else
					_qipai_sub2({ID,math.random(#char_juese[ID].shoupai),true})
				end
			else
				if is_panding_included == true and #char_juese[ID].panding ~= 0 then
					for i = 1,#char_juese[ID].panding do
						if char_juese[ID].panding[i][1] == "闪电" then
							if is_gain then
								_napai_sub3({ID,ID_s,i,true})
								return
							else
								_qipai_sub3({ID,i,true})
								return
							end
						end
					end
					for i = 1,#char_juese[ID].panding do
						if char_juese[ID].panding[i][1] == "兵粮寸断" then
							if is_gain then
								_napai_sub3({ID,ID_s,i,true})
								return
							else
								_qipai_sub3({ID,i,true})
								return
							end
						end
					end
					if is_gain then
						_napai_sub3({ID,ID_s,1,true})
					else
						_qipai_sub3({ID,1,true})
					end
				else
					return
				end
			end
		end
	else
		if is_panding_included == true and #char_juese[ID].panding ~= 0 then
			for i = 1,#char_juese[ID].panding do
				if char_juese[ID].panding[i][1] == "乐不思蜀" then
					if is_gain then
						_napai_sub3({ID,ID_s,i,true})
					else
						_qipai_sub3({ID,i,true})
					end
				end
			end
			for i = 1,#char_juese[ID].panding do
				if char_juese[ID].panding[i][1] == "兵粮寸断" then
					if is_gain then
						_napai_sub3({ID,ID_s,i,true})
					else
						_qipai_sub3({ID,i,true})
					end
				end
			end
			if is_gain then
				_napai_sub3({ID,ID_s,1,true})
			else
				_qipai_sub3({ID,1,true})
			end
		else
			if char_juese[ID].fangju[1] == "白银狮" and char_juese[ID].tili < char_juese[ID].tili_max then
				if is_gain then
					_napai_sub5(ID,ID_s,nil,true)
				else
					_qipai_sub5(ID,nil,true)
				end
			elseif #char_juese[ID].shoupai ~= 0 then
				if is_gain then
					_napai_sub2({ID,ID_s,math.random(#char_juese[ID].shoupai),true})
				else
					_qipai_sub2({ID,math.random(#char_juese[ID].shoupai),true})
				end
			elseif is_zhuangbei_included == true then
				if #char_juese[ID].gongma ~= 0 then
					if is_gain then
						_napai_sub6(ID,ID_s,nil,true)
					else
						_qipai_sub6(ID,nil,true)
					end
				elseif #char_juese[ID].wuqi ~= 0 then
					if is_gain then
						_napai_sub4(ID,ID_s,nil,true)
					else
						_qipai_sub4(ID,nil,true)
					end
				elseif #char_juese[ID].fangma ~= 0 then
					if is_gain then
						_napai_sub7(ID,ID_s,nil,true)
					else
						_qipai_sub7(ID,nil,true)
					end
				elseif #char_juese[ID].fangju ~= 0 then
					if is_gain then
						_napai_sub5(ID,ID_s,nil,true)
					else
						_qipai_sub5(ID,nil,true)
					end
				end
			else
				return
			end
		end
	end
end

--  AI与其他角色进行拼点 --
function ai_pindian_judge(ID,is_enemy)
	local card_pindian = 1
	local card_pindian_dianshu = 0
	if char_juese[ID].shoupai[1][3] == "A" then
		card_pindian_dianshu = 1
	elseif char_juese[ID].shoupai[1][3] == "J" then
		card_pindian_dianshu = 11
	elseif char_juese[ID].shoupai[1][3] == "Q" then
	card_pindian_dianshu = 12
	elseif char_juese[ID].shoupai[1][3] == "K" then
		card_pindian_dianshu = 13
	else
		card_pindian_dianshu = tonumber(char_juese[ID].shoupai[1][3])
	end
	for i = 1, #char_juese[ID].shoupai do
		local j = 0
		if char_juese[ID].shoupai[i][3] == "A" then
			j = 1
		elseif char_juese[ID].shoupai[i][3] == "J" then
			j = 11
		elseif char_juese[ID].shoupai[i][3] == "Q" then
				j = 12
		elseif char_juese[ID].shoupai[i][3] == "K" then
			j = 13
		else
			j = tonumber(char_juese[ID].shoupai[i][3])
		end
		if card_pindian_dianshu < j and is_enemy then
			card_pindian, card_pindian_dianshu = i, j
		elseif card_pindian_dianshu > j then
			card_pindian, card_pindian_dianshu = i, j
		end
	end
	return card_pindian, card_pindian_dianshu
end

--  AI回合内使用技能 (优先于使用大部分牌前的)  --
function ai_skill_use_priority(ID)
	local fadong, ID_shoupai, mubiao

	--  周瑜反间  --
	if char_juese[ID].skill["反间"] == 1 then
		mubiao = ai_judge_fanjian_mubiao(ID)
		if #mubiao > 0 then
			skills_fanjian_ai(ID, mubiao[1])
			timer.start(0.6)
			return true
		end
	end

	--  张昭张纮直谏  --
	if char_juese[ID].skill["直谏"] == "available" then
		fadong, ID_shoupai, mubiao = ai_judge_zhijian(ID)
		if fadong == true then
			if skills_zhijian_ai(ID, mubiao, ID_shoupai) then
				timer.start(0.6)
				return true
			end
		end
	end

	return false
end

--  AI回合内使用技能  --
function ai_skill_use(ID)
	local fadong, ID_shoupai, mubiao

	--  貂蝉离间  --
	if char_juese[ID].skill["离间"] == 1 then
		fadong, ID_shoupai, mubiao = ai_judge_lijian(ID)
		if fadong == true then
			local mubiao1, mubiao2
			if ai_judge_random_percent(50) == 1 then
				mubiao1 = mubiao[1]
				mubiao2 = mubiao[2]
			else
				mubiao1 = mubiao[2]
				mubiao2 = mubiao[1]
			end

			if skills_lijian_ai(ID_shoupai, ID, mubiao1, mubiao2, {}) then
				timer.start(0.6)
				return true
			end
		end
	end

	--  大乔国色  --
	if char_juese[ID].skill["国色"] == "available" then
		fadong, ID_shoupai, mubiao = ai_judge_guose(ID)
		if fadong == true then
			if card_judge_le(mubiao) == true then
				add_funcptr(card_le, {ID_shoupai, ID, mubiao})
				timer.start(0.6)
				return true
			end
		end
	end

	--  徐晃断粮  --
	if char_juese[ID].skill["断粮"] == "available" then
		fadong, ID_shoupai, mubiao = ai_judge_duanliang(ID)
		if fadong == true then
			if card_judge_bingliang(ID, mubiao) == true then
				add_funcptr(card_bingliang, {ID_shoupai, ID, mubiao})
				timer.start(0.6)
				return true
			end
		end
	end

	return false
end

--  AI回合内出牌 (判断)  --
function ai_card_use(ID)
	funcptr_queue = {}
	funcptr_i = 0

	if char_juese[ID].tili < char_juese[ID].tili_max then
		local card_use = ai_card_search(ID, "桃", 1)
		if #card_use ~= 0 then
			if card_chupai_ai({card_use[1]}, ID, nil, nil, "桃") then
				--  桃后处理ai_next_card --
				return
			end
		end
	end
	targets = ai_judge_target(ID, "火杀", {{"火杀","红桃","K"}}, 1)
	if #char_juese[ID].wuqi == 0 or char_juese[ID].skill["枭姬"] == "available" or #targets == 0 then
		local card_use = ai_card_search(ID, "武器", 1)
		if #card_use ~= 0 then
			local wuqi_card = char_juese[ID].shoupai[card_use[1]]
			card_chupai_ai({card_use[1]}, ID, nil, nil, wuqi_card[1])
			--ai_next_card(ID)
			return
		end
	end

	if (#char_juese[ID].fangju == 0 and char_juese[ID].skill["八阵"] ~= "available") or char_juese[ID].skill["枭姬"] == "available" then
		local card_use = ai_card_search(ID, "防具", 1)
		if #card_use ~= 0 then
			local wuqi_card = char_juese[ID].shoupai[card_use[1]]
			card_chupai_ai({card_use[1]}, ID, nil, nil, wuqi_card[1])
			--ai_next_card(ID)
			return
		end
	end

	if #char_juese[ID].gongma == 0 or char_juese[ID].skill["枭姬"] == "available" then
		local card_use = ai_card_search(ID, "-1马", 1)
		if #card_use ~= 0 then
			local wuqi_card = char_juese[ID].shoupai[card_use[1]]
			card_chupai_ai({card_use[1]}, ID, nil, nil, wuqi_card[1])
			--ai_next_card(ID)
			return
		end
	end

	if #char_juese[ID].fangma == 0 or char_juese[ID].skill["枭姬"] == "available" then
		local card_use = ai_card_search(ID, "+1马", 1)
		if #card_use ~= 0 then
			local wuqi_card = char_juese[ID].shoupai[card_use[1]]
			card_chupai_ai({card_use[1]}, ID, nil, nil, wuqi_card[1])
			--ai_next_card(ID)
			return
		end
	end

	if ai_skill_use_priority(ID) then
		return
	end

	local card_use = ai_card_search(ID, "五谷丰登", 1)
	if #card_use ~= 0 and ai_judge_AOE(ID,"五谷丰登") >= 0.5 then
		card_chupai_ai({card_use[1]}, ID, nil, nil, "五谷丰登")
		ai_next_card(ID)
		return
	end

	local card_use = ai_card_search(ID, "过河拆桥", 1)
	if #card_use ~= 0 then
		local ID_mubiao, targets
		local shoupai = char_juese[ID].shoupai[card_use[1]]
		targets = ai_judge_target(ID, shoupai[1], {shoupai}, 1)

		if #targets > 0 then
			ID_mubiao = targets[1]
			if card_chupai_ai({card_use[1]}, ID, ID_mubiao, nil, "过河拆桥") then
				--  拆后处理ai_next_card --
				timer.start(0.6)
				return
			end
		end
	end

	local card_use = ai_card_search(ID, "铁锁连环", 1)
	if #card_use ~= 0 then
		local ID1, ID2, targets
		local shoupai = char_juese[ID].shoupai[card_use[1]]
		targets = ai_judge_target(ID, shoupai[1], {shoupai}, 2)

		if #targets == 2 then
			ID1 = targets[1]
			ID2 = targets[2]
			if card_chupai_ai({card_use[1]}, ID1, ID2, ID, "铁锁连环-连环") then
				--  连后处理ai_next_card --
				timer.start(0.6)
				return
			end
		else
			card_chupai_ai({card_use[1]}, ID, nil, nil, "铁锁连环-重铸")
			ai_next_card(ID)
			return
		end
	end

	local card_use = ai_card_search(ID, "顺手牵羊", 1)
	if #card_use ~= 0 then
		local ID_mubiao, targets
		local shoupai = char_juese[ID].shoupai[card_use[1]]
		targets = ai_judge_target(ID, shoupai[1], {shoupai}, 1)

		if #targets > 0 then
			ID_mubiao = targets[1]
			if card_chupai_ai({card_use[1]}, ID, ID_mubiao, nil, "顺手牵羊") then
				--  顺后处理ai_next_card --
				timer.start(0.6)
				return
			end
		end
	end

	local card_use = ai_card_search(ID, "南蛮入侵", 1)
	if #card_use ~= 0 and ai_judge_AOE(ID,"南蛮入侵") >= 0.5 then
		card_chupai_ai({card_use[1]}, ID, nil, nil, "南蛮入侵")
		--  南蛮后处理ai_next_card --
		timer.start(0.6)
		return
	end

	local card_use = ai_card_search(ID, "万箭齐发", 1)
	if #card_use ~= 0 and ai_judge_AOE(ID,"万箭齐发") >= 0.5 then
		card_chupai_ai({card_use[1]}, ID, nil, nil, "万箭齐发")
		--  万箭后处理ai_next_card --
		timer.start(0.6)
		return
	end

	if ai_chazhao_sha(ID, char_juese[ID].shoupai) > 0 then
		local card_use = ai_card_search(ID, "决斗", 1)
		if #card_use ~= 0 then
			local ID_mubiao, targets
			local shoupai = char_juese[ID].shoupai[card_use[1]]
			targets = ai_judge_target(ID, shoupai[1], {shoupai}, 1)
	
			if #targets > 0 then
				if ai_judge_random_percent(20*(#char_juese[ID].shoupai - #char_juese[targets[1]].shoupai) + 60) == 1 or #char_juese[targets[1]].shoupai == 0 then
					ID_mubiao = targets[1]
					card_chupai_ai({card_use[1]}, ID, ID_mubiao, nil, "决斗")
					--  决斗后处理ai_next_card --
					timer.start(0.6)
					return
				end
			end
		end
	end

	local card_use = ai_card_search(ID, "借刀杀人", 1)
	if #card_use ~= 0 then
		local ID1, ID2, targets
		local shoupai = char_juese[ID].shoupai[card_use[1]]
		targets = ai_judge_target(ID, shoupai[1], {shoupai}, 2)

		if #targets == 2 then
			ID1 = targets[1]
			ID2 = targets[2]
			if card_chupai_ai({card_use[1]}, ID1, ID2, ID, "借刀杀人") then
				--  借刀后处理ai_next_card --
				timer.start(0.6)
				return
			end
		end
	end

	local card_use = ai_card_search(ID, "火攻", 1)
	if #card_use ~= 0 then
		local ID_mubiao, targets
		local shoupai = char_juese[ID].shoupai[card_use[1]]
		targets = ai_judge_target(ID, shoupai[1], {shoupai}, 1)
	
		if #targets > 0 then
			ID_mubiao = targets[1]
			if ai_judge_random_percent(30*(#char_juese[ID].shoupai - #char_juese[targets[1]].shoupai)) == 1 then
				if card_chupai_ai({card_use[1]}, ID, ID_mubiao, nil, "火攻") then
					--  火攻后处理ai_next_card --
					timer.start(0.6)
					return
				end
			end
		end
	end

	local card_use = ai_card_search(ID, "无中生有", 1)
	if #card_use ~= 0 then
		card_chupai_ai({card_use[1]}, ID, nil, nil, "无中生有")
		ai_next_card(ID)
		return
	end

	local card_use = ai_card_search(ID, "桃园结义", 1)
	if #card_use ~= 0 and ai_judge_AOE(ID,"桃园结义") >= 0.5 then
		card_chupai_ai({card_use[1]}, ID, nil, nil, "桃园结义")
		ai_next_card(ID)
		return
	end

	local card_use = ai_card_search(ID, "杀", 1)
	if #card_use ~= 0 then
		local ID_mubiao, targets
		local shoupai = char_juese[ID].shoupai[card_use[1]]
		targets = ai_judge_target(ID, shoupai[1], {shoupai}, 1)

		if #targets > 0 and char_hejiu == false then
			if char_juese[targets[1]].fangju ~= "白银狮" then
				local card_use_jiu = ai_card_search(ID, "酒", 1)
				if #card_use_jiu ~= 0 and (char_sha_time > 0 or char_juese[ID].wuqi[1] == "诸葛弩" ) and char_sha_able == true then
					if card_chupai_ai({card_use_jiu[1]}, ID, nil, nil, "酒") then
						ai_next_card(ID)
						return
					end
				end
			end
		end

		if #targets > 0 then
			ID_mubiao = targets[1]
			if card_chupai_ai({card_use[1]}, ID, ID_mubiao, nil, "杀") then
				--  杀后处理ai_next_card --
				timer.start(0.6)
				return
			end
		end
	end

	local card_use = ai_card_search(ID, "乐不思蜀", 1)
	if #card_use ~= 0 then
		local ID_mubiao, targets
		local shoupai = char_juese[ID].shoupai[card_use[1]]
		targets = ai_judge_target(ID, shoupai[1], {shoupai}, 1)
	
		if #targets > 0 then
			ID_mubiao = targets[1]
			if card_chupai_ai({card_use[1]}, ID, ID_mubiao, nil, "乐不思蜀") then
				--ai_next_card(ID)
				return
			end
		end
	end

	local card_use = ai_card_search(ID, "兵粮寸断", 1)
	if #card_use ~= 0 then
		local ID_mubiao, targets
		local shoupai = char_juese[ID].shoupai[card_use[1]]
		targets = ai_judge_target(ID, shoupai[1], {shoupai}, 1)
	
		if #targets > 0 then
			ID_mubiao = targets[1]
			if card_chupai_ai({card_use[1]}, ID, ID_mubiao, nil, "兵粮寸断") then
				--ai_next_card(ID)
				return
			end
		end
	end

	local card_use = ai_card_search(ID, "闪电", 1)
	if #card_use ~= 0 and ai_judge_random_percent(30) == 1 then
		if card_chupai_ai({card_use[1]}, ID, nil, nil, "闪电") then
			--ai_next_card(ID)
			return
		end
	end

	if ai_skill_use(ID) then
		return
	end

	ai_stage_qipai(ID)
end

function ai_next_card(ID)
	funcptr_add_tag = "下一次出牌"
	add_funcptr(ai_card_use, ID)
	funcptr_add_tag = nil
	timer.start(0.6)
end

function ai_stage_qipai(ID)
	funcptr_queue = {}
	funcptr_i = 0
	if gamerun_dangxian == true then
		--  跳过死亡的玩家  --
		local j = true
		while j do
			j = false
			if char_juese[char_acting_i].siwang == true then
				char_acting_i = char_acting_i + 1
				j = true
			end
			if char_acting_i > 5 then
				char_acting_i = 1
			end
		end
		for i = 1,5 do
			for k,v in pairs(char_juese[i].skill) do
				if v=="locked" then
					char_juese[i].skill[k] = 1
				end
			end
		end


		--  注释此行即使用主动AI，不注释不使用  --
		--char_current_i = char_acting_i

		set_hints("")
		gamerun_huihe_start()    -- 正常回合开始
	else
		add_funcptr(_qipai_huihe_set)
		wugucards = {}

		local extra = 0
		extra = skills_judge_xueyi(char_acting_i)
		if char_juese[ID].skill["巧变"] == "available" then
			add_funcptr(skills_qiaobian,{ID, "弃牌"})
		elseif char_juese[ID].skill["克己"] == "available" and char_yisha == false then
			add_funcptr(skills_keji,ID)
		elseif char_juese[ID].tili + extra < #char_juese[ID].shoupai or char_juese[ID].skill["庸肆"] == "available" then
			_ai_qipai_exe(ID)
		else
			gamerun_huihe_jieshu(true)
		end
	end
	timer.start(0.2)
end
function _ai_qipai_exe(ID)
	local extra = 0
	extra = skills_judge_xueyi(char_acting_i)

	local qipai_id, i, qizhuangbei_id
	local required = math.max(#char_juese[ID].shoupai - char_juese[ID].tili - extra, 0)
	if char_juese[ID].skill["庸肆"] == "available" then
		local shili = {}
		for i = 1, 5 do
			if char_juese[i].siwang ~= true then
				shili[char_juese[i].shili] = 1
			end
		end
		add_funcptr(push_message, char_juese[char_acting_i].name .. "触发了武将技能 '庸肆'")
		required = math.min(math.max(required, table.getn2(shili)), ai_card_stat(ID, false, true))
		qipai_id, qizhuangbei_id = ai_judge_withdraw(ID, required, true)
	else
		qipai_id, qizhuangbei_id = ai_judge_withdraw(ID, required, false)
	end

	for i = #qipai_id, 1, -1 do
		add_funcptr(_qipai_sub1, qipai_id[i])
	end
	if qizhuangbei_id[1] == 1 then
		add_funcptr(_qipai_sub4,ID)
	end

	if qizhuangbei_id[2] == 1 then
		add_funcptr(_qipai_sub5,ID)
	end

	if qizhuangbei_id[3] == 1 then
		add_funcptr(_qipai_sub6,ID)
	end

	if qizhuangbei_id[4] == 1 then
		add_funcptr(_qipai_sub7,ID)
	end
	skills_losecard(ID, #qipai_id, true)

	gamerun_huihe_jieshu(true)
end
function _qipai_huihe_set()
	gamerun_huihe_set("弃牌")
	push_message(table.concat({char_juese[char_acting_i].name, "弃牌阶段"}))
end

--  AI身份判定 --
--[[isantigovernment:nil未确定,false为忠臣,true为反贼
isblackjack:true为内奸
]]
function ai_judge_shenfen()
	--  明身份临时  --
	if true then
		return
	end

	for i = 1,5 do
		if char_juese[i].shenfen == "主公" then
			char_juese[i].isblackjack,char_juese[i].isantigovernment = false,false
		else
			char_juese[i].antigovernmentmax = math.max(char_juese[i].antigovernmentmax,char_juese[i].antigovernment)
			char_juese[i].antigovernmentmin = math.min(char_juese[i].antigovernmentmin,char_juese[i].antigovernment)
			if char_juese[i].antigovernmentmax-char_juese[i].antigovernmentmin > 10 then
				char_juese[i].isblackjack,char_juese[i].isantigovernment = true,nil
			elseif char_juese[i].antigovernmentmax > 5 then
				char_juese[i].isblackjack,char_juese[i].isantigovernment = false,true
			elseif char_juese[i].antigovernment < 5 then
			    char_juese[i].isblackjack,char_juese[i].isantigovernment = false,false
			end
		end
	end
end
