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
--  AI身份判定 --
function ai_judge_shenfen()
	for i = 1,5 do
		if char_juese[i].shenfen == "主公" then
			char_juese[i].isblackjack,char_juese[i].isantigovernment = false,false
		else
			char_juese[i].antigovernmentmax = math.max(char_juese[i].antigovernmentmax,char_juese[i].antigovernment)
			char_juese[i].antigovernmentmin = math.min(char_juese[i].antigovernmentmin,char_juese[i].antigovernment)
			if char_juese[i].antigovernmentmax-char_juese[i].antigovernmentmin > 10 then
				char_juese[i].isblackjack,char_juese[i].isantigovernment = true,false
			elseif char_juese[i].antigovernmentmax > 5 then
				char_juese[i].isblackjack,char_juese[i].isantigovernment = false,true
			else
			    char_juese[i].isblackjack,char_juese[i].isantigovernment = false,false
			end
		end
	end
end
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