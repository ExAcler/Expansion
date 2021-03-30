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
	return false
end

--  AI决定是否发动放权  --
function ai_judge_fangquan(ID)
	if #char_juese[ID].shoupai == 0 then
		return {}
	end
	local ID_mubiao = ai_basic_judge_mubiao(ID, 1, true, false)
	if ai_judge_random_percent(75 - 25 * ai_withdraw_need(ID)) == 1 then
		return ID_mubiao
	else
		return {}
	end
end