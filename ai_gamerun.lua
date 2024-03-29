function random_pick(_array, n)
	local array = table.copy(_array)
    local currentIndex = #array
    local temporaryValue, randomIndex

    for currentIndex = #array, 1, -1 do
        randomIndex = math.floor(math.random() * currentIndex) + 1

        temporaryValue = array[currentIndex]
        array[currentIndex] = array[randomIndex]
        array[randomIndex] = temporaryValue
    end

	local result = {}
	for i = 1, math.min(n, #array) do
		table.insert(result, array[i])
	end

    return result
end

--  AI判断是否有队友 (或自己) 处于横置状态  --
function ai_judge_friends_hengzhi(ID)
	if char_juese[ID].hengzhi == true then
		return true
	end

	local friends = ai_basic_judge_mubiao(ID, 4, true, true, true)
	for i = 1, #friends do
		if char_juese[friends[i]].hengzhi == true then
			return true
		end
	end

	return false
end

--  AI决定是否出桃解救濒死角色  --
function ai_judge_jiejiu(ID_s, ID_jiu)
	local jiejiu = false
	if char_juese[ID_jiu].shenfen == "主公" or char_juese[ID_jiu].shenfen == "忠臣" then
		if ai_judge_same_identity(ID_jiu, ID_s) == 1 then
			jiejiu = true
		end
	elseif char_juese[ID_jiu].shenfen == "反贼" then
		if ai_judge_same_identity(ID_jiu, ID_s) == 1 then
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
		if char_juese[ID_mubiao].isblackjack ~= true or blackjack == false then
			if char_juese[ID_mubiao].isantigovernment == false and char_juese[ID_mubiao].isblackjack ~= true then
				return 1
			elseif char_juese[ID_mubiao].isantigovernment == true or char_juese[ID_mubiao].isblackjack == true then
				return 2
			end
		else
			if ai_judge_befriend_blackjack(ID) then
				return 1
			else
				return 2
			end
		end
	elseif char_juese[ID].shenfen == "忠臣" then
		--  5人局1忠，除主以外都是敌方  --
		if char_juese[ID_mubiao].shenfen == "主公" then
			return 1
		else
			if char_juese[ID_mubiao].isblackjack ~= true or blackjack == false then
				return 2
			else
				if ai_judge_befriend_blackjack(ID) then
					return 1
				else
					return 2
				end
			end
		end
	elseif char_juese[ID].shenfen == "反贼" then
		if char_juese[ID_mubiao].isblackjack ~= true or blackjack == false then
			if char_juese[ID_mubiao].isantigovernment == true and char_juese[ID_mubiao].isblackjack ~= true then
				return 1
			elseif char_juese[ID_mubiao].isantigovernment == false or char_juese[ID_mubiao].isblackjack == true then
				return 2
			end
		else
			if ai_judge_befriend_blackjack(ID) then
				return 1
			else
				return 2
			end
		end
	elseif char_juese[ID].shenfen == "内奸" then
		local lord_id = ai_get_lord_id()
		if blackjack then
			if char_juese[ID_mubiao].shenfen == "主公" and char_juese[ID_mubiao].tili <= 2 and char_alive_stat() > 3 then
				return 1
			elseif char_alive_stat() == 3 and char_juese[lord_id].tili <= 2 then
				if char_juese[ID_mubiao].shenfen == "主公" then
					return 1
				else
					return 2
				end
			elseif char_alive_stat() == 2 then
				return 2
			else
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
					if char_juese[possible_target[i]].isblackjack ~= true then
						if char_juese[possible_target[i]].isantigovernment == true or char_juese[possible_target[i]].isblackjack == true then
							table.remove(possible_target, i)
						end
					else
						if ai_judge_befriend_blackjack(ID) == false then
							table.remove(possible_target, i)
						end
					end
				else
					if char_juese[possible_target[i]].isblackjack ~= true then
						if char_juese[possible_target[i]].isantigovernment == false and char_juese[possible_target[i]].isblackjack ~= true then
							table.remove(possible_target, i)
						end
					else
						if ai_judge_befriend_blackjack(ID) == true then
							table.remove(possible_target, i)
						end
					end
				end
			elseif char_juese[ID].shenfen == "忠臣" then
				--  5人局1忠，除主以外都是敌方  --
				if is_help then
					if char_juese[possible_target[i]].isblackjack ~= true then
						if char_juese[possible_target[i]].shenfen ~= "主公" and possible_target[i] ~= ID then
							table.remove(possible_target, i)
						end
					else
						if ai_judge_befriend_blackjack(ID) == false then
							table.remove(possible_target, i)
						end
					end
				else
					if char_juese[possible_target[i]].isblackjack ~= true then
						if char_juese[possible_target[i]].shenfen == "主公" or possible_target[i] == ID then
							table.remove(possible_target, i)
						end
					else
						if ai_judge_befriend_blackjack(ID) == true then
							table.remove(possible_target, i)
						end
					end
				end
			elseif char_juese[ID].shenfen == "反贼" then
				if is_help then
					if char_juese[possible_target[i]].isblackjack ~= true then
						if char_juese[possible_target[i]].isantigovernment == false or char_juese[possible_target[i]].isblackjack == true then
							table.remove(possible_target, i)
						end
					else
						if ai_judge_befriend_blackjack(ID) == false then
							table.remove(possible_target, i)
						end
					end
				else
					if char_juese[possible_target[i]].isblackjack ~= true then
						if char_juese[possible_target[i]].isantigovernment == true and char_juese[possible_target[i]].isblackjack ~= true then
							table.remove(possible_target, i)
						end
					else
						if ai_judge_befriend_blackjack(ID) == true then
							table.remove(possible_target, i)
						end
					end
				end
			elseif char_juese[ID].shenfen == "内奸" then
				local lord_id = ai_get_lord_id()
				if char_juese[possible_target[i]].shenfen == "主公" and char_juese[possible_target[i]].tili <= 2 and char_alive_stat() > 2 then
					if char_juese[possible_target[i]].isantigovernment == is_help then
						table.remove(possible_target, i)
					end
				elseif char_alive_stat() == 3 and char_juese[lord_id].tili <= 2 then
					if char_juese[possible_target[i]].shenfen == "主公" then
						if char_juese[possible_target[i]].isantigovernment == is_help then
							table.remove(possible_target, i)
						end
					else
						if char_juese[possible_target[i]].isantigovernment == not is_help then
							table.remove(possible_target, i)
						end
					end
				elseif char_alive_stat() == 2 then
					if char_juese[possible_target[i]].isantigovernment == not is_help then
						table.remove(possible_target, i)
					end
				else
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
	end

	possible_target = random_pick(possible_target, required)

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

--  获得防御系数最小的角色  --
function ai_judge_minimum_def(targets)
	if #targets == 1 then
		return targets[1]
	else
		local mindef_ID = targets[1]
		for i = 2, #targets do
			if ai_judge_def(targets[i], false, false) < ai_judge_def(mindef_ID, false, false) then
				mindef_ID = targets[i]
			end
		end
		return mindef_ID
	end
end

--  获得防御系数最大的角色  --
function ai_judge_maximum_def(targets)
	if #targets == 1 then
		return targets[1]
	else
		local maxdef_ID = targets[1]
		for i = 2, #targets do
			if ai_judge_def(targets[i], false, false) > ai_judge_def(maxdef_ID, false, false) then
				maxdef_ID = targets[i]
			end
		end
		return maxdef_ID
	end
end

--  获得在角色攻击范围内其他角色的列表  --
function ai_get_in_range(ID, targets)
	local attack_mubiao = table.copy(targets)

	for i = #attack_mubiao, 1, -1 do
		if #char_juese[ID].wuqi > 0 then
			if char_calc_distance(ID, attack_mubiao[i]) > card_wuqi_r[char_juese[ID].wuqi[1]] then
				table.remove(attack_mubiao, i)
			end
		else
			if char_calc_distance(ID, attack_mubiao[i]) > 1 then
				table.remove(attack_mubiao, i)
			end
		end
	end

	return attack_mubiao
end

--  AI距离与攻击范围测算  --
--  第一个参数是否在指定距离内，第二个参数返回是否在攻击范围内  --
function ai_judge_distance(ID_s, ID_d, limdis, weapon_ignore, horse_ignore, delta)
	local indis, range, inrange = false, 1, false
	local distance = char_calc_distance(ID_s, ID_d, horse_ignore, delta)

	if #char_juese[ID_s].wuqi ~= 0 and weapon_ignore == nil then
		range = card_wuqi_r[char_juese[ID_s].wuqi[1]]
	end

	if distance <= limdis then
		indis = true
	end
	if distance <= range then
		inrange = true
	end

	return indis, inrange
end

--  AI计算对阵双方实力强弱 (不含内奸)  --
function ai_judge_lord_rebel()
	local lord, rebel = 200, 200

	for i = 1, 5 do
		if char_juese[i].isblackjack == true then
			
		elseif char_juese[i].siwang == true and char_juese[i].shenfen == "忠臣" then
			lord = lord - 100
		elseif char_juese[i].siwang == true and char_juese[i].shenfen == "反贼" then
			rebel = rebel - 100
		elseif char_juese[i].siwang == false and char_juese[i].isantigovernment == false then
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
		elseif char_juese[i].siwang == false and char_juese[i].isantigovernment == true then
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

	return lord, rebel
end

--  AI内奸场上局势判断  --
--  返回false装反,返回true装忠  --
function ai_judge_blackjack(ID)
	local lord, rebel = ai_judge_lord_rebel()

	if lord > rebel then
		return false
	else
		return true
	end
end

--  AI判断是否要依靠内奸  --
function ai_judge_befriend_blackjack(ID)
	local lord, rebel = ai_judge_lord_rebel()

	if char_juese[ID].shenfen == "主公" or char_juese[ID].shenfen == "忠臣" then
		if lord > rebel then
			return false
		else
			return true
		end
	elseif char_juese[ID].shenfen == "反贼" then
		if rebel > lord then
			return false
		else
			return true
		end
	else
		return false
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

--  AI回合内使用技能 (最高优先级)  --
function ai_skill_use_highest_priority(ID)
	local fadong, ID_shoupai, mubiao

	--  颜良文丑双雄  --
	if char_juese[ID].skill["双雄"] == "available" and char_shuangxiong ~= nil and ai_skills_discard["双雄"] ~= 2 then
		fadong, ID_shoupai, mubiao = ai_judge_shuangxiong_mubiao(ID)
		if fadong == true then
			if card_juedou({ID_shoupai}, ID, mubiao) then
				if type(ai_skills_discard["双雄"]) ~= "number" then
					ai_skills_discard["双雄"] = 1
				else
					ai_skills_discard["双雄"] = ai_skills_discard["双雄"] + 1
				end

				timer.start(0.6)
				return true
			end
		end
	end

	--  神周瑜业炎  --
	if char_juese[ID].skill["业炎"] == "available" then
		fadong, ID_shoupai, mubiao = ai_judge_yeyan(ID)
		if fadong == true then
			if skills_yeyan_ai(ID, ID_shoupai, mubiao) then
				timer.start(0.6)
				return true
			end
		end
	end

	--  神周瑜是否放弃出牌发动琴音  --
	if char_juese[ID].skill["琴音"] == "available" then
		fadong = ai_judge_qinyin(ID)
		if fadong ~= 3 and #char_juese[ID].shoupai >= char_juese[ID].tili + 2 then
			if ai_judge_random_percent(50) == 1 then
				ai_giveup_chupai = true
			end
		end
	end

	return false
end

--  AI回合内使用技能 (优先于使用大部分牌前的)  --
function ai_skill_use_priority(ID)
	local fadong, ID_shoupai, mubiao

	--  神司马懿极略  --
	if char_juese[ID].skill["极略"] == "available" and mark_ren[ID] > 0 and ai_skills_discard["极略"] ~= true then
		if skills_jilve_ai(ID) then
			timer.start(0.6)
			return true
		end
	end
	
	--  神吕蒙攻心  --
	if char_juese[ID].skill["攻心"] == 1 then
		if skills_gongxin_ai(ID) then
			timer.start(0.6)
			return true
		end
	end

	--  甘宁奇袭  --
	if char_juese[ID].skill["奇袭"] == "available" then
		fadong, ID_shoupai, mubiao = ai_judge_qixi(ID)
		if fadong == true then
			if card_chai({ID_shoupai}, ID, mubiao) then
				timer.start(0.6)
				return true
			end
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
	
	--  卧龙诸葛火计  --
	if char_juese[ID].skill["火计"] == "available" and ai_skills_discard["火计"] ~= true then
		fadong, ID_shoupai, mubiao = ai_judge_huoji(ID)
		if fadong == true then
			if card_huogong({ID_shoupai}, ID, mubiao) then
				timer.start(0.6)
				return true
			end
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
	if char_juese[ID].skill["仁德"] == "available" and ai_skills_discard["仁德"] ~= true then
		fadong, ID_shoupai, mubiao = ai_judge_rende(ID)
		if fadong == true then
			if skills_rende_ai(ID, mubiao, ID_shoupai) then
				ai_skills_discard["仁德"] = true
				timer.start(0.6)
				return true
			end
		end
	end

	--  邓艾急袭  --
	if char_juese[ID].skill["急袭"] == "available" and #card_tian[ID] > 0 and ai_skills_discard["急袭"] ~= true then
		local shoupai = {"顺手牵羊", "方块", "4"}
		mubiao = ai_judge_target(ID, shoupai[1], {shoupai}, 1)

		if #mubiao > 0 then
			if skills_jixi_ai(ID, mubiao[1], #card_tian[ID]) then
				local percent = math.floor(100 / (3 ^ math.max(3 - #card_tian[ID], 0)))
				if ai_judge_random_percent(percent) == 0 then 
					ai_skills_discard["急袭"] = true
				end
				return true
			end
		end
	end

	--  袁绍乱击  --
	if char_juese[ID].skill["乱击"] == "available" and ai_skills_discard["乱击"] ~= true then
		fadong, ID_shoupai = ai_judge_luanji(ID)
		if fadong == true then
			ai_skills_discard["乱击"] = true
			if ai_judge_random_percent(80) == 1 then
				if skills_luanji_ai(ID, ID_shoupai) then
					return true
				end
			end
		end
	end

	return false
end

--  AI回合内使用技能 (在使用杀之前的)  --
function ai_skills_use_with_sha(ID)
	local fadong, ID_shoupai, mubiao

	--  SP貂蝉离魂  --
	if char_juese[ID].skill["离魂"] == 1 then
		fadong, ID_shoupai, mubiao = ai_judge_lihun(ID)
		if fadong == true then
			if skills_lihun_ai(ID_shoupai, ID, mubiao) then
				ai_attack_priority = mubiao
				timer.start(0.6)
				return true
			end
		end
	end
end

--  AI回合内使用技能 (在使用手牌之后的)  --
function ai_skill_use(ID)
	local fadong, ID_shoupai, mubiao

	--  贾诩乱武  --
	if char_juese[ID].skill["乱武"] == "available" then
		if ai_judge_luanwu(ID) == true then
			skills_luanwu_add(ID)
			timer.start(0.6)
			return true
		end
	end

	--  鲁肃缔盟  --
	if char_juese[ID].skill["缔盟"] == 1 then
		fadong, ID_shoupai, mubiao = ai_judge_dimeng(ID)
		if fadong == true then
			if skills_dimeng_ai(ID_shoupai, ID, mubiao[1], mubiao[2]) then
				timer.start(0.6)
				return true
			end
		end
	end

	--  吴国太甘露  --
	if char_juese[ID].skill["甘露"] == 1 then
		mubiao = ai_judge_ganlu(ID)
		if #mubiao > 0 then
			if skills_ganlu(ID, mubiao[1], mubiao[2]) then
				timer.start(0.6)
				return true
			end
		end
	end

	--  姜维挑衅  --
	if char_juese[ID].skill["挑衅"] == 1 and ai_skills_discard["挑衅"] ~= true then
		fadong, mubiao = ai_judge_tiaoxin(ID)
		if fadong == true then
			if skills_tiaoxin(ID, mubiao) then
				timer.start(0.6)
				return true
			end
		else
			ai_skills_discard["挑衅"] = true
		end
	end

	--  典韦强袭  --
	if char_juese[ID].skill["强袭"] == 1 then
		fadong, ID_shoupai, mubiao = ai_judge_qiangxi(ID)
		if fadong == true then
			if skills_qiangxi(ID, ID_shoupai, mubiao) == true then
				timer.start(0.6)
				return true
			end
		end
	end

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
			if card_judge_le(ID_shoupai, ID, mubiao) == true then
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
			if card_judge_bingliang(ID_shoupai, ID, mubiao) == true then
				add_funcptr(card_bingliang, {ID_shoupai, ID, mubiao})
				timer.start(0.6)
				return true
			end
		end
	end

	--  关羽武圣  --
	if char_juese[ID].skill["武圣"] == "available" then
		fadong, ID_shoupai, mubiao = ai_judge_wusheng(ID)
		if fadong == true then
			if card_sha({ID_shoupai}, ID, {mubiao}, true) then
				timer.start(0.6)
				return true
			end
		end
	end

	--  赵云龙胆  --
	if char_juese[ID].skill["龙胆"] == "available" then
		fadong, ID_shoupai, mubiao = ai_judge_longdan(ID)
		if fadong == true then
			if card_sha({ID_shoupai}, ID, {mubiao}, true) then
				timer.start(0.6)
				return true
			end
		end
	end

	--  庞统连环  --
	if char_juese[ID].skill["连环"] == "available" then
		fadong, ID_shoupai, mubiao = ai_judge_lianhuan_lian(ID)
		if fadong == true then
			local mubiao1, mubiao2, doubl
			if #mubiao == 2 then
				mubiao1 = mubiao[1]
				mubiao2 = mubiao[2]
				doubl = true
			else
				mubiao1 = mubiao[1]
				mubiao2 = nil
				doubl = false
			end

			if ai_skills_discard["连环"] ~= true then
				if card_lian_lianhuan({ID_shoupai}, ID, mubiao1, mubiao2, doubl) then
					ai_skills_discard["连环"] = true
					timer.start(0.6)
					return true
				end
			end
		end

		fadong, ID_shoupai = ai_judge_lianhuan_chongzhu(ID)
		if fadong == true then
			add_funcptr(card_lian_chongzhu, {ID_shoupai, ID})
			ai_next_card(ID)
			return true
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

	--  刘备激将  --
	if char_juese[ID].skill["激将"] == "available" and (char_sha_time > 0 or char_juese[ID].wuqi[1] == "诸葛弩") and char_sha_able == true then
		fadong, mubiao = ai_judge_jijiang_zhudong(ID)
		if fadong == true then
			skills_jijiang_add(ID, "杀", {-1, ID, mubiao})
			timer.start(0.6)
			return true
		end
	end

	--  张角黄天  --
	if char_juese[ID].shili == "群" then
		fadong, ID_shoupai, mubiao = ai_judge_huangtian(ID)
		if fadong == true then
			if skills_huangtian_ai(ID_shoupai, ID, mubiao) then
				return true
			end
		end
	end

	--  孙策制霸  --
	if char_juese[ID].shili == "吴" then
		fadong, mubiao = ai_judge_zhiba(ID)
		if fadong == true then
			if skills_zhiba(ID, mubiao) then
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

	if ai_skill_use_highest_priority(ID) then
		return
	end

	if ai_giveup_chupai == true then
		ai_stage_qipai(ID)
		return
	end

	local targets = ai_judge_target(ID, "火杀", {{"火杀","红桃","K"}}, 1)
	if #char_juese[ID].wuqi == 0 or char_juese[ID].skill["枭姬"] == "available" or char_juese[ID].skill["旋风"] == "available" or #targets == 0 then
		local card_use = ai_card_search(ID, "武器", 1)
		if #card_use ~= 0 then
			local wuqi_card = char_juese[ID].shoupai[card_use[1]]
			card_chupai_ai({card_use[1]}, ID, nil, nil, wuqi_card[1])
			--ai_next_card(ID)
			return
		end
	end

	if (#char_juese[ID].fangju == 0 and char_juese[ID].skill["八阵"] ~= "available") or char_juese[ID].skill["枭姬"] == "available" or char_juese[ID].skill["旋风"] == "available" or ai_judge_withdraw_fangju(ID, true) == true then
		local card_use = ai_card_search(ID, "防具", 1)
		if #card_use ~= 0 then
			local wuqi_card = char_juese[ID].shoupai[card_use[1]]
			card_chupai_ai({card_use[1]}, ID, nil, nil, wuqi_card[1])
			--ai_next_card(ID)
			return
		end
	end

	if #char_juese[ID].gongma == 0 or char_juese[ID].skill["枭姬"] == "available" or char_juese[ID].skill["旋风"] == "available" then
		local card_use = ai_card_search(ID, "-1马", 1)
		if #card_use ~= 0 then
			local wuqi_card = char_juese[ID].shoupai[card_use[1]]
			card_chupai_ai({card_use[1]}, ID, nil, nil, wuqi_card[1])
			--ai_next_card(ID)
			return
		end
	end

	if #char_juese[ID].fangma == 0 or char_juese[ID].skill["枭姬"] == "available" or char_juese[ID].skill["旋风"] == "available" then
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
		if card_chupai_ai({card_use[1]}, ID, nil, nil, "五谷丰登") then
			ai_next_card(ID)
			return
		end
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

	local card_use = ai_card_search(ID, "铁索连环", 1)
	if #card_use ~= 0 then
		local ID1, ID2, targets
		local shoupai = char_juese[ID].shoupai[card_use[1]]
		targets = ai_judge_target(ID, shoupai[1], {shoupai}, 2)

		if #targets == 2 then
			ID1 = targets[1]
			ID2 = targets[2]
			if card_chupai_ai({card_use[1]}, ID1, ID2, ID, "铁索连环-连环") then
				--  连后处理ai_next_card --
				timer.start(0.6)
				return
			end
		elseif #targets == 1 then
			if card_chupai_ai({card_use[1]}, targets[1], nil, ID, "铁索连环-连环") then
				timer.start(0.6)
				return
			end
		else
			card_chupai_ai({card_use[1]}, ID, nil, nil, "铁索连环-重铸")
			--ai_next_card(ID)
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
		if card_chupai_ai({card_use[1]}, ID, nil, nil, "南蛮入侵") then
			--  南蛮后处理ai_next_card --
			timer.start(0.6)
		end
		return
	end

	local card_use = ai_card_search(ID, "万箭齐发", 1)
	if #card_use ~= 0 and ai_judge_AOE(ID,"万箭齐发") >= 0.5 then
		if card_chupai_ai({card_use[1]}, ID, nil, nil, "万箭齐发") then
			--  万箭后处理ai_next_card --
			timer.start(0.6)
		end
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
					if card_chupai_ai({card_use[1]}, ID, ID_mubiao, nil, "决斗") then
						--  决斗后处理ai_next_card --
						timer.start(0.6)
						return
					end
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
		if card_chupai_ai({card_use[1]}, ID, nil, nil, "无中生有") then
			ai_next_card(ID)
			return
		end
	end

	local card_use = ai_card_search(ID, "桃园结义", 1)
	if #card_use ~= 0 and ai_judge_AOE(ID,"桃园结义") >= 0.5 then
		if card_chupai_ai({card_use[1]}, ID, nil, nil, "桃园结义") then
			ai_next_card(ID)
			return
		end
	end

	if ai_skills_use_with_sha(ID) then
		return
	end

	local card_use = ai_card_search(ID, "杀", 1)
	if #card_use ~= 0 then
		local ID_mubiao, targets
		local shoupai = char_juese[ID].shoupai[card_use[1]]
		local n_targets = 1

		if gamerun_judge_fangtian(ID) == true then
			n_targets = 3
		end

		if char_sha_add_target_able == false then
			targets = ai_judge_target(ID, shoupai[1], {shoupai}, n_targets)
		else
			targets = ai_judge_target(ID, shoupai[1], {shoupai}, math.min(n_targets + char_sha_additional_target, 4))
		end

		if #targets > 0 and char_hejiu == false then
			if char_juese[targets[1]].fangju[1] ~= "白银狮" then
				local card_use_jiu = ai_card_search(ID, "酒", 1)
				if (char_sha_time > 0 or char_juese[ID].wuqi[1] == "诸葛弩") and char_sha_able == true then
					if #card_use_jiu ~= 0 then
						if card_chupai_ai({card_use_jiu[1]}, ID, nil, nil, "酒") then
							return
						end
					end

					if char_juese[ID].skill["酒池"] == "available" then
						local fadong, shoupai = ai_judge_jiuchi(ID)
						if fadong == true then
							if card_chupai_ai({shoupai}, ID, nil, nil, "酒") then
								return
							end
						end
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
	if lihun_target ~= nil then
		skills_lihun_stage_2_ai()
		return
	end

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
	required = math.min(required, #char_juese[ID].shoupai)
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

	gamerun_qipai_n = 0
	for i = #qipai_id, 1, -1 do
		add_funcptr(_qipai_sub1, {qipai_id[i], ID})
		gamerun_qipai_n = gamerun_qipai_n + 1
	end
	if qizhuangbei_id[1] == 1 then
		add_funcptr(_qipai_sub4,ID)
		gamerun_qipai_n = gamerun_qipai_n + 1
	end

	if qizhuangbei_id[2] == 1 then
		add_funcptr(_qipai_sub5,ID)
		gamerun_qipai_n = gamerun_qipai_n + 1
	end

	if qizhuangbei_id[3] == 1 then
		add_funcptr(_qipai_sub6,ID)
		gamerun_qipai_n = gamerun_qipai_n + 1
	end

	if qizhuangbei_id[4] == 1 then
		add_funcptr(_qipai_sub7,ID)
		gamerun_qipai_n = gamerun_qipai_n + 1
	end
	skills_losecard(ID)
	
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
