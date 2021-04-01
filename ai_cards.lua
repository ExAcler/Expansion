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

--  AI决定是否出无懈可击  --
function ai_judge_wuxie(id, ID_s, ID_jiu, name)
	if (name == "万箭齐发" or name == "南蛮入侵") and char_juese[ID_jiu].fangju[1] == "藤甲" then
        return false
	elseif name == "万箭齐发" or name == "南蛮入侵" or name == "火攻" or name == "借刀杀人" or name == "决斗" or (name == "铁锁连环" and char_juese[ID_jiu].hengzhi == false) or name == "乐不思蜀" or name == "兵粮寸断" or name == "闪电" then
		if char_juese[id].shenfen == "内奸" and char_juese[ID_jiu].shenfen == "主公" and char_juese[ID_jiu].tili == 1 then
			return true
		elseif ai_judge_same_identity(id, ID_jiu, false) == 1 then
			return true
		else
			return false
		end
	elseif name == "桃园结义" or name == "五谷丰登" or name == "无中生有" or (name == "铁锁连环" and char_juese[ID_jiu].hengzhi == true) then
		if ai_judge_same_identity(id, ID_jiu, false) == 2 and char_juese[id].shenfen ~= "内奸" then
			return true
		else
			return false
		end
	elseif name == "顺手牵羊" or name == "过河拆桥" then
		if char_juese[ID_jiu].isantigovernment == nil or char_juese[ID_jiu].isblackjack == true then
			return false
		elseif char_juese[ID_s].isantigovernment == nil or char_juese[ID_s].isblackjack == true then
			if ai_judge_same_identity(id, ID_jiu, false) == 1 then
				return true
			else
				return false
			end
		elseif id == ID_jiu then
			if ai_judge_same_identity(id, ID_s, false) == 1 then
				return false
			else
				return true
			end
		elseif ai_judge_same_identity(id, ID_s, false) == 2 and char_juese[id].shenfen ~= "内奸" then
			return true
		else
			return false
		end
	elseif name == "无懈可击" then
		if id == ID_jiu then
			return true
		elseif ai_judge_same_identity(id, ID_s, false) == 2 and char_juese[id].shenfen ~= "内奸" then
			return true
		else
			return false
		end
	else
		return false
	end
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
		elseif char_juese[ID].shenfen == "主公" then
			if (char_juese[possible_target[i]].isantigovernment == false and char_juese[possible_target[i]].isblackjack ~= true) and ((#char_juese[possible_target[i]].panding ~= 0 and (card_treated == "顺手牵羊" or card_treated == "过河拆桥")) or (char_juese[possible_target[i]].hengzhi == true and card_treated == "铁锁连环")) then
				
			elseif char_juese[possible_target[i]].isantigovernment == false and char_juese[possible_target[i]].isblackjack ~= true then
				table.remove(possible_target,i)
			end
		elseif char_juese[ID].shenfen == "忠臣" then
			if (char_juese[possible_target[i]].shenfen == "主公") and ((#char_juese[possible_target[i]].panding ~= 0 and (card_treated == "顺手牵羊" or card_treated == "过河拆桥")) or (char_juese[possible_target[i]].hengzhi == true and card_treated == "铁锁连环")) then

			elseif char_juese[possible_target[i]].shenfen == "主公" then
				table.remove(possible_target, i)
			end
		elseif char_juese[ID].shenfen == "反贼" then
			if (char_juese[possible_target[i]].isantigovernment == true and char_juese[possible_target[i]].isblackjack ~= true) and ((#char_juese[possible_target[i]].panding ~= 0 and (card_treated == "顺手牵羊" or card_treated == "过河拆桥")) or (char_juese[possible_target[i]].hengzhi == true and card_treated == "铁锁连环")) then
			
			elseif char_juese[possible_target[i]].isantigovernment == true and char_juese[possible_target[i]].isblackjack ~= true then
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
			elseif ai_judge_blackjack(ID) == false then
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
		if char_distance_infinity == false then
			for i=#possible_target,1,-1 do
				local _,inrange = ai_judge_distance(ID,possible_target[i],1)
				if inrange == false then
					table.remove(possible_target,i)
				end
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
		elseif card_pindian_dianshu > j and not is_enemy then
			card_pindian, card_pindian_dianshu = i, j
		end
	end
	return card_pindian, card_pindian_dianshu
end
