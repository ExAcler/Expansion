
-- 各角色拥有技能 --
char_juese_jineng = {    -- 体力上限, 阵营, 能否为主公, 技能
    ["刘备"] = {{4,4}, "蜀", true, {"仁德", "激将"}, "男", {"","主公"}, true}, 
	["关羽"] = {{4,4}, "蜀", false, {"武圣"}, "男", {""}, true},
    ["张飞"] = {{4,4}, "蜀", false, {"咆哮"}, "男", {"锁定"}, true}, 
	["赵云"] = {{4,4}, "蜀", false, {"龙胆"}, "男", {""}, true}, 
	["马超"] = {{4,4}, "蜀", false, {"马术", "铁骑"}, "男", {"锁定",""}, true}, 
	["诸葛亮"] = {{3,3}, "蜀", false, {"观星", "空城"}, "男", {"","锁定"}, true}, 
	["黄月英"] = {{3,3}, "蜀", false, {"集智", "奇才"}, "女", {"","锁定"}, true}, 
	["黄忠"] = {{4,4}, "蜀", false, {"烈弓"}, "男", {"锁定"}, true},
    ["魏延"] = {{4,4}, "蜀", false, {"狂骨"}, "男", {"锁定"}, true},
    ["庞统"] = {{3,3}, "蜀", false, {"连环", "涅槃"}, "男", {"","限定"}, true},  
	["卧龙诸葛"] = {{3,3}, "蜀", false, {"火计", "看破", "八阵"}, "男", {"","","锁定"}, true},  
	["孟获"] = {{4,4}, "蜀", false, {"祸首", "再起"}, "男", {"锁定",""}, true},  
	["祝融"] = {{4,4}, "蜀", false, {"巨象", "烈刃"}, "女", {"锁定",""}, false},  
	["姜维"] = {{4,4}, "蜀", false, {"挑衅", "志继"}, "男", {"","觉醒"}, true},  
	["刘禅"] = {{3,3}, "蜀", true, {"享乐", "放权", "若愚"}, "男", {"锁定","","主公"}, false}, 
    ["关索"] = {{4,4}, "蜀", false, {"征南", "撷芳"}, "男", {"","锁定"}, false},	
	["廖化"] = {{4,4}, "蜀", false, {"当先", "伏枥"}, "男", {"锁定","限定"}, true},	
	["曹操"] = {{4,4}, "魏", true, {"奸雄", "护驾"}, "男", {"","主公"}, false},  
	["司马懿"] = {{3,3}, "魏", false, {"鬼才", "反馈"}, "男", {"",""}, true},  
	["郭嘉"] = {{3,3}, "魏", false, {"遗计", "天妒"}, "男", {"",""}, true},
    ["张辽"] = {{4,4}, "魏", false, {"突袭"}, "男", {""}, true},
    ["甄姬"] = {{3,3}, "魏", false, {"洛神", "倾国"}, "女", {"",""}, true},
    ["夏侯惇"] = {{4,4}, "魏", false, {"刚烈"}, "男", {""}, true}, 
    ["曹仁"] = {{4,4}, "魏", false, {"据守"}, "男", {""}, false},
    ["许褚"] = {{4,4}, "魏", false, {"裸衣"}, "男", {""}, true}, 
    ["夏侯渊"] = {{4,4}, "魏", false, {"神速"}, "男", {""}, false},  
    ["荀彧"] = {{3,3}, "魏", false, {"驱虎", "节命"}, "男", {"",""}, true}, 
    ["典韦"] = {{4,4}, "魏", false, {"强袭"}, "男", {""}, true}, 
    ["曹丕"] = {{3,3}, "魏", true, {"放逐", "行殇", "颂威"}, "男", {"","","主公"}, true},    
    ["徐晃"] = {{4,4}, "魏", false, {"断粮"}, "男", {""}, true}, 
    ["邓艾"] = {{4,4}, "魏", false, {"屯田", "凿险"}, "男", {"","觉醒"}, false}, 
    ["张郃"] = {{4,4}, "魏", false, {"巧变"}, "男", {""}, false}, 
	["张春华"] = {{3,3}, "魏", false, {"绝情", "伤逝"}, "女", {"锁定",""}, true},
	["SP姜维"] = {{4,4}, "魏", false, {"困奋", "逢亮"}, "男", {"锁定","觉醒"}, true},
	["曹彰"] = {{4,4}, "魏", false, {"将驰"}, "男", {""}, true},
    ["孙权"] = {{4,4}, "吴", true, {"制衡", "救援"}, "男", {"","主公"}, true}, 
    ["甘宁"] = {{4,4}, "吴", false, {"奇袭"}, "男", {""}, true}, 
    ["黄盖"] = {{4,4}, "吴", false, {"苦肉"}, "男", {""}, true}, 
    ["周瑜"] = {{3,3}, "吴", false, {"英姿", "反间"}, "男", {"",""}, true}, 
    ["陆逊"] = {{3,3}, "吴", false, {"谦逊", "连营"}, "男", {"锁定",""}, true}, 
    ["大乔"] = {{3,3}, "吴", false, {"国色", "流离"}, "女", {"",""}, true}, 
    ["小乔"] = {{3,3}, "吴", false, {"天香", "红颜"}, "女", {"","锁定"}, false},
	["吕蒙"] = {{4,4}, "吴", false, {"克己"}, "男", {""}, true}, 
    ["孙尚香"] = {{3,3}, "吴", false, {"结姻", "枭姬"}, "女", {"",""}, true}, 
    ["周泰"] = {{4,4}, "吴", false, {"不屈"}, "男", {""}, false}, 
    ["太史慈"] = {{4,4}, "吴", false, {"天义"}, "男", {""}, true}, 
    ["鲁肃"] = {{3,3}, "吴", false, {"好施", "缔盟"}, "男", {"",""}, true}, 
    ["孙坚"] = {{4,4}, "吴", false, {"英魂"}, "男", {"",""}, true}, 
    ["张昭张宏"] = {{3,3}, "吴", false, {"直谏", "固政"}, "男", {"",""}, true}, 
    ["孙策"] = {{4,4}, "吴", true, {"激昂", "魂姿", "制霸"}, "男", {"","觉醒","主公"}, true}, 
    ["吕布"] = {{4,4}, "群", false, {"无双"}, "男", {"锁定"}, true}, 
    ["貂蝉"] = {{3,3}, "群", false, {"闭月", "离间"}, "女", {"",""}, true}, 	
	["华佗"] = {{3,3}, "群", false, {"急救", "青囊"}, "男", {"",""}, true}, 
	["张角"] = {{3,3}, "群", true, {"雷击", "鬼道", "黄天"}, "男", {"","","主公"}, true}, 
    ["庞德"] = {{4,4}, "群", false, {"猛进", "马术"}, "男", {"","锁定"}, true}, 
    ["袁绍"] = {{4,4}, "群", true, {"乱击", "血裔"}, "男", {"","主公"}, true}, 
    ["董卓"] = {{8,8}, "群", true, {"酒池", "肉林", "崩坏", "暴虐"}, "男", {"","锁定","锁定","主公"}, true}, 
    ["蔡文姬"] = {{3,3}, "群", false, {"悲歌", "断肠"}, "女", {"","锁定"}, false}, 
    ["左慈"] = {{3,3}, "群", false, {"化身", "新生"}, "男", {"禁止","禁止"}, true},
	["贾诩"] = {{3,3}, "群", false, {"完杀", "乱武", "帷幕"}, "男", {"锁定", "限定", "锁定"}, true},	
	["SP貂蝉"] = {{3,3}, "群", false, {"闭月", "离魂"}, "女", {"",""}, true}, 
	["灵雎"] = {{3,3}, "群", false, {"竭缘", "焚心"}, "女", {"", "限定"}, true},	
	["神曹操"] = {{3,3}, "神", false, {"归心", "飞影"}, "男", {"","锁定"}, true},
	["孙笑川"] = {{4,4}, "神", false, {"苦肉","驱虎","离魂","奸雄","天香","鬼道","当先","火计","化身","新生","伤逝","仁德","制衡","困奋"}, "男", {"","","","","","","锁定","","禁止","禁止","","","",""}, true},
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
char_wujiang = {"刘备", "刘禅", "曹操", "曹丕", "孙权", "孙策", "张角", "袁绍", "董卓", "孙笑川", "关羽", "张飞", "赵云", "马超", "诸葛亮", "黄月英", "黄忠", "魏延", "庞统", "卧龙诸葛", "孟获", "祝融", "姜维", "关索", "司马懿", "郭嘉", "张辽", "甄姬", "夏侯惇", "曹仁", "许褚", "夏侯渊", "荀彧", "典韦", "徐晃", "邓艾", "张郃", "张春华", "甘宁", "黄盖", "周瑜", "陆逊", "大乔", "吕蒙", "孙尚香", "周泰", "太史慈", "鲁肃", "孙坚", "张昭张宏", "吕布", "貂蝉", "华佗", "庞德", "蔡文姬", "左慈", "神曹操", "曹彰", "廖化", "灵雎", "SP貂蝉", "贾诩"}
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
char_acting_i = 1	-- 当前正在进行其回合的武将
char_yisha = false  -- 已经出过杀
char_sha_time = 1  -- 回合内允许的出杀次数
char_sha_able = true  -- 回合内是否允许出杀
char_distance_infinity = false  --回合内是否攻击范围无限
char_jiu_time = 1  -- 回合内允许的喝酒次数
char_hejiu = false  -- 已经喝酒
char_wushi = false  -- 无视防具标志 (古锭刀)
char_rende_given = 0  -- 使用仁德技能已给出牌数
char_luoyi = false  -- 许褚使用了裸衣技能
char_xiangying_2 = false	-- 吕布无双、董卓肉林，需要己方使用两张手牌抵消的
char_liegong = false	-- 黄忠发动烈弓标志
char_zhuque = false		-- 发动朱雀羽扇标志
char_haoshi = false		-- 鲁肃发动好施标志
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

    char_juese_fid = table.copy(char_juese_identity)
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
	
	--  玩家选择武将 --
	add_funcptr(char_choose_wujiang, nil)
	add_funcptr(char_choose_zhudong, nil)
	add_funcptr(char_choose_shili, nil)
	-- 其他身份分配武将 --
	for i = 1, 5 do
	    add_funcptr(_wujiang_sub2, {i})
	end
	
end


function char_choose_wujiang()
	local ID
	ID = char_current_i
	if char_juese[char_current_i].shenfen == "主公" then
		is_zhugong = true
	end
	wujiang_choose ={}
	local wujiang_number = 5
	char_wujiang_f = char_wujiang
	if is_zhugong then
		for i = 1, #char_wujiang_zhugong do
			table.insert(wujiang_choose, {char_juese_jineng[char_wujiang_zhugong[i]][2], char_wujiang_zhugong[i], char_juese_jineng[char_wujiang_zhugong[i]][1][1], char_juese_jineng[char_wujiang_zhugong[i]][1][2], char_juese_jineng[char_wujiang_zhugong[i]][5]})
		end
		for i = 1, #char_wujiang_zhugong do
			table.remove(char_wujiang_f, 1)
		end
		wujiang_number = 2
	end
	math.randomseed(timer.getMilliSecCounter())
	table.insert(wujiang_choose,{char_juese_jineng[char_wujiang_f[9]][2], char_wujiang_f[9], char_juese_jineng[char_wujiang_f[9]][1][1], char_juese_jineng[char_wujiang_f[9]][1][2], char_juese_jineng[char_wujiang_f[9]][5]})
	while wujiang_number > 0 do
		local t = math.random(#char_wujiang_f)
		if char_juese_jineng[char_wujiang_f[t]][7] == true then
			table.insert(wujiang_choose,{char_juese_jineng[char_wujiang_f[t]][2], char_wujiang_f[t], char_juese_jineng[char_wujiang_f[t]][1][1], char_juese_jineng[char_wujiang_f[t]][1][2], char_juese_jineng[char_wujiang_f[t]][5]})
			table.remove(char_wujiang_f,t)
			wujiang_number = wujiang_number - 1
		else
			table.remove(char_wujiang_f,t)
		end
	end
end

function char_choose_zhudong()
	local ID
	ID = char_current_i

	local old_gamerun_status = gamerun_status
	push_zhudong_queue(table.copy(funcptr_queue), funcptr_i)
	timer.stop()
	funcptr_queue = {}
	funcptr_i = 0

	gamerun_status = "选项选择"
	if is_zhugong == true then
		choose_name = "您是"..char_juese[char_current_i].shenfen.."，请选将"
	else
		choose_name = "您是"..char_juese[char_current_i].shenfen.."，主公是"..zhugong_name
	end
	choose_option = {}
	for i = 1,#wujiang_choose do
		table.insert(choose_option,wujiang_choose[i][1].." "..wujiang_choose[i][2].." "..wujiang_choose[i][3].."/"..wujiang_choose[i][4])
	end

	txt_messages:setVisible(false)
	gamerun_guankan_selected = 1
	item_disrow = 0
	gamerun_item = function(i)
		funcptr_queue = {}
		txt_messages:setVisible(true)
		push_message("您选择了武将"..wujiang_choose[i][2])
		char_juese[char_current_i].name = wujiang_choose[i][2]
		char_juese[char_current_i].shili = wujiang_choose[i][1]
		char_juese[char_current_i].xingbie = wujiang_choose[i][5]
		if is_zhugong then
			char_juese[char_current_i].tili_max = wujiang_choose[i][3] + 1
			char_juese[char_current_i].tili = wujiang_choose[i][4] + 1
			for j = 1,#char_juese_jineng[char_juese[char_current_i].name][4] do
				if char_juese_jineng[char_juese[char_current_i].name][4][j] == "焚心" then
					
				elseif char_juese_jineng[char_juese[char_current_i].name][4][j] == "挑衅" or char_juese_jineng[char_juese[char_current_i].name][4][j] == "伏枥" or char_juese_jineng[char_juese[char_current_i].name][4][j] == "反间" or char_juese_jineng[char_juese[char_current_i].name][4][j] == "驱虎" or char_juese_jineng[char_juese[char_current_i].name][4][j] == "制衡" or char_juese_jineng[char_juese[char_current_i].name][4][j] == "结姻" or char_juese_jineng[char_juese[char_current_i].name][4][j] == "天义"  or char_juese_jineng[char_juese[char_current_i].name][4][j] == "涅槃" or char_juese_jineng[char_juese[char_current_i].name][4][j] == "缔盟" or char_juese_jineng[char_juese[char_current_i].name][4][j] == "离间" or char_juese_jineng[char_juese[char_current_i].name][4][j] == "离魂" or char_juese_jineng[char_juese[char_current_i].name][4][j] == "青囊" then
					char_juese[char_current_i].skill[char_juese_jineng[char_juese[char_current_i].name][4][j]] = 1
				else
					char_juese[char_current_i].skill[char_juese_jineng[char_juese[char_current_i].name][4][j]] = "available"
				end
				table.insert(char_juese[char_current_i].skillname,char_juese_jineng[char_juese[char_current_i].name][4][j])
			end
			table.remove(wujiang_choose, i)
			for j = 1, #wujiang_choose do
				table.insert(char_wujiang_f,#char_wujiang_f,wujiang_choose[j][2])
			end
			wujiang_choose = {}
		else
			char_juese[char_current_i].tili_max = wujiang_choose[i][3]
			char_juese[char_current_i].tili = wujiang_choose[i][4]
			for j = 1,#char_juese_jineng[char_juese[char_current_i].name][4] do
				if char_juese_jineng[char_juese[char_current_i].name][4][j] == "激将" or char_juese_jineng[char_juese[char_current_i].name][4][j] == "护驾" or char_juese_jineng[char_juese[char_current_i].name][4][j] == "救援" or char_juese_jineng[char_juese[char_current_i].name][4][j] == "黄天" or char_juese_jineng[char_juese[char_current_i].name][4][j] == "血裔" or char_juese_jineng[char_juese[char_current_i].name][4][j] == "颂威" or char_juese_jineng[char_juese[char_current_i].name][4][j] == "暴虐" or char_juese_jineng[char_juese[char_current_i].name][4][j] == "若愚" or char_juese_jineng[char_juese[char_current_i].name][4][j] == "制霸" then
					
				elseif char_juese_jineng[char_juese[char_current_i].name][4][j] == "挑衅" or char_juese_jineng[char_juese[char_current_i].name][4][j] == "伏枥" or char_juese_jineng[char_juese[char_current_i].name][4][j] == "反间" or char_juese_jineng[char_juese[char_current_i].name][4][j] == "驱虎" or char_juese_jineng[char_juese[char_current_i].name][4][j] == "制衡" or char_juese_jineng[char_juese[char_current_i].name][4][j] == "结姻" or char_juese_jineng[char_juese[char_current_i].name][4][j] == "天义"  or char_juese_jineng[char_juese[char_current_i].name][4][j] == "涅槃" or char_juese_jineng[char_juese[char_current_i].name][4][j] == "缔盟" or char_juese_jineng[char_juese[char_current_i].name][4][j] == "离间" or char_juese_jineng[char_juese[char_current_i].name][4][j] == "离魂" or char_juese_jineng[char_juese[char_current_i].name][4][j] == "青囊" or char_juese_jineng[char_juese[char_current_i].name][4][j] == "焚心" then
					char_juese[char_current_i].skill[char_juese_jineng[char_juese[char_current_i].name][4][j]] = 1
					table.insert(char_juese[char_current_i].skillname,char_juese_jineng[char_juese[char_current_i].name][4][j])
				else
					char_juese[char_current_i].skill[char_juese_jineng[char_juese[char_current_i].name][4][j]] = "available"
					table.insert(char_juese[char_current_i].skillname,char_juese_jineng[char_juese[char_current_i].name][4][j])
				end
			end
			table.remove(wujiang_choose, i)
		end
		gamerun_status = old_gamerun_status
		_huashen_huifu()
		timer.start(0.2)
	end
	platform.window:invalidate()
end


--  神将选择势力  --
function char_choose_shili()
	if char_juese[char_current_i].shili ~= "神" then
		return
	end
	local ID
	ID = char_current_i

	local old_gamerun_status = gamerun_status
	push_zhudong_queue(table.copy(funcptr_queue), funcptr_i)
	timer.stop()
	funcptr_queue = {}
	funcptr_i = 0

	gamerun_status = "选项选择"
	choose_name = "您选了神武将"..char_juese[char_current_i].name.."，请选势力"
	choose_option = {"魏","蜀","吴","群","晋"}

	txt_messages:setVisible(false)
	gamerun_guankan_selected = 1
	item_disrow = 0
	gamerun_item = function(i)
		funcptr_queue = {}
		txt_messages:setVisible(true)
		push_message("您选择了"..choose_option[i].."势力")
		char_juese[char_current_i].shili = choose_option[i]
		gamerun_status = old_gamerun_status
		_huashen_huifu()
		timer.start(0.2)
	end
	platform.window:invalidate()
end

function _wujiang_sub1()
    local i, t = 0, msg

	char_wujiang_f = char_wujiang
	math.randomseed(timer.getMilliSecCounter())
    
	for i = 1, 5 do
	    if char_juese[i].shenfen == "主公" and i ~= char_current_i then
		    t = math.random(#char_wujiang_zhugong)
			-- t = 10 取消锁定选择孙笑川主公
			char_juese[i].name = char_wujiang_zhugong[t]
			zhugong_name = char_juese[i].name
			char_juese[i].tili_max = char_juese_jineng[char_wujiang_zhugong[t]][1][1] + 1
			char_juese[i].tili = char_juese_jineng[char_wujiang_zhugong[t]][1][2] + 1
			char_juese[i].shili = char_juese_jineng[char_wujiang_zhugong[t]][2]
			char_juese[i].xingbie = char_juese_jineng[char_wujiang_zhugong[t]][5]
			table.remove(char_wujiang_f, t)
			for j = 1,#char_juese_jineng[char_juese[i].name][4] do
				if char_juese_jineng[char_juese[i].name][4][j] == "焚心" then
					
				elseif char_juese_jineng[char_juese[i].name][4][j] == "挑衅" or char_juese_jineng[char_juese[i].name][4][j] == "伏枥" or char_juese_jineng[char_juese[i].name][4][j] == "反间" or char_juese_jineng[char_juese[i].name][4][j] == "驱虎" or char_juese_jineng[char_juese[i].name][4][j] == "制衡" or char_juese_jineng[char_juese[i].name][4][j] == "结姻" or char_juese_jineng[char_juese[i].name][4][j] == "天义"  or char_juese_jineng[char_juese[i].name][4][j] == "涅槃" or char_juese_jineng[char_juese[i].name][4][j] == "缔盟" or char_juese_jineng[char_juese[i].name][4][j] == "离间" or char_juese_jineng[char_juese[i].name][4][j] == "离魂" or char_juese_jineng[char_juese[i].name][4][j] == "青囊" then
					char_juese[i].skill[char_juese_jineng[char_juese[i].name][4][j]] = 1
				else
					char_juese[i].skill[char_juese_jineng[char_juese[i].name][4][j]] = "available"
				end
				table.insert(char_juese[i].skillname,char_juese_jineng[char_juese[i].name][4][j])
			end
		    msg = {"玩家", i, "(主公)选择", char_juese[i].name}
			push_message(table.concat(msg))
			if char_juese[i].shili == "神" then
				local shili = {"魏","蜀","吴","群","晋"}
				char_juese[i].shili = shili[math.random(5)]
				msg = {"玩家", i, "选择了", char_juese[i].shili, "势力"}
				push_message(table.concat(msg))
			end
			msg = nil; --collectgarbage()
			



			--  注释此二行即使用主动AI，不注释不使用  --
			--char_current_i = i
			--char_acting_i = char_current_i
		end
	end
end
function _wujiang_sub2(va_list)
    local i, t = 0, msg
    i = va_list[1]

    if char_juese[i].shenfen ~= "主公" and i ~= char_current_i then
		--if i ~= 1 then
			t = math.random(#char_wujiang_f)
			while char_juese_jineng[char_wujiang_f[t]][7] == false do
				t = math.random(#char_wujiang_f)
			end
		--else
		--	t = 31
		--end
		char_juese[i].name = char_wujiang_f[t]
		char_juese[i].tili_max = char_juese_jineng[char_wujiang_f[t]][1][1]
		char_juese[i].tili = char_juese_jineng[char_wujiang_f[t]][1][2]
		char_juese[i].shili = char_juese_jineng[char_wujiang_f[t]][2]
		char_juese[i].xingbie = char_juese_jineng[char_wujiang_f[t]][5]
		table.remove(char_wujiang_f, t)
		--char_juese[i].tili = 1
		for j = 1,#char_juese_jineng[char_juese[i].name][4] do
			if char_juese_jineng[char_juese[i].name][4][j] == "激将" or char_juese_jineng[char_juese[i].name][4][j] == "护驾" or char_juese_jineng[char_juese[i].name][4][j] == "救援" or char_juese_jineng[char_juese[i].name][4][j] == "黄天" or char_juese_jineng[char_juese[i].name][4][j] == "血裔" or char_juese_jineng[char_juese[i].name][4][j] == "颂威" or char_juese_jineng[char_juese[i].name][4][j] == "暴虐" or char_juese_jineng[char_juese[i].name][4][j] == "若愚" or char_juese_jineng[char_juese[i].name][4][j] == "制霸" then
				
			elseif char_juese_jineng[char_juese[i].name][4][j] == "挑衅" or char_juese_jineng[char_juese[i].name][4][j] == "伏枥" or char_juese_jineng[char_juese[i].name][4][j] == "反间" or char_juese_jineng[char_juese[i].name][4][j] == "驱虎" or char_juese_jineng[char_juese[i].name][4][j] == "制衡" or char_juese_jineng[char_juese[i].name][4][j] == "结姻" or char_juese_jineng[char_juese[i].name][4][j] == "天义"  or char_juese_jineng[char_juese[i].name][4][j] == "涅槃" or char_juese_jineng[char_juese[i].name][4][j] == "缔盟" or char_juese_jineng[char_juese[i].name][4][j] == "离间" or char_juese_jineng[char_juese[i].name][4][j] == "离魂" or char_juese_jineng[char_juese[i].name][4][j] == "青囊" or char_juese_jineng[char_juese[i].name][4][j] == "焚心" then
				char_juese[i].skill[char_juese_jineng[char_juese[i].name][4][j]] = 1
				table.insert(char_juese[i].skillname,char_juese_jineng[char_juese[i].name][4][j])
			else
				char_juese[i].skill[char_juese_jineng[char_juese[i].name][4][j]] = "available"
				table.insert(char_juese[i].skillname,char_juese_jineng[char_juese[i].name][4][j])
			end
		end
		msg = {"玩家", i, "选择", char_juese[i].name}
	    push_message(table.concat(msg))
		if char_juese[i].shili == "神" then
			local shili = {"魏","蜀","吴","群","晋"}
			char_juese[i].shili = shili[math.random(5)]
			msg = {"玩家", i, "选择了", char_juese[i].shili, "势力"}
			push_message(table.concat(msg))
		end
		msg = nil; --collectgarbage()
	end
	for j = 1, #wujiang_choose do
		table.insert(char_wujiang_f,#char_wujiang_f,wujiang_choose[j][2])
	end
	wujiang_choose = {}
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
function char_judge_shengli(siwang_id, laiyuan)
	local i, count, alive, ended

	--  内奸最后存活  --
	count = 0
	for i = 1, 5 do
		if char_juese[i].siwang == false then
			count = count + 1
			alive = i
		end
	end
	if count == 1 and char_juese[alive].shenfen == "内奸" then
		msg = {"所有其他角色阵亡，内奸胜利，游戏结束"}
		add_funcptr(push_message, table.concat(msg))
		add_funcptr(_deduct_sub)

		game_victory = true
		return true
	end
	
	--  主公阵亡  --
	if char_juese[siwang_id].shenfen == "主公" then
		msg = {"主公阵亡，反贼胜利，游戏结束"}
		add_funcptr(push_message, table.concat(msg))
		add_funcptr(_deduct_sub)
		
		game_victory = true
		return true
	end
	
	--  主公与忠臣最后存活  --
	ended = true
	for i = 1, 5 do
		if char_juese[i].siwang == false then
			if char_juese[i].shenfen == "反贼" or char_juese[i].shenfen == "内奸" then
				ended = false
			end
		end
	end
	if ended then
		msg = {"反贼与内奸阵亡，主公与忠臣胜利，游戏结束"}
		add_funcptr(push_message, table.concat(msg))
		add_funcptr(_deduct_sub)
		
		game_victory = true
		return true
	end
	
	--  奖惩  --
	if laiyuan ~= nil then
		--  任何人杀死反贼，摸3张牌  --
		if siwang_id ~= laiyuan and char_juese[siwang_id].shenfen == "反贼" then
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
	local msg = table.concat({char_juese[ID].name, "将武将牌翻面"})
	push_message(msg)
end

--  卖血技能结算  --
function char_skills_sellblood(va_list)
	local id, laiyuan, tili, shuxing, AOE
	local hengzhi

	id = va_list[2]; laiyuan = va_list[3]; shuxing = va_list[4]; fp = va_list[6]; AOE = va_list[7]
	tili = char_juese[id].tili - _deduct_count(va_list)

	local soldblood = false

	--  曹操发动奸雄  --
	if char_juese[id].skill["奸雄"] == "available" and cansellblood == true then
		add_funcptr(skills_jianxiong, id)
		soldblood = true
	end

	--  郭嘉发动遗计  --
	if char_juese[id].skill["遗计"] == "available" and cansellblood == true then
		skills_yiji_add(id, _deduct_count(va_list))
		soldblood = true
	end

	--  司马懿发动反馈  --
	if char_juese[id].skill["反馈"] == "available" and cansellblood == true and laiyuan ~= nil then
		if ai_card_stat(laiyuan, true) >= 1 then
			add_funcptr(skills_fankui, {id, laiyuan})
			soldblood = true
		end
	end
	
	--  曹丕发动放逐  --
	if char_juese[id].skill["放逐"] == "available" and cansellblood == true and laiyuan ~= nil then
		add_funcptr(skills_fangzhu, {id, laiyuan})
		soldblood = true
	end
	
	--  神曹操发动归心  --
	if char_juese[id].skill["归心"] == "available" and cansellblood == true and laiyuan ~= nil then
		skills_guixin_add(id, _deduct_count(va_list))
		soldblood = true
	end
	
	--  夏侯惇发动刚烈  --
	if char_juese[id].skill["刚烈"] == "available" and cansellblood == true and laiyuan ~= nil then
		add_funcptr(skills_ganglie, {id, laiyuan})
		soldblood = true
	end
	
	--  左慈发动新生  --
	if char_juese[id].skill["新生"] == "available" and cansellblood == true then
		for i = 1, _deduct_count(va_list) do
			add_funcptr(skills_xinsheng, {id, false})
		end
		soldblood = true
	end

	--  荀彧发动节命  --
	if char_juese[id].skill["节命"] == "available" and cansellblood == true then
		skills_jieming_add(id, _deduct_count(va_list))
		soldblood = true
	end

	--  张春华发动伤逝，在手牌不足时摸牌  --
	if char_juese[id].skill["伤逝"] == "available" and #char_juese[id].shoupai < char_juese[id].tili_max - char_juese[id].tili then
		add_funcptr(skills_shangshi,id)
		soldblood = true
	end

	if soldblood == false and tili <= 0 then
		add_funcptr(_sha_sub4)		--  占位，因为 "必须至少有一个函数" 是带卖血标志
	end
end

--  体力扣减结算  --
function char_tili_deduct(va_list)
	local id, laiyuan, tili, shuxing, AOE
	local hengzhi
	local fp
	id = va_list[2]; laiyuan = va_list[3]; shuxing = va_list[4]; fp = va_list[6]; AOE = va_list[7]
	tili = char_juese[id].tili - _deduct_count(va_list)
	
	--  设置函数队列为体力扣减结算部分  --
	local old_add_tag = funcptr_add_tag
	if funcptr_add_tag == nil then
		funcptr_add_tag = "体力扣减"
	elseif string.find(funcptr_add_tag, "体力扣减") then

	else
		funcptr_add_tag = funcptr_add_tag .. "/体力扣减"
	end

	if laiyuan ~= nil then
		if char_juese[laiyuan].skill["绝情"] == "available" and shuxing ~= "流失" then
			add_funcptr(push_message, char_juese[laiyuan].name .. "触发了武将技能 '绝情'")
			cansellblood, shuxing = false, "流失"
		end
	end
	if shuxing ~= "流失" then
		cansellblood = true
	else
		cansellblood = false
	end

	--  小乔天香  --
	if char_juese[id].skill["天香"] == "available" and cansellblood == true then
		add_funcptr(skills_tianxiang, {id, _deduct_count(va_list), shuxing, va_list})
	end

	--  扣减体力  --
	add_funcptr(_char_tili_deduct, va_list)
	
	if laiyuan ~= nil then
		--  魏延对距离1以内的玩家造成伤害，回复1点体力  --
		if char_juese[laiyuan].skill["狂骨"] == "available" and char_calc_distance(laiyuan, id) <= 1 and char_juese[laiyuan].tili < char_juese[laiyuan].tili_max and shuxing ~= "流失" then
			skills_kuanggu(laiyuan)
		end
	end
	
	--  重置连环状态  --
	hengzhi = char_juese[id].hengzhi
	if shuxing == "火" or shuxing == "雷" then
		if hengzhi == true then
			add_funcptr(_deduct_chongzhi, id)
		end
	end
		
	if tili <= 0 then
		--  进入濒死状态  --
		add_funcptr(char_binsi, {id, tili, laiyuan, shuxing, true})
	end

	--  设置函数队列卖血标志  --
	local old_add_tag_2 = funcptr_add_tag
	funcptr_add_tag = funcptr_add_tag .. "/卖血"
	if cansellblood then
		char_skills_sellblood(va_list)
	elseif tili <= 0 then
		add_funcptr(_sha_sub4)	--  占位，因为 "必须至少有一个函数" 是带卖血标志
	end
		
	--  在杀的状态下：造成伤害后，麒麟弓可将马弃置  --
	if laiyuan ~= nil and fp ~= nil and shuxing ~= "流失" then
		if #char_juese[laiyuan].wuqi ~= 0 then
			if char_juese[laiyuan].wuqi[1] == "麒麟弓" then
				fp(laiyuan, id)
			end
		end
	end
	funcptr_add_tag = old_add_tag_2
			
	--  连环状态，下一个受到传导伤害  --
	if hengzhi == true then
		if shuxing == "火" or shuxing == "雷" then
			_deduct_lianhuan(va_list)
		end
	end

	funcptr_add_tag = old_add_tag
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
	--add_funcptr(_sha_sub2, nil)
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
	msg = nil; --collectgarbage()
end
function _deduct_sub()    --  进入游戏重置状态
	timer.stop()
	funcptr_queue = {}
	gamerun_huihe = "游戏结束"
	gamerun_status = ""
	set_hints("请按'确定'重新开局")
end

--  角色濒死结算  --
function char_binsi(va_list)
	local id, tili, ID_shanghai, shanghai_shuxing, has_sellblood
	id = va_list[1]; tili = va_list[2]; ID_shanghai = va_list[3]; shanghai_shuxing = va_list[4]; has_sellblood = va_list[5]

	if char_juese[id].tili > 0 then
		return
	end

	push_zhudong_queue(table.copy(funcptr_queue), funcptr_i)

	timer.stop()
	funcptr_queue = {}
	funcptr_i = 0

	msg = {char_juese[id].name, "快死了，求", 1 - tili, "个桃救命"}
	add_funcptr(push_message, table.concat(msg))
	
	--  求桃救命  --
	local i, cur
	cur = id
	
	if char_juese[char_acting_i].skill["完杀"] == "available" then
		msg = {char_juese[char_acting_i].name, "触发了武将技能 '完杀'"}
		add_funcptr(push_message, table.concat(msg))
	end

	for i = 1, 5 do
		if char_juese[cur].siwang == false then
			local wansha = false

			--  贾诩完杀，除贾诩和濒死对象外都不可出桃  --
			if char_juese[char_acting_i].skill["完杀"] == "available" and cur ~= id and cur ~= char_acting_i then
				wansha = true
			end

			if wansha == false then
				--  庞统发动涅槃  --
				if id == cur and char_juese[id].skill["涅槃"] == 1 then
					add_funcptr(skills_niepan, id)
				elseif id == cur and char_juese[id].skill["伏枥"] == 1 then
					add_funcptr(skills_fuli, id)
				else
					if cur ~= char_current_i then
						add_funcptr(_binsi_ai, {id, cur})
					else
						add_funcptr(_binsi_zhudong, id)
					end
				end
			end
		end
		
		cur = cur + 1
		if cur > 5 then
			cur = 1
		end
	end
	
	--  死亡结算  --
	add_funcptr(_binsi_siwang, {id, ID_shanghai, shanghai_shuxing, has_sellblood})
	timer.start(0.6)
end
function _binsi_ai(va_list)		--  濒死结算：AI做出决定
	local msg
	local ID_s, ID_jiu
	ID_s = va_list[1]; ID_jiu = va_list[2]

	if char_juese[ID_jiu].siwang == false then
		if char_juese[ID_s].tili > 0 then
			msg = {char_juese[ID_s].name, "已被救活, ", char_juese[ID_jiu].name, "不使用桃"}
			push_message(table.concat(msg))
			return
		end

		if ID_s ~= ID_jiu and ai_judge_jiejiu(ID_s, ID_jiu) == false then
			msg = {char_juese[ID_jiu].name, "不使用桃"}
			push_message(table.concat(msg))
			return
		end

		local n_tao = 0
		local n_jiu = 0
		local c_pos, card
		while char_juese[ID_s].tili <= 0 do
			c_pos = card_chazhao(ID_jiu, "桃")

			if c_pos <= 0 then
				--  华佗在他人的回合可以使用急救  --
				if ID_s ~= ID_jiu and char_juese[ID_jiu].skill["急救"] == "available" then
					c_pos = skills_jijiu_chazhao(ID_jiu)
				end
			end

			if c_pos > 0 then
				card = char_juese[ID_jiu].shoupai[c_pos]
				card_add_qipai(card)
				card_remove({ID_jiu, c_pos})

				char_juese[ID_s].tili = char_juese[ID_s].tili + 1
				n_tao = n_tao + 1
			else
				break
			end
		end

		--  救自己才能用酒  --
		if ID_s == ID_jiu then
			while char_juese[ID_s].tili <= 0 do
				c_pos = card_chazhao(ID_jiu, "酒")
				if c_pos > 0 then
					card = char_juese[ID_jiu].shoupai[c_pos]
					card_add_qipai(card)
					card_remove({ID_jiu, c_pos})

					char_juese[ID_s].tili = char_juese[ID_s].tili + 1
					n_jiu = n_jiu + 1
				else
					break
				end
			end
		end

		msg = _binsi_create_msg(n_tao, n_jiu, ID_jiu)
		push_message(table.concat(msg))
	end
end
function _binsi_create_msg(n_tao, n_jiu, ID_jiu)	--  濒死结算：返回显示信息
	local msg
	if n_tao == 0 and n_jiu == 0 then
		msg = {char_juese[ID_jiu].name, "不使用桃"}
	elseif n_tao > 0 and n_jiu == 0 then
		msg = {char_juese[ID_jiu].name, "出", n_tao, "张桃"}
	elseif n_tao == 0 and n_jiu > 0 then
		msg = {char_juese[ID_jiu].name, "出", n_jiu, "张酒"}
	else
		msg = {char_juese[ID_jiu].name, "出", n_tao, "张桃, ", n_jiu, "张酒"}
	end
	return msg
end
function _binsi_judge_tao(ID_s, tao_needed)		--  濒死结算：判断选择的牌是否符合条件
	local qualified_cards = {}
	local shoupai = char_juese[char_current_i].shoupai

	if table.getn2(card_selected) <= tao_needed then
		for i = #shoupai, 1, -1 do
			if card_selected[i] ~= nil then
				local qualified = false
				--  华佗在他人的回合可以使用急救，可使用红色牌  --
				if ID_s ~= char_current_i and char_juese[char_current_i].skill["急救"] == "available" then
					if shoupai[i][2] == "红桃" or shoupai[i][2] == "方块" then
						qualified = true
					end
				end

				if shoupai[i][1] == "桃" then
					qualified = true
				end

				if ID_s == char_current_i and shoupai[i][1] == "酒" then
					qualified = true
				end

				if qualified then
					table.insert(qualified_cards, i)
				else
					return {}
				end
			end
		end
		return qualified_cards
	else
		return {}
	end
end
function _binsi_zhudong(ID_s)	--  濒死结算：己方做出决定
	if char_juese[char_current_i].siwang == true then
		return
	end

	if char_juese[ID_s].tili > 0 then
		msg = {char_juese[ID_s].name, "已被救活, ", char_juese[char_current_i].name, "不使用桃"}
		push_message(table.concat(msg))
		return
	end

	push_zhudong_queue(table.copy(funcptr_queue), funcptr_i)
	timer.stop()
	funcptr_queue = {}
	funcptr_i = 0

	local tao_needed = 1 - char_juese[ID_s].tili
	local msg

	if ID_s == char_current_i then
		msg = {"您可出", tao_needed, "张桃或酒"}
	else
		msg = {"您可出", tao_needed, "张桃"}
	end

	skills_enter(table.concat(msg), "", "濒死", "技能选择-多牌")
	gamerun_OK = false

	gamerun_OK_ptr = function()
		if gamerun_OK then
			local qualified_cards = _binsi_judge_tao(ID_s, tao_needed)
			if #qualified_cards > 0 then
				_binsi_zhudong_chu(ID_s, qualified_cards)
				timer.start(0.6)
			end
		else
			_binsi_zhudong_fangqi(ID_s)
			timer.start(0.6)
		end
	end
end
function _binsi_zhudong_chu(ID_s, qualified_cards)		--  濒死结算：己方解救
	gamerun_status = "手牌生效中"
	set_hints("")
	card_selected = {}
	card_highlighted = 1

	local n_tao = 0
	local n_jiu = 0

	for i = 1, #qualified_cards do
		local card = char_juese[char_current_i].shoupai[qualified_cards[i]]

		if card[1] == "酒" then
			n_jiu = n_jiu + 1
		else
			n_tao = n_tao + 1
		end

		card_add_qipai(card)
		card_remove({char_current_i, i})
		char_juese[ID_s].tili = char_juese[ID_s].tili + 1
	end

	msg = _binsi_create_msg(n_tao, n_jiu, char_current_i)
	add_funcptr(push_message, table.concat(msg))
	add_funcptr(_binsi_zhudong_huifu)
end
function _binsi_zhudong_fangqi(ID_s)	--  濒死结算：己方放弃
	gamerun_status = "手牌生效中"
	set_hints("")
	card_selected = {}
	card_highlighted = 1

	msg = {char_juese[char_current_i].name, "不使用桃"}
	add_funcptr(push_message, table.concat(msg))
	add_funcptr(_binsi_zhudong_huifu)
end
function _binsi_zhudong_huifu()		--  濒死结算：(己方响应) 恢复原有函数队列
	funcptr_queue, funcptr_i = pop_zhudong_queue()
end
function _binsi_siwang(va_list)	--  濒死结算：角色最终死亡处理
	local id, ID_shanghai, shanghai_shuxing, has_sellblood
	id = va_list[1]; ID_shanghai = va_list[2]; shanghai_shuxing = va_list[3]; has_sellblood = va_list[4]

	--  如经过濒死结算后，角色最后被救活  --
	if char_juese[id].tili > 0 then
		_binsi_huifu()
		return
	end

	push_zhudong_queue(table.copy(funcptr_queue), funcptr_i)
	timer.stop()
	funcptr_queue = {}
	funcptr_i = 0
	char_juese[id].hengzhi = false
	
	--  曹丕发动行殇  --
	local xingshang_id ,fenxin_id = 0, 0
	for i = 1, 5 do
		if i ~= id and char_juese[i].skill["行殇"] == "available" and char_juese[i].siwang == false then
			xingshang_id = i
			break
		end
	end

	--  关索发动征南  --
	--  暂留空

	--  设置死亡标志  --
	char_juese[id].siwang = true

	--  死亡丢弃所有手牌  --
	if xingshang_id == 0 then
		card_qipai_all(id, true)
	else
		add_funcptr(skills_xingshang, {xingshang_id, id, true})
	end

	--  灵雎发动焚心  --
	if ID_shanghai ~= nil and shuxing ~= "流失" and ID_shanghai ~= id and char_juese[ID_shanghai].skill["焚心"] == 1 and char_juese[ID_shanghai].shenfen ~= "主公" and char_juese[id].shenfen ~= "主公" then
		fenxin_pending = id
		add_funcptr(skills_fenxin, {ID_shanghai, id})
	end
	
	--  蔡文姬发动断肠  --
	if ID_shanghai ~= nil and shuxing ~= "流失" and char_juese[id].skill["断肠"] == "available" then
		add_funcptr(skills_duanchang, {id, ID_shanghai})
	end

	add_funcptr(_binsi_sub1, id)

	--  胜利条件判断  --
	if shanghai_shuxing == "流失" then
		char_judge_shengli(id, nil)
	else
		char_judge_shengli(id, ID_shanghai)
	end

	add_funcptr(_binsi_remove_sellblood, {has_sellblood, id})
	timer.start(0.6)
end
function _binsi_remove_sellblood(va_list)	--  濒死结算：角色已死亡，从队列中删除所有卖血结算函数
	local has_sellblood, siwang_id
	has_sellblood = va_list[1]; siwang_id = va_list[2]

	local v_funcptr_queue, v_funcptr_i

	--  弹出第一层：死亡结算，此时位于濒死结算的函数队列中  --
	v_funcptr_queue, v_funcptr_i = pop_zhudong_queue()

	--  弹出第二层：濒死结算，此时位于上一层char_tili_deduct所在的函数队列中  --
	v_funcptr_queue, v_funcptr_i = pop_zhudong_queue()

	--  如果角色已死亡且在自己的回合，跳过其所有阶段  --
	if char_judge_siwang_skip_all_stages(siwang_id) then
		return
	end

	local items_to_remove = {}
	local keep_after = false
	for i = 1, #v_funcptr_queue do
		local tag = v_funcptr_queue[i].tag

		if tag ~= nil then
			if string.find(tag, "卖血") and keep_after == false then
				keep_after = true
			end

			if string.find(tag, "卖血") or keep_after == false then
				table.insert(items_to_remove, i)
			else
				break
			end
		else
			if keep_after == false then
				table.insert(items_to_remove, i)
			else
				break
			end
		end
	end

	for i = #items_to_remove, 1, -1 do
		table.remove(v_funcptr_queue, items_to_remove[i])
	end

	funcptr_queue = v_funcptr_queue
	funcptr_i = 0
end
function _binsi_huifu()		--  濒死结算：角色未死亡，恢复濒死结算前的函数队列
	funcptr_queue, funcptr_i = pop_zhudong_queue()
end
function _binsi_sub1(id)
	msg = {char_juese[id].name, "阵亡，身份为", char_juese[id].shenfen}
	push_message(table.concat(msg))
end
function _binsi_sub2()
	timer.start(0.2)
end

--  当前玩家死亡，跳过其接下来所有阶段  --
function char_judge_siwang_skip_all_stages(ID)
	if char_juese[ID].siwang == true and ID == char_acting_i then
		timer.stop()
		funcptr_queue = {}

		gamerun_huihe_set("结束")
		gamerun_status = ""
		set_hints("请按'确定'继续")

		return true
	else
		return false
	end
end