--  AI 在牌堆中查找牌，若没有则尝试使用技能  --
function card_judge_chupai(ID, card)
	local name, card_id, card_name, card_huase, skill
	skill = ""
	name = char_juese[ID].name
	card_id = card_chazhao(ID,card)
	return card_id
end

function card_judge_arm(ID, card)
	local name, card_id, card_name, card_huase, skill
	skill = ""
	name = char_juese[ID].name
	card_id = card_chazhaoarm(ID,card)
	return card_id
end

--  AI从手牌中查找杀  --
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
function ai_chazhao_shan(ID, shoupai)
	local c_pos = _sha_card_chazhao(shoupai, "闪")
	if c_pos == -1 then
		--  甄姬倾国  --
		if char_juese[ID].skill["倾国"] == "available" then
			c_pos = _sha_chazhao_redblack(shoupai, false)
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

--  AI决定是否发动雌雄双股剑  --
function ai_judge_cixiong()
	return true
end

--  AI决定是否发动烈弓  --
function ai_judge_liegong(ID_s)
	if ID_s == char_current_i then
		return true
	end

	return true
end

--  AI决定是否发动贯石斧  --
function ai_judge_guanshi(ID_s)
	if #char_juese[ID_s].shoupai > 2 then
		return true
	end

	return false
end

--  AI决定是否发动寒冰剑  --
function ai_judge_hanbing(ID_mubiao)
	if #char_juese[ID_mubiao].shoupai >= 2 then
		return true
	end

	return false
end

--  AI决定是否发动青龙刀  --
function ai_judge_qinglong(ID_s)
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
	return false
end

--  AI决定雷击的目标 (暂为明身份)  --
function ai_judge_leiji_mubiao(ID_mubiao)
	local i, v
	
	if char_juese[ID_mubiao].shenfen == "反贼" then
		return ID_mubiao
	end
	
	for i, v in ipairs(char_juese) do
		if v.siwang == false then
			if v.shenfen == "反贼" then
				return i
			end
		end
	end
	
	for i, v in ipairs(char_juese) do
		if v.siwang == false then
			if v.shenfen == "内奸" then
				return i
			end
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
	end

	return nil
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
		range = card_wuqi_r[char_juese[ID_s].wuqi]
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
		if huase == "黑桃" and char_juese[ID].skill["红颜"] == "available" then
			huase = "红桃"
		end
		if huase == "黑桃" or huase == "草花" then
			yanse = "黑色"
		else
			yanse = "红色"
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
function ai_judge_target(ID,card_treated,cards,target_number)
	if target_number == nil then
		target_number = 1
	end
	local possible_target = {1,2,3,4,5}
	for i=5,1,-1 do
		if char_juese[possible_target[i]].siwang == true then
			table.remove(possible_target,i)
		elseif card_treated ~= "借刀杀人" and string.find(card_treated,"杀") ~= nil and ai_judge_cardinfo(ID,cards) == "黑色" and char_juese[possible_target[i]].skill["帷幕"] == "available" then
			table.remove(possible_target,i)
		elseif ID == possible_target[i] and card_treated == "铁索连环" and char_juese[ID].hengzhi == true then
			
		elseif ID == possible_target[i] then
			table.remove(possible_target,i)
		elseif char_juese[ID].shenfen == "主公" or char_juese[ID].shenfen == "忠臣" then
			if char_juese[possible_target[i]].isantigovernment == false and ((#char_juese[possible_target[i]].panding ~= 0 and (card_treated == "顺手牵羊" or card_treated == "过河拆桥")) or (char_juese[possible_target[i]].hengzhi == true and card_treated == "铁索连环")) then
				
			elseif char_juese[possible_target[i]].isantigovernment == false then
				table.remove(possible_target,i)
			end
		elseif char_juese[ID].shenfen == "反贼" then
			if char_juese[possible_target[i]].isantigovernment == true and ((#char_juese[possible_target[i]].panding ~= 0 and (card_treated == "顺手牵羊" or card_treated == "过河拆桥")) or (char_juese[possible_target[i]].hengzhi == true and card_treated == "铁索连环")) then
			
			elseif char_juese[possible_target[i]].isantigovernment ~= false then
				table.remove(possible_target,i)
			end
		elseif char_juese[ID].shenfen == "内奸" then
			if ai_judge_blackjack(ID)==true then
				if char_juese[possible_target[i]].isantigovernment == false then
					table.remove(possible_target,i)
				end
			else
				if char_juese[possible_target[i]].isantigovernment ~= false then
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
			if ai_judge_distance(ID,possible_target[i],1) == false and char_juese[ID].skill["奇才"] ~= "available" then
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
	elseif card_treated == "铁索连环" then
		--剔除已经横置的对手
		for i=#possible_target,1,-1 do
			if #char_juese[possible_target[i]].hengzhi == true and (char_juese[ID].shenfen == "主公" or char_juese[ID].shenfen == "忠臣") and char_juese[possible_target[i]].isantigovernment ~= false then
				table.remove(possible_target,i)
			elseif #char_juese[possible_target[i]].hengzhi == true and char_juese[ID].shenfen == "反贼" and char_juese[possible_target[i]].isantigovernment ~= true then
				table.remove(possible_target,i)
			end
		end
	elseif string.find(card_treated,"杀") then
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
		--剔除普杀藤甲
		for i=#possible_target,1,-1 do
			if char_juese[possible_target[i]].fangju[1] == "藤甲" and shuxing == false and #char_juese[ID].wuqi ~= "朱雀扇" and #char_juese[ID].wuqi ~= "青钢剑" then
				table.remove(possible_target,i)
			end
		end
		--剔除黑杀仁王
		for i=#possible_target,1,-1 do
			if char_juese[possible_target[i]].fangju[1] == "仁王盾" and ai_judge_cardinfo(ID,cards) == "黑色" and #char_juese[ID].wuqi ~= "青钢剑" then
				table.remove(possible_target,i)
			end
		end
		--剔除能流离给队友的角色
		for i=#possible_target,1,-1 do
			if char_juese[possible_target[i]].skill["流离"] == "available" then
				local liuli_target = ai_judge_in_range(i)
				if (#char_juese[possible_target[i]].shoupai ~= 0 or #char_juese[possible_target[i]].fangju ~= 0 or #char_juese[possible_target[i]].fangma ~= 0) and #liuli_target > 0 and (#liuli_target ~= 1 or liuli_target[1] ~= ID) then
					for j=1,#liuli_target do
						if ((char_juese[ID].shenfen == "主公" or char_juese[ID].shenfen == "忠臣") and char_juese[j].isantigovernment == false) or (char_juese[ID].shenfen == "反贼" and char_juese[j].isantigovernment == true) then
							table.remove(possible_target,i)
							break
						end
					end
				else
					if #char_juese[possible_target[i]].gongma ~= 0 then
						local liuli_target = ai_judge_in_range(i,nil,true)
						if  #liuli_target > 0 and (#liuli_target ~= 1 or liuli_target[1] ~= ID) then
							for j=1,#liuli_target do
								if ((char_juese[ID].shenfen == "主公" or char_juese[ID].shenfen == "忠臣") and char_juese[j].isantigovernment == false) or (char_juese[ID].shenfen == "反贼" and char_juese[j].isantigovernment == true) then
									table.remove(possible_target,i)
									break
								end
							end
						end
					elseif #char_juese[possible_target[i]].wuqi ~= 0 then
						local liuli_target = ai_judge_in_range(i,true)
						if  #liuli_target > 0 and (#liuli_target ~= 1 or liuli_target[1] ~= ID) then
							for j=1,#liuli_target do
								if ((char_juese[ID].shenfen == "主公" or char_juese[ID].shenfen == "忠臣") and char_juese[j].isantigovernment == false) or (char_juese[ID].shenfen == "反贼" and char_juese[j].isantigovernment == true) then
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
	while #possible_target > target_number do
		table.remove(possible_target,math.random(#possible_target))
	end
	return possible_target
end

--  AI根据条件查找牌 --
function ai_card_search(ID,kind,required)
	card_searched = {}
	if kind == "基本" then
		for i = #char_juese[ID].shoupai,1,-1 do
			if char_juese[ID].shoupai[i][1] == "杀" or char_juese[ID].shoupai[i][1] == "火杀" or char_juese[ID].shoupai[i][1] == "雷杀" or char_juese[ID].shoupai[i][1] == "闪" or char_juese[ID].shoupai[i][1] == "桃" or char_juese[ID].shoupai[i][1] == "酒" then
				table.insert(card_searched,i)
			end
		end
	elseif kind == "锦囊" then
		for i = #char_juese[ID].shoupai,1,-1 do
			if char_juese[ID].shoupai[i][1] == "兵粮寸断" or char_juese[ID].shoupai[i][1] == "过河拆桥" or char_juese[ID].shoupai[i][1] == "火攻" or char_juese[ID].shoupai[i][1] == "借刀杀人" or char_juese[ID].shoupai[i][1] == "决斗" or char_juese[ID].shoupai[i][1] == "乐不思蜀" or char_juese[ID].shoupai[i][1] == "南蛮入侵" or char_juese[ID].shoupai[i][1] == "闪电" or char_juese[ID].shoupai[i][1] == "顺手牵羊" or char_juese[ID].shoupai[i][1] == "乐不思蜀" or char_juese[ID].shoupai[i][1] == "桃园结义" or char_juese[ID].shoupai[i][1] == "铁索连环" or char_juese[ID].shoupai[i][1] == "万箭齐发" or char_juese[ID].shoupai[i][1] == "五谷丰登" or char_juese[ID].shoupai[i][1] == "无懈可击" or char_juese[ID].shoupai[i][1] == "无中生有" then
				table.insert(card_searched,i)
			end
		end
	elseif kind == "非无懈锦囊" then
		for i = #char_juese[ID].shoupai,1,-1 do
			if char_juese[ID].shoupai[i][1] == "兵粮寸断" or char_juese[ID].shoupai[i][1] == "过河拆桥" or char_juese[ID].shoupai[i][1] == "火攻" or char_juese[ID].shoupai[i][1] == "借刀杀人" or char_juese[ID].shoupai[i][1] == "决斗" or char_juese[ID].shoupai[i][1] == "乐不思蜀" or char_juese[ID].shoupai[i][1] == "南蛮入侵" or char_juese[ID].shoupai[i][1] == "闪电" or char_juese[ID].shoupai[i][1] == "顺手牵羊" or char_juese[ID].shoupai[i][1] == "乐不思蜀" or char_juese[ID].shoupai[i][1] == "桃园结义" or char_juese[ID].shoupai[i][1] == "铁索连环" or char_juese[ID].shoupai[i][1] == "万箭齐发" or char_juese[ID].shoupai[i][1] == "五谷丰登" or char_juese[ID].shoupai[i][1] == "无中生有" then
				table.insert(card_searched,i)
			end
		end
	elseif kind == "非延时锦囊" then
		for i = #char_juese[ID].shoupai,1,-1 do
			if char_juese[ID].shoupai[i][1] == "过河拆桥" or char_juese[ID].shoupai[i][1] == "火攻" or char_juese[ID].shoupai[i][1] == "借刀杀人" or char_juese[ID].shoupai[i][1] == "决斗" or char_juese[ID].shoupai[i][1] == "乐不思蜀" or char_juese[ID].shoupai[i][1] == "南蛮入侵" or char_juese[ID].shoupai[i][1] == "顺手牵羊" or char_juese[ID].shoupai[i][1] == "桃园结义" or char_juese[ID].shoupai[i][1] == "铁索连环" or char_juese[ID].shoupai[i][1] == "万箭齐发" or char_juese[ID].shoupai[i][1] == "五谷丰登" or char_juese[ID].shoupai[i][1] == "无懈可击" or char_juese[ID].shoupai[i][1] == "无中生有" then
				table.insert(card_searched,i)
			end
		end
	elseif kind == "装备" then
		for i = #char_juese[ID].shoupai,1,-1 do
			if char_juese[ID].shoupai[i][1] == "八卦阵" or char_juese[ID].shoupai[i][1] == "赤兔" or char_juese[ID].shoupai[i][1] == "雌雄剑" or char_juese[ID].shoupai[i][1] == "大宛" or char_juese[ID].shoupai[i][1] == "的卢" or char_juese[ID].shoupai[i][1] == "方天戟" or char_juese[ID].shoupai[i][1] == "贯石斧" or char_juese[ID].shoupai[i][1] == "古锭刀" or char_juese[ID].shoupai[i][1] == "寒冰剑" or char_juese[ID].shoupai[i][1] == "骅骝" or char_juese[ID].shoupai[i][1] == "绝影" or char_juese[ID].shoupai[i][1] == "诸葛弩" or char_juese[ID].shoupai[i][1] == "麒麟弓" or char_juese[ID].shoupai[i][1] == "青钢剑" or char_juese[ID].shoupai[i][1] == "仁王盾" or char_juese[ID].shoupai[i][1] == "白银狮" or char_juese[ID].shoupai[i][1] == "藤甲" or char_juese[ID].shoupai[i][1] == "青龙刀" or char_juese[ID].shoupai[i][1] == "朱雀扇" or char_juese[ID].shoupai[i][1] == "丈八矛" or char_juese[ID].shoupai[i][1] == "爪黄飞电" or char_juese[ID].shoupai[i][1] == "紫骍" then
				table.insert(card_searched,i)
			end
		end
	elseif kind == "武器" then
		for i = #char_juese[ID].shoupai,1,-1 do
			if char_juese[ID].shoupai[i][1] == "雌雄剑" or char_juese[ID].shoupai[i][1] == "方天戟" or char_juese[ID].shoupai[i][1] == "贯石斧" or char_juese[ID].shoupai[i][1] == "古锭刀" or char_juese[ID].shoupai[i][1] == "寒冰剑" or char_juese[ID].shoupai[i][1] == "诸葛弩" or char_juese[ID].shoupai[i][1] == "麒麟弓" or char_juese[ID].shoupai[i][1] == "青钢剑" or char_juese[ID].shoupai[i][1] == "青龙刀" or char_juese[ID].shoupai[i][1] == "朱雀扇" or char_juese[ID].shoupai[i][1] == "丈八矛" then
				table.insert(card_searched,i)
			end
		end
	elseif kind == "防具" then
		for i = #char_juese[ID].shoupai,1,-1 do
			if char_juese[ID].shoupai[i][1] == "八卦阵" or char_juese[ID].shoupai[i][1] == "白银狮" or char_juese[ID].shoupai[i][1] == "藤甲" or char_juese[ID].shoupai[i][1] == "仁王盾" then
				table.insert(card_searched,i)
			end
		end	
	elseif kind == "+1马" then
		for i = #char_juese[ID].shoupai,1,-1 do
			if char_juese[ID].shoupai[i][1] == "的卢" or char_juese[ID].shoupai[i][1] == "爪黄飞电" or char_juese[ID].shoupai[i][1] == "骅骝" or char_juese[ID].shoupai[i][1] == "绝影" then
				table.insert(card_searched,i)
			end
		end	
	elseif kind == "-1马" then
		for i = #char_juese[ID].shoupai,1,-1 do
			if char_juese[ID].shoupai[i][1] == "紫骍" or char_juese[ID].shoupai[i][1] == "赤兔" or char_juese[ID].shoupai[i][1] == "大宛" then
				table.insert(card_searched,i)
			end
		end	
	elseif kind == "红色" then
		for i = #char_juese[ID].shoupai,1,-1 do
			local ys,hs,ds = ai_judge_cardinfo(ID,{char_juese[ID].shoupai[i]})
			if ys == "红色" then
				table.insert(card_searched,i)
			end
		end	
	elseif kind == "黑色" then
		for i = #char_juese[ID].shoupai,1,-1 do
			local ys,hs,ds = ai_judge_cardinfo(ID,{char_juese[ID].shoupai[i]})
			if ys == "黑色" then
				table.insert(card_searched,i)
			end
		end	
	elseif kind == "红桃" then
		for i = #char_juese[ID].shoupai,1,-1 do
			local ys,hs,ds = ai_judge_cardinfo(ID,{char_juese[ID].shoupai[i]})
			if hs == "红桃" then
				table.insert(card_searched,i)
			end
		end	
	elseif kind == "方块" then
		for i = #char_juese[ID].shoupai,1,-1 do
			local ys,hs,ds = ai_judge_cardinfo(ID,{char_juese[ID].shoupai[i]})
			if hs == "方块" then
				table.insert(card_searched,i)
			end
		end	
	elseif kind == "黑桃" then
		for i = #char_juese[ID].shoupai,1,-1 do
			local ys,hs,ds = ai_judge_cardinfo(ID,{char_juese[ID].shoupai[i]})
			if hs == "黑桃" then
				table.insert(card_searched,i)
			end
		end	
	elseif kind == "草花" then
		for i = #char_juese[ID].shoupai,1,-1 do
			local ys,hs,ds = ai_judge_cardinfo(ID,{char_juese[ID].shoupai[i]})
			if hs == "草花" then
				table.insert(card_searched,i)
			end
		end	
	elseif kind == "随意" then
		for i = #char_juese[ID].shoupai,1,-1 do
			table.insert(card_searched,i)
		end	
	elseif tonumber(kind) ~= nil then
		if tonumber(kind) > 0 then
			for i = #char_juese[ID].shoupai,1,-1 do
				local ys,hs,ds = ai_judge_cardinfo(ID,{char_juese[ID].shoupai[i]})
				if ds >= tonumber(kind) then
					table.insert(card_searched,i)
				end
			end	
		elseif tonumber(kind) < 0 then
			for i = #char_juese[ID].shoupai,1,-1 do
				local ys,hs,ds = ai_judge_cardinfo(ID,{char_juese[ID].shoupai[i]})
				if ds <= math.abs(tonumber(kind)) then
					table.insert(card_searched,i)
				end
			end
		end	
	elseif kind == "杀" then
		for i = #char_juese[ID].shoupai,1,-1 do
			if char_juese[ID].shoupai[i][1] == "杀" or char_juese[ID].shoupai[i][1] == "火杀" or char_juese[ID].shoupai[i][1] == "雷杀" then
				table.insert(card_searched,i)
			end
		end
	elseif kind == "普通杀" then
		for i = #char_juese[ID].shoupai,1,-1 do
			if char_juese[ID].shoupai[i][1] == "杀" then
				table.insert(card_searched,i)
			end
		end
	else
		for i = #char_juese[ID].shoupai,1,-1 do
			if char_juese[ID].shoupai[i][1] == kind then
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
function ai_card_stat(ID)
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
	card = card + table.maxn(char_juese[ID].shoupai)
	return card
end

--  AI主动弃置牌 --
function ai_judge_withdraw(ID,required)
	if ai_card_stat(ID) < required then
		for i = 1, table.maxn(char_juese[ID].shoupai) do
			if char_juese[ID].shoupai[1] ~= nil then
				_qipai_sub2({ID, 1})
			end
		end
		if #char_juese[ID].wuqi ~= 0 then
			_qipai_sub4(ID)
		end
		if #char_juese[ID].fangju ~= 0 then
			_qipai_sub5(ID)
		end
		if #char_juese[ID].gongma ~= 0 then
			_qipai_sub6(ID)
		end
		if #char_juese[ID].fangma ~= 0 then
			_qipai_sub7(ID)
		end
		return false
	else
		local withdraw_needed = required
		while withdraw_needed >= 0 do
			local withdrawed = ai_card_search(ID,"非无懈锦囊",withdraw_needed)
			for i = 1,#withdrawed do
				_qipai_sub2({ID, withdrawed[i]})
				withdraw_needed = withdraw_needed - 1
			end
			if withdraw_needed <= 0 then
				break
			end
			local withdrawed = ai_card_search(ID,"装备",withdraw_needed)
			for i = 1,#withdrawed do
				_qipai_sub2({ID, withdrawed[i]})
				withdraw_needed = withdraw_needed - 1
			end
			if withdraw_needed <= 0 then
				break
			end
			local withdrawed = ai_card_search(ID,"普通杀",withdraw_needed)
			for i = 1,#withdrawed do
				_qipai_sub2({ID, withdrawed[i]})
				withdraw_needed = withdraw_needed - 1
			end
			if withdraw_needed <= 0 then
				break
			end
			local withdrawed = ai_card_search(ID,"雷杀",withdraw_needed)
			for i = 1,#withdrawed do
				_qipai_sub2({ID, withdrawed[i]})
				withdraw_needed = withdraw_needed - 1
			end
			if withdraw_needed <= 0 then
				break
			end
			local withdrawed = ai_card_search(ID,"火杀",withdraw_needed)
			for i = 1,#withdrawed do
				_qipai_sub2({ID, withdrawed[i]})
				withdraw_needed = withdraw_needed - 1
			end
			if withdraw_needed <= 0 then
				break
			end
			local withdrawed = ai_card_search(ID,"酒",withdraw_needed)
			for i = 1,#withdrawed do
				_qipai_sub2({ID, withdrawed[i]})
				withdraw_needed = withdraw_needed - 1
			end
			if withdraw_needed <= 0 then
				break
			end
			local withdrawed = ai_card_search(ID,"无懈可击",withdraw_needed)
			for i = 1,#withdrawed do
				_qipai_sub2({ID, withdrawed[i]})
				withdraw_needed = withdraw_needed - 1
			end
			if withdraw_needed <= 0 then
				break
			end
			local withdrawed = ai_card_search(ID,"闪",withdraw_needed)
			for i = 1,#withdrawed do
				_qipai_sub2({ID, withdrawed[i]})
				withdraw_needed = withdraw_needed - 1
			end
			if withdraw_needed <= 0 then
				break
			end
			local withdrawed = ai_card_search(ID,"桃",withdraw_needed)
			for i = 1,#withdrawed do
				_qipai_sub2({ID, withdrawed[i]})
				withdraw_needed = withdraw_needed - 1
			end
			if withdraw_needed <= 0 then
				break
			end
			local withdrawed = ai_card_search(ID,"随便",withdraw_needed)
			for i = 1,#withdrawed do
				_qipai_sub2({ID, withdrawed[i]})
				withdraw_needed = withdraw_needed - 1
			end
			if withdraw_needed <= 0 then
				break
			end
			if #char_juese[ID].gongma ~= 0 then
				_qipai_sub6(ID)
				withdraw_needed = withdraw_needed - 1
			end
			if withdraw_needed <= 0 then
				break
			end
			if #char_juese[ID].wuqi ~= 0 then
				_qipai_sub4(ID)
				withdraw_needed = withdraw_needed - 1
			end
			if withdraw_needed <= 0 then
				break
			end
			if #char_juese[ID].fangma ~= 0 then
				_qipai_sub7(ID)
				withdraw_needed = withdraw_needed - 1
			end
			if withdraw_needed <= 0 then
				break
			end
			if #char_juese[ID].fangju ~= 0 then
				_qipai_sub5(ID)
				withdraw_needed = withdraw_needed - 1
			end
			if withdraw_needed <= 0 then
				break
			elseif #char_juese[ID].fangju == 0 and char_juese[ID].fangma == 0 and #char_juese[ID].wuqi == 0 and #char_juese[ID].gongma == 0 and #char_juese[ID].shoupai == 0 then
				break
			end
		end
		return true
	end
end

--  AI弃置其他角色牌 --
function ai_judge_withdraw_other(ID,is_zhuangbei_included,is_panding_included,is_enemy,is_visible)
	if is_enemy then
		if is_zhuangbei_included == true and (#char_juese[ID].gongma ~= 0 or #char_juese[ID].wuqi ~= 0 or #char_juese[ID].fangma ~= 0 or #char_juese[ID].fangju ~= 0) then
			if #char_juese[ID].fangju ~= 0 then
				_qipai_sub5(ID,nil,true)
			end
			if #char_juese[ID].fangma ~= 0 then
				_qipai_sub7(ID,nil,true)
			end
			if #char_juese[ID].wuqi ~= 0 then
				_qipai_sub4(ID,nil,true)
			end
			if #char_juese[ID].gongma ~= 0 then
				_qipai_sub6(ID,nil,true)
			end
		else
			if #char_juese[ID].shoupai ~= 0 then
				_qipai_sub2({ID,math.random(#char_juese[ID].shoupai),true})
			else
				if is_panding_included == true and #char_juese[ID].panding ~= 0 then
					for i = 1,#char_juese[ID].panding do
						if char_juese[ID].panding[i][1] == "闪电" then
							_qipai_sub3({ID,i,true})
						end
					end
					for i = 1,#char_juese[ID].panding do
						if char_juese[ID].panding[i][1] == "兵粮寸断" then
							return "判定",i
						end
					end
					_qipai_sub3({ID,i,true})
				else
					return
				end
			end
		end
	else
		if is_panding_included == true and #char_juese[ID].panding ~= 0 then
			for i = 1,#char_juese[ID].panding do
				if char_juese[ID].panding[i][1] == "乐不思蜀" then
					_qipai_sub3({ID,i,true})
				end
			end
			for i = 1,#char_juese[ID].panding do
				if char_juese[ID].panding[i][1] == "兵粮寸断" then
					_qipai_sub3({ID,i,true})
				end
			end
			return _qipai_sub3({ID,1,true})
		else
			if #char_juese[ID].shoupai ~= 0 then
				_qipai_sub2({ID,math.random(#char_juese[ID].shoupai),true})
			elseif is_zhuangbei_included == true then
				if #char_juese[ID].gongma ~= 0 then
					_qipai_sub6(ID,nil,true)
				end
				if #char_juese[ID].wuqi ~= 0 then
					_qipai_sub4(ID,nil,true)
				end
				if #char_juese[ID].fangma ~= 0 then
					_qipai_sub7(ID,nil,true)
				end
				if #char_juese[ID].fangju ~= 0 then
					_qipai_sub5(ID,nil,true)
				end
				return
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

--  AI回合内使用牌 --
function ai_card_use(ID)
	if char_juese[ID].tili < char_juese[ID].tili_max then
		local card_use = ai_card_search(ID,"桃",1)
		if #card_use ~= 0 then
			card_chupai(card_use[1])
			return
		end
	end
	if #char_juese[ID].wuqi == 0 or card_juese[ID].skill["枭姬"] == "available" then
		local card_use = ai_card_search(ID,"武器",1)
		if #card_use ~= 0 then
			card_chupai(card_use[1])
			return
		end
	end
	if #char_juese[ID].wuqi == 0 or card_juese[ID].skill["枭姬"] == "available" then
		local card_use = ai_card_search(ID,"防具",1)
		if #card_use ~= 0 then
			card_chupai(card_use[1])
			return
		end
	end
	if #char_juese[ID].wuqi == 0 or card_juese[ID].skill["枭姬"] == "available" then
		local card_use = ai_card_search(ID,"-1马",1)
		if #card_use ~= 0 then
			card_chupai(card_use[1])
			return
		end
	end
	if #char_juese[ID].wuqi == 0 or card_juese[ID].skill["枭姬"] == "available" then
		local card_use = ai_card_search(ID,"+1马",1)
		if #card_use ~= 0 then
			card_chupai(card_use[1])
			return
		end
	end
	local card_use = ai_card_search(ID,"五谷丰登",1)
	if #card_use ~= 0 then
		card_chupai(card_use[1])
		return
	end
	local card_use = ai_card_search(ID,"过河拆桥",1)
	if #card_use ~= 0 then
		card_chupai(card_use[1])
		return
	end
	local card_use = ai_card_search(ID,"铁索连环",1)
	if #card_use ~= 0 then
		card_chupai(card_use[1])
		return
	end
	local card_use = ai_card_search(ID,"顺手牵羊",1)
	if #card_use ~= 0 then
		card_chupai(card_use[1])
		return
	end
	local card_use = ai_card_search(ID,"南蛮入侵",1)
	if #card_use ~= 0 then
		card_chupai(card_use[1])
		return
	end
	local card_use = ai_card_search(ID,"万箭齐发",1)
	if #card_use ~= 0 then
		card_chupai(card_use[1])
		return
	end
	local card_use = ai_card_search(ID,"决斗",1)
	if #card_use ~= 0 then
		card_chupai(card_use[1])
		return
	end
	local card_use = ai_card_search(ID,"借刀杀人",1)
	if #card_use ~= 0 then
		card_chupai(card_use[1])
		return
	end
	local card_use = ai_card_search(ID,"火攻",1)
	if #card_use ~= 0 then
		card_chupai(card_use[1])
		return
	end
	local card_use = ai_card_search(ID,"无中生有",1)
	if #card_use ~= 0 then
		card_chupai(card_use[1])
		return
	end
	local card_use = ai_card_search(ID,"桃园结义",1)
	if #card_use ~= 0 then
		card_chupai(card_use[1])
		return
	end
	local card_use = ai_card_search(ID,"杀",1)
	if #card_use > 1 then
		local card_use = ai_card_search(ID,"酒",1)
		if #card_use ~= 0 then
			card_chupai(card_use[1])
			return
		end
	end
	local card_use = ai_card_search(ID,"杀",1)
	if #card_use ~= 0 then
		card_chupai(card_use[1])
		return
	end
	local card_use = ai_card_search(ID,"乐不思蜀",1)
	if #card_use ~= 0 then
		card_chupai(card_use[1])
		return
	end
	local card_use = ai_card_search(ID,"兵粮寸断",1)
	if #card_use ~= 0 then
		card_chupai(card_use[1])
		return
	end
	local card_use = ai_card_search(ID,"闪电",1)
	if #card_use ~= 0 then
		card_chupai(card_use[1])
		return
	end
end

--  AI身份判定 --
--[[isantigovernment:nil未确定,false为忠臣,true为反贼
isblackjack:true为内奸
]]
function ai_judge_shenfen()
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





--  以下不是我写的





--[[
--  AI 回合内出牌处理  --
function auto_chupai(ID)
	local shoupai_c, tili, tili_max, name, shenfen, shili
	local wuqi_name
	local shoupai_pos
	
	shenfen = char_juese[ID].shenfen
	name = char_juese[ID].name
	shoupai_c = #char_juese[ID].shoupai
	tili_max = char_juese[ID].tili_max
	tili = char_juese[ID].tili
	shili = char_juese_jineng[char_juese[ID].name][2]
	
	if #char_juese[ID].wuqi ~= 0 then
		wuqi_name = char_juese[ID].wuqi[1]
	end
	
	if char_juese[ID].siwang then
		return true
	end
	
	if name == "黄盖" then
		if (shenfen == "主公" and tili > 2) or (shenfen == "内奸" and tili > 3) or (shenfen == "忠臣" and tili > 2) or (shenfen == "反贼" and tili > 2) then
			skills_kurou_ai()
			return false
		end
	end
	
	if shoupai_c < 1 then
		return true
	end
	
	shoupai_pos = card_judge_chupai(ID, "无中生有")
	if shoupai_pos > 0 then
		if card_wuzhong_ai(ID, shoupai_pos) then
			return false
		end
	end
	
	shoupai_pos = card_judge_chupai(ID, "顺手牵羊")
	if shoupai_pos > 0 then
		if card_shun_ai(ID, shoupai_pos) then
			return false
		end
	end
	
	if name ~= "魏延" then
		if tili < tili_max then
			shoupai_pos = card_judge_chupai(ID, "桃")
			if shoupai_pos > 0 then
				if card_tao_ai(ID, shoupai_pos) then
					return false
				end
			end
		end
	end
	
	if name == "孙权" and skill_used == false and tili < 2 then
		if skills_zhiheng_ai(ID) then
			return false
		end
	end
	
	if name == "华佗" and shoupai_c == 1 and skill_used == false then
		if skills_qingnang_ai(ID) then
			return false
		end
	end
	
	if name == "貂蝉" and shoupai_c == 1 and skill_used == false then
		if skills_lijian_ai(ID) then
			return false
		end
	end
	
	if name == "周瑜" and shoupai_c == 1 and skill_used == false then
		if skills_fanjian_ai(ID) then
			return false
		end
	end
	
	if name == "孙尚香" and shoupai_c == 1 and skill_used == false then
		if skills_jieyin_ai(ID) then
			return false
		end
	end
	
	if name == "刘备" then
		if shoupai_c == 2 then
			if skills_rende_ai(ID) then
				return false
			end
		end
	end
	
	if name == "甘宁" then
		shoupai_pos = card_judge_arm(ID, "防具")
		if shoupai_pos > 0 then
			if card_arm_ai(ID, shoupai_pos) then
				return false
			end
		end
	end
	
	shoupai_pos = card_judge_chupai(ID, "过河拆桥")
	if shoupai_pos > 0 then
		if card_chai_ai(ID, shoupai_pos) then
			return false
		end
	end
	
	shoupai_pos = card_judge_chupai(ID, "南蛮入侵")
	if shoupai_pos > 0 then
		if card_nanman_ai(ID, shoupai_pos) then
			return false
		end
	end
	
	shoupai_pos = card_judge_chupai(ID, "万箭齐发")
	if shoupai_pos > 0 then
		if card_wanjian_ai(ID, shoupai_pos) then
			return false
		end
	end
	
	shoupai_pos = card_judge_arm(ID, "-1马")
	if shoupai_pos > 0 then
		if card_arm_ai(ID, shoupai_pos) then
			return false
		end
	end
	
	shoupai_pos = card_judge_arm(ID, "武器")
	if shoupai_pos > 0 then
		if card_arm_ai(ID, shoupai_pos) then
			return false
		end
	end
	
	if ai_judge_able_sha(ID) then
		shoupai_pos = card_judge_chupai(ID, "杀")
		if shoupai_pos > 0 then
			if card_sha_ai(ID, shoupai_pos) then
				return false
			end
		end
		shoupai_pos = card_judge_chupai(ID, "火杀")
		if shoupai_pos > 0 then
			if card_sha_ai(ID, shoupai_pos) then
				return false
			end
		end
		shoupai_pos = card_judge_chupai(ID, "雷杀")
		if shoupai_pos > 0 then
			if card_sha_ai(ID, shoupai_pos) then
				return false
			end
		end
	end
	
	if name == "周瑜" and shoupai_c > 0 and skill_used == false then
		if skills_fanjian_ai(ID) then
			return false
		end
	end
	
	shoupai_pos = card_judge_chupai(ID, "决斗")
	if shoupai_pos > 0 then
		if ai_get_attackid(ID, "决斗", shoupai_pos) then
			if card_juedou_judge_ai(ID, shoupai_pos) then
				if card_juedou_ai(ID, shoupai_pos) then
					return false
				end
			end
		end
	end
	
	shoupai_pos = card_judge_chupai(ID, "借刀杀人")
	if shoupai_pos > 0 then
		if card_jiedao_ai(ID, shoupai_pos) then
			return false
		end
	end
	
	shoupai_pos = card_judge_arm(ID, "防具")
	if shoupai_pos > 0 then
		if card_arm_ai(ID, shoupai_pos) then
			return false
		end
	end
	
	if name == "貂蝉" and shoupai_c > 0 and skill_used == false then
		if skills_lijian_ai(ID) then
			return false
		end
	end
	
	shoupai_pos = card_judge_chupai(ID, "闪电")
	if shoupai_pos > 0 then
		if card_shandian_ai(ID, shoupai_pos) then
			return false
		end
	end
	
	shoupai_pos = card_judge_chupai(ID, "乐不思蜀")
	if shoupai_pos > 0 then
		if card_le_ai(ID, shoupai_pos) then
			return false
		end
	end
	
	shoupai_pos = card_judge_chupai(ID, "兵粮寸断")
	if shoupai_pos > 0 then
		if card_bingliang_ai(ID, shoupai_pos) then
			return false
		end
	end

	shoupai_pos = card_judge_chupai(ID, "桃园结义")
	if shoupai_pos > 0 then
		if card_taoyuan_ai(ID, shoupai_pos) then
			return false
		end
	end
	
	if name == "魏延" then
		if tili < tili_max then
			shoupai_pos = card_judge_chupai(ID, "桃")
			if shoupai_pos > 0 then
				if card_tao_ai(ID, shoupai_pos) then
					return false
				end
			end
		end
	end
	
	if name == "孙权" and skill_used == false and shoupai_c > 0 then
		if skills_zhiheng_ai(ID) then
			return false
		end
	end
	
	if name == "华佗" and shoupai_c > 0 and skill_used == false then
		if skills_qingnang_ai(ID) then
			return false
		end
	end
	
	if name == "孙尚香" and shoupai_c > 0 and skill_used == false then
		if skills_jieyin_ai(ID) then
			return false
		end
	end
	
	if name == "刘备" and shoupai_c >= 2 then
		if skills_rende_ai(ID) then
			return false
		end
	end
	
	if name == "黄盖" then
		if shenfen == "反贼" and tili > 1 then
			skills_kurou_ai()
			return false
		end
	end
	
	return true
end

--  判断判定区内是否有牌  --
function ai_judge_jinnang(ID)
	if #char_juese[ID].panding > 0 then
		return true
	end
	return false
end

--  判断是否解救当前目标 (使摆脱不利状态)  --
function ai_judge_jiejiu(ID_s, ID_d, action)
	local s_shenfen, s_name, d_name, d_shenfen
	local i
	local fanzei_tili, zhugong_tili, shenfen_unknown_c, _unknown_tili, zhongchen_siwang_c
	local cunhuo
	
	if ID_s == ID_d then
		return true
	end
	
	if char_juese[ID_d].siwang then
		return false
	end
	
	s_name = char_juese[ID_s].name
	d_name = char_juese[ID_d].name
	s_shenfen = char_juese[ID_s].shenfen
	d_shenfen = char_juese[ID_d].shenfen
	
	if s_shenfen == "忠臣" and d_shenfen ~= "主公" then
		return false
	end
	if s_shenfen == "反贼" and not (d_shenfen == "反贼" and char_juese[ID_d].shenfen_unknown == false) then
		return false
	end
	if s_shenfen == "内奸" and d_shenfen ~= "主公" then
		return false
	end
	if s_shenfen == "主公" and char_juese[ID_d].shenfen_unknown == false then
		return false
	end
	if s_shenfen == "内奸" and d_shenfen == "主公" then
		cunhuo = 0
		fanzei_tili = 0
		for i = 1, 5 do
			if i ~= ID_s and i ~= ID_d then
				if char_juese[i].siwang == false then
					if char_juese[i].shenfen == "反贼" and char_juese[ID_d].shenfen_unknown == false then
						fanzei_tili = char_juese[i].tili
					end
					cunhuo = cunhuo + 1
				end
			end
		end
		if cunhuo == 0 then
			return false
		end
		if cunhuo == 1 then
			zhugong_tili = char_juese[ID_d].tili
			if fanzei_tili > 0 then
				if zhugong_tili - fanzei_tili >= 2 then
					return false
				end
			else
				return false
			end
		end
	end
	
	if s_shenfen == "主公" and char_juese[ID_d].shenfen_unknown then
		cunhuo = 2
		shenfen_unknown_c = 1
		zhongchen_siwang_c = 0
		_unknown_tili = char_juese[ID_d].tili
		for i = 1, 5 do
			if i ~= ID_s and i ~= ID_d then
				if char_juese[i].siwang == false then
					cunhuo = cunhuo + 1
				end
				if char_juese[i].shenfen_unknown then
					shenfen_unknown_c = shenfen_unknown_c + 1
				end
				if char_juese[i].shenfen == "忠臣" and char_juese[i].siwang then
					zhongchen_siwang_c = zhongchen_siwang_c + 1
				end
				if char_juese[i].shenfen == "反贼" and char_juese[i].shenfen_unknown == false and char_juese[i].siwang == false then
					fanzei_tili = char_juese[i].tili
				end
			end
		end
		if shenfen_unknown_c > 1 then
			if math.floor(shenfen_unknown_c * math.random()) > 0 then
				return false
			end
		else
			if zhongchen_siwang_c > 0 then
				if cunhuo == 2 then
					return false
				end
				if cunhuo == 3 then
					if action == "顺手牵羊" or action == "过河拆桥" then
						return false
					end
					if fanzei_tili > 0 and _unknown_tili - fanzei_tili >= 2 then
						return false
					end
				end
			end
		end
	end
	if action == "顺手牵羊" or action == "过河拆桥" then
		if ai_judge_jinnang(ID_d) then
			return false
		end
		if action == "顺手牵羊" and d_name == "陆逊" then
			return false
		end
		if action == "顺手牵羊" and s_name ~= "黄月英" then
			if char_calc_distance(ID_s, ID_d) > 1 then
				return false
			end
		end
	end
	
	return true
end

--  判断是否攻击当前目标 (使处于不利状态)  --
function ai_judge_gongji(ID_s, ID_d, action)
	local s_shenfen, d_tili, d_shenfen, d_unknown
	local cunhuo, shenfen, shenfen_unknown_c, tili
	local shenfen_unknown_id, _unknown_tili, zhongchen_siwang, zhongchen_fangyu, fanzei_id, fanzei_fangyu, neijian_id, neijian_fangyu, zhugong_id, zhugong_fangyu
	local i
	
	s_shenfen = char_juese[ID_s].shenfen
	d_tili = char_juese[ID_d].tili
	d_shenfen = char_juese[ID_d].shenfen
	d_unknown = char_juese[ID_d].shenfen_unknown
	
	if ID_s == ID_mubiao then
		return false
	end
	if char_juese[ID_mubiao].siwang == true then
		return false
	end
	
	if s_shenfen == "忠臣" then
		if d_shenfen == "主公" then
			return false
		end
	elseif s_shenfen == "反贼" then
		if d_unknown == true then
			if d_shenfen == "反贼" then
				return false
			end
		else
			local fanzei_expose = 0
			cunhuo = 0
			for i = 1, 5 do
				if char_juese[i].siwang == false then
					cunhuo = cunhuo + 1
				end
				shenfen = char_juese[i].shenfen
				if i ~= ID_s and shenfen == "反贼" and char_juese[i].shenfen_unknown == false then
					fanzei_expose = fanzei_expose + 1
				end
			end
			if fanzei_expose == 0 and math.floor(cunhuo * math.random()) == 0 then
				return false
			end
		end
	elseif s_shenfen == "主公" then
		if d_unkonwn then
			cunhuo = 0
			shenfen_unknown_c = 0
			zhongchen_siwang = 0
			for i = 1, 5 do
				if char_juese[i].siwang == false then
					cunhuo = cunhuo + 1
				end
				if char_juese[i].shenfen_unknown then
					shenfen_unknown_c = shenfen_unknown_c + 1
					if i ~= ID_mubiao then
						shenfen_unknown_id = i
						_unknown_tili = char_juese[i].tili
					end
				end
				if char_juese[i].shenfen == "忠臣" and char_juese[i].siwang then
					zhongchen_siwang = zhongchen_siwang + 1
				end
				if char_juese[i].shenfen == "反贼" and char_juese[i].shenfen_unknown == false and char_juese[i].siwang == false then
					fanzei_id = i
					fanzei_fangyu = calc_fangyu(ID_s, i)
				end
			end
			if shenfen_unknown_c > 1 then
				if cunhuo > 3 then
					return false
				end
				if action == "过河拆桥" or action == "杀" or action == "流离" or action == "离间" then
					if d_tili <= 2 or d_tili < _unknown_tili then
						return false
					end
				elseif action == "顺手牵羊" then
					if d_tili <= 1 or d_tili < _unknown_tili then
						return false
					end
				else
					return false
				end
				return true
			end
			if zhongchen_siwang == 0 then
				return false
			end
			if cunhuo > 3 then
				return false
			end
			neijian_fangyu = calc_fangyu(ID_s, ID_mubiao)
			if fanzei_fangyu > 0 and neijian_fangyu - fanzei_fangyu < 8 then
				return false
			end
		end
	elseif s_shenfen == "内奸" then
		cunhuo = 1
		shenfen_unknown_c = 0
		fanzei_fangyu = 0
		for i = 1, 5 do
			shenfen = char_juese[i].shenfen
			tili = char_juese[i].tili
			if i ~= ID_s and char_juese[i].siwang == false then
				cunhuo = cunhuo + 1
				if shenfen == "主公" then
					zhugong_id = i
					zhugong_fangyu = calc_fangyu(ID_s, i)
				elseif char_juese[i].shenfen_unknown then
					shenfen_unknown_c = shenfen_unknown_c + 1
					zhongchen_fangyu = calc_fangyu(ID_s, i)
					_unknown_id = i
				elseif shenfen == "反贼" then
					fanzei_fangyu = fanzei_fangyu + calc_fangyu(ID_s, i)
				end
			end
		end
		neijian_fangyu = calc_fangyu(ID_s, ID_s)
		if d_shenfen == "主公" then
			if cunhuo > 3 then
				return false
			end
			if cunhuo == 3 then
				if shenfen_unknown_c > 0 then
					return false
				else
					if zhugong_fangyu <= fanzei_fangyu + 8 then
						return false
					end
				end
			end
		end
	end
	if d_unknown then
		if zhugong_fangyu + zhongchen_fangyu + neijian_fangyu < fanzei_fangyu + 12 then
			return false
		end
	end
	if d_shenfen == "反贼" and d_unknown == false then
		if cunhuo == 3 then
			if zhugong_fangyu > fanzei_fangyu + 8 then
				if ai_judge_able_gongji(ID_s, ID_d, action) then
					return false
				end
			else
				if _unknown_ID > 0 then
					if ai_judge_shazhong(ID_s, _unknown_id) then
						return false
					end
				end
			end
		end
	end
	
	return true
end

--  决定是否要响应决斗  --
function ai_judge_response_juedou(ID_s, ID_d)
	local s_shenfen, s_tili, d_shenfen, d_tili
	
	if ai_judge_gongji(ID_s, ID_d, "?") then
		return true
	end
	
	s_shenfen = char_juese[ID_s].shenfen
	s_tili = char_juese[ID_s].tili
	d_shenfen = char_juese[ID_d].shenfen
	d_tili = char_juese[ID_d].tili
	
	if s_shenfen == "主公" then
		if char_juese[ID_d].shenfen_unknown then
			if s_tili < d_tili + 2 then
				return true
			end
		else
			return true
		end
	elseif s_shenfen == "忠臣" then
		if d_shenfen == "主公" then
			if s_tili <= d_tili - 2 then
				return true
			end
		else
			return true
		end
	elseif s_shenfen == "反贼" then
		if d_shenfen == "反贼" and char_juese[ID_d].shenfen_unknown == false then
			if char_juese[ID_s].shenfen_unknown == false then
				if s_tili <= d_tili then
					return true
				end
			end
		else
			return true
		end
	elseif s_shenfen == "内奸" then
		if s_tili == 1 then
			return true
		end
		if d_shenfen == "主公" then
			if s_tili < d_tili or d_tili > 3 then
				return true
			end
		else
			return true
		end
	end
	
	return false
end

--  决定是否出桃园结义  --
function ai_judge_taoyuan(ID)
	local tili, tili_min, tili_max, current_tili
	local i, iCount
	local tili_deduct = {0, 0, 0, 0, 0, 0}
	
	tili = char_juese[ID].tili
	tili_min = 9
	iCount = 0
	
	for i = 1, 5 do
		tili_max = char_juese[i].tili_max
		current_tili = char_juese[i].tili
		if current_tili > 0 then
			if tili_max > current_tili then
				tili_deduct[i] = tili_max - current_tili
				iCount = iCount + 1
			end
			if tili_min > current_tili then
				tili_min = current_tili
			end
		end
	end
	if iCount == 0 then
		return false
	end
	for i = 1, 5 do
		if tili_deduct[i] > 0 then
			if ai_judge_jiejiu(ID, i, "桃") then
				if iCount > 1 and tili > 1 then
					current_tili = char_juese[i].tili
					if tili_min ~= current_tili then
						return false
					end
					if tili_min > 2 then
						return false
					end
				end
				return true
			end
		end
	end
	return false
end

--  决定是否使用 AOE  --
function ai_judge_AOE(ID)
	local tili, tili_min, tili_notattack
	local i
	
	tili_min = 9
	tili_notattack = 9
	
	for i = 1, 5 do
		if i ~= ID then
			tili = char_juese[i].tili
			if tili > 0 and char_juese[i].siwang == false then
				if tili_min > tili then tili_min = tili end
				if ai_judge_gongji(ID, i, "南蛮入侵") == false then
					if tili_notattack > tili then
						tili_notattack = tili
					end
				end
			end
		end
	end
	
	if tili_notattack > 2 or tili_notattack > tili_min then
		return true
	end
	return false
end

--  判断当前角色是否能够攻击对方  --
function ai_judge_able_gongji(ID_s, ID_d, action)
	if char_juese[ID_d].tili < 1 then
		return false
	end
	if card_if_d_limit(action, ID_s, ID_d) == false then
		return false
	end
	return true
end

--  计算当前对象的防御系数  --
function calc_fangyu(ID_s, ID_d, action)
	local ans
	local s_shenfen, d_shenfen, d_name, d_cards, d_tilimax
	
	s_shenfen = char_juese[ID_s].shenfen
	d_shenfen = char_juese[ID_d].shenfen
	d_name = char_juese[ID_d].name
	d_cards = #char_juese[ID_d].shoupai
	d_tilimax = char_juese[ID_d].tili_max
	
	ans = calc_direct_fangyu(ID_d)
	
	if s_shenfen == "主公" and d_shenfen == "反贼" and char_juese[ID_d].shenfen_unknown == false then
		ans = ans - 6
	end
	if s_shenfen == "反贼" and d_shenfen == "主公" then
		ans = ans - 6
		if action == "顺手牵羊" or action == "过河拆桥" or action == "乐不思蜀" or action == "兵粮寸断" then
			ans = ans - 6
		end
	end
	if s_shenfen == "忠臣" and d_shenfen == "反贼" and char_juese[ID_d].shenfen_unknown == false then
		ans = ans - 6
	end
	if s_shenfen == "内奸" and char_juese[ID_d].shenfen_unknown then
		if ai_judge_shazhong(ID_s, ID_d) then
			ans = ans - 6
		end
	end
	if d_name == "华佗" or d_name == "孙尚香" then
		ans = ans - 1
	end
	if action == "乐不思蜀" and d_name ~= "吕蒙" then
		if d_cards > d_tilimax then
			ans = ans - (d_cards - d_tilimax)
		end
	end
	return ans
end

--  判断是否要优先攻击忠臣  --
function ai_judge_shazhong(ID_s, ID_d)
	local zhugong_fangyu, fanzei_fangyu, zhongchen_fangyu
	local id, id_zhugong
	
	for id = 1, 5 do
		if char_juese[id].shenfen == "主公" then
			id_zhugong = id
			break
		end
	end
	
	zhugong_fangyu = calc_direct_fangyu(id_zhugong)
	zhongchen_fangyu = calc_direct_fangyu(ID_d)
	fanzei_fangyu = 0
	for id = 1, 5 do
		if char_juese[id].siwang == false then
			if char_juese[id].shenfen == "反贼" and char_juese[id].shenfen_unknown == false then
				fanzei_fangyu = fanzei_fangyu + calc_direct_fangyu(id)
			end
		end
	end
	if zhugong_fangyu + zhongchen_fangyu > fanzei_fangyu and zhugong_fangyu > 12 then
		return true
	end
	return false
end

--  计算当前对象的直接防御系数  --
function calc_direct_fangyu(ID)
	local tili, shoupai_c
	local ans
	
	tili = char_juese[ID].tili
	shoupai_c = #char_juese[ID].shoupai
	
	ans = tili * 4
	if #char_juese[ID].fangju > 0 then
		ans = ans + 1
	end
	if shoupai_c > 0 then
		ans = ans + shoupai_c
	end
end
--]]