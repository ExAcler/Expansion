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

--  AI判断对方是否与自己同阵营  --
--  返回1是，返回2否，返回3未知  --
function ai_judge_same_identity(ID, ID_mubiao, blackjack)
	if ID == ID_mubiao then
		return 1
	end

	if char_juese[ID].shenfen == "主公" then
		if char_juese[ID_mubiao].isantigovernment == false and char_juese[ID_mubiao].isblackjack ~= true then
			return 1
		elseif char_juese[ID_mubiao].isantigovernment == true or char_juese[ID_mubiao].isblackjack == true then
			return 2
		end
	elseif char_juese[ID].shenfen == "忠臣" then
		--  5人局1忠，除主以外都是敌方  --
		if char_juese[ID_mubiao].shenfen == "主公" then
			return 1
		else
			return 2
		end
	elseif char_juese[ID].shenfen == "反贼" then
		if char_juese[ID_mubiao].isantigovernment == true and char_juese[ID_mubiao].isblackjack ~= true then
			return 1
		elseif char_juese[ID_mubiao].isantigovernment == false or char_juese[ID_mubiao].isblackjack == true then
			return 2
		end
	elseif char_juese[ID].shenfen == "内奸" then
		if blackjack then
			if ai_judge_blackjack(ID) then
				if char_juese[ID_mubiao].isantigovernment == false and char_juese[ID_mubiao].isblackjack ~= true then
					return 1
				elseif char_juese[ID_mubiao].isantigovernment == true or char_juese[ID_mubiao].isblackjack == true then
					return 2
				end
			else
				if char_juese[ID_mubiao].isantigovernment == true and char_juese[ID_mubiao].isblackjack ~= true then
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

	for i = #possible_target, 1, -1 do
		if char_juese[possible_target[i]].siwang == true then
			table.remove(possible_target, i)
		end
	end

	for i = #possible_target, 1, -1 do
		if exclude_self and possible_target[i] == ID then
			table.remove(possible_target, i)
		elseif exclude_unknown and char_juese[possible_target[i]].isantigovernment == nil and char_juese[ID].shenfen ~= "忠臣" then
			table.remove(possible_target, i)
		else
			if char_juese[ID].shenfen == "主公" then
				if is_help then
					if char_juese[possible_target[i]].isantigovernment == true or char_juese[possible_target[i]].isblackjack == true then
						table.remove(possible_target, i)
					end
				else
					if char_juese[possible_target[i]].isantigovernment == false and char_juese[possible_target[i]].isblackjack ~= true then
						table.remove(possible_target, i)
					end
				end
			elseif char_juese[ID].shenfen == "忠臣" then
				--  5人局1忠，除主以外都是敌方  --
				if is_help then
					if char_juese[ID].shenfen ~= "主公" and possible_target[i] ~= ID then
						table.remove(possible_target, i)
					end
				else
					if char_juese[ID].shenfen == "主公" or possible_target[i] == ID then
						table.remove(possible_target, i)
					end
				end
			elseif char_juese[ID].shenfen == "反贼" then
				if is_help then
					if char_juese[possible_target[i]].isantigovernment == false or char_juese[possible_target[i]].isblackjack == true then
						table.remove(possible_target, i)
					end
				else
					if char_juese[possible_target[i]].isantigovernment == true and char_juese[possible_target[i]].isblackjack ~= true then
						table.remove(possible_target, i)
					end
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

--  明身份临时：AI初始化其反政府属性  --
function ai_init_shenfen()
	for i = 1, 5 do
		if char_juese[i].shenfen == "反贼" then
			char_juese[i].isantigovernment = true
			char_juese[i].isblackjack = false
		elseif char_juese[i].shenfen == "主公" then
			char_juese[i].isantigovernment = false
			char_juese[i].isblackjack = false
		elseif char_juese[i].shenfen == "忠臣" then
			char_juese[i].isantigovernment = false
			char_juese[i].isblackjack = false
		elseif char_juese[i].shenfen == "内奸" then
			char_juese[i].isantigovernment = true
			char_juese[i].isblackjack = true
		end
	end
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

--  AI随机选择系数  --
--  以percent的概率返回1  --
function ai_judge_random_percent(percent)
	if math.random() < percent / 100 then
		return 1
	else
		return 0
	end
end

--  AI回合内使用技能 (优先于使用大部分牌前的)  --
function ai_skill_use_priority(ID)
	local fadong, ID_shoupai, mubiao

	--  神司马懿极略  --
	if char_juese[ID].skill["极略"] == "available" and mark_ren[ID] > 0 then
		skills_jilve_ai(ID)
		timer.start(0.6)
		return true
	end
	
	--  神吕蒙攻心  --
	if char_juese[ID].skill["攻心"] == 1 then
		if skills_gongxin_ai(ID) then
			timer.start(0.6)
			return true
		end
	end
	
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

	--  黄盖苦肉  --
	if char_juese[ID].skill["苦肉"] == "available" and (ai_skills_discard["苦肉"] ~= true or char_juese[ID].tili == char_juese[ID].tili_max) then
		if ai_judge_kurou(ID) then
			skills_kurou(ID)
			timer.start(0.6)
			return true
		end
	end

	--  华佗青囊  --
	if char_juese[ID].skill["青囊"] == 1 then
		fadong, ID_shoupai, mubiao = ai_judge_qingnang(ID)
		if fadong == true then
			if skills_qingnang(ID_shoupai, ID, mubiao) then
				timer.start(0.6)
				return true
			end
		end
	end

	--  荀彧驱虎  --
	if char_juese[ID].skill["驱虎"] == 1 then
		local mubiao_1, mubiao_2
		fadong, ID_shoupai, mubiao_1, mubiao_2 = ai_judge_quhu(ID)
		if fadong == true then
			if skills_quhu_ai(ID, mubiao_1, mubiao_2) then
				timer.start(0.6)
				return true
			end
		end
	end

	--  太史慈天义  --
	if char_juese[ID].skill["天义"] == 1 then
		fadong, ID_shoupai, mubiao = ai_judge_tianyi(ID)
		if fadong == true then
			if skills_tianyi_ai(ID, mubiao, ID_shoupai) then
				timer.start(0.6)
				return true
			end
		end
	end

	--  孙尚香结姻  --
	if char_juese[ID].skill["结姻"] == 1 then
		fadong, ID_shoupai, mubiao = ai_judge_jieyin(ID)
		if fadong == true then
			if skills_jieyin_ai(ID, mubiao, ID_shoupai) then
				timer.start(0.6)
				return true
			end
		end
	end

	--  刘备仁德  --
	if char_juese[ID].skill["仁德"] == "available" then
		fadong, ID_shoupai, mubiao = ai_judge_rende(ID)
		if fadong == true then
			if skills_rende_ai(ID, mubiao, ID_shoupai) then
				ai_skills_discard["仁德"] = true
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
			if skills_lijian_ai(ID_shoupai, ID, mubiao[1], mubiao[2], {}) then
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

	--  孙权制衡  --
	if char_juese[ID].skill["制衡"] == 1 then
		local zhuangbei_id
		fadong, ID_shoupai, zhuangbei_id = ai_judge_zhiheng(ID)
		if fadong == true then
			if skills_zhiheng_ai(ID, ID_shoupai, zhuangbei_id) then
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

		if char_sha_add_target_able == false then
			targets = ai_judge_target(ID, shoupai[1], {shoupai}, 1)
		else
			targets = ai_judge_target(ID, shoupai[1], {shoupai}, 1 + char_sha_additional_target)
		end

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

		if #targets == 1 then
			ID_mubiao = targets[1]
			if card_chupai_ai({card_use[1]}, ID, ID_mubiao, nil, "杀") then
				--  杀后处理ai_next_card --
				timer.start(0.6)
				return
			end
		elseif #targets > 1 then
			if card_sha({card_use[1]}, ID, targets, true) then
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
		end
		if char_juese[ID].skill["克己"] == "available" and char_yisha == false then
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
		required = math.min(math.max(required, table.getn2(shili)), ai_card_stat(ID, true, false))
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
