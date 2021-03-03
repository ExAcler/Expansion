
-- 各角色拥有技能 --
char_juese_jineng = {    -- 体力上限, 阵营, 能否为主公, 技能
    ["刘备"] = {4, "蜀", true, {"仁德", "激将"}, "男", {"","主公"}}, 
	["关羽"] = {4, "蜀", false, {"武圣"}, "男", {""}},
    ["张飞"] = {4, "蜀", false, {"咆哮"}, "男", {"锁定"}}, 
	["赵云"] = {4, "蜀", false, {"龙胆"}, "男", {""}}, 
	["马超"] = {4, "蜀", false, {"马术", "铁骑"}, "男", {"锁定",""}}, 
	["诸葛亮"] = {3, "蜀", false, {"观星", "空城"}, "男", {"","锁定"}}, 
	["黄月英"] = {3, "蜀", false, {"集智", "奇才"}, "女", {"","锁定"}}, 
	["黄忠"] = {4, "蜀", false, {"烈弓"}, "男", {"锁定"}},
    ["魏延"] = {4, "蜀", false, {"狂骨"}, "男", {"锁定"}},
    ["庞统"] = {3, "蜀", false, {"连环", "涅槃"}, "男", {"","限定"}},  
	["卧龙诸葛"] = {3, "蜀", false, {"火计", "看破", "八阵"}, "男", {"","","锁定"}},  
	["孟获"] = {4, "蜀", false, {"祸首", "再起"}, "男", {"锁定",""}},  
	["祝融"] = {4, "蜀", false, {"巨象", "烈刃"}, "女", {"锁定",""}},  
	["姜维"] = {4, "蜀", false, {"挑衅", "志继"}, "男", {"","觉醒"}},  
	["刘禅"] = {3, "蜀", true, {"享乐", "放权", "若愚"}, "男", {"锁定","","主公"}}, 
    ["关索"] = {4,"蜀",false,{"征南","撷芳"},"男", {"","锁定"}},	
	["曹操"] = {4, "魏", true, {"奸雄", "护驾"}, "男", {"","主公"}},  
	["司马懿"] = {3, "魏", false, {"鬼才", "反馈"}, "男", {"",""}},  
	["郭嘉"] = {3, "魏", false, {"遗计", "天妒"}, "男", {"",""}},
    ["张辽"] = {4, "魏", false, {"突袭"}, "男", {""}},
    ["甄姬"] = {3, "魏", false, {"洛神", "倾国"}, "女", {"锁定",""}},
    ["夏侯惇"] = {4, "魏", false, {"刚烈"}, "男", {""}}, 
    ["曹仁"] = {4, "魏", false, {"据守"}, "男", {""}},
    ["许褚"] = {4, "魏", false, {"裸衣"}, "男", {""}}, 
    ["夏侯渊"] = {4, "魏", false, {"神速"}, "男", {""}},  
    ["荀彧"] = {3, "魏", false, {"驱虎", "节命"}, "男", {"",""}}, 
    ["典韦"] = {4, "魏", false, {"强袭"}, "男", {""}}, 
    ["曹丕"] = {3, "魏", true, {"放逐", "行殇", "颂威"}, "男", {"","","主公"}},    
    ["徐晃"] = {4, "魏", false, {"断粮"}, "男", {""}}, 
    ["邓艾"] = {4, "魏", false, {"屯田", "凿险"}, "男", {"","觉醒"}}, 
    ["张颌"] = {4, "魏", false, {"巧变"}, "男", {""}}, 
	["张春华"] = {3,"魏",false,{"绝情","伤逝"},"女", {"锁定",""}},
    ["孙权"] = {4, "吴", true, {"制衡", "救援"}, "男", {"","主公"}}, 
    ["甘宁"] = {4, "吴", false, {"奇袭"}, "男", {""}}, 
    ["黄盖"] = {4, "吴", false, {"苦肉"}, "男", {""}}, 
    ["周瑜"] = {3, "吴", false, {"英姿", "反间"}, "男", {"",""}}, 
    ["陆逊"] = {3, "吴", false, {"谦逊", "连营"}, "男", {"锁定",""}}, 
    ["大乔"] = {3, "吴", false, {"国色", "流离"}, "女", {"",""}}, 
    ["小乔"] = {3, "吴", false, {"天香", "红颜"}, "女", {"","锁定"}},
	["吕蒙"] = {4, "吴", false, {"克己"}, "男", {""}}, 
    ["孙尚香"] = {3, "吴", false, {"结姻", "枭姬"}, "女", {"",""}}, 
    ["周泰"] = {4, "吴", false, {"不屈"}, "男", {""}}, 
    ["太史慈"] = {4, "吴", false, {"天义"}, "男", {""}}, 
    ["鲁肃"] = {3, "吴", false, {"好施", "缔盟"}, "男", {"",""}}, 
    ["孙坚"] = {4, "吴", false, {"英魂"}, "男", {"",""}}, 
    ["张昭张宏"] = {3, "吴", false, {"直谏", "固政"}, "男", {"",""}}, 
    ["孙策"] = {4, "吴", true, {"激昂", "魂姿", "制霸"}, "男", {"","觉醒","主公"}}, 
    ["吕布"] = {4, "群", false, {"无双"}, "男", {"锁定"}}, 
    ["貂蝉"] = {3, "群", false, {"闭月", "离间"}, "女", {"",""}}, 	
	["华佗"] = {3, "群", false, {"急救", "青囊"}, "男", {"",""}}, 
	["张角"] = {3, "群", true, {"雷击", "鬼道", "黄天"}, "男", {"","","主公"}}, 
    ["庞德"] = {4, "群", false, {"猛进", "马术"}, "男", {"","锁定"}}, 
    ["袁绍"] = {4, "群", true, {"乱击", "血裔"}, "男", {"","主公"}}, 
    ["董卓"] = {8, "群", true, {"酒池", "肉林", "崩坏", "暴虐"}, "男", {"","锁定","锁定","主公"}}, 
    ["蔡文姬"] = {3, "群", false, {"悲歌", "断肠"}, "女", {"","锁定"}}, 
    ["左慈"] = {3, "群", false, {"化身", "新生"}, "男", {"禁止","禁止"}}, 		
	["神曹操"] = {3,"神",false,{"归心","飞影"},"男", {"","锁定"}},
	["孙笑川"] = {4,"神",false,{"苦肉","绝情","伤逝","乱击"},"男", {"","锁定","",""}},
}

-- 武器攻击范围 --
card_wuqi_r = 
{
    ["诸葛弩"] = 1, 
	["雌雄剑"] = 2, ["青钢剑"] = 2, ["寒冰剑"] = 2, ["古锭刀"] = 2, 
	["青龙刀"] = 3, ["丈八矛"] = 3, ["贯石斧"] = 3, 
	["朱雀扇"] = 4, ["方天戟"] = 4, 
	["麒麟弓"] = 5
}

function init_character()
-- 各角色武将牌 --
char_wujiang = {"刘备", "刘禅", "曹操", "曹丕", "孙权", "孙策", "张角", "袁绍", "董卓", "关羽", "张飞", "赵云", "马超", "诸葛亮", "黄月英", "黄忠", "魏延", "庞统", "卧龙诸葛", "孟获", "祝融", "姜维", "关索","司马懿", "郭嘉", "张辽", "甄姬", "夏侯惇", "曹仁", "许褚", "夏侯渊", "荀彧", "典韦", "徐晃", "邓艾", "张颌","张春华", "甘宁", "黄盖", "周瑜", "陆逊", "大乔", "吕蒙", "孙尚香", "周泰", "太史慈", "鲁肃", "孙坚", "张昭张宏", "吕布", "貂蝉", "华佗", "庞德", "蔡文姬", "左慈","神曹操","孙笑川"}
char_wujiang_zhugong = {"刘备", "刘禅", "曹操", "曹丕", "孙权", "孙策", "张角", "袁绍", "董卓","孙笑川"}  -- 主公武将牌
char_wujiang_f = {}  -- 洗后的武将牌

-- 各角色身份牌 --
char_juese_identity = {"主公", "忠臣", "反贼", "反贼", "内奸"}
char_juese_fid = {}  -- 洗后的身份牌

-- 各角色状态 --
char_juese = {
    {   
	    name = "", 
		shili = "",
		xingbie = "",
		shenfen = "", 
		hengzhi = false, 
		fanmian = false,
		antigovernment = 0,
		antigovernmentmax = 0,
		antigovernmentmin = 0,
		isantigovernment = nil,
		isblackjack = false,
		tili = 0, 
		tili_max = 0, 
		shoupai = {}, 
		panding = {}, 
		wuqi = {}, 
		fangju = {}, 
		gongma = {}, 
		fangma = {}, 
		skill = {},
		skillname = {},
		siwang = false, 
		shenfen_unknown = true, 
	}, 
	{
	    name = "",
		shili = "",
		xingbie = "",
		shenfen = "",
		hengzhi = false, 
		fanmian = false,
		antigovernment = 0,
		antigovernmentmax = 0,
		antigovernmentmin = 0,
		isantigovernment = nil,
		isblackjack = false,
		tili = 0, 
		tili_max = 0, 
		shoupai = {}, 
		panding = {}, 
		wuqi = {}, 
		fangju = {}, 
		gongma = {}, 
		fangma = {}, 
		skill = {},
		skillname = {},
		siwang = false, 
		shenfen_unknown = true, 
	}, 
	{
	    name = "",
		shili = "",
		xingbie = "",
		shenfen = "",
		hengzhi = false,
		fanmian = false,
		antigovernment = 0,
		antigovernmentmax = 0,
		antigovernmentmin = 0,
		isantigovernment = nil,
		isblackjack = false,
		tili = 0, 
		tili_max = 0, 
		shoupai = {}, 
		panding = {}, 
		wuqi = {}, 
		fangju = {}, 
		gongma = {}, 
		fangma = {}, 
		skill = {},
		skillname = {},
		siwang = false, 
		shenfen_unknown = true, 
	}, 
	{
	    name = "",
		shili = "",
		xingbie = "",
		shenfen = "",
		hengzhi = false, 
		fanmian = false,
		antigovernment = 0,
		antigovernmentmax = 0,
		antigovernmentmin = 0,
		isantigovernment = nil,
		isblackjack = false,
		tili = 0, 
		tili_max = 0, 
		shoupai = {}, 
		panding = {}, 
		wuqi = {}, 
		fangju = {}, 
		gongma = {}, 
		fangma = {}, 
		skill = {},
		skillname = {},
		siwang = false, 
		shenfen_unknown = true, 
	}, 
	{
	    name = "",
		shili = "",
		xingbie = "",
		shenfen = "",
		hengzhi = false, 
		fanmian = false,
		antigovernment = 0,
		antigovernmentmax = 0,
		antigovernmentmin = 0,
		isantigovernment = nil,
		isblackjack = false,
		tili = 0, 
		tili_max = 0, 
		shoupai = {}, 
		panding = {}, 
		wuqi = {}, 
		fangju = {}, 
		gongma = {}, 
		fangma = {}, 
		skill = {},
		skillname = {},
		siwang = false, 
		shenfen_unknown = true, 
	}, 
}
for i = 1,5 do
    for j = 1,4 do
		char_juese[i][-j] = {}
	end
end
char_current_i = 1  -- 当前受控制的武将
char_yisha = false  -- 已经出过杀
char_hejiu = false  -- 已经喝酒
char_wushi = false  -- 无视防具标志 (古锭刀)
char_rende_given = 0  -- 使用仁德技能已给出牌数
char_luoyi = false  -- 许褚使用了裸衣技能
skill_used = false  -- 已经发动过技能
end

--  定义变量  --
init_character()

--  分配身份  --
function char_fenpei_id()
    add_funcptr(_id_sub1, nil)
end
function _id_sub1()
    local i, t = 0

    char_juese_fid = char_juese_identity
	math.randomseed(timer.getMilliSecCounter())
	
	for i = 1, 5 do
	    t = math.random(1,#char_juese_fid)
		char_juese[i].shenfen = char_juese_fid[t]
		table.remove(char_juese_fid, t)
	end
	
	push_message("身份分配完毕")
end

--  分配武将 (暂为随机分配)  --
function char_fenpei_wujiang()
    local i, t = 0
	
	-- 主公分配武将 --
	add_funcptr(_wujiang_sub1, nil)
	
	-- 其他身份分配武将 --
	for i = 1, 5 do
	    add_funcptr(_wujiang_sub2, {i})
	end
	
end
function _wujiang_sub1()
    local i, t = 0, msg

	char_wujiang_f = char_wujiang
	math.randomseed(timer.getMilliSecCounter())
	
    for i = 1, 5 do
	    if char_juese[i].shenfen == "主公" then
		    t = math.random(#char_wujiang_zhugong)
			t = 10
			char_juese[i].name = char_wujiang_zhugong[t]
			char_juese[i].tili_max = char_juese_jineng[char_wujiang_zhugong[t]][1] + 1
			char_juese[i].shili = char_juese_jineng[char_wujiang_zhugong[t]][2]
			char_juese[i].xingbie = char_juese_jineng[char_wujiang_zhugong[t]][5]
			table.remove(char_wujiang_f, t)
			char_juese[i].tili = char_juese[i].tili_max
			for j = 1,#char_juese_jineng[char_juese[i].name][4] do
				if char_juese_jineng[char_juese[i].name][4][j] == "挑衅" or char_juese_jineng[char_juese[i].name][4][j] == "反间" or char_juese_jineng[char_juese[i].name][4][j] == "驱虎" or char_juese_jineng[char_juese[i].name][4][j] == "制衡" or char_juese_jineng[char_juese[i].name][4][j] == "结姻" or char_juese_jineng[char_juese[i].name][4][j] == "天义"  or char_juese_jineng[char_juese[i].name][4][j] == "涅槃" or char_juese_jineng[char_juese[i].name][4][j] == "缔盟" or char_juese_jineng[char_juese[i].name][4][j] == "离间" or char_juese_jineng[char_juese[i].name][4][j] == "青囊" then
					char_juese[i].skill[char_juese_jineng[char_juese[i].name][4][j]] = 1
				else
					char_juese[i].skill[char_juese_jineng[char_juese[i].name][4][j]] = "available"
				end
				table.insert(char_juese[i].skillname,char_juese_jineng[char_juese[i].name][4][j])
			end
		    msg = {"玩家", i, "(主公)选择", char_juese[i].name}
	        push_message(table.concat(msg))
			msg = nil; collectgarbage()
			char_current_i = i
		end
	end
end
function _wujiang_sub2(va_list)
    local i, t = 0, msg
    i = va_list[1]

    if char_juese[i].shenfen ~= "主公" then
		if i ~= 1 then
			t = math.random(#char_wujiang_f)
		else
			t = 31
		end
		char_juese[i].name = char_wujiang_f[t]
		char_juese[i].tili_max = char_juese_jineng[char_wujiang_f[t]][1]
		table.remove(char_wujiang_f, t)
		char_juese[i].shili = char_juese_jineng[char_wujiang_f[t]][2]
		char_juese[i].xingbie = char_juese_jineng[char_wujiang_f[t]][5]
		char_juese[i].tili = char_juese[i].tili_max
		--char_juese[i].tili = 1
		for j = 1,#char_juese_jineng[char_juese[i].name][4] do
			if char_juese_jineng[char_juese[i].name][4][j] == "激将" or char_juese_jineng[char_juese[i].name][4][j] == "护驾" or char_juese_jineng[char_juese[i].name][4][j] == "救援" or char_juese_jineng[char_juese[i].name][4][j] == "黄天" or char_juese_jineng[char_juese[i].name][4][j] == "血裔" or char_juese_jineng[char_juese[i].name][4][j] == "颂威" or char_juese_jineng[char_juese[i].name][4][j] == "暴虐" or char_juese_jineng[char_juese[i].name][4][j] == "若愚" or char_juese_jineng[char_juese[i].name][4][j] == "制霸" then
				
			elseif char_juese_jineng[char_juese[i].name][4][j] == "挑衅" or char_juese_jineng[char_juese[i].name][4][j] == "反间" or char_juese_jineng[char_juese[i].name][4][j] == "驱虎" or char_juese_jineng[char_juese[i].name][4][j] == "制衡" or char_juese_jineng[char_juese[i].name][4][j] == "结姻" or char_juese_jineng[char_juese[i].name][4][j] == "天义"  or char_juese_jineng[char_juese[i].name][4][j] == "涅槃" or char_juese_jineng[char_juese[i].name][4][j] == "缔盟" or char_juese_jineng[char_juese[i].name][4][j] == "离间" or char_juese_jineng[char_juese[i].name][4][j] == "青囊" then
				char_juese[i].skill[char_juese_jineng[char_juese[i].name][4][j]] = 1
				table.insert(char_juese[i].skillname,char_juese_jineng[char_juese[i].name][4][j])
			else
				char_juese[i].skill[char_juese_jineng[char_juese[i].name][4][j]] = "available"
				table.insert(char_juese[i].skillname,char_juese_jineng[char_juese[i].name][4][j])
			end
		end
		msg = {"玩家", i, "选择", char_juese[i].name}
	    push_message(table.concat(msg))
		msg = nil; collectgarbage()
	end
end

--  身份初步判定 --
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

--  计算玩家与其他玩家的距离  --
function char_calc_distance(_ID_s, _ID_d)
    local dist, avg, count
	local ID_s, ID_d
	
	ID_s, ID_d, count = distance_remove(_ID_s, _ID_d)
	avg = ID_s + count / 2

	if avg > count then
	    avg = avg - count
	end
	
	if avg > ID_s then
	    if ID_d >= avg then
	        dist = ID_s - ID_d + count
	    end
	    if ID_d < ID_s or (ID_d > ID_s and ID_d < avg) then
	        dist = math.abs(ID_s - ID_d)
	    end
	else
	    if ID_d <= avg then
		    dist = ID_d - ID_s + count
		end
	    if ID_d > ID_s or (ID_d < ID_s and ID_d > avg) then
		    dist = math.abs(ID_s - ID_d)
		end
	end
	
	--  防御马计算距离时，加1  --
	if #char_juese[_ID_d].fangma ~= 0 then
	    dist = dist + 1
	end
	if (char_juese[_ID_d].skill["飞影"] == "available") then
		dist = dist + 1
	end	
	--  攻击马计算距离时，减1  --
	if #char_juese[_ID_s].gongma ~= 0 and dist > 1 then
	    dist = dist - 1
	end
	
	--  马超、庞德拥有马术，距离减1  --
	if char_juese[_ID_s].skill["马术"] == "available" and dist > 1 then
		dist = dist - 1
	end
	
	return dist
end
function distance_remove(ID_s, ID_d)    -- 删除已死亡角色
	local i
	local _ID_d = ID_d
	local _ID_s = ID_s
	local count = 5
	
	for i = 1, ID_s do
		if char_juese[i].siwang == true then
			_ID_s = _ID_s - 1
		end
	end
	
	for i = 1, ID_d do
		if char_juese[i].siwang == true then
			_ID_d = _ID_d - 1
		end
	end
	
	for i = 1, 5 do
		if char_juese[i].siwang == true then
			count = count - 1
		end
	end
	
	return _ID_s, _ID_d, count
end

--  游戏胜利条件判断  --
function char_judge_shengli(siwang_id, laiyuan, p)
	local i, count, alive, ended

	--  内奸最后存活  --
	count = 5
	for i = 1, 5 do
		if char_juese[i].siwang == true or i == siwang_id then
			count = count - 1
		else
			alive = i
		end
	end
	if count == 1 and char_juese[alive].shenfen == "内奸" then
		msg = {"所有其他角色阵亡，内奸胜利，游戏结束"}
		if p == nil then
			add_funcptr(push_message, table.concat(msg))
			add_funcptr(_deduct_sub)
		else
			add_funcptr(push_message, table.concat(msg), p)
			add_funcptr(_deduct_sub, nil, p + 1)
		end
		game_victory = true
		return true
	end
	
	--  主公阵亡  --
	if char_juese[siwang_id].shenfen == "主公" then
		msg = {"主公阵亡，反贼胜利，游戏结束"}
		if p == nil then
			add_funcptr(push_message, table.concat(msg))
			add_funcptr(_deduct_sub)
		else
			add_funcptr(push_message, table.concat(msg), p)
			add_funcptr(_deduct_sub, nil, p + 1)
		end
		game_victory = true
		return true
	end
	
	--  主公与忠臣最后存活  --
	ended = true
	for i = 1, 5 do
		if char_juese[i].siwang == false and i ~= siwang_id then
			if char_juese[i].shenfen == "反贼" or char_juese[i].shenfen == "内奸" then
				ended = false
			end
		end
	end
	if ended then
		msg = {"反贼与内奸阵亡，主公与忠臣胜利，游戏结束"}
		if p == nil then
			add_funcptr(push_message, table.concat(msg))
			add_funcptr(_deduct_sub)
		else
			add_funcptr(push_message, table.concat(msg), p)
			add_funcptr(_deduct_sub, nil, p + 1)
		end
		game_victory = true
		return true
	end
	
	--  奖惩  --
	if laiyuan ~= nil then
		--  任何人杀死反贼，摸3张牌  --
		if char_juese[siwang_id].shenfen == "反贼" then
			add_funcptr(card_fenfa, {laiyuan, 3, true})
		end
		
		--  主公杀死忠臣，丢弃所有牌  --
		if char_juese[laiyuan].shenfen == "主公" and char_juese[siwang_id].shenfen == "忠臣" then
			add_funcptr(push_message, "主公误杀忠臣，丢弃所有牌")
			card_qipai_all(laiyuan, false)
		end
	end
	
	return false
end

--  翻面结算 --
function char_fanmian(ID)
	char_juese[ID].fanmian = not char_juese[ID].fanmian
end

--  卖血技能结算  --

function char_skills_sellblood(va_list)
	local id, laiyuan, tili, shuxing, AOE
	local hengzhi
	local p = _p, fp
	id = va_list[2]; laiyuan = va_list[3]; shuxing = va_list[4]; fp = va_list[6]; AOE = va_list[7]
	tili = char_juese[id].tili - _deduct_count(va_list)

	-- 张春华触发绝情 --
	--[[if laiyuan~=nil then
		if char_juese[laiyuan].skill["绝情"] == "available" then
			add_funcptr(push_message,char_juese[laiyuan].name.."触发了武将技能 '绝情'")
		end
	end]]--

	--  郭嘉发动遗计  --
	if char_juese[id].skill["遗计"] == "available" and cansellblood == true then
		skills_yiji(id, _deduct_count(va_list))
	end

	--  司马懿发动反馈  --
	if char_juese[id].skill["反馈"] == "available" and cansellblood == true then
		skills_fankui(id, laiyuan)
	end
	
	-- 神曹操发动归心 --
	if char_juese[id].skill["归心"] == "available" and cansellblood == true then
		skills_guixin(id)
	end
	
	--  夏侯惇发动刚烈  --
	if char_juese[id].skill["刚烈"] == "available" and AOE ~= true and cansellblood == true then
		if hengzhi == true then
			lianhuan_va = va_list
		else
			lianhuan_va = nil
		end
		skills_ganglie(id, laiyuan)
		return
	end
	

	-- 张春华在手牌不足时摸牌 --
	if char_juese[id].skill["伤逝"] == "available" and table.maxn(char_juese[id].shoupai) < char_juese[id].tili_max-char_juese[id].tili then
		push_message(char_juese[id].name.."发动了武将技能 '伤逝'")
		card_fenfa(id, char_juese[id].tili_max-table.maxn(char_juese[id].tili-#char_juese[id].shoupai), true)
	end
end

--  体力扣减结算  --
function char_tili_deduct(va_list, _p)
	local id, laiyuan, tili, shuxing, AOE
	local hengzhi
	local p = _p, fp
	id = va_list[2]; laiyuan = va_list[3]; shuxing = va_list[4]; fp = va_list[6]; AOE = va_list[7]
	tili = char_juese[id].tili - _deduct_count(va_list)
	
	if p == nil then
		--  插入函数队列末尾  --
		add_funcptr(_char_tili_deduct, va_list)
			
		if shuxing~="流失" then
			cansellblood = true
		else
			cansellblood = false
		end
		if laiyuan~=nil then
			if char_juese[laiyuan].skill["绝情"] == "available" and shuxing~="流失" then
				add_funcptr(push_message,char_juese[laiyuan].name.."触发了武将技能 '绝情'")
				cansellblood,shuxing = false,"流失"
			end
		end
		
		if laiyuan ~= nil then
			--  魏延对距离1以内的玩家造成伤害，回复1点体力  --
			if char_juese[laiyuan].skill["狂骨"] == "available" and char_calc_distance(laiyuan, id) <= 1 and char_juese[laiyuan].tili < char_juese[laiyuan].tili_max then
				skills_kuanggu(laiyuan)
			end
		end
		
		hengzhi = char_juese[id].hengzhi
		if shuxing == "火" or shuxing == "雷" then
			if hengzhi == true then
				add_funcptr(_deduct_chongzhi, id)
			end
		end
		
		if tili <= 0 then
			--  进入濒死状态  --
			tili = char_binsi(id, tili)
			
			--  若最终死亡，进行胜利条件判断  --
			if tili <= 0 then
				if shuxing=="流失" then
					if char_judge_shengli(id, nil) then
						return
					end
				else
					if char_judge_shengli(id, laiyuan) then
						return
					end
				end
			else
				char_skills_sellblood(va_list)
			end
		else
			char_skills_sellblood(va_list)
		end
		
		--  在杀的状态下：造成伤害后，麒麟弓可将马弃置  --
		--  连环状态，下一个受到传导伤害  --
		if tili > 0 and fp ~= nil and shuxing ~= "流失" then
			if #char_juese[laiyuan].wuqi ~= 0 then
				if char_juese[laiyuan].wuqi[1] == "麒麟弓" then
					lianhuan_va = va_list
					fp(laiyuan, id)
				end
			end
			if hengzhi == true then
				if shuxing == "火" or shuxing == "雷" then
					_deduct_lianhuan(va_list)
				end
			end
		else
			if hengzhi == true then
				if shuxing == "火" or shuxing == "雷" then
					_deduct_lianhuan(va_list)
				end
			end
		end
	else
		--  插入函数队列中间  --
		add_funcptr(_char_tili_deduct, va_list, p)
		if tili <= 0 then
			tili, p = char_binsi(id, tili, p + 1)
			
			if tili <= 0 then
				char_judge_shengli(id, laiyuan, p)
			end
		else
			add_funcptr(_binsi_sub2, nil, p + 1)
		end
	end
end
function _deduct_chongzhi(ID)    --  体力扣减：横置状态重置
	local msg
	msg = {char_juese[ID].name, "的横置状态解除"}
	push_message(table.concat(msg))
	
	char_juese[ID].hengzhi = false
end
function _deduct_lianhuan(va_list)    --  体力扣减：遍历下一个连环伤害对象
	local j, v
	v = table.copy(va_list)
	j = v[2] + 1
	if j > 5 then j = 1 end
	
	while j ~= v[5] do
		if char_juese[j].hengzhi == true then
			v[2] = j
			char_tili_deduct(v)
			return
		end
		j = j + 1
		if j > 5 then j = 1 end
	end
	
	--  没有下一个连环伤害对象  --
	add_funcptr(_sha_sub2, nil)
end
function _deduct_count(va_list)    --  体力扣减：计算体力扣减点数
	local dianshu, id, laiyuan, shuxing, s_card
	dianshu = va_list[1]; id = va_list[2]; laiyuan = va_list[3]; shuxing = va_list[4]
	local msg
	
	if not char_wushi then
	    if char_juese[id].fangju[1] == "藤甲" and shuxing == "火" then
		    dianshu = dianshu + 1
	    end
	
	    if char_juese[id].fangju[1] == "白银狮" and dianshu > 1 and shuxing ~= "流失" then
		    dianshu = 1
	    end
	end
	
	return dianshu
end
function _char_tili_deduct(va_list)    --  体力扣减：队列执行函数
    local dianshu, id, laiyuan, shuxing, s_card
	dianshu = va_list[1]; id = va_list[2]; laiyuan = va_list[3]; shuxing = va_list[4]
	
	--timer.start(0.6)
	
	--  青钢剑无视防具  --
	if not char_wushi then
		--  藤甲受火属性伤害，伤害+1  --
		if char_juese[id].fangju[1] == "藤甲" and shuxing == "火" then
			msg = {"火烧藤甲，伤害+1"}
			push_message(table.concat(msg))
			dianshu = dianshu + 1
		end
		
		--  白银狮子防止1点以上的伤害  --
	    if char_juese[id].fangju[1] == "白银狮" and dianshu > 1 and shuxing ~= "流失" then
	        msg = {char_juese[id].name, "装备了白银狮子，防止多余伤害"}
	        push_message(table.concat(msg))
			dianshu = 1
		end
	end
	
	char_juese[id].tili = char_juese[id].tili - dianshu
	if shuxing == "流失" then
		msg = {char_juese[id].name, "失去", dianshu, "点体力"}
	elseif shuxing == "火" then
		msg = {char_juese[id].name, "受到", dianshu, "点火焰伤害"}
	elseif shuxing == "雷" then
		msg = {char_juese[id].name, "受到", dianshu, "点雷电伤害"}
	else
		msg = {char_juese[id].name, "受到", dianshu, "点伤害"}
	end
	push_message(table.concat(msg))
	msg = nil; collectgarbage()
end
function _deduct_sub()    --  进入游戏重置状态
	timer.stop()
	funcptr_queue = {}
	gamerun_huihe = "游戏结束"
	gamerun_status = ""
	set_hints("请按'确定'重新开局")
end

--  角色濒死结算  --
function char_binsi(id, tili, p)
	msg = {char_juese[id].name, "快死了，请求出桃救命"}
	if p == nil then
		add_funcptr(push_message, table.concat(msg))
	else
		add_funcptr(push_message, table.concat(msg), p) -- p + 1
	end
	
	--  求桃救命  --
	local i, cur, msg_i
	local k = tili
	
	cur = id
	
	if p ~= nil then
		msg_i = p
	else
		msg_i = 0
	end
	for i = 1, 4 do
		if char_juese[cur].siwang == false then
			msg_i = msg_i + 1
			
			if cur ~= id then
				--  他人则放弃 (临时)  --
				msg = {char_juese[cur].name, "放弃"}
				if p == nil then
					add_funcptr(push_message, table.concat(msg))
				else
					add_funcptr(push_message, table.concat(msg), msg_i)  -- p + 2
				end
			else
				--  自己则喝酒/吃桃  --
				local j = true
				local n
				while k <= 0 and j do
					j = false
					n = card_chazhao(id, "桃")
					
					--  华佗可用红色手牌代替桃  --
					if n < 0 and char_juese[id].skill["急救"] == "available" then
						n = skills_jijiu_chazhao(id)
					end
					
					if n > 0 then
						msg_i = msg_i + 1
						j = true
						if p == nil then
							card_tao(n, id, id, true)
						else
							msg_i = card_tao(n, id, id, true, msg_i)  -- p + 2
						end
						k = k + 1
					end
					
					n = card_chazhao(id, "酒")
					if n > 0 and k <= 0 then
						msg_i = msg_i + 1
						j = true
						if p == nil then
							card_jiu(n, id, true)
						else
							msg_i = card_jiu(n, id, true, msg_i)
						end
						k = k + 1
					end
				end
				msg_i = msg_i - 1
				
				if k > 0 then break end
			end
		end
		
		cur = cur + 1
		if cur > 5 then
			cur = 1
		end
	end
	if p == nil then
		add_funcptr(_binsi_sub2, nil)
	else
		add_funcptr(_binsi_sub2, nil, msg_i + 1)
	end
	
	--  如果有曹丕，发动行殇  --
	local xingshang_id = 0
	for i = 1, 5 do
		if i ~= id and char_juese[i].skill["行殇"] == "available" and char_juese[i].siwang == false then
			xingshang_id = i
			break
		end
	end
	--  如果有关索，发动征南  --
	local zhengnan_id = 0
	for i = 1, 5 do
		if i ~= id and char_juese[i].skill["征南"] == "available" and char_juese[i].siwang == false then
			zhengnan_id = i
			break
		end
	end
	--  死亡丢弃所有手牌  --
	if k <= 0 then
		if p == nil then    --  被动死亡
			if xingshang_id == 0 then
				card_qipai_all(id, true)
			else
				add_funcptr(skills_xingshang, {xingshang_id, id, true})
			end
			add_funcptr(_binsi_sub1, id)
			if zhengnan_id == 0 then
			else
				add_funcptr(skills_zhengnan, {zhengnan_id, id, true})
			end
			--  当前玩家死亡，跳过其接下来所有阶段  --
			if id == char_current_i then
				add_funcptr(_binsi_sub3, id)
			end
		else    --  被闪电劈死
			if xingshang_id == 0 then
				msg_i = card_qipai_all(id, true, msg_i + 2)
			else
				msg_i = msg_i + 2
				add_funcptr(skills_xingshang, {xingshang_id, id, false}, msg_i)
				msg_i = msg_i + 1
			end
			add_funcptr(_binsi_sub1, id, msg_i)
			if zhengnan_id == 0 then
			else
				add_funcptr(skills_zhengnan, {zhengnan_id, id, false},msg_i+1)
				msg_i = msg_i + 1
			end
			--  当前玩家死亡，跳过其接下来所有阶段  --
			add_funcptr(_binsi_sub3, id, msg_i + 1)
		end
	end
	
	if p == nil then
		return k
	else
		return k, msg_i + 1
	end
end
function _binsi_sub1(id)
	char_juese[id].siwang = true
	msg = {char_juese[id].name, "阵亡，身份为", char_juese[id].shenfen}
	push_message(table.concat(msg))
end
function _binsi_sub2()
	timer.start(0.2)
end
function _binsi_sub3()
	--  当前玩家死亡，跳过其接下来所有阶段  --
	timer.stop()
	funcptr_queue = {}
	
	gamerun_huihe_set("结束")
	gamerun_status = ""
	set_hints("请按'确定'继续")
end