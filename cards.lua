
function init_cards()
-- 卡牌类型 --
card_leixing = {    -- 类型，花色，点数
    {"八卦阵", "黑桃", "2"},
	{"八卦阵", "草花", "2"},
	{"兵粮寸断", "草花", "4"},
	{"兵粮寸断", "黑桃", "10"},
	{"过河拆桥", "黑桃", "3"},
	{"过河拆桥", "黑桃", "4"},
	{"过河拆桥", "黑桃", "Q"},
	{"过河拆桥", "红桃", "Q"},
	{"过河拆桥", "草花", "3"},
	{"过河拆桥", "草花", "4"},
	{"赤兔", "红桃", "5"},
	{"雌雄剑", "黑桃", "2"},
	{"大宛", "黑桃", "K"},
	{"的卢", "草花", "5"},
	{"方天戟", "方块", "Q"},
	{"贯石斧", "方块", "5"},
	{"古锭刀", "黑桃", "A"},
	{"寒冰剑", "黑桃", "2"},
	{"骅骝", "方块", "K"},
	{"火攻", "红桃", "2"},
	{"火攻", "红桃", "4"},
	{"火攻", "方块", "Q"},
	{"火杀", "红桃", "2"},
	{"火杀", "红桃", "3"},
	{"火杀", "红桃", "7"},
	{"火杀", "方块", "4"},
	{"火杀", "方块", "5"},
	{"借刀杀人", "草花", "Q"},
	{"借刀杀人", "草花", "K"},
	{"酒", "黑桃", "3"},
	{"酒", "黑桃", "9"},
	{"酒", "草花", "3"},
	{"酒", "草花", "9"},
	{"酒", "方块", "9"},
	{"决斗", "黑桃", "A"},
	{"决斗", "草花", "A"},
	{"决斗", "方块", "A"},
	{"绝影", "黑桃", "5"},
	{"乐不思蜀", "黑桃", "6"},
	{"乐不思蜀", "红桃", "6"},
	{"乐不思蜀", "草花", "6"},
	{"雷杀", "黑桃", "4"},
	{"雷杀", "黑桃", "5"},
	{"雷杀", "黑桃", "6"},
	{"雷杀", "黑桃", "7"},
	{"雷杀", "黑桃", "8"},
	{"雷杀", "草花", "5"},
	{"雷杀", "草花", "6"},
	{"雷杀", "草花", "7"},
	{"雷杀", "草花", "8"},
	{"诸葛弩", "草花", "A"},
	{"诸葛弩", "方块", "A"},
	{"南蛮入侵", "黑桃", "7"},
	{"南蛮入侵", "黑桃", "K"},
	{"南蛮入侵", "草花", "7"},
	{"麒麟弓", "红桃", "5"},
	{"青钢剑", "黑桃", "6"},
	{"青龙刀", "黑桃", "5"},
	{"仁王盾", "草花", "2"},
	{"杀", "黑桃", "7"},
	{"杀", "黑桃", "8"},
	{"杀", "黑桃", "8"},
	{"杀", "黑桃", "9"},
	{"杀", "黑桃", "9"},
    {"杀", "黑桃", "10"},
	{"杀", "黑桃", "10"},
	{"杀", "红桃", "10"},
	{"杀", "红桃", "10"},
	{"杀", "红桃", "J"},
	{"杀", "草花", "2"},
	{"杀", "草花", "3"},
	{"杀", "草花", "4"},
	{"杀", "草花", "5"},
	{"杀", "草花", "6"},
	{"杀", "草花", "7"},
	{"杀", "草花", "8"},
	{"杀", "草花", "8"},
	{"杀", "草花", "9"},
	{"杀", "草花", "9"},
	{"杀", "草花", "10"},
	{"杀", "草花", "10"},
	{"杀", "草花", "J"},
	{"杀", "草花", "J"},
	{"杀", "方块", "6"},
	{"杀", "方块", "7"},
	{"杀", "方块", "8"},
	{"杀", "方块", "9"},
	{"杀", "方块", "10"},
	{"杀", "方块", "K"},
	{"闪", "红桃", "2"},
	{"闪", "红桃", "2"},
	{"闪", "红桃", "8"},
	{"闪", "红桃", "9"},
	{"闪", "红桃", "J"},
	{"闪", "红桃", "Q"},
	{"闪", "红桃", "K"},
	{"闪", "方块", "2"},
	{"闪", "方块", "2"},
	{"闪", "方块", "3"},
	{"闪", "方块", "4"},
	{"闪", "方块", "5"},
	{"闪", "方块", "6"},
	{"闪", "方块", "6"},
	{"闪", "方块", "7"},
	{"闪", "方块", "7"},
	{"闪", "方块", "8"},
	{"闪", "方块", "8"},
	{"闪", "方块", "9"},
	{"闪", "方块", "10"},
	{"闪", "方块", "10"},
	{"闪", "方块", "J"},
	{"闪", "方块", "J"},
	{"闪", "方块", "J"},
	{"闪电", "黑桃", "A"},
	{"闪电", "红桃", "Q"},
	{"白银狮", "草花", "A"},
	{"顺手牵羊", "黑桃", "3"},
	{"顺手牵羊", "黑桃", "4"},
	{"顺手牵羊", "黑桃", "J"},
	{"顺手牵羊", "方块", "3"},
	{"顺手牵羊", "方块", "4"},
	{"桃", "红桃", "3"},
	{"桃", "红桃", "4"},
	{"桃", "红桃", "5"},
	{"桃", "红桃", "6"},
	{"桃", "红桃", "6"},
	{"桃", "红桃", "7"},
	{"桃", "红桃", "8"},
	{"桃", "红桃", "9"},
	{"桃", "红桃", "Q"},
	{"桃", "方块", "2"},
	{"桃", "方块", "3"},
	{"桃", "方块", "Q"},
	{"桃园结义", "红桃", "A"},
	{"藤甲", "黑桃", "2"},
	{"藤甲", "草花", "2"},
	{"铁锁连环", "黑桃", "J"},
	{"铁锁连环", "黑桃", "Q"},
	{"铁锁连环", "草花", "10"},
	{"铁锁连环", "草花", "J"},
	{"铁锁连环", "草花", "Q"},
	{"铁锁连环", "草花", "K"},
	{"万箭齐发", "红桃", "A"},
	{"五谷丰登", "红桃", "3"},
	{"五谷丰登", "红桃", "4"},
	{"无懈可击", "黑桃", "J"},
	{"无懈可击", "黑桃", "K"},
	{"无懈可击", "红桃", "A"},
	{"无懈可击", "红桃", "K"},
	{"无懈可击", "草花", "Q"},
	{"无懈可击", "草花", "K"},
	{"无懈可击", "方块", "Q"},
	{"无中生有", "红桃", "7"},
	{"无中生有", "红桃", "8"},
	{"无中生有", "红桃", "9"},
	{"无中生有", "红桃", "J"},
	{"朱雀扇", "方块", "A"},
	{"丈八矛", "黑桃", "Q"},
	{"爪黄飞电", "红桃", "K"},
	{"紫骍", "方块", "K"},
}

-- 卡牌使用提示 --
card_tishi = {
    ["八卦阵"] = "装备八卦阵",
	["兵粮寸断"] = "安装兵粮寸断",
	["过河拆桥"] = "使用过河拆桥",
	["赤兔"] =  "装备-1马",
	["雌雄剑"] =  "装备雌雄双股剑",
	["大宛"] = "装备-1马",
	["的卢"] = "装备+1马",
	["方天戟"] = "装备方天画戟",
	["贯石斧"] = "装备贯石斧",
	["古锭刀"] = "装备古锭刀",
	["寒冰剑"] = "装备寒冰剑",
	["骅骝"] = "装备+1马",
	["火攻"] = "火攻",
	["火杀"] = "火杀", 
	["借刀杀人"] = "请选择目标A",
	["酒"] = "使用酒",
	["决斗"] = "决斗",
	["绝影"] = "装备+1马",
	["乐不思蜀"] = "安装乐不思蜀",
	["雷杀"] = "雷杀",
	["诸葛弩"] = "装备诸葛连弩",
	["南蛮入侵"] = "使用南蛮入侵",
	["麒麟弓"] = "装备麒麟弓",
	["青钢剑"] = "装备青钢剑",
	["青龙刀"] = "装备青龙刀",
	["仁王盾"] = "装备仁王盾",
	["杀"] = "杀",
	["闪"] = "", 
	["闪电"] = "安装闪电",
	["白银狮"] = "装备白银狮子",
	["顺手牵羊"] = "使用顺手牵羊",
	["桃"] = "使用桃, 回复1点体力",
	["桃园结义"] = "使用桃园结义",
	["藤甲"] = "装备藤甲",
	["铁锁连环"] = "'确定': 选择目标A; '取消': 重铸",
	["万箭齐发"] = "使用万箭齐发",
	["五谷丰登"] = "使用五谷丰登",
	["无懈可击"] = "", 
	["无中生有"] = "使用无中生有",
	["朱雀扇"] = "装备朱雀羽扇",
	["丈八矛"] = "装备丈八蛇矛",
	["爪黄飞电"] = "装备+1马",
	["紫骍"] = "装备-1马",
}

-- 牌堆 --
card_weixi = {}    -- 未洗的牌，供随机选取 
card_yixi = {}    -- 已洗的牌 (游戏牌堆)，用于分发
card_qipai = {}    -- 弃牌堆
card_panding_card = {}    -- 翻开的判定牌

-- 界面上高亮/已选取 (凸起) 的牌
card_selected = {}
card_highlighted = 1
end

--  定义变量  --
init_cards()

--  将原始牌堆洗后放入分发牌堆  --
function card_xipai(qipai)
    local t = 0

	if qipai then
	    card_weixi = card_qipai
	else
        card_weixi = card_leixing
	end
	card_yixi = {}
	math.randomseed(timer.getMilliSecCounter())
	
	while #card_weixi ~= 0 do
	    t = math.random(#card_weixi)
		table.insert(card_yixi, card_weixi[t])
		table.remove(card_weixi, t)
	end
	
	if not qipai then
	    push_message("牌堆重置完毕")
	end
end

--  向角色分发手牌  --
function card_fenfa(va_list)
    local ID, zhangshu, xinxi
	ID = va_list[1]; zhangshu = va_list[2]; xinxi = va_list[3]
	
    local i, text
	
    for i = 1, zhangshu do
	    if #card_yixi == 0 then
		    card_xipai(true)
		end
        table.insert(char_juese[ID].shoupai, card_yixi[1])
		table.remove(card_yixi, 1)
    end
	
	if xinxi then
	    text = {char_juese[ID].name, "摸起", zhangshu, "张牌"}
	    push_message(table.concat(text))
	end
end

--  删除角色的手牌，并进入弃牌堆  --
function card_shanchu(va_list)
    local ID_juese, ID_shoupai
	ID_juese = va_list[1]; ID_shoupai = va_list[2]
	if ID_shoupai == -1 then
		_qipai_sub4(ID_juese)
	elseif ID_shoupai == -2 then
		_qipai_sub5(ID_juese)
	elseif ID_shoupai == -3 then
		_qipai_sub6(ID_juese)
	elseif ID_shoupai == -4 then
		_qipai_sub7(ID_juese)
	else
		card_add_qipai(char_juese[ID_juese].shoupai[ID_shoupai])
	end

	card_remove({ID_juese, ID_shoupai})
end

function card_remove(va_list)
	local ID_juese, ID_shoupai
	ID_juese = va_list[1]; ID_shoupai = va_list[2]

	--  如果选择的手牌为装备牌，实际删除装备牌  --
	if ID_shoupai < 0 then
		gamerun_wuqi_in_hand_chu(ID_juese, ID_shoupai)
		return
	end
	
	table.remove(char_juese[ID_juese].shoupai, ID_shoupai)
	
	--  陆逊在失去最后手牌时摸一张牌  --
	if char_juese[ID_juese].skill["连营"] == "available" and #char_juese[ID_juese].shoupai == 0 then
		push_message(char_juese[ID_juese].name.."发动了武将技能 '连营'")
		card_fenfa({ID_juese, 1, true})
	end
	-- 张春华在手牌不足时摸牌 --
	if char_juese[ID_juese].skill["伤逝"] == "available" and table.maxn(char_juese[ID_juese].shoupai) < char_juese[ID_juese].tili_max-char_juese[ID_juese].tili then
		push_message(char_juese[ID_juese].name.."发动了武将技能 '伤逝'")
		card_fenfa({ID_juese, char_juese[ID_juese].tili_max-char_juese[ID_juese].tili-table.maxn(char_juese[ID_juese].shoupai), true})
	end
end

--  在弃牌堆添加手牌  --
function card_add_qipai(card)
	--  去除卡牌的锦囊标志 (技能发动)  --
	if card[4] ~= nil then
		card[4] = nil
	end
    table.insert(card_qipai, card)
end

--  游戏开始时，向所有角色分发4张手牌  --
function card_fenfa_init()
    local i

	for i = 1, 5 do
		--[[
		if i == 1 then
			table.insert(char_juese[1].shoupai, {"寒冰剑", "黑桃", "2"})
		end
		--]]
        card_fenfa({i, 4, false})
	end
end

--  当前顺位玩家摸牌  --
function card_mopai()
    local msg
	
	gamerun_huihe_set("摸牌")
	
    if game_skip_mopai == true then
	    msg = {char_juese[char_current_i].name, "对'兵粮寸断'判定成功, 不能摸牌"}
		push_message(table.concat(msg))
		msg = nil; collectgarbage()
		return
	end
	
	local draw_number = 2
	
	if char_juese[char_current_i].skill["英姿"] == "available" then
		draw_number = draw_number + 1
	end
	if char_luoyi == true then
		draw_number = draw_number - 1
	end
	if type(char_jiangchi) == "number" then
		draw_number = draw_number + char_jiangchi
		if char_jiangchi > 0 then
			char_sha_able = false
		elseif char_jiangchi < 0 then
			char_sha_time = char_sha_time + 1
			char_distance_infinity = true
		end
		char_jiangchi = nil
	end
	if char_tuxi then
		draw_number = 0
		char_tuxi = nil
	end
	if draw_number > 0 then
		card_fenfa({char_current_i, draw_number, true})
	end
end

--  当前玩家弃牌  --
function card_qipai_go()
    local i, v
	v = card_selected
	
	for i = #char_juese[char_current_i].shoupai, -4, -1 do
	    if v[i] ~= nil then
			add_funcptr(_qipai_sub1, i)
		end
	end

	card_selected = {}
end
function _qipai_sub1(ID)
    local msg
	if ID > 0 then
		msg = {char_juese[char_current_i].name, "丢弃'", char_juese[char_current_i].shoupai[ID][2], char_juese[char_current_i].shoupai[ID][3], "的", char_juese[char_current_i].shoupai[ID][1], "'"}
		push_message(table.concat(msg))
		msg = nil; collectgarbage()
	end
	card_shanchu({char_current_i, ID})
end

--  角色死亡，弃置所有手牌  --
function card_qipai_all(ID, panding, _p)
    local i, v, j, max_select
	local p = _p
	
	max_select = #char_juese[ID].shoupai
	j = 0
	
	if max_select > 0 then
		for i = 1, max_select do
			if char_juese[ID].shoupai[i] ~= nil then
				if p == nil then
					add_funcptr(_qipai_sub2, {ID, i - j})
				else
					add_funcptr(_qipai_sub2, {ID, i - j}, p)
					p = p + 1
				end
				j = j + 1
			end
		end
	end
	
	if panding and #char_juese[ID].panding ~= 0 then
		j = 0
		for i = 1, #char_juese[ID].panding do
			if char_juese[ID].panding[i] ~= nil then
				if p == nil then
					add_funcptr(_qipai_sub3, {ID, i - j})
				else
					add_funcptr(_qipai_sub3, {ID, i - j}, p)
					p = p + 1
				end
				j = j + 1
			end
		end
	end
	
	if #char_juese[ID].wuqi ~= 0 then
		if p == nil then
			add_funcptr(_qipai_sub4, ID)
		else
			add_funcptr(_qipai_sub4, ID, p)
		end
		if p ~= nil then p = p + 1 end
	end
	
	if #char_juese[ID].fangju ~= 0 then
		if p == nil then
			add_funcptr(_qipai_sub5, ID)
		else
			add_funcptr(_qipai_sub5, ID, p)
		end
		if p ~= nil then p = p + 1 end
	end
	
	if #char_juese[ID].gongma ~= 0 then
		if p == nil then
			add_funcptr(_qipai_sub6, ID)
		else
			add_funcptr(_qipai_sub6, ID, p)
		end
		if p ~= nil then p = p + 1 end
	end
	
	if #char_juese[ID].fangma ~= 0 then
		if p == nil then
			add_funcptr(_qipai_sub7, ID)
		else
			add_funcptr(_qipai_sub7, ID, p)
		end
		if p ~= nil then p = p + 1 end
	end
	
	if p ~= nil then
		return p
	end
end
function _qipai_sub2(va_list)    --  丢弃手牌
    local msg
	local cardID, ID, is_passive
	ID = va_list[1]; cardID = va_list[2]; is_passive = va_list[3]
	
	if char_juese[ID].shoupai[cardID] == nil then return end
	
	if is_passive then
		msg = {char_juese[ID].name, "的手牌'", char_juese[ID].shoupai[cardID][2], char_juese[ID].shoupai[cardID][3], "的", char_juese[ID].shoupai[cardID][1], "'被弃置"}
	else
		msg = {char_juese[ID].name, "丢弃'", char_juese[ID].shoupai[cardID][2], char_juese[ID].shoupai[cardID][3], "的", char_juese[ID].shoupai[cardID][1], "'"}
	end
	push_message(table.concat(msg))
	msg = nil; collectgarbage()
	card_add_qipai(char_juese[ID].shoupai[cardID])
    table.remove(char_juese[ID].shoupai, cardID)
end
function _qipai_sub3(va_list)    --  丢弃判定区
    local msg
	local cardID, ID, is_passive
	ID = va_list[1]; cardID = va_list[2]; is_passive = va_list[3]
	
	if char_juese[ID].panding[cardID] == nil then return end
	
	if is_passive then
		msg = {char_juese[ID].name, "判定区的'", char_juese[ID].panding[cardID][2], char_juese[ID].panding[cardID][3], "的", char_juese[ID].panding[cardID][1], "'被弃置"}
	else
		msg = {char_juese[ID].name, "丢弃'", char_juese[ID].panding[cardID][2], char_juese[ID].panding[cardID][3], "的", char_juese[ID].panding[cardID][1], "'"}
    end
	push_message(table.concat(msg))
	msg = nil; collectgarbage()
	card_add_qipai(char_juese[ID].panding[cardID])
    table.remove(char_juese[ID].panding, cardID)
end
function _qipai_sub4(ID, hide_msg, is_passive)    --  丢弃武器
    local msg
	
	if hide_msg ~= true then
		if is_passive then
			msg = {char_juese[ID].name, "的武器'", char_juese[ID].wuqi[2], char_juese[ID].wuqi[3], "的", char_juese[ID].wuqi[1], "'被弃置"}
		else
			msg = {char_juese[ID].name, "丢弃'", char_juese[ID].wuqi[2], char_juese[ID].wuqi[3], "的", char_juese[ID].wuqi[1], "'"}
    	end
		push_message(table.concat(msg))
		msg = nil; collectgarbage()
	end
	card_add_qipai(char_juese[ID].wuqi)
    char_juese[ID].wuqi = {}
end
function _qipai_sub5(ID, hide_msg, is_passive)    --  丢弃防具
    local msg
	
	if hide_msg ~= true then
		if is_passive then
			msg = {char_juese[ID].name, "的防具'", char_juese[ID].fangju[2], char_juese[ID].fangju[3], "的", char_juese[ID].fangju[1], "'被弃置"}
		else
			msg = {char_juese[ID].name, "丢弃'", char_juese[ID].fangju[2], char_juese[ID].fangju[3], "的", char_juese[ID].fangju[1], "'"}
    	end
		push_message(table.concat(msg))
		msg = nil; collectgarbage()
	end
	card_add_qipai(char_juese[ID].fangju)
    char_juese[ID].fangju = {}
end
function _qipai_sub6(ID, hide_msg, is_passive)    --  丢弃-1马
    local msg
	
	if hide_msg ~= true then
		if is_passive then
			msg = {char_juese[ID].name, "的-1马'", char_juese[ID].gongma[2], char_juese[ID].gongma[3], "的", char_juese[ID].gongma[1], "'被弃置"}
		else
			msg = {char_juese[ID].name, "丢弃'", char_juese[ID].gongma[2], char_juese[ID].gongma[3], "的", char_juese[ID].gongma[1], "'"}
    	end
		push_message(table.concat(msg))
		msg = nil; collectgarbage()
	end
	card_add_qipai(char_juese[ID].gongma)
    char_juese[ID].gongma = {}
end
function _qipai_sub7(ID, hide_msg, is_passive)    --  丢弃+1马
    local msg
	
	if hide_msg ~= true then
		if is_passive then
			msg = {char_juese[ID].name, "的+1马'", char_juese[ID].fangma[2], char_juese[ID].fangma[3], "的", char_juese[ID].fangma[1], "'被弃置"}
		else
			msg = {char_juese[ID].name, "丢弃'", char_juese[ID].fangma[2], char_juese[ID].fangma[3], "的", char_juese[ID].fangma[1], "'"}
    	end
		push_message(table.concat(msg))
		msg = nil; collectgarbage()
	end
	card_add_qipai(char_juese[ID].fangma)
    char_juese[ID].fangma = {}
end

--  在玩家手牌中查找手牌  --
function card_chazhao(ID, name)
    local i, v
	
	for i, v in pairs(char_juese[ID].shoupai) do
	    if v[1] == name then
		    return i
		end
	end
	
	return -1
end

--  在玩家手牌中查找指定花色的手牌  --
function card_chazhao_with_huase(ID, name)
    local i, v
	
	for i, v in pairs(char_juese[ID].shoupai) do
	    if v[2] == name then
		    return i
		end
	end
	
	return -1
end


--  拼点结算  --
function card_pindian(ID_s, ID_mubiao, win_fp)
	pindianing = {}
	if ID_s == char_current_i or ID_mubiao == char_current_i then
		skills_enter("请选择拼点的牌", "", "进行拼点", "技能选择-拼点")
		gamerun_OK_pindian_ptr = function()
			if ID_s == char_current_i then
				set_hints("")
				gamerun_status = "手牌生效中"
				card_into_pindian(ID_s,card_highlighted)
				card_into_pindian(ID_mubiao,ai_pindian_judge(ID_mubiao,true))
				local win = card_pindian_judge(ID_s,ID_mubiao)

				win_fp(win)
			--[[
			elseif ID_mubiao == char_current_i then
				set_hints("")
				gamerun_status = ""
				card_into_pindian(ID_mubiao,ai_pindian_judge(ID_mubiao,true))
				card_into_pindian(ID_s,card_highlighted)
				win = card_pindian_judge(ID_s,ID_mubiao)
			]]
			end
		end
	--[[
	else
		card_into_pindian(ID_s,ai_pindian_judge(ID_s,true))
		card_into_pindian(ID_mubiao,ai_pindian_judge(ID_mubiao,true))
		win = card_pindian_judge(ID_s,ID_mubiao)
	]]
	end
end

--  手牌进入拼点区  --
function card_into_pindian(ID,ID_card)
	table.insert(pindianing,{char_juese[ID].shoupai[ID_card][1],char_juese[ID].shoupai[ID_card][2],char_juese[ID].shoupai[ID_card][3]})
	table.remove(char_juese[ID].shoupai,ID_card)
	--  陆逊在失去最后手牌时摸一张牌  --
	if char_juese[ID].skill["连营"] == "available" and #char_juese[ID].shoupai == 0 then
		push_message(char_juese[ID].name.."发动了武将技能 '连营'")
		card_fenfa({ID, 1, true})
	end
	-- 张春华在手牌不足时摸牌 --
	if char_juese[ID].skill["伤逝"] == "available" and table.maxn(char_juese[ID].shoupai) < char_juese[ID].tili_max-char_juese[ID].tili then
		push_message(char_juese[ID].name.."发动了武将技能 '伤逝'")
		card_fenfa({ID, char_juese[ID].tili_max-char_juese[ID].tili-table.maxn(char_juese[ID].shoupai), true})
	end
end

--  拼点结算  --
function card_pindian_judge(ID_s,ID_mubiao)
	local i,j
	if pindianing[1][3] == "A" then
		i = 1
	elseif pindianing[1][3] == "J" then
		i = 11
	elseif pindianing[1][3] == "Q" then
		i = 12
	elseif pindianing[1][3] == "K" then
		i = 13
	else
		i = tonumber(pindianing[1][3])
	end
	if pindianing[2][3] == "A" then
		j = 1
	elseif pindianing[2][3] == "J" then
		j = 11
	elseif pindianing[2][3] == "Q" then
		j = 12
	elseif pindianing[2][3] == "K" then
		j = 13
	else
		j = tonumber(pindianing[2][3])
	end
	push_message(char_juese[ID_s].name.."的拼点牌是'"..pindianing[1][2]..pindianing[1][3].."的"..pindianing[1][1].."'")
	push_message(char_juese[ID_mubiao].name.."的拼点牌是'"..pindianing[2][2]..pindianing[2][3].."的"..pindianing[2][1].."'")
	card_add_qipai(pindianing[1])
	card_add_qipai(pindianing[2])
	pindianing = {}
	if i > j then
		push_message(char_juese[ID_s].name.."拼点获胜")
		return true,false
	elseif i < j then
		push_message(char_juese[ID_mubiao].name.."拼点获胜")
		return false,true
	else
		push_message(char_juese[ID_s].name.."与"..char_juese[ID_mubiao].name.."拼点均失败")
		return false,false
	end
end

--  在玩家装备区中查找装备  --
function card_chazhaoarm(ID, name)
	
    if name == "武器" then
		if char_juese[ID].wuqi[1] ~= nil then
			return 1
		end
	elseif name == "防具" then
		if char_juese[ID].fangju[1] ~= nil then
			return 1
		end
	elseif name == "-1马" then
		if char_juese[ID].gongma[1] ~= nil then
			return 1
		end
	elseif name == "+1马" then
		if char_juese[ID].fangma[1] ~= nil then
			return 1
		end
	end
	
	return -1
end

--  判断卡牌类型  --
function card_get_leixing(name)
    if name == "杀" or name == "火杀" or name == "雷杀" or name == "闪" or name == "桃" then
	    return "基本牌"
	end
	
	if name == "乐不思蜀" or name == "兵粮寸断" or name == "闪电" then
	    return "延时类锦囊"
	end
	
	if name == "决斗" or name == "过河拆桥" or name == "顺手牵羊" or name == "万箭齐发" or name == "南蛮入侵" or name == "桃园结义" or name == "无中生有" or name == "五谷丰登" or name == "借刀杀人" or name == "无懈可击" or name == "火攻" or name == "铁锁连环" then
	    return "非延时类锦囊"
	end
	
	if name == "诸葛弩" or name == "雌雄剑" or name == "青钢剑" or name == "青龙刀" or name == "丈八矛" or name == "方天戟" or name == "麒麟弓" or name == "寒冰剑" or name == "古锭刀" or name == "朱雀扇" or name == "贯石斧" then
	    return "武器"
	end
	
	if name == "八卦阵" or name == "仁王盾" or name == "藤甲" or name == "白银狮" then
	    return "防具"
	end
	
	if name == "的卢" or name == "骅骝" or name == "爪黄飞电" or name == "绝影" then
	    return "+1马"
	end
	
	if name == "赤兔" or name == "大宛" or name == "紫骍" then
	    return "-1马"
	end
end

--  判断指定的牌是否是杀  --
function card_judge_if_sha(ID, card_i)
	local card = char_juese[ID].shoupai[card_i]

	if card[1] == "杀" or card[1] == "火杀" or card[1] == "雷杀" then
		return true
	end

	if char_juese[ID].skill["武圣"] == "available" then
		if card[2] == "红桃" or card[2] == "方块" then
			return true
		end
	end

	if char_juese[ID].skill["龙胆"] == "available" then
		if card[1] == "闪" then
			return true
		end
	end
end

--  判断指定的牌是否是闪  --
function card_judge_if_shan(ID, card_i)
	local card = char_juese[ID].shoupai[card_i]

	if card[1] == "闪" then
		return true
	end

	if char_juese[ID].skill["倾国"] == "available" then
		if card[2] == "草花" or card[2] == "黑桃" then
			return true
		end
	end

	if char_juese[ID].skill["龙胆"] == "available" then
		if card[1] == "杀" or card[1] == "火杀" or card[1] == "雷杀" then
			return true
		end
	end
end

--  计算卡牌使用限制  --
function card_if_d_limit(card, ID_s, ID_d)
    local v, p

	--  无任何使用限制，无来源限制  --
	if ID_s < 0 then
		return true
	end

	if type(card) == "table" then
		if #char_juese[ID_s].wuqi ~= 0 then
		    if char_sha_time <= 0 or char_sha_able == false then
	            return false
	        end
		
	        if char_calc_distance(ID_s, ID_d) > card_wuqi_r[char_juese[ID_s].wuqi[1]] and char_distance_infinity == false then
	            return false
	        end
	    else
		    if char_sha_time <= 0 or char_sha_able == false then return false end
	        if char_calc_distance(ID_s, ID_d) > 1 and char_distance_infinity == false then
	            return false
	        end
	    end
		return true
	end
	
    if card_get_leixing(card) == "延时类锦囊" then
	    for _, v in ipairs(char_juese[ID_d].panding) do
	        if v[1] == card then return false end
	    end
	end

    if card == "兵粮寸断" or card == "顺手牵羊" then
		if char_juese[ID_s].skill["断粮"] == "available" then
			--  徐晃使用兵粮寸断距离最大2  --
			if char_calc_distance(ID_s, ID_d) > 2 then
				return false
			end
		else
			--  黄月英使用锦囊不受距离限制  --
			if char_juese[ID_s].skill["奇才"] ~= "available" and char_calc_distance(ID_s, ID_d) > 1 then
				return false
			end
		end
	end
	
	if card == "过河拆桥" or card == "顺手牵羊" then
	    p = char_juese[ID_d]
		--  陆逊谦逊，不能被过河拆桥、顺手牵羊  --
		if p.skill["谦逊"] == "available" then
			return false
		end
		
		if #p.shoupai < 1 and #p.fangju == 0 and #p.wuqi == 0 and #p.gongma == 0 and #p.fangma == 0 and #p.panding == 0 then
		    return false
		end
	end
	
	if card == "火攻" then
	    if ID_s ~= ID_d and #char_juese[ID_d].shoupai < 1 then
	        return false
	    elseif ID_s == ID_d and #char_juese[ID_d].shoupai < 2 then
			return false
		else
			return true
		end
	end
	
	if card == "杀" or card == "火杀" or card == "雷杀" then
		--  空城状态的诸葛亮不能杀  --
		if char_juese[ID_d].skill["空城"] == "available" and #char_juese[ID_d].shoupai == 0 then
			return false
		end
	
	    if #char_juese[ID_s].wuqi ~= 0 then
		    local arm_zhuge
		
		    arm_zhuge = false
	        --  装备诸葛连弩，出杀不受限制  --
	        if char_juese[ID_s].wuqi[1] == "诸葛弩" then
	            arm_zhuge = true
	        end
			
			--  张飞出杀不受限制  --
			if char_juese[ID_s].skill["咆哮"] == "available" then
				arm_zhuge = true
			end
			
		    if (char_sha_time <= 0 and not arm_zhuge) or char_sha_able == false then
	            return false
	        end
		
	        if char_calc_distance(ID_s, ID_d) > card_wuqi_r[char_juese[ID_s].wuqi[1]] and char_distance_infinity == false then
	            return false
	        end
	    else
			arm_zhuge = false
			--  张飞出杀不受限制  --
			if char_juese[ID_s].skill["咆哮"] == "available" then
				arm_zhuge = true
			end
		
		    if (char_sha_time <= 0 and not arm_zhuge) or char_sha_able == false then return false end
	        if char_calc_distance(ID_s, ID_d) > 1 and char_distance_infinity == false then
	            return false
	        end
	    end
	end
	
	if card == "借刀杀人" and gamerun_status == "选择目标" then
		if #char_juese[ID_d].wuqi > 0 then
			return true
		else
			return false
		end
	end
	
	if card == "借刀杀人" and gamerun_status == "选择目标-B" then
		if ID_s == ID_d then
			return false
		end
		if #char_juese[ID_s].wuqi ~= 0 then
	        if char_calc_distance(ID_s, ID_d) > card_wuqi_r[char_juese[ID_s].wuqi[1]] then
	            return false
	        end
	    else
	        if char_calc_distance(ID_s, ID_d) > 1 then
	            return false
	        end
	    end
	end
	
	--  孙尚香结姻  --
	if card == "结姻" then
		if skills_judge_jieyin_2(ID_d) then
			return true
		else
			return false
		end
	end
	
	--  姜维挑衅  --
	if card == "挑衅" then
		if #char_juese[ID_d].wuqi ~= 0 then
			if char_calc_distance(ID_d, ID_s) > card_wuqi_r[char_juese[ID_d].wuqi[1]] then
				return false
			end
		else
			if char_calc_distance(ID_d, ID_s) > 1 then
				return false
			end
		end
	end

	--  荀彧驱虎  --
	if card == "驱虎2" then
		if #char_juese[ID_s].wuqi ~= 0 then
			if char_calc_distance(ID_s, ID_d) > card_wuqi_r[char_juese[ID_s].wuqi[1]] then
				return false
			end
		else
			if char_calc_distance(ID_s, ID_d) > 1 then
				return false
			end
		end
	end
	
	--  典韦强袭  --
	if card == "强袭" then
		if #char_juese[ID_s].wuqi ~= 0 then
			if char_calc_distance(ID_s, ID_d) > card_wuqi_r[char_juese[ID_s].wuqi[1]] then
				return false
			end
		else
			if char_calc_distance(ID_s, ID_d) > 1 then
				return false
			end
		end
	end
	
	--  鲁肃缔盟  --
	if card == "缔盟" and gamerun_status == "技能选择-目标B" then
		if table.getn2(card_selected) ~= math.abs(#char_juese[ID_d].shoupai - #char_juese[guankan_s].shoupai) then
			return false
		end
	end

	--  太史慈天义  --
	if card == "天义" and gamerun_status == "技能选择-目标" then
		if #char_juese[ID_d].shoupai == 0 then
			return false
		end
	end	
	return true
end

--  出牌  --
function card_chupai(ID)
    local card, wuqi
    if card_highlighted <= 0 then return false end
	if gamerun_status == "五谷丰登后" then
		gamerun_status = "手牌生效中"
		return false 
	end
	card = char_juese[char_current_i].shoupai[card_highlighted][1]
	funcptr_queue = {}
		
	--  丈八蛇矛出两张手牌  --
	if #char_juese[char_current_i].wuqi ~= 0 then
		wuqi = char_juese[char_current_i].wuqi[1]
	else
		wuqi = ""
	end
	if table.getn2(card_selected) == 2 and wuqi == "丈八矛" then
		--  取出所有选择的手牌  --
		local i, max_select
		local sel = {}
	
		max_select = #char_juese[char_current_i].shoupai
		for i = 1, max_select do
			if card_selected[i] ~= nil then
				table.insert(sel, i)
			end
		end
	
		--  执行操作  --
		if card_sha(sel, char_current_i, gamerun_target_selected, true) then
		    consent_func_queue(0.6)
		end
		return false
	end
		
    --  武器牌  --
	if card_get_leixing(card) == "武器" or card_get_leixing(card) == "防具" or card_get_leixing(card) == "+1马" or card_get_leixing(card) == "-1马" then
		card_arm(card_highlighted)
		--card_into_hand(char_current_i)
		return true
    end
		
	--  乐不思蜀  --
	if card == "乐不思蜀" then
		return card_le(card_highlighted, char_current_i, gamerun_target_selected)
    end
	
	--  兵粮寸断  --
	if card == "兵粮寸断" then
		return card_bingliang(card_highlighted, char_current_i, gamerun_target_selected)
    end
	
	--  闪电  --
	if card == "闪电" then
		return card_shandian(card_highlighted, char_current_i)
    end
	
	--  桃  --
	if card == "桃" then
	    if card_tao(card_highlighted, char_current_i, char_current_i, false) then
		    consent_func_queue(0.6)
		end
		return false
	end
	
	--  无中生有  --
	if card == "无中生有" then
	    card_wuzhong(card_highlighted, char_current_i)
		consent_func_queue(0.6)
		return false
	end
	
	--  桃园结义  --
	if card == "桃园结义" then
	    card_taoyuan(card_highlighted, char_current_i)
		consent_func_queue(0.6)
		return false
	end
	
	--  过河拆桥  --
	if card == "过河拆桥" then
		if card_chai(card_highlighted, char_current_i, gamerun_target_selected) then
		    consent_func_queue(0.6)
		end
		return false
    end
	
	--  顺手牵羊  --
	if card == "顺手牵羊" then
		if card_shun(card_highlighted, char_current_i, gamerun_target_selected) then
		    consent_func_queue(0.6)
		end
		return false
    end
	
	--  南蛮入侵  --
	if card == "南蛮入侵" then
		card_nanman(card_highlighted, char_current_i)
		consent_func_queue(0.6)
		return false
    end
	
	--  万箭齐发  --
	if card == "万箭齐发" then
		card_wanjian(card_highlighted, char_current_i)
		consent_func_queue(0.6)
		return false
    end
	
	--  五谷丰登  --
	if card == "五谷丰登" then
		card_wugu(card_highlighted, char_current_i)
		consent_func_queue(0.6)
		return false
    end
	
	--  决斗  --
	if card == "决斗" then
		card_juedou(card_highlighted, char_current_i, gamerun_target_selected)
		consent_func_queue(0.6)
		return false
    end

	--  火攻  --
	if card == "火攻" then
		if card_huogong(card_highlighted, char_current_i, gamerun_target_selected) then
		    consent_func_queue(0.6)
		end
		return false
    end
	
	--  酒  --
	if card == "酒" then
		return card_jiu(card_highlighted, char_current_i, false)
    end
	
	--  杀  --
	if card == "杀" or card == "火杀" or card == "雷杀" then
		if card_sha(card_highlighted, char_current_i, gamerun_target_selected, true) then
		    consent_func_queue(0.6)
		end
		return false
    end
	
	--  借刀杀人  --
	if card == "借刀杀人" then
		if card_jiedao(card_highlighted, char_current_i, guankan_s, gamerun_target_selected) then
			consent_func_queue(0.6)
		end
		return false
	end
	
	--  铁索连环 (连环效果)  --
	if card == "铁锁连环" then
		if card_lian_lianhuan(card_highlighted, char_current_i, guankan_s, gamerun_target_selected, ID) then
			consent_func_queue(0.6)
		end
		return false
	end
end

--  装备武器  --
function card_arm(ID_shoupai)
    local card, msg
    card = char_juese[char_current_i].shoupai[ID_shoupai]
	
	--  删除手牌  --
	card_remove({char_current_i, ID_shoupai})
	
	if card_get_leixing(card[1]) == "武器" then
	    --  如果已有装备，丢弃之  --
		if #char_juese[char_current_i].wuqi ~= 0 then
		    table.insert(card_qipai, char_juese[char_current_i].wuqi)
		end
        char_juese[char_current_i].wuqi = card
	end
	if card_get_leixing(card[1]) == "防具" then
	    if #char_juese[char_current_i].fangju ~= 0 then
		    --  失去白银狮子，回复一点体力  --
			if char_juese[char_current_i].fangju[1] == "白银狮" and char_juese[char_current_i].tili < char_juese[char_current_i].tili_max then
			    push_message(table.concat({char_juese[char_current_i].name, "失去白银狮子，回复1点体力"}))
				char_juese[char_current_i].tili = char_juese[char_current_i].tili + 1
				platform.window:invalidate()
			end
		    table.insert(card_qipai, char_juese[char_current_i].fangju)
		end
	    char_juese[char_current_i].fangju = card
	end
	if card_get_leixing(card[1]) == "+1马" then
	    if #char_juese[char_current_i].fangma ~= 0 then
		    table.insert(card_qipai, char_juese[char_current_i].fangma)
		end
	    char_juese[char_current_i].fangma = card
	end
	if card_get_leixing(card[1]) == "-1马" then
	    if #char_juese[char_current_i].gongma ~= 0 then
		    table.insert(card_qipai, char_juese[char_current_i].gongma)
		end
		char_juese[char_current_i].gongma = card
	end
	
	msg = {char_juese[char_current_i].name, "装备'", card[2], card[3], "的", card[1], "'"}
	push_message(table.concat(msg))
	msg = nil; collectgarbage()
	
	gamerun_status = ""
	jiaohu_text = "请您出牌"
end

--  八卦阵效果  --
function card_arm_bagua(ID)
    add_funcptr(push_message, table.concat({char_juese[ID].name, "发动了'八卦阵'效果"}))
	add_funcptr(_bagua_fan_panding, ID)

	--  如场上有司马懿或张角，询问其改判技能  --
	skills_guicai_guidao_ask(ID, nil, ID, "洛神")
end
function _bagua_fan_panding(ID)
	--  翻开判定牌  --
	if #card_yixi == 0 then
	    card_xipai(true)
	end
    card_panding_card = card_yixi[1]
	table.remove(card_yixi, 1)
	push_message(table.concat({char_juese[ID].name, "的判定牌是'", card_panding_card[2], card_panding_card[3], "的", card_panding_card[1], "'"}))
end
function _bagua_jiesuan(ID)
	local success = false

	if card_panding_card[2] == "红桃" or card_panding_card[2] == "方块" then
	    --  判定成功  --
		push_message(table.concat({char_juese[ID].name, "的'八卦阵'判定成功"}))
		success = true
	else
		push_message(table.concat({char_juese[ID].name, "的'八卦阵'判定失败"}))
		success = false
	end
	
	--  郭嘉天妒  --
	if char_juese[ID].skill["天妒"] ~= "available" then
		card_add_qipai(card_panding_card)
	else
		add_funcptr(push_message, char_juese[ID].name .. "发动了武将技能 '天妒'")
		add_funcptr(skills_tiandu_add, {ID, card_panding_card})
	end

	return success
end

--  使用乐不思蜀  --
function card_le(ID_shoupai, ID_s, ID_mubiao)
    local msg, card, v

	--  对方判定区内已有乐不思蜀则不可使用  --
	for _, v in ipairs(char_juese[ID_mubiao].panding) do
	    if v[1] == "乐不思蜀" then return false end
	end
	
	card = char_juese[ID_s].shoupai[ID_shoupai]
	--  大乔国色  --
	if card[1] ~= "乐不思蜀" then
		card[4] = "乐不思蜀"
		push_message(char_juese[ID_s].name.."使用了武将技能 '国色'")
	end
	
    table.insert(char_juese[ID_mubiao].panding, 1, card)
	card_remove({ID_s, ID_shoupai})
	
	if char_juese[ID_s].skill["集智"] == "available" then
		skills_jizhi(ID_s)
	end
	if char_juese[ID_mubiao].isantigovernment ~= nil then
		if char_juese[ID_mubiao].isantigovernment == false then
			if char_juese[ID_mubiao].shenfen == "主公" then
				char_juese[ID_s].antigovernment = char_juese[ID_s].antigovernment + 5
			else
				char_juese[ID_s].antigovernment = char_juese[ID_s].antigovernment + 2
			end
		else
			char_juese[ID_s].antigovernment = char_juese[ID_s].antigovernment - 3
		end
	end
	ai_judge_shenfen()
	if card[1] == "乐不思蜀" then
		msg = {char_juese[ID_s].name, "给", char_juese[ID_mubiao].name, "安装了'", card[2], card[3], "的", card[1], "'"}
	else
		msg = {char_juese[ID_s].name, "给", char_juese[ID_mubiao].name, "安装了乐不思蜀 {", card[2], card[3], "的", card[1], ")"}
	end
	push_message(table.concat(msg))
	msg = nil; collectgarbage()
	
	gamerun_status = ""
	jiaohu_text = "请您出牌"
	
	return true
end

--  使用兵粮寸断  --
function card_bingliang(ID_shoupai, ID_s, ID_mubiao)
    local msg, card, v
	
	if char_juese[ID_s].skill["断粮"] == "available" then
		--  徐晃：只能对距离 2 以内角色使用  --
		if char_calc_distance(ID_s, ID_mubiao) > 2 then
			return false
		end
	else
		--  只能对距离 1 以内角色使用  --
		if char_juese[ID_s].skill["奇才"] ~= "available" and char_calc_distance(ID_s, ID_mubiao) > 1 then
			return false
		end
	end
	
    --  对方判定区内已有兵粮寸断则不可使用  --
	for _, v in ipairs(char_juese[ID_mubiao].panding) do
	    if v[1] == "兵粮寸断" then return false end
	end
	
    card = char_juese[ID_s].shoupai[ID_shoupai]
	--  徐晃断粮  --
	if card[1] ~= "兵粮寸断" then
		card[4] = "兵粮寸断"
		push_message(char_juese[ID_s].name.."使用了武将技能 '断粮'")
	end
	
    table.insert(char_juese[ID_mubiao].panding, 1, card)
	card_remove({ID_s, ID_shoupai})
	if char_juese[ID_mubiao].isantigovernment ~= nil then
		if char_juese[ID_mubiao].isantigovernment == false then
			if char_juese[ID_mubiao].shenfen == "主公" then
				char_juese[ID_s].antigovernment = char_juese[ID_s].antigovernment + 5
			else
				char_juese[ID_s].antigovernment = char_juese[ID_s].antigovernment + 2
			end
		else
			char_juese[ID_s].antigovernment = char_juese[ID_s].antigovernment - 3
		end
	end
	ai_judge_shenfen()
	if char_juese[ID_s].skill["集智"] == "available" then
		skills_jizhi(ID_s)
	end
	
	if card[1] == "兵粮寸断" then
		msg = {char_juese[ID_s].name, "给", char_juese[ID_mubiao].name, "安装了'", card[2], card[3], "的", card[1], "'"}
	else
		msg = {char_juese[ID_s].name, "给", char_juese[ID_mubiao].name, "安装了兵粮寸断 {", card[2], card[3], "的", card[1], ")"}
	end
	push_message(table.concat(msg))
	msg = nil; collectgarbage()
	
	gamerun_status = ""
	jiaohu_text = "请您出牌"
	
	return true
end

--  使用闪电  --
function card_shandian(ID_shoupai, ID_s)
    local msg, card, v
	
	--  己方判定区内已有闪电则不可使用  --
	for _, v in ipairs(char_juese[ID_s].panding) do
	    if v[1] == "闪电" then return false end
	end
	
    card = char_juese[ID_s].shoupai[ID_shoupai]
    table.insert(char_juese[ID_s].panding, 1, card)
	card_remove({ID_s, ID_shoupai})
	
	if char_juese[ID_s].skill["集智"] == "available" then
		skills_jizhi(ID_s)
	end
	
	msg = {char_juese[ID_s].name, "安装了'", card[2], card[3], "的", card[1], "'"}
	push_message(table.concat(msg))
	msg = nil; collectgarbage()
	
	gamerun_status = ""
	jiaohu_text = "请您出牌"
	
	return true
end

--  锦囊通用子过程 (显示 "xx 使用 xx")
function _card_sub1(va_list)
    local msg, card
	local ID_s, ID_shoupai, ID_mubiao
	ID_shoupai = va_list[1]; ID_s = va_list[2]; ID_mubiao = va_list[3]
	
	--  恢复状态  --
	--on.tabKey()
	card_selected = {}
	card_highlighted = 1
	platform.window:invalidate()
	
	card = char_juese[ID_s].shoupai
	
	if ID_mubiao ~= nil then
	    msg = {char_juese[ID_s].name, "对", char_juese[ID_mubiao].name, "使用", card[ID_shoupai][1]}
    else
		if type(ID_shoupai) ~= "table" then
			msg = {char_juese[ID_s].name, "使用", card[ID_shoupai][1]}
		else
			msg = {char_juese[ID_s].name, "使用万箭齐发 (", card[ID_shoupai[1]][2], card[ID_shoupai[1]][3], "的", card[ID_shoupai[1]][1], ", ", card[ID_shoupai[2]][2], card[ID_shoupai[2]][3], "的", card[ID_shoupai[2]][1], ")"}
		end
	end
	push_message(table.concat(msg))
	msg = nil; collectgarbage()
	
	if char_juese[ID_s].skill["集智"] == "available" then
		skills_jizhi(ID_s)
	end
	
	if type(ID_shoupai) ~= "table" then
		card_shanchu({ID_s, ID_shoupai})
	else
		card_shanchu({ID_s, ID_shoupai[1]})
		if ID_shoupai[1] > ID_shoupai[2] then
			card_shanchu({ID_s, ID_shoupai[2]})
		else
			card_shanchu({ID_s, ID_shoupai[2] - 1})
		end
	end
end
function _card_sub2(va_list)    --  当技能将不同牌面的牌当作本牌使用时
    local msg
	local ID_s, ID_shoupai, ID_mubiao, nk_name
	ID_shoupai = va_list[1]; ID_s = va_list[2]; ID_mubiao = va_list[3]; nk_name = va_list[4]
	
	--  恢复状态  --
	card_selected = {}
	card_highlighted = 1
	platform.window:invalidate()
	
	local card = char_juese[ID_s].shoupai[ID_shoupai]
	if ID_mubiao ~= nil then
	    msg = {char_juese[ID_s].name, "对", char_juese[ID_mubiao].name, "使用", nk_name, " (", card[2], card[3], "的", card[1], ")"}
    else
	    msg = {char_juese[ID_s].name, "使用", nk_name, " (", card[2], card[3], "的", card[1], ")"}
	end
	push_message(table.concat(msg))
	msg = nil; collectgarbage()
	
	card_shanchu({ID_s, ID_shoupai})
end

--  使用无懈可击  --
function card_wuxie(card, ID_s, ID_mubiao, additional_func_ptr)
	add_funcptr(_wuxie_prepare, nil, nil, "无懈轮询开始")
	card_wuxie_query(card, ID_s, ID_mubiao)
end
function _wuxie_prepare()
	push_message("等待其他玩家响应")
	wuxie_in_effect = false
	wuxie_queue_jinnang = table.copy(funcptr_queue)
end
function _wuxie_prepare_2()
	push_message("等待其他玩家响应")
end
function card_wuxie_query(card, ID_s, ID_mubiao)	--  无懈可击：从锦囊作用目标开始，轮询确定各方是否出无懈可击
	id = ID_mubiao
	for i = 1, 5 do
		if char_juese[id].siwang == false then
			if id == char_current_i then
				--  轮到己方出无懈可击，插入主动响应  --
				add_funcptr(card_wuxie_zhudong, {card, ID_s, ID_mubiao})
			else
				add_funcptr(card_wuxie_ai, {id, card, ID_s, ID_mubiao})
			end
		end

		id = id + 1
		if id > 5 then id = 1 end
	end

	--  此时已经没有其他人再出无懈，进行原有锦囊的结算  --
	add_funcptr(_wuxie_exe)
end
function card_wuxie_ai(va_list)  --  无懈可击：他方无懈可击出牌判断 
	id = va_list[1]; card = va_list[2]; ID_s = va_list[3]; ID_mubiao = va_list[4]

	if char_juese[id].siwang == true then
		return
	end

	n = card_chazhao(id, "无懈可击")
	if n < 0 then
		if char_juese[id].skill["看破"] == "available" then
			n = _sha_chazhao_redblack(char_juese[id].shoupai, false)
		end
	end

	local ai_should_use_wuxie = false

	--  如果有害锦囊的作用对象是自己，则出无懈可击；此处预留AI判断是否应对应用于他人的锦囊出无懈可击  --
	--此处有bug，为方便调试暂时不对转化锦囊进行判断
	
	
	
	
	local should_use_wuxie = false
	if card == nil then
		should_use_wuxie = false
	else
		name = card[1]
		if id == ID_mubiao and (name == "决斗" or name == "过河拆桥" or name == "顺手牵羊" or name == "万箭齐发" or name == "南蛮入侵" or name == "借刀杀人" or name == "无懈可击" or name == "火攻" or name == "铁锁连环") then
			should_use_wuxie = true
		elseif ai_should_use_wuxie then
			should_use_wuxie = true
		end
	end
	
	local card_wx
	if n > 0 and should_use_wuxie then
		card_wx = char_juese[id].shoupai[n]
		if card_wx[1] ~= "无懈可击" then
			push_message(char_juese[id].name.."使用了武将技能 '看破'")
			msg = {char_juese[id].name, "使用了无懈可击 (", card_wx[2], card_wx[3], "的", card_wx[1], ")"}
		else
			msg = {char_juese[id].name, "使用了'", card_wx[2], card_wx[3], "的", card_wx[1], "'"}
		end
		push_message(table.concat(msg))
		card_shanchu({id, n})
		wuxie_in_effect = not wuxie_in_effect

		--  出无懈可击后，原有轮询已失效；从原锦囊的发出对象（无懈可击的作用对象）本身开始重新轮询  --
		timer.stop()
		funcptr_queue = {}

		add_funcptr(_wuxie_prepare_2)
		card_wuxie_query(card_wx, id, ID_s)
		funcptr_i = 0
		timer.start(0.6)
	else
		msg = {char_juese[id].name, "放弃无懈"}
		push_message(table.concat(msg))
	end
end
function card_wuxie_zhudong(va_list)	--  无懈可击：轮到己方出无懈可击时，状态转换至主动出牌
	card = va_list[1]; ID_s = va_list[2]; ID_mubiao = va_list[3]

	wuxie_queue_xiangying = table.copy(funcptr_queue)
	wuxie_queue_xiangying_i = funcptr_i + 1
	wuxie_va = {ID_s, ID_mubiao}
	timer.stop()
	funcptr_queue = {}

	gamerun_status = "主动出牌-无懈可击"
	--此处有bug，为方便调试暂时不对转化锦囊进行判断
	
	
	if card == nil then
		msg = {"是否无懈"}
	else
		msg = {card[1], "是否无懈"}
	end
	set_hints(table.concat(msg))
	msg = nil; collectgarbage()
end
function _wuxie_zhudong_chu(card, i, va_list)	--  无懈可击：己方选择出无懈可击
	ID_s = va_list[1]; ID_mubiao = va_list[2]
	
	gamerun_status = "手牌生效中"
	msg = {char_juese[char_current_i].name, "使用了'", card[2], card[3], "的", card[1], "'"}
	push_message(table.concat(msg))
	card_add_qipai(card)
	card_remove({char_current_i, i})
	wuxie_in_effect = not wuxie_in_effect

	--  出无懈可击后，原有轮询已失效；从原锦囊的发出对象（无懈可击的作用对象）本身开始重新轮询  --
	timer.stop()
	funcptr_queue = {}
	
	add_funcptr(_wuxie_prepare_2)
	card_wuxie_query(card, char_current_i, ID_s)
	funcptr_i = 0
	timer.start(0.6)
end
function _wuxie_zhudong_fangqi()	--  无懈可击：己方放弃出无懈可击
	gamerun_status = "手牌生效中"
	jiaohu_text = ""
	msg = {char_juese[char_current_i].name, "放弃无懈"}
	push_message(table.concat(msg))

	--  恢复原有的函数队列，继续原有轮询  --
	funcptr_queue = wuxie_queue_xiangying
	funcptr_i = wuxie_queue_xiangying_i
	timer.start(0.6)

	msg = nil; collectgarbage()
end
function _wuxie_exe()
	timer.stop()
	funcptr_queue = {}

	local items_to_remove = {}
	local current_query = true
	for i = 1, #wuxie_queue_jinnang do
		if wuxie_queue_jinnang[i].tag == "无懈轮询开始" then
			--  第一次轮询需要删除  --
			if current_query then
				current_query = false
			else
				break
			end
		end

		if wuxie_queue_jinnang[i].tag == "无懈执行完毕" or wuxie_queue_jinnang[i].tag == "无懈执行前" and current_query == false then
			break
		end

		if wuxie_in_effect then
			--  无懈可击有效，保留标记为有效结算的函数，以及下一次轮询之后的函数  --
			if wuxie_queue_jinnang[i].tag ~= nil then
				if string.find(wuxie_queue_jinnang[i].tag, "无懈有效结算") == nil or current_query == true then
					table.insert(items_to_remove, i)
				end
			else
				table.insert(items_to_remove, i)
			end
		else
			--  无懈可击无效，保留标记为无效结算的函数，以及下一次轮询之后的函数  --
			if wuxie_queue_jinnang[i].tag ~= nil then
				if string.find(wuxie_queue_jinnang[i].tag, "无懈无效结算") == nil or current_query == true then
					table.insert(items_to_remove, i)
				end
			else
				table.insert(items_to_remove, i)
			end
		end
	end

	for i = #items_to_remove, 1, -1 do
		table.remove(wuxie_queue_jinnang, items_to_remove[i])
	end

	funcptr_queue = table.copy(wuxie_queue_jinnang)
	funcptr_i = 0
	timer.start(0.6)
end

--  使用桃  --
function card_tao(ID_shoupai, ID_s, ID_mubiao, binsi, p)
	if char_juese[ID_mubiao].tili == char_juese[ID_mubiao].tili_max and binsi == false then
	    return false
	end
	if binsi == false then
		gamerun_status = "手牌生效中"
	end
	
	local card = char_juese[ID_s].shoupai[ID_shoupai]
	
	if p == nil then
		add_funcptr(_tao_show, {ID_shoupai, ID_s, ID_mubiao})
		add_funcptr(_tao_sub, {ID_mubiao, binsi})
		return true
	else
		if card[1] ~= "桃" then
			add_funcptr(push_message, char_juese[ID_s].name.."发动了武将技能 '青囊'")
		end
		add_funcptr(_tao_show, {ID_shoupai, ID_s, ID_mubiao}, p)
		add_funcptr(_tao_sub, {ID_mubiao, binsi}, p + 1)
		if binsi == false then return true end
		return p + 1
	end
	
end
function _tao_sub(va_list)
	local ID_mubiao, binsi
    local msg
	
	ID_mubiao = va_list[1]; binsi = va_list[2]
	char_juese[ID_mubiao].tili = char_juese[ID_mubiao].tili + 1
	msg = {char_juese[ID_mubiao].name, "回复1点体力"}
	push_message(table.concat(msg))
	msg = nil; collectgarbage()
	
	if binsi == false then
		gamerun_status = ""
		set_hints("请您出牌")
	end
end
function _tao_show(va_list)
    local msg
	local ID_s, ID_shoupai, ID_mubiao
	ID_shoupai = va_list[1]; ID_s = va_list[2]; ID_mubiao = va_list[3]
	
	--  恢复状态  --
	--on.tabKey()
	card_selected = {}
	card_highlighted = 1
	platform.window:invalidate()
	
	local card = char_juese[ID_s].shoupai[ID_shoupai]
	
	if ID_mubiao ~= nil then
	    msg = {char_juese[ID_s].name, "对", char_juese[ID_mubiao].name, "使用", char_juese[ID_s].shoupai[ID_shoupai][1]}
    else
		if card[1] ~= "桃" then
			msg = {char_juese[ID_s].name, "使用", card[1]}
		else
			msg = {char_juese[ID_s].name, "使用桃 (", card[2], card[3], "的", card[1], ")"}
		end
	end
	push_message(table.concat(msg))
	msg = nil; collectgarbage()
	
	card_shanchu({ID_s, ID_shoupai})
end

--  使用无中生有  --
function card_wuzhong(ID_shoupai, ID_s)
	gamerun_status = "手牌生效中"
	local card = char_juese[ID_s].shoupai[ID_shoupai]

	add_funcptr(_card_sub1, {ID_shoupai, ID_s})
	card_wuxie(card, ID_s, ID_s, nil)

	funcptr_add_tag = "无懈无效结算"
	add_funcptr(_wuzhong_sub1, ID_s)
	funcptr_add_tag = "无懈执行完毕"
	add_funcptr(_wuzhong_sub2, ID_s)
	funcptr_add_tag = nil
end
function _wuzhong_sub1(ID_s)
	card_fenfa({ID_s, 2, true})
end
function _wuzhong_sub2(ID_s)
	gamerun_status = ""
    set_hints("请您出牌")
end

--  使用铁索连环 (重铸效果)  --
function card_lian_chongzhu(ID_shoupai, ID_s)
    local msg, card
	card = char_juese[ID_s].shoupai[ID_shoupai]
	
	card_add_qipai(card)
	card_remove({ID_s, ID_shoupai})
	
	card_fenfa({ID_s, 1, false})
	
	if card[1] == "铁锁连环" then
		msg = {char_juese[ID_s].name, "重铸'", card[2], card[3], "的铁索连环"}
		push_message(table.concat(msg))
	else
		push_message(char_juese[ID_s].name.."发动了武将技能 '连环'")
		msg = {char_juese[ID_s].name, "重铸铁索连环 (", card[2], card[3], "的", card[1], ")"}
		push_message(table.concat(msg))
	end
	msg = nil; collectgarbage()
	
	set_hints("请您出牌")
	gamerun_status = ""
end
--  使用铁索连环 (连环效果)  --
function card_lian_lianhuan(ID_shoupai, ID_s, ID_first, ID_second, doubl)
	gamerun_status = "手牌生效中"
	local card = char_juese[ID_s].shoupai[ID_shoupai]

	if char_juese[ID_s].shoupai[ID_shoupai][1] == "铁锁连环" then
		add_funcptr(_card_sub1, {ID_shoupai, ID_s})
	else
		add_funcptr(_card_sub2, {ID_shoupai, ID_s, nil, "铁锁连环"})
	end
	
	if char_juese[ID_first].isantigovernment ~= nil and ID_s ~= ID_first then
		if char_juese[ID_first].isantigovernment == char_juese[ID_first].hengzhi then
			if char_juese[ID_first].shenfen == "主公" then
				char_juese[ID_s].antigovernment = char_juese[ID_s].antigovernment + 2
			else
				char_juese[ID_s].antigovernment = char_juese[ID_s].antigovernment + 1
			end
		else
			char_juese[ID_s].antigovernment = char_juese[ID_s].antigovernment - 1
		end
	end
	if char_juese[ID_second].isantigovernment ~= nil and ID_s ~= ID_second then
		if char_juese[ID_second].isantigovernment == char_juese[ID_second].hengzhi then
			if char_juese[ID_second].shenfen == "主公" then
				char_juese[ID_s].antigovernment = char_juese[ID_s].antigovernment + 2
			else
				char_juese[ID_s].antigovernment = char_juese[ID_s].antigovernment + 1
			end
		else
			char_juese[ID_s].antigovernment = char_juese[ID_s].antigovernment - 1
		end
	end
	ai_judge_shenfen()
	
	if doubl == false then
		_lian_sub1(ID_s, ID_first)
	else
		if ID_first > ID_second then
			_lian_sub1(card, ID_s, ID_second)
			_lian_sub1(card, ID_s, ID_first)
		else
			_lian_sub1(card, ID_s, ID_first)
			_lian_sub1(card, ID_s, ID_second)
		end
	end
	
	funcptr_add_tag = "无懈执行完毕"
	add_funcptr(_lian_sub3)
	funcptr_add_tag = nil

	return true
end
function _lian_sub1(card, ID_s, ID_mubiao)
	card_wuxie(card, ID_s, ID_mubiao, nil)
	
	funcptr_add_tag = "无懈无效结算"
	if char_juese[ID_mubiao].hengzhi == false then
		add_funcptr(_lian_sub2, {ID_s, ID_mubiao, true})
	else
		add_funcptr(_lian_sub2, {ID_s, ID_mubiao, false})
	end
	funcptr_add_tag = nil
end
function _lian_sub2(va_list)
	local ID_s, ID_mubiao, stat
	ID_s = va_list[1]; ID_mubiao = va_list[2]; stat = va_list[3]

	if stat then
		_nanman_send_msg({char_juese[ID_s].name, "横置", char_juese[ID_mubiao].name, "的武将牌"})
	else
		_nanman_send_msg({char_juese[ID_s].name, "解除", char_juese[ID_mubiao].name, "的横置状态"})
	end
	
	char_juese[ID_mubiao].hengzhi = stat
end
function _lian_sub3()
    gamerun_status = ""
	set_hints("请您出牌")
end

--  使用桃园结义  --
function card_taoyuan(ID_shoupai, ID_s)
    local i, id
	
    gamerun_status = "手牌生效中"
	local card = char_juese[ID_s].shoupai[ID_shoupai]
	add_funcptr(_card_sub1, {ID_shoupai, ID_s})
	
	id = ID_s
	for i = 1, 5 do
		if char_juese[id].siwang == false then
			if char_juese[id].tili < char_juese[id].tili_max then
				funcptr_add_tag = "无懈执行前"
    			add_funcptr(_nanman_send_msg, {char_juese[ID_s].name, "对", char_juese[id].name, "使用了桃园结义"})
				funcptr_add_tag = nil

				card_wuxie(card, ID_s, id, nil)

				funcptr_add_tag = "无懈无效结算"
				add_funcptr(_taoyuan_sub1, id)
				funcptr_add_tag = nil
			end
		end
	    id = id + 1
		if id > 5 then id = 1 end
	end
	
	funcptr_add_tag = "无懈执行完毕"
	add_funcptr(_taoyuan_sub2)
	funcptr_add_tag = nil
end
function _taoyuan_sub1(ID_mubiao)
    local msg
	char_juese[ID_mubiao].tili = char_juese[ID_mubiao].tili + 1
	msg = {char_juese[ID_mubiao].name, "回复1点体力"}
	push_message(table.concat(msg))
	msg = nil; collectgarbage()
end
function _taoyuan_sub2()
    gamerun_status = ""
	set_hints("请您出牌")
end

--  使用过河拆桥  --
function card_chai(ID_shoupai, ID_s, ID_mubiao)
    --  只能对有牌角色使用  --
	local p
	p = char_juese[ID_mubiao]
	local card = char_juese[ID_s].shoupai[ID_shoupai]
	
	if p.skill["谦逊"] == "available" then
		return false
	end
	
	if #p.shoupai < 1 and #p.fangju == 0 and #p.wuqi == 0 and #p.gongma == 0 and #p.fangma == 0 and #p.panding == 0 then
	    return false
	end

    gamerun_status = "手牌生效中"
	
	--  甘宁奇袭  --
	if char_juese[ID_s].shoupai[ID_shoupai][1] ~= "过河拆桥" then
		add_funcptr(push_message, char_juese[ID_s].name .. "发动了武将技能 '奇袭'")
		add_funcptr(_card_sub2, {ID_shoupai, ID_s, ID_mubiao, "过河拆桥"})
		add_funcptr(gamerun_wuqi_out_hand, char_current_i)
	else
		add_funcptr(_card_sub1, {ID_shoupai, ID_s, ID_mubiao})
	end
	
	card_wuxie(card, ID_s, ID_mubiao, nil)

	funcptr_add_tag = "无懈无效结算"
	if ID_s == char_current_i then
		add_funcptr(_chai_sub1, {true, ID_s, ID_mubiao})
	else
		add_funcptr(_chai_ai, {ID_s, ID_mubiao})
		add_funcptr(_chai_sub2)
	end
	funcptr_add_tag = "无懈有效结算"
	add_funcptr(_chai_sub2)
	funcptr_add_tag = nil
	
	return true
end
function _chai_ai(va_list)		--  过河拆桥：AI拆牌 (临时AI)
	local ID_s, ID_d
	ID_s = va_list[1]; ID_d = va_list[2]

	if #char_juese[ID_d].shoupai > 0 then
		local id, card
		id = math.random(#char_juese[ID_d].shoupai)

		card = char_juese[ID_d].shoupai[id]
		card_add_qipai(card)
		card_remove({ID_d, id})
			
		msg = {char_juese[ID_s].name, "弃掉", char_juese[ID_d].name, "的'", card[2], card[3], "的", card[1], "'"}
		push_message(table.concat(msg))
		msg = nil; card = nil; collectgarbage()
	end
end
function _chai_sub1(va_list)    --  过河拆桥/顺手牵羊初始化 (寒冰剑效果共用)
    local i
	local leixing, ID_s, ID_d
	leixing = va_list[1]; ID_s = va_list[2]; ID_d = va_list[3]
	
	if char_juese[ID_d].isantigovernment ~= nil then
		if char_juese[ID_d].isantigovernment == false then
			if char_juese[ID_d].shenfen == "主公" then
				char_juese[ID_s].antigovernment = char_juese[ID_s].antigovernment + 3
			else
				char_juese[ID_s].antigovernment = char_juese[ID_s].antigovernment + 2
			end
		else
			char_juese[ID_s].antigovernment = char_juese[ID_s].antigovernment - 2
		end
	end
	ai_judge_shenfen()
	
	if leixing then
	    gamerun_status = "观看手牌-拆"
	else
	    gamerun_status = "观看手牌-顺"
	end
	
	gamerun_guankan_type = {}
	
	--  往观看牌堆添加牌  --
	if #char_juese[ID_d].shoupai > 0 then
	    table.insert(gamerun_guankan_type, {"手牌", 0})
	end
	if #char_juese[ID_d].fangma > 0 then
	    table.insert(gamerun_guankan_type, {"防御马", 0})
	end
	if #char_juese[ID_d].gongma > 0 then
	    table.insert(gamerun_guankan_type, {"攻击马", 0})
	end
	if #char_juese[ID_d].wuqi > 0 then
	    table.insert(gamerun_guankan_type, {"武器", 0})
	end
	if #char_juese[ID_d].fangju > 0 then
	    table.insert(gamerun_guankan_type, {"防具", 0})
	end
	for i = 1, #char_juese[ID_d].panding do
	    table.insert(gamerun_guankan_type, {"判定牌", i})
	end
	
	--  设置状态信息  --
	gamerun_guankan_selected = 1
	guankan_s = ID_s
	guankan_d = ID_d
	
	txt_messages:setVisible(false)
	platform.window:invalidate()
end
function _chai_sub2()
    txt_messages:setVisible(true)
    gamerun_status = ""
    set_hints("请您出牌")
	lianhuan_va = nil
end

--  使用顺手牵羊  --
function card_shun(ID_shoupai, ID_s, ID_mubiao)
    --  只能对距离 1 以内、有牌角色使用  --
	local p
	p = char_juese[ID_mubiao]
	local card = char_juese[ID_s].shoupai[ID_shoupai]
	
	if p.skill["谦逊"] == "available" then
		return false
	end
	
	if (char_juese[ID_s].skill["奇才"] ~= "available" and char_calc_distance(ID_s, ID_mubiao) > 1) or #p.shoupai < 1 and #p.fangju == 0 and #p.wuqi == 0 and #p.gongma == 0 and #p.fangma == 0 and #p.panding == 0 then
	    return false
	end

    gamerun_status = "手牌生效中"
    add_funcptr(_card_sub1, {ID_shoupai, ID_s, ID_mubiao})

	card_wuxie(card, ID_s, ID_mubiao, nil)

	funcptr_add_tag = "无懈无效结算"
	if ID_s == char_current_i then
		add_funcptr(_chai_sub1, {false, ID_s, ID_mubiao})
	else
		add_funcptr(_shun_ai, {ID_s, ID_mubiao})
		add_funcptr(_chai_sub2)
	end
	funcptr_add_tag = "无懈有效结算"
	add_funcptr(_chai_sub2)
	funcptr_add_tag = nil

	return true
end
function _shun_ai(va_list)		--  顺手牵羊：AI顺牌 (临时AI)
	local ID_s, ID_d
	ID_s = va_list[1]; ID_d = va_list[2]

	if #char_juese[ID_d].shoupai > 0 then
		local id
		id = math.random(#char_juese[ID_d].shoupai)

		table.insert(char_juese[ID_s].shoupai, char_juese[ID_d].shoupai[id])
		card_remove({ID_d, id})
			
		msg = {char_juese[ID_s].name, "获得", char_juese[ID_d].name, "的一张牌"}
		push_message(table.concat(msg))
		msg = nil; collectgarbage()
	end
end
function _shun_sub2()
    txt_messages:setVisible(true)
    gamerun_status = ""
	set_hints("请您出牌")
end

--  执行过河拆桥/顺手牵羊动作  --
function card_chai_shun_exe(leixing, ID_selected, ID_s, ID_d)
    local id, msg, card

    if gamerun_guankan_type[ID_selected][1] == "手牌" then
		--  随机抽出一张牌  --
		math.randomseed(timer.getMilliSecCounter())
		id = math.random(#char_juese[ID_d].shoupai)
		
		if leixing then    -- 拆
		    card = char_juese[ID_d].shoupai[id]
		    card_add_qipai(card)
			card_remove({ID_d, id})
			
			msg = {char_juese[ID_s].name, "弃掉", char_juese[ID_d].name, "的'", card[2], card[3], "的", card[1], "'"}
			push_message(table.concat(msg))
			msg = nil; card = nil; collectgarbage()
		else    -- 顺
		    table.insert(char_juese[ID_s].shoupai, char_juese[ID_d].shoupai[id])
			card_remove({ID_d, id})
			--card_shanchu({ID_d, id})
			
			msg = {char_juese[ID_s].name, "获得", char_juese[ID_d].name, "的一张牌"}
			push_message(table.concat(msg))
			msg = nil; collectgarbage()
		end
	end
	if gamerun_guankan_type[ID_selected][1] == "防御马" then
	    if leixing then    -- 拆
		    card = char_juese[ID_d].fangma
		    card_add_qipai(card)
	        char_juese[ID_d].fangma = {}
			
			msg = {char_juese[ID_s].name, "弃掉", char_juese[ID_d].name, "的马'", card[2], card[3], "的", card[1], "'"}
			push_message(table.concat(msg))
			msg = nil; card = nil; collectgarbage()
		else    -- 顺
		    card = char_juese[ID_d].fangma
		    table.insert(char_juese[ID_s].shoupai, card)
			char_juese[ID_d].fangma = {}
			
			msg = {char_juese[ID_s].name, "获得", char_juese[ID_d].name, "的马'", card[2], card[3], "的", card[1], "'"}
			push_message(table.concat(msg))
			msg = nil; card = nil; collectgarbage()
		end
	end
	if gamerun_guankan_type[ID_selected][1] == "攻击马" then
	    if leixing then    -- 拆
		    card = char_juese[ID_d].gongma
		    card_add_qipai(card)
	        char_juese[ID_d].gongma = {}
			
			msg = {char_juese[ID_s].name, "弃掉", char_juese[ID_d].name, "的马'", card[2], card[3], "的", card[1], "'"}
			push_message(table.concat(msg))
			msg = nil; card = nil; collectgarbage()
		else    -- 顺
		    card = char_juese[ID_d].gongma
		    table.insert(char_juese[ID_s].shoupai, card)
			char_juese[ID_d].gongma = {}
			
			msg = {char_juese[ID_s].name, "获得", char_juese[ID_d].name, "的马'", card[2], card[3], "的", card[1], "'"}
			push_message(table.concat(msg))
			msg = nil; card = nil; collectgarbage()
		end
	end
	if gamerun_guankan_type[ID_selected][1] == "武器" then
	    if leixing then    -- 拆
		    card = char_juese[ID_d].wuqi
		    card_add_qipai(card)
	        char_juese[ID_d].wuqi = {}
			
			msg = {char_juese[ID_s].name, "弃掉", char_juese[ID_d].name, "的武器'", card[2], card[3], "的", card[1], "'"}
			push_message(table.concat(msg))
			msg = nil; card = nil; collectgarbage()
		else    -- 顺
		    card = char_juese[ID_d].wuqi
		    table.insert(char_juese[ID_s].shoupai, card)
			char_juese[ID_d].wuqi = {}
			
			msg = {char_juese[ID_s].name, "获得", char_juese[ID_d].name, "的武器'", card[2], card[3], "的", card[1], "'"}
			push_message(table.concat(msg))
			msg = nil; card = nil; collectgarbage()
		end
	end
	if gamerun_guankan_type[ID_selected][1] == "防具" then
	    if leixing then    -- 拆
		    card = char_juese[ID_d].fangju
			
		    card_add_qipai(card)
	        char_juese[ID_d].fangju = {}
			
			msg = {char_juese[ID_s].name, "弃掉", char_juese[ID_d].name, "的防具'", card[2], card[3], "的", card[1], "'"}
			push_message(table.concat(msg))
			msg = nil; collectgarbage()
		else    -- 顺
		    card = char_juese[ID_d].fangju
		    table.insert(char_juese[ID_s].shoupai, card)
			char_juese[ID_d].fangju = {}
			
			msg = {char_juese[ID_s].name, "获得", char_juese[ID_d].name, "的防具'", card[2], card[3], "的", card[1], "'"}
			push_message(table.concat(msg))
			msg = nil; collectgarbage()
		end
		
		--  失去白银狮子，回复一点体力  --
		if card[1] == "白银狮" and char_juese[ID_d].tili < char_juese[ID_d].tili_max then
			push_message(table.concat({char_juese[ID_d].name, "失去白银狮子，回复1点体力"}))
			char_juese[ID_d].tili = char_juese[ID_d].tili + 1
			platform.window:invalidate()
		end
	end
	if gamerun_guankan_type[ID_selected][1] == "判定牌" then
	    if leixing then    -- 拆
		    card = char_juese[ID_d].panding[gamerun_guankan_type[ID_selected][2]]
		    card_add_qipai(card)
	        table.remove(char_juese[ID_d].panding, gamerun_guankan_type[ID_selected][2])
			
			msg = {char_juese[ID_s].name, "弃掉", char_juese[ID_d].name, "的判定牌'", card[2], card[3], "的", card[1], "'"}
			push_message(table.concat(msg))
			msg = nil; card = nil; collectgarbage()
		else    -- 顺
		    card = char_juese[ID_d].panding[gamerun_guankan_type[ID_selected][2]]
		    table.insert(char_juese[ID_s].shoupai, card)
			table.remove(char_juese[ID_d].panding, gamerun_guankan_type[ID_selected][2])
			
			msg = {char_juese[ID_s].name, "获得", char_juese[ID_d].name, "的判定牌'", card[2], card[3], "的", card[1], "'"}
			push_message(table.concat(msg))
			msg = nil; card = nil; collectgarbage()
		end
	end
end

--  使用南蛮入侵  --
function card_nanman(ID_shoupai, _ID_s)
    local i, id, ID_s
	local source_card = char_juese[_ID_s].shoupai[ID_shoupai]
	
	ID_s = _ID_s
    gamerun_status = "手牌生效中"
	jiaohu_text = ""
	add_funcptr(_card_sub1, {ID_shoupai, ID_s, nil})
	
	--  场上若有孟获，则改动伤害来源为孟获  --
	for i = 1, 5 do
		if char_juese[i].siwang == false and char_juese[i].skill["祸首"] == "available" then
			ID_s = i
			skills_huoshou(ID_s)
			break
		end
	end
	
	id = ID_s + 1
	if id > 5 then id = 1 end
	
	for i = 1, 4 do
		if char_juese[id].siwang == false and char_juese[id].skill["祸首"] ~= "available" and id ~= _ID_s then
			funcptr_add_tag = "无懈执行前"
    		add_funcptr(_nanman_send_msg, {char_juese[ID_s].name, "对", char_juese[id].name, "使用了南蛮入侵"})
			funcptr_add_tag = nil

			card_wuxie(source_card, ID_s, id, nil)

			if id ~= char_current_i then
				_nanman_AI(source_card, ID_s, id)
			else
				_nanman_zhudong(source_card, ID_s)
			end
		end
	    id = id + 1
		if id > 5 then id = 1 end
	end
	
	funcptr_add_tag = "无懈执行完毕"
	add_funcptr(_nanman_sub1)
	funcptr_add_tag = nil
end
function _nanman_judge_mian(ID_mubiao)	--  南蛮入侵：判断是否可以免除出杀
	--  若装备藤甲，免过  --
	card = char_juese[ID_mubiao].fangju
	if #card ~= 0 then
	    if card[1] == "藤甲" then
	        add_funcptr(_nanman_send_msg, {char_juese[ID_mubiao].name, "装备藤甲，不用出杀"})
		    return true
	    end
	end

	return false
end
function _nanman_AI(source_card, ID_s, ID_mubiao)    --  南蛮入侵：响应AI (临时)
    local c_pos, card, card_origin
	
	funcptr_add_tag = "无懈无效结算"
	
    if _nanman_judge_mian(ID_mubiao) == true then
		funcptr_add_tag = nil
		return
	end
	
	--  自动出杀  --
	c_pos = ai_chazhao_sha(ID_mubiao, char_juese[ID_mubiao].shoupai)
	if c_pos > -1 then
		card_origin = char_juese[ID_mubiao].shoupai[c_pos]
	    add_funcptr(_nanman_sha, {ID_mubiao, c_pos})
		
		--  孙策使用红色杀，摸一张牌  --
		if char_juese[ID_mubiao].skill["激昂"] == "available" and (card_origin[2] == "红桃" or card_origin[2] == "方块") then
			skills_jiang(ID_mubiao)
		end
	else
	    add_funcptr(_nanman_send_msg, {char_juese[ID_mubiao].name, "放弃"})
		char_tili_deduct({1, ID_mubiao, ID_s, "普通", ID_mubiao, nil, true})
	end

	funcptr_add_tag = nil
end
function _nanman_zhudong(source_card, ID_s)		--  南蛮入侵：己方主动出牌
	funcptr_add_tag = "无懈无效结算"
	
	if _nanman_judge_mian(char_current_i) == true then
		funcptr_add_tag = nil
		return
	end

	add_funcptr(_nanman_zhudong_enter, ID_s)
	funcptr_add_tag = nil
end
function _nanman_zhudong_enter(ID_s)	--  南蛮入侵：进入己方主动出牌状态
	zhudong_queue = table.copy(funcptr_queue)
	zhudong_queue_i = funcptr_i
	wuxie_va = ID_s
	timer.stop()
	funcptr_queue = {}

	gamerun_status = "主动出牌-南蛮"
	set_hints("请您出杀或'取消'放弃")
	platform.window:invalidate()
end
function _nanman_zhudong_chu(ID_s)	--  南蛮入侵：己方出杀
	c_pos = card_highlighted

	gamerun_status = "手牌生效中"
	set_hints("")
	card_selected = {}
	card_highlighted = 1

	card_origin = char_juese[char_current_i].shoupai[c_pos]
	if card_origin[1] ~= "杀" and card_origin[1] ~= "火杀" and card_origin[1] ~= "雷杀" then
		if char_juese[char_current_i].skill["武圣"] == "available" then
			add_funcptr(push_message, table.concat({char_juese[char_current_i].name, "发动了武将技能 '武圣'"}))
		elseif char_juese[char_current_i].skill["龙胆"] == "available" then
			add_funcptr(push_message, table.concat({char_juese[char_current_i].name, "发动了武将技能 '龙胆'"}))
		end
	end
	add_funcptr(_nanman_sha, {char_current_i, c_pos})
		
	--  孙策使用红色杀，摸一张牌  --
	if char_juese[char_current_i].skill["激昂"] == "available" and (card_origin[2] == "红桃" or card_origin[2] == "方块") then
		skills_jiang(char_current_i)
	end

	add_funcptr(_nanman_zhudong_huifu)
end
function _nanman_zhudong_fangqi(ID_s)	--  南蛮入侵：己方放弃
	gamerun_status = "手牌生效中"
	set_hints("")

	add_funcptr(_nanman_send_msg, {char_juese[char_current_i].name, "放弃"})
	char_tili_deduct({1, char_current_i, ID_s, "普通", char_current_i, nil, true})
	add_funcptr(_nanman_zhudong_huifu)
end
function _nanman_zhudong_huifu()	--  南蛮入侵：恢复己方中断前函数队列
	funcptr_queue = zhudong_queue
	funcptr_i = zhudong_queue_i
	--timer.start(0.6)
end
function _nanman_send_msg(msg)    --  南蛮入侵：发送游戏状态信息
	push_message(table.concat(msg))
end
function _nanman_sha(va_list)    --  南蛮入侵：实际出杀
    local ID_mubiao, c_pos, msg, card
	ID_mubiao = va_list[1]; c_pos = va_list[2]
	
	card = char_juese[ID_mubiao].shoupai[c_pos]
	card_add_qipai(card)
	card_remove({ID_mubiao, c_pos})

	if ID_mubiao == char_current_i then
		card_selected = {}
		card_highlighted = 1
	end
	
	msg = {char_juese[ID_mubiao].name, "使用'", card[2], card[3], "的", card[1], "'"}
	push_message(table.concat(msg))
	msg = nil; collectgarbage()
end
function _nanman_sub1()
    gamerun_status = ""
	jiaohu_text = "请您出牌"
	platform.window:invalidate()
end

--  使用万箭齐发  --
function card_wanjian(ID_shoupai, ID_s)
    local i, id
	local source_card = char_juese[ID_s].shoupai[ID_shoupai]
	
    gamerun_status = "手牌生效中"
	jiaohu_text = ""
	
	if type(ID_shoupai) == "table" then
		msg = table.concat({char_juese[ID_s].name, "发动了武将技能 '乱击'"})
		add_funcptr(push_message, msg)
	end
	add_funcptr(_card_sub1, {ID_shoupai, ID_s, nil})
	
	id = ID_s + 1
	if id > 5 then id = 1 end
	for i = 1, 4 do
	    if char_juese[id].siwang == false then
			funcptr_add_tag = "无懈执行前"
    		add_funcptr(_nanman_send_msg, {char_juese[ID_s].name, "对", char_juese[id].name, "使用了万箭齐发"})
			funcptr_add_tag = nil

			card_wuxie(source_card, ID_s, id, nil)

			funcptr_add_tag = "无懈无效结算"
			add_funcptr(_wanjian_exe, {source_card, ID_s, id})
			funcptr_add_tag = nil
	    end
		id = id + 1
		if id > 5 then id = 1 end
	end
	
	funcptr_add_tag = "无懈执行完毕"
	add_funcptr(_nanman_sub1, nil)
	funcptr_add_tag = nil

	return true
end
function _wanjian_judge_mian(ID)	--  万箭齐发：判断是否可以不用出闪
	local card = char_juese[ID].fangju
	if #card ~= 0 then
	    if card[1] == "藤甲" then
	        _nanman_send_msg({char_juese[ID].name, "装备藤甲，不用出闪"})
			return true
	    end
	end
	return false
end
function _wanjian_exe(va_list)
	local source_card, ID_s, ID_mubiao
	source_card = va_list[1]; ID_s = va_list[2]; ID_mubiao = va_list[3]

	if _wanjian_judge_mian(ID_mubiao) == true then
		return
	end

	push_zhudong_queue(table.copy(funcptr_queue), funcptr_i)
	timer.stop()
	funcptr_queue = {}
	funcptr_i = 0

	local card = table.copy(char_juese[ID_mubiao].fangju)
	if char_juese[ID_mubiao].skill["八阵"] == "available" and #card == 0 then
		card[1] = "八卦阵"
	end

	if #card ~= 0 then
		if card[1] == "八卦阵" then
			if char_juese[ID_mubiao].skill["八阵"] == "available" then
				add_funcptr(push_message, table.concat({char_juese[ID_mubiao].name, "发动了武将技能 '八阵'"}))
			end
			card_arm_bagua(ID_mubiao)
		end
	end
	
	add_funcptr(_wanjian_jiesuan, {source_card, ID_s, ID_mubiao, card})
	timer.start(0.6)
end
function _wanjian_jiesuan(va_list)
	local source_card, ID_s, ID_mubiao, fangju_card
	source_card = va_list[1]; ID_s = va_list[2]; ID_mubiao = va_list[3]; fangju_card = va_list[4]

	timer.stop()
	funcptr_queue = {}
	funcptr_i = 0

	local yanshi = false

	if #fangju_card ~= 0 then
		if fangju_card[1] == "八卦阵" then
			if _bagua_jiesuan(ID_mubiao) then
				--  张角雷击  --
				if char_juese[ID_mubiao].skill["雷击"] == "available" then
					add_funcptr(skills_leiji, {ID_mubiao, ID_s})
				end

				add_funcptr(_wanjian_huifu)
				timer.start(0.6)
				return
			else
				yanshi = true
			end
		end
	end

	if ID_mubiao ~= char_current_i then
		--  自动出闪  --
		local c_pos = ai_chazhao_shan(ID_mubiao, char_juese[ID_mubiao].shoupai)
		if c_pos > -1 then
			if yanshi then
				add_funcptr(_wanjian_shan, {ID_mubiao, c_pos})
			else
	    		_wanjian_shan({ID_mubiao, c_pos})
			end
		else
			if yanshi then
				add_funcptr(_nanman_send_msg, {char_juese[ID_mubiao].name, "放弃"})
			else
	    		_nanman_send_msg({char_juese[ID_mubiao].name, "放弃"})
			end
			char_tili_deduct({1, ID_mubiao, ID_s, "普通", ID_mubiao, nil, true})
		end
		add_funcptr(_wanjian_huifu)
	else
		add_funcptr(_wanjian_zhudong_enter, ID_s)
	end
	timer.start(0.6)
end
function _wanjian_shan(va_list)
	local ID_mubiao, c_pos
	ID_mubiao = va_list[1]; c_pos = va_list[2]

	if char_juese[ID_mubiao].shoupai[c_pos][1] ~= "闪" then
		if char_juese[ID_mubiao].skill["倾国"] == "available" then
			push_message(char_juese[ID_mubiao].name .. "发动了武将技能 '倾国'")
		end
	
		if char_juese[ID_mubiao].skill["龙胆"] == "available" then
			push_message(char_juese[ID_mubiao].name .. "发动了武将技能 '龙胆'")
		end
	end

	_nanman_sha({ID_mubiao, c_pos})
end
function _wanjian_zhudong_enter(ID_s)	--  万箭齐发：进入己方主动出牌状态
	wuxie_va = ID_s
	timer.stop()
	funcptr_queue = {}
	funcptr_i = 0

	gamerun_status = "主动出牌-万箭"
	set_hints("请您出闪或'取消'放弃")
	platform.window:invalidate()
end
function _wanjian_zhudong_chu(ID_s)	--  万箭齐发：己方出杀
	c_pos = card_highlighted

	gamerun_status = "手牌生效中"
	set_hints("")
	card_selected = {}
	card_highlighted = 1

	card_origin = char_juese[char_current_i].shoupai[c_pos]
	if card_origin[1] ~= "闪" then
		if char_juese[char_current_i].skill["倾国"] == "available" then
			add_funcptr(push_message, table.concat({char_juese[char_current_i].name, "发动了武将技能 '倾国'"}))
		elseif char_juese[char_current_i].skill["龙胆"] == "available" then
			add_funcptr(push_message, table.concat({char_juese[char_current_i].name, "发动了武将技能 '龙胆'"}))
		end
	end
	add_funcptr(_nanman_sha, {char_current_i, c_pos})
	add_funcptr(_wanjian_huifu)
end
function _wanjian_zhudong_fangqi(ID_s)	--  万箭齐发：己方放弃
	gamerun_status = "手牌生效中"
	set_hints("")

	add_funcptr(_nanman_send_msg, {char_juese[char_current_i].name, "放弃"})
	char_tili_deduct({1, char_current_i, ID_s, "普通", char_current_i, nil, true})
	add_funcptr(_wanjian_huifu)
end
function _wanjian_huifu()	--  万箭齐发：恢复己方中断前函数队列
	funcptr_queue, funcptr_i = pop_zhudong_queue()
end

--  使用五谷丰登 --
function card_wugu(ID_shoupai, ID_s)
	local card = char_juese[ID_s].shoupai[ID_shoupai]
    gamerun_status = "手牌生效中"
	jiaohu_text = ""
	add_funcptr(_card_sub1, {ID_shoupai, ID_s, nil})

	local card = char_juese[ID_s].shoupai[ID_shoupai]
	wugucards = {}
	wugucardsdisplay = ""
	for i = 1, 5 do
		if char_juese[ID_s].siwang == false then
			_wugu_mopai()
			if wugucardsdisplay ~= "" then
				wugucardsdisplay = wugucardsdisplay .. ";" .. wugucards[#wugucards][2] .. " " .. wugucards[#wugucards][3] .. "的" .. wugucards[#wugucards][1]
			else
				wugucardsdisplay = "牌堆顶展示的牌:" .. wugucards[#wugucards][2] .. " " .. wugucards[#wugucards][3] .. "的" .. wugucards[#wugucards][1]
			end
		end
	end
	add_funcptr(push_message, wugucardsdisplay)

	_wugu_get_card_exe(card, ID_s)
end
function _wugu_zhudong_enter()		--  五谷丰登：进入己方选择模式
	zhudong_queue = table.copy(funcptr_queue)
	zhudong_queue_i = funcptr_i + 1

	funcptr_queue = {}
	timer.stop()

	gamerun_status = "牌堆选择-五谷"
	gamerun_guankan_selected = 1
	txt_messages:setVisible(false)
	platform.window:invalidate()
end
function _wugu_huifu()	--  无懈可击：己方执行完毕恢复原有函数队列
	funcptr_queue = zhudong_queue
	funcptr_i = zhudong_queue_i
	timer.start(0.6)
end
function _wugu_mopai()	--  五谷丰登：从主牌堆摸一张牌到五谷丰登牌堆
	if #card_yixi == 0 then
		card_xipai(true)
	end
	table.insert(wugucards, card_yixi[1])
	table.remove(card_yixi, 1)
end
function _wugu_get_card_exe(card, ID_s)		--  五谷丰登：执行获得五谷丰登手牌动作
	gamerun_status = "手牌生效中"
	for counter = 0, 4 do
		if ID_s + counter > 5 then
			ID_mubiao = ID_s + counter - 5
		else
			ID_mubiao = ID_s + counter
		end
		if char_juese[ID_mubiao].siwang == false then
			funcptr_add_tag = "无懈执行前"
    		add_funcptr(_nanman_send_msg, {char_juese[ID_s].name, "对", char_juese[ID_mubiao].name, "使用了五谷丰登"})
			funcptr_add_tag = nil

			card_wuxie(card, ID_s, ID_mubiao, nil)

			funcptr_add_tag = "无懈无效结算"
			if ID_mubiao ~= char_current_i then
				--  轮到己方选择卡牌  --
				add_funcptr(_wugu_get_card, {ID_mubiao})
			else
				add_funcptr(_wugu_zhudong_enter)
			end
			funcptr_add_tag = nil
		end
	end
	funcptr_add_tag = "无懈执行完毕"
	add_funcptr(_wugu_qipai)
	add_funcptr(_nanman_sub1)
	funcptr_add_tag = nil
end
function _wugu_get_card(va_list)	--  五谷丰登：获得五谷丰登牌堆中的牌（其他角色）
	local ID_s = va_list[1]

	local wugu_card_i = math.random(#wugucards)
	table.insert(char_juese[ID_s].shoupai, wugucards[wugu_card_i])
	push_message(char_juese[ID_s].name .. "选择并获得了" .. wugucards[wugu_card_i][2] .. wugucards[wugu_card_i][3] .. "的" .. wugucards[wugu_card_i][1])

	table.remove(wugucards, wugu_card_i)
	platform.window:invalidate()
end
function _wugu_get_card_zhudong(ID_s, ID_card)	--  五谷丰登：获得五谷丰登牌堆中的牌（当前角色）
	gamerun_status = "手牌生效中"
	jiaohu_text = ""

	table.insert(char_juese[ID_s].shoupai, wugucards[ID_card])
	txt_messages:setVisible(true)
	push_message(char_juese[ID_s].name .. "选择并获得了" .. wugucards[ID_card][2] .. wugucards[ID_card][3] .. "的" .. wugucards[ID_card][1])
	table.remove(wugucards, ID_card)
	platform.window:invalidate()

	_wugu_huifu()
end
function _wugu_qipai()	--  五谷丰登：牌堆所有角色选择完毕如有剩余，放入弃牌堆
	for i = 1, #wugucards do
		card_add_qipai(wugucards[i])
	end
	wugucards = nil; collectgarbage()
end

--  使用决斗  --
function card_juedou(ID_shoupai, ID_s, ID_mubiao)
    local card = char_juese[ID_s].shoupai[ID_shoupai]
	
	gamerun_status = "手牌生效中"
	jiaohu_text = ""
	add_funcptr(_card_sub1, {ID_shoupai, ID_s, ID_mubiao})
	
	--  孙策使用红色决斗，摸一张牌  --
	if char_juese[ID_s].skill["激昂"] == "available" and (card[2] == "红桃" or card[2] == "方块") then
		skills_jiang(ID_s)
	end
	if char_juese[ID_mubiao].isantigovernment ~= nil then
		if char_juese[ID_mubiao].isantigovernment == false then
			if char_juese[ID_s].shenfen == "主公" then
				char_juese[ID_s].antigovernment = char_juese[ID_s].antigovernment + 5
			else
				char_juese[ID_s].antigovernment = char_juese[ID_s].antigovernment + 2
			end
		else
			char_juese[ID_s].antigovernment = char_juese[ID_s].antigovernment - 3
		end
	end
	ai_judge_shenfen()
	--add_funcptr(card_wuxie,ID_mubiao)
	--if is_affect == false then
		--add_funcptr(_juedou_sub1)
	--else
	if ID_mubiao ~= char_current_i then
		if ID_s == char_current_i then
			--  AI与己方互杀，己方挑起决斗  --
			_juedou_exe(ID_s, ID_mubiao, false)
		else
			--  AI之间互杀  --
			emulated_shoupai_s = table.copy(char_juese[ID_s].shoupai)
			emulated_shoupai_mubiao = table.copy(char_juese[ID_mubiao].shoupai)
			_juedou_exe(ID_s, ID_mubiao, true, emulated_shoupai_s, emulated_shoupai_mubiao)
		end
	else
		--  AI与己方互杀，AI挑起决斗  --
		_juedou_xiangying(ID_s, ID_mubiao)
	end
	--end
end
function _juedou_exe(ID_s, ID_mubiao, between_ai, emulated_shoupai_s, emulated_shoupai_mubiao)    --  决斗：AI响应 (临时)
    local c_pos
	
	local shoupai_copy
	if between_ai == true then
		shoupai_copy = emulated_shoupai_mubiao
	else
		shoupai_copy = table.copy(char_juese[ID_mubiao].shoupai)    --  目标手牌的副本
	end

	--  吕布无双  --
	local firstFlag = false    --  出第一个杀的标志
	if char_juese[ID_s].skill["无双"] == "available" then
		firstFlag = true
		add_funcptr(push_message, char_juese[ID_s].name .. "发动了武将技能 '无双'")
	end
	
	--  自动出杀  --
	while true do
		c_pos = ai_chazhao_sha(ID_mubiao, shoupai_copy)
		if c_pos > -1 then
			add_funcptr(_juedou_sha, {ID_mubiao, ID_s, c_pos})
			if firstFlag == false then
				if between_ai then
					table.remove(shoupai_copy, c_pos)
					_juedou_exe(ID_mubiao, ID_s, between_ai, emulated_shoupai_mubiao, emulated_shoupai_s)
				else
					_juedou_xiangying(ID_mubiao, ID_s)
				end
				break
			else
				table.remove(shoupai_copy, c_pos)
				firstFlag = false
			end
		else
			add_funcptr(_nanman_send_msg, {char_juese[ID_mubiao].name, "放弃"})
		
			char_tili_deduct({1, ID_mubiao, ID_s, "普通", ID_mubiao})
			if game_victory == false then
				add_funcptr(_juedou_sub1, nil)
			end
			break
		end
	end
end
function _juedou_exe_ji(ID_s, ID_mubiao, c_pos)    --  决斗：己方响应
    gamerun_status = "手牌生效中"
	jiaohu_text = ""
	
	card_selected = {}
	card_highlighted = 1
	platform.window:invalidate()
	
	add_funcptr(_juedou_sha, {ID_s, ID_mubiao, c_pos})
	if char_xiangying_2 == false then
		_juedou_exe(ID_s, ID_mubiao, false)
	else
		char_xiangying_2 = false
		add_funcptr(_juedou_xiangying_enter, {ID_s, ID_mubiao})
	end
end
function _juedou_exe_fangqi(ID_s, ID_mubiao)    --  决斗：己方放弃
    gamerun_status = "手牌生效中"
	jiaohu_text = ""
	
	add_funcptr(_nanman_send_msg, {char_juese[ID_s].name, "放弃"})
	
	char_tili_deduct({1, ID_s, ID_mubiao, "普通", ID_s})
	if game_victory == false then
		add_funcptr(_juedou_sub1, nil)
	end
end
function _juedou_xiangying(ID_s, ID_mubiao)
	if char_juese[ID_s].skill["无双"] == "available" then
		add_funcptr(push_message, char_juese[ID_s].name .. "发动了武将技能 '无双'")
		char_xiangying_2 = true
	else
		char_xiangying_2 = false
	end

	add_funcptr(_juedou_xiangying_enter, {ID_s, ID_mubiao})
end
function _juedou_xiangying_enter(va_list)    --  决斗：进入主动响应状态
	wuxie_va = va_list
    gamerun_status = "主动出牌-决斗"
	jiaohu_text = "请您出杀"
	platform.window:invalidate()
end
function _juedou_sha(va_list)    --  决斗：出杀
    local ID_mubiao, c_pos, msg, card
	ID_s = va_list[1]; ID_mubiao = va_list[2]; c_pos = va_list[3]
	
	card = char_juese[ID_s].shoupai[c_pos]
	card_add_qipai(card)
	card_remove({ID_s, c_pos})
	
	msg = {char_juese[ID_s].name, "'杀'", char_juese[ID_mubiao].name, " (", card[2], card[3], "的", card[1], ")"}
	push_message(table.concat(msg))
	msg = nil; collectgarbage()
end
function _juedou_sub1()
    gamerun_status = ""
	jiaohu_text = "请您出牌"
    platform.window:invalidate()
end

--  使用火攻  --
function card_huogong(ID_shoupai, ID_s, ID_mubiao)
    --  有手牌的目标才能火攻  --
	if #char_juese[ID_mubiao].shoupai < 1 then
	    return false
	end
	
	gamerun_status = "手牌生效中"
	jiaohu_text = ""
	
	if char_juese[ID_mubiao].isantigovernment ~= nil then
		if char_juese[ID_mubiao].isantigovernment == false then
			if char_juese[ID_s].shenfen == "主公" then
				char_juese[ID_s].antigovernment = char_juese[ID_s].antigovernment + 3
			else
				char_juese[ID_s].antigovernment = char_juese[ID_s].antigovernment + 2
			end
		else
			char_juese[ID_s].antigovernment = char_juese[ID_s].antigovernment - 2
		end
	end
	ai_judge_shenfen()
	
	--  卧龙诸葛火计  --
	if char_juese[ID_s].shoupai[ID_shoupai][1] ~= "火攻" then
		add_funcptr(push_message,char_juese[ID_s].name.. "发动了武将技能 '火计'")
		add_funcptr(_card_sub2, {ID_shoupai, ID_s, ID_mubiao, "火攻"})
	else
		add_funcptr(_card_sub1, {ID_shoupai, ID_s, ID_mubiao})
	end
	--add_funcptr(card_wuxie,ID_mubiao)
	--if is_affect == false then
	--	add_funcptr(_huogong_sub1)
	--else
	if ID_mubiao ~= char_current_i then
		if ID_s == char_current_i then
			--  己方火攻AI  --
			_huogong_exe_1(ID_s, ID_mubiao, false)
		else
			--  AI互相火攻  --
			_huogong_exe_1(ID_s, ID_mubiao, true)
		end
	else
		--  AI火攻己方  --
		_huogong_beidong_exe_1(ID_s, ID_mubiao)
	end
	--end
    return true
end
function _huogong_beidong_exe_1(ID_s, ID_mubiao)	--  火攻 (己方被动) 执行一：己方展示手牌
	add_funcptr(_huogong_beidong_xiangying, {ID_s, ID_mubiao})
end
function _huogong_beidong_xiangying(va_list)
	wuxie_va = va_list
	gamerun_status = "主动出牌-火攻B"
	jiaohu_text = "请展示一张手牌"
	platform.window:invalidate()
end
function _huogong_beidong_exe_2(ID_s, ID_mubiao, c_pos)		--  火攻 (己方被动) 执行二：攻方出牌并造成伤害
	if ID_mubiao == char_current_i then
		gamerun_status = "手牌生效中"
		jiaohu_text = ""
	
		card_selected = {}
		card_highlighted = 1
		platform.window:invalidate()
	end

	card_source = char_juese[ID_mubiao].shoupai[c_pos]
	add_funcptr(_nanman_send_msg, {char_juese[ID_mubiao].name, "展示了'", card_source[2], card_source[3], "的", card_source[1], "'"})

	card_t_pos = card_chazhao_with_huase(ID_s, card_source[2])
	if card_t_pos < 0 then
		add_funcptr(_nanman_send_msg, {char_juese[ID_s].name, "放弃"})
    	add_funcptr(_huogong_sub1, nil)
	else
		add_funcptr(_huogong_qipai, {ID_s, ID_mubiao, card_t_pos})
		char_tili_deduct({1, ID_mubiao, ID_s, "火", ID_mubiao})
		if game_victory == false then
			add_funcptr(_huogong_sub1, nil)
		end
	end
end
function _huogong_exe_1(ID_s, ID_mubiao, between_ai)    --  火攻执行一：被攻方展示手牌 (临时AI)
    local card, card_chosen, i
	
	card = char_juese[ID_mubiao].shoupai
	i = math.random(#card)
	if between_ai then
		card_chosen = i
	else
   		guankan_s = card[i][2]
	end

	if between_ai then
		_huogong_beidong_exe_2(ID_s, ID_mubiao, card_chosen)
	else
		add_funcptr(_nanman_send_msg, {char_juese[ID_mubiao].name, "展示了'", card[i][2], card[i][3], "的", card[i][1], "'"})
    	add_funcptr(_huogong_xiangying, nil)
	end
end
function _huogong_xiangying()    --  火攻：进入主动响应状态
    gamerun_status = "主动出牌-火攻A"
	jiaohu_text = "请您出相同花色牌"
	platform.window:invalidate()
end
function _huogong_exe_2(ID_s, ID_mubiao, c_pos)    --  火攻执行二：攻方出牌并造成伤害
    gamerun_status = "手牌生效中"
	jiaohu_text = ""
	
	card_selected = {}
	card_highlighted = 1
	platform.window:invalidate()
	
	add_funcptr(_huogong_qipai, {ID_s, ID_mubiao, c_pos})
	
	char_tili_deduct({1, ID_mubiao, ID_s, "火", ID_mubiao})
	if game_victory == false then
		add_funcptr(_huogong_sub1, nil)
	end
end
function _huogong_qipai(va_list)    --  火攻：攻方出牌
    local ID_s, ID_mubiao, c_pos
	ID_s = va_list[1]; ID_mubiao = va_list[2]; c_pos = va_list[3]
	local card
	
	card = char_juese[ID_s].shoupai[c_pos]
	card_add_qipai(card)
	card_remove({ID_s, c_pos})
	--card_shanchu({ID_s, c_pos})

	_nanman_send_msg({char_juese[ID_s].name, "弃掉了'", card[2], card[3], "的", card[1], "'"})
end
function _huogong_exe_3(ID_s)    --  火攻执行三：己方放弃
    add_funcptr(_nanman_send_msg, {char_juese[ID_s].name, "放弃"})
    add_funcptr(_huogong_sub1, nil)
end
function _huogong_sub1()
    guankan_s = 0
    gamerun_status = ""
	jiaohu_text = "请您出牌"
    platform.window:invalidate()
end

--  使用酒  --
function card_jiu(ID_shoupai, ID_s, binsi, p)
    local card
	if binsi == false then
		if char_hejiu then return false end
	end
	
	card = char_juese[ID_s].shoupai[ID_shoupai]
	
	if binsi == true then
		if p == nil then
			if card[1] ~= "酒" then
				add_funcptr(push_message, char_juese[ID_s].name.."发动了武将技能 '酒池'")
			end
			add_funcptr(_jiu_sub1, {ID_s, ID_shoupai, card})
			add_funcptr(_tao_sub, {ID_s, true})
		else
			add_funcptr(_jiu_sub1, {ID_s, ID_shoupai, card}, p)
			add_funcptr(_tao_sub, {ID_s, true}, p + 1)
			return p + 1
		end
	else
		char_hejiu = true
		_jiu_sub1({ID_s, ID_shoupai, card})
	end
	
	return true
end
function _jiu_sub1(va_list)
	local ID_s, ID_shoupai, card
	ID_s = va_list[1]; ID_shoupai = va_list[2]; card = va_list[3];
	
	if card[1] ~= "酒" then
		push_message(char_juese[ID_s].name.."发动了武将技能 '酒池'")
		_nanman_send_msg({char_juese[ID_s].name, "喝酒 (", card[2], card[3], "的", card[1], ")"})
	else
		_nanman_send_msg({char_juese[ID_s].name, "喝酒"})
	end

	card_add_qipai(card)
	card_remove({ID_s, ID_shoupai})
end

--  使用杀  --
function card_sha(ID_shoupai, ID_s, ID_mubiao, iscur)
    local card_shoupai, arm_zhuge, xingbie_diff
	char_liegong = false
	
	--  空城状态的诸葛亮不能杀  --
	if char_juese[ID_mubiao].skill["空城"] == "available" and #char_juese[ID_mubiao].shoupai == 0 then
		return false
	end
	
    --  攻击范围内的角色才能杀  --
	if #char_juese[ID_s].wuqi ~= 0 then
	    arm_zhuge = false
	    --  装备诸葛连弩，出杀不受限制  --
	    if char_juese[ID_s].wuqi[1] == "诸葛弩" then
	        arm_zhuge = true
	    end
		
		--  张飞出杀不受限制  --
		if char_juese[ID_s].skill["咆哮"] == "available" then
			arm_zhuge = true
		end
		
		if iscur then
			if (char_sha_time <= 0 and not arm_zhuge) or char_sha_able == false then
				return false
			end
		end
	    if char_calc_distance(ID_s, ID_mubiao) > card_wuqi_r[char_juese[ID_s].wuqi[1]] and char_distance_infinity == false then
	        return false
	    end
	else
		arm_zhuge = false
		--  张飞出杀不受限制  --
		if char_juese[ID_s].skill["咆哮"] == "available" then
			arm_zhuge = true
		end
	
	    if (char_sha_time <= 0 and not arm_zhuge) or char_sha_able == false then return false end
	    if char_calc_distance(ID_s, ID_mubiao) > 1 and char_distance_infinity == false then
	        return false
	    end
	end
	
	gamerun_status = "手牌生效中"
	jiaohu_text = ""
	
	if char_juese[ID_mubiao].isantigovernment ~= nil then
		if char_juese[ID_mubiao].isantigovernment == false then
			if char_juese[ID_s].shenfen == "主公" then
				char_juese[ID_s].antigovernment = char_juese[ID_s].antigovernment + 5
			else
				char_juese[ID_s].antigovernment = char_juese[ID_s].antigovernment + 2
			end
		else
			char_juese[ID_s].antigovernment = char_juese[ID_s].antigovernment - 3
		end
	end
	ai_judge_shenfen()
	
	if type(ID_shoupai) == "table" then
		--  丈八蛇矛，多张牌作伤害来源牌  --
		card_shoupai = {char_juese[ID_s].shoupai[ID_shoupai[1]], char_juese[ID_s].shoupai[ID_shoupai[2]]}
	else
		card_shoupai = char_juese[ID_s].shoupai[ID_shoupai]
		
		if card_shoupai[1] ~= "杀" and card_shoupai[1] ~= "火杀" and card_shoupai[1] ~= "雷杀" then
			--  关羽武圣  --
			if char_juese[ID_s].skill["武圣"] == "available" then
				add_funcptr(push_message, char_juese[ID_s].name .. "发动了武将技能 '武圣'")
			end
			
			--  赵云龙胆  --
			if char_juese[ID_s].skill["龙胆"] == "available" then
				add_funcptr(push_message, char_juese[ID_s].name .. "发动了武将技能 '龙胆'")
			end
		end
	end
	
	if #char_juese[ID_s].wuqi ~= 0 then
		if type(card_shoupai[1]) ~= "table" then
			--  ai_judge_liegong如ID_s为己方则始终返回true  --
			if char_juese[ID_s].skill["烈弓"] == "available" and skills_judge_liegong(ID_s, ID_mubiao) and ai_judge_liegong(ID_s) and not iscur then
				if ID_s == char_current_i then
					skills_liegong_enter(card_shoupai, ID_shoupai, ID_s, ID_mubiao)
				else
					skills_liegong(card_shoupai, ID_shoupai, ID_s, ID_mubiao)
				end
			else
				if _sha_judge_zhuque_cixiong(ID_shoupai, card_shoupai, ID_s, ID_mubiao) == false then
					_sha_go(ID_shoupai, card_shoupai, ID_s, ID_mubiao, iscur)
				end
			end
		else
			_sha_go(ID_shoupai, card_shoupai, ID_s, ID_mubiao, iscur)
		end
	else
		if char_juese[ID_s].skill["烈弓"] == "available" and skills_judge_liegong(ID_s, ID_mubiao) and ai_judge_liegong(ID_s) then
			if ID_s == char_current_i then
				skills_liegong_enter(card_shoupai, ID_shoupai, ID_s, ID_mubiao)
			else
				skills_liegong(card_shoupai, ID_shoupai, ID_s, ID_mubiao)
			end
	    else
			_sha_go(ID_shoupai, card_shoupai, ID_s, ID_mubiao, iscur)
		end
    end
	return true
end
function _sha_judge_zhuque_cixiong(ID_shoupai, card_shoupai, ID_s, ID_mubiao)		--  杀：判断是否符合朱雀羽扇、雌雄双股剑发动条件
	local xingbie_diff = (char_juese_jineng[char_juese[ID_s].name][5] ~= char_juese_jineng[char_juese[ID_mubiao].name][5])

	if ID_s == char_current_i then
		--  己方杀AI  --
		if char_juese[ID_s].wuqi[1] == "朱雀扇" and card_shoupai[1] == "杀" then
			guankan_s = card_shoupai
			_sha_zhuque()
			return true
		elseif xingbie_diff and char_juese[ID_s].wuqi[1] == "雌雄剑" and card_shoupai[1] == "杀" then
			guankan_s = card_shoupai
			_sha_cixiong()
			return true
		end
	else
		--  AI杀己方或其他AI  --
		if char_juese[ID_s].wuqi[1] == "朱雀扇" and ai_judge_zhuque() then
			_sha_zhuque_ai(ID_shoupai, ID_s, ID_mubiao)
			return true
		elseif xingbie_diff and char_juese[ID_s].wuqi[1] == "雌雄剑" and ai_judge_cixiong() then
			if ID_mubiao == char_current_i then
				--  AI杀己方  --
				_sha_cixiong_ai(ID_shoupai, ID_s, ID_mubiao)
			else
				--  AI杀其他AI  --
				_sha_cixiong_ai_between_ai(ID_shoupai, ID_s, ID_mubiao)
			end
			return true
		end
	end
	return false
end
function _sha_go(ID_shoupai, card_shoupai, ID_s, ID_mubiao, iscur)		--  杀：出杀
	add_funcptr(_sha_sub1, {ID_shoupai, ID_s, ID_mubiao})
	--  孙策使用红色杀，摸一张牌  --
	if char_juese[ID_s].skill["激昂"] == "available" and (card_shoupai[2] == "红桃" or card_shoupai[2] == "方块") then
		skills_jiang(ID_s)
	end

	--  吕布无双、董卓肉林  --
	local wushuang_flag = _sha_judge_if_xiangying_2(ID_s, ID_mubiao)

	if ID_mubiao == char_current_i then
		--  杀的目标是己方  --
		_sha_exe_ai_1(card_shoupai, ID_s, ID_mubiao, iscur, wushuang_flag)
	else
		--  杀的目标是AI  --
		_sha_exe_1(card_shoupai, ID_s, ID_mubiao, iscur, wushuang_flag)
	end
end
function _sha_judge_if_xiangying_2(ID_s, ID_mubiao)		--  杀：判断是否需要使用两张闪抵消
	--  吕布无双、董卓肉林  --
	if char_juese[ID_s].skill["无双"] == "available" then
		add_funcptr(push_message, char_juese[ID_s].name .. "发动了武将技能 '无双'")
		return true
	end
	if char_juese[ID_s].skill["肉林"] == "available" and char_juese_jineng[char_juese[ID_s].name][5] ~= char_juese_jineng[char_juese[ID_mubiao].name][5] then
		add_funcptr(push_message, char_juese[ID_s].name .. "发动了武将技能 '肉林'")
		return true
	end
	if char_juese[ID_mubiao].skill["肉林"] == "available" and char_juese_jineng[char_juese[ID_s].name][5] ~= char_juese_jineng[char_juese[ID_mubiao].name][5] then
		add_funcptr(push_message, char_juese[ID_mubiao].name .. "发动了武将技能 '肉林'")
		return true
	end
	return false
end
function _sha_get_leixing(card_shoupai)		--  杀：根据牌面返回杀的类型
	if type(card_shoupai[1]) ~= "table" then
		if card_shoupai[1] == "杀" or card_shoupai[1] == "火杀" or card_shoupai[1] == "雷杀" then
			hint_1 = card_shoupai[1]
		else
			hint_1 = "杀"
		end
	else
		hint_1 = "杀"
	end
	return hint_1
end
function _sha_judge_fangju_ying(card_zhuangbei, card_shoupai, sha_leixing, ID_s, ID_mubiao)		--  杀：判断是否装备硬防具（100%概率抵御，即藤甲仁王盾）
	if card_zhuangbei[1] == "藤甲" and sha_leixing == "杀" then
		add_funcptr(_nanman_send_msg, {char_juese[ID_mubiao].name, "装备藤甲，不用出闪"})
		return true
	end
	if card_zhuangbei[1] == "仁王盾" and (card_shoupai[2] == "黑桃" or card_shoupai[2] == "草花") then
		add_funcptr(_nanman_send_msg, {char_juese[ID_mubiao].name, "装备仁王盾，抵御黑杀"})
		return true
	end
	return false
end
function _sha_exe_ai_1(card_shoupai, ID_s, ID_mubiao, iscur, wushuang_flag)	--  杀：己方响应
	local card, hint_1

	hint_1 = _sha_get_leixing(card_shoupai)
	--  青釭剑，设置无视防具标志  --
	if #char_juese[ID_s].wuqi ~= 0 then
	    if char_juese[ID_s].wuqi[1] == "青钢剑" then
	        char_wushi = true
	    end
		if char_juese[ID_s].wuqi[1] == "朱雀扇" then
		    hint_1 = "火杀"
		end
	end

	--  若装备防具，进行判断  --
	card = table.copy(char_juese[ID_mubiao].fangju)

	--  卧龙诸葛若未装备防具，视为装备八卦阵  --
	if char_juese[ID_mubiao].skill["八阵"] == "available" and #card == 0 then
		card[1] = "八卦阵"
	end

	if #card ~= 0 then
		if not char_wushi then
			if _sha_judge_fangju_ying(card, card_shoupai, hint_1, ID_s, ID_mubiao) then
				add_funcptr(_sha_sub2, nil)
			    return
			end
		else
			add_funcptr(_nanman_send_msg, {char_juese[ID_s].name, "发动了'青钢剑'效果"})
		end
	end

	--  如果发动烈弓，则杀不可被闪避  --
	if char_liegong == true then
		_sha_zhudong_fangqi({card_shoupai, ID_s, ID_mubiao, iscur}, false)
		return
	end

	if #card ~= 0 then
		if not char_wushi then        
		    if card[1] == "八卦阵" then
				if char_juese[ID_mubiao].skill["八阵"] == "available" then
					add_funcptr(skills_bazhen, ID_mubiao)
				end
				card_arm_bagua(ID_mubiao)
		    end
		end
	end

	add_funcptr(_sha_zhudong_xiangying, {card_shoupai, ID_s, ID_mubiao, iscur, wushuang_flag, card})
end
function _sha_zhudong_xiangying(va_list)
	local card_shoupai, ID_s, ID_mubiao, iscur, wushuang_flag, fangju_card
	card_shoupai = va_list[1]; ID_s = va_list[2]; ID_mubiao = va_list[3]; iscur = va_list[4]; wushuang_flag = va_list[5]; fangju_card = va_list[6]

	timer.stop()
	funcptr_queue = {}
	funcptr_i = 0

	if #fangju_card ~= 0 then
	    if not char_wushi then
		    if fangju_card[1] == "八卦阵" then
				if _bagua_jiesuan(ID_mubiao) then
					--  张角雷击  --
					if char_juese[ID_mubiao].skill["雷击"] == "available" then
						add_funcptr(skills_leiji, {ID_mubiao, ID_s})
					end

					if wushuang_flag == true then
						_sha_exe_ai_1(card_shoupai, ID_s, ID_mubiao, iscur, false)
					else
						_sha_shan_post_ai(card_shoupai, ID_s, ID_mubiao, iscur)
					end

					timer.start(0.6)
					return
				end
			end
		end
	end

	add_funcptr(_sha_zhudong_enter, {card_shoupai, ID_s, ID_mubiao, iscur})
	timer.start(0.6)
end
function _sha_zhudong_enter(va_list)	--  杀：进入己方主动出牌状态
	wuxie_va = va_list

	gamerun_status = "主动出牌-杀"
	set_hints("请您出闪或'取消'放弃")
	platform.window:invalidate()
end
function _sha_zhudong_chu(va_list)	--  杀：己方出闪
	local card_shoupai, ID_s, ID_mubiao, iscur, c_pos
	card_shoupai = va_list[1]; ID_s = va_list[2]; ID_mubiao = va_list[3]; iscur = va_list[4]
	c_pos = card_highlighted

	gamerun_status = "手牌生效中"
	set_hints("")
	card_selected = {}
	card_highlighted = 1

	card_origin = char_juese[char_current_i].shoupai[c_pos]
	if card_origin[1] ~= "闪" then
		if char_juese[char_current_i].skill["倾国"] == "available" then
			add_funcptr(push_message, table.concat({char_juese[char_current_i].name, "发动了武将技能 '倾国'"}))
		elseif char_juese[char_current_i].skill["龙胆"] == "available" then
			add_funcptr(push_message, table.concat({char_juese[char_current_i].name, "发动了武将技能 '龙胆'"}))
		end
	end

	add_funcptr(_sha_shan, {char_current_i, c_pos})
	--  张角雷击  --
	if char_juese[ID_mubiao].skill["雷击"] == "available" then
		add_funcptr(skills_leiji, {ID_mubiao, ID_s})
	end

	if char_xiangying_2 == false then
		_sha_shan_post_ai(card_shoupai, ID_s, ID_mubiao, iscur)
	else
		_sha_exe_ai_1(card_shoupai, ID_s, ID_mubiao, iscur, false)
	end
end
function _sha_zhudong_fangqi(va_list, is_from_zhudong)	--  杀：杀的来源是AI时，放弃后处理
	local card_shoupai, ID_s, ID_mubiao, iscur
	card_shoupai = va_list[1]; ID_s = va_list[2]; ID_mubiao = va_list[3]; iscur = va_list[4]

	if is_from_zhudong then
		gamerun_status = "手牌生效中"
		set_hints("")
	end

	add_funcptr(_nanman_send_msg, {char_juese[ID_mubiao].name, "放弃"})
	if #char_juese[ID_s].wuqi ~= 0 and type(card_shoupai[1]) ~= "table" and iscur then
		if ai_judge_hanbing(ID_mubiao) and char_juese[ID_s].wuqi[1] == "寒冰剑" then
			add_funcptr(_sha_hanbing_ai_judge, {card_shoupai, ID_s, ID_mubiao, iscur})
		else
			_sha_tili_deduct(card_shoupai, ID_s, ID_mubiao, iscur)
		end
	else
		_sha_tili_deduct(card_shoupai, ID_s, ID_mubiao, iscur)
	end
end
function _sha_shan_post_ai(card_shoupai, ID_s, ID_mubiao, iscur)	--  杀：杀的来源是AI时，出闪后处理
	if iscur and #char_juese[ID_s].wuqi ~= 0 and type(card_shoupai[1]) ~= "table" then
		if char_juese[ID_s].wuqi[1] == "青龙刀" and ai_judge_qinglong(ID_s) then    --  青龙刀，可再出杀追杀
			add_funcptr(_sha_qinglong_ai_judge, {ID_s, ID_mubiao, iscur})
		elseif char_juese[ID_s].wuqi[1] == "贯石斧" and ai_judge_guanshi(ID_s) then
			add_funcptr(_sha_guanshi_ai_judge, {card_shoupai, ID_s, ID_mubiao, iscur})
		else
			add_funcptr(_sha_sub2, nil)
		end
	else
		add_funcptr(_sha_sub2, nil)
	end
end
function _sha_zhuque_ai(ID_shoupai, ID_s, ID_mubiao)	--  杀：AI使用朱雀羽扇效果
	local card = char_juese[ID_s].shoupai[ID_shoupai]
	add_funcptr(_nanman_send_msg, {char_juese[ID_s].name, "发动了'朱雀羽扇'效果"})
	_sha_go(ID_shoupai, card, ID_s, ID_mubiao, true)
end
function _sha_cixiong_ai(ID_shoupai, ID_s, ID_mubiao)	--  杀：AI使用雌雄双股剑效果 (杀己方)
	add_funcptr(_nanman_send_msg, {char_juese[ID_s].name, "发动了'雌雄双股剑'效果"})
	add_funcptr(_sha_cixiong_zhudong_enter, {ID_shoupai, ID_s, ID_mubiao})
end
function _sha_cixiong_ai_between_ai(ID_shoupai, ID_s, ID_mubiao)	--  杀：AI使用雌雄双股剑效果 (杀其他AI)
	add_funcptr(_nanman_send_msg, {char_juese[ID_s].name, "发动了'雌雄双股剑'效果"})
	add_funcptr(card_fenfa, {ID_s, 1, true})
	
	local card = char_juese[ID_s].shoupai[ID_shoupai]
	_sha_go(ID_shoupai, card, ID_s, ID_mubiao, true)
end
function _sha_cixiong_zhudong_enter(va_list)
	wuxie_va = va_list
	gamerun_status = "主动出牌-雌雄"
	jiaohu_text = "请弃一张牌或'取消'对方摸牌"
	platform.window:invalidate()
end
function _sha_cixiong_zhudong_qipai(va_list)	--  杀：(雌雄双股剑) 己方弃一张牌
	local ID_shoupai, ID_s, ID_mubiao
	ID_shoupai = va_list[1]; ID_s = va_list[2]; ID_mubiao = va_list[3]

	local c_pos = card_highlighted
	card_highlighted = 1
	card_selected = {}

	local card = char_juese[char_current_i].shoupai[c_pos]
	local card_shoupai_sha = char_juese[ID_s].shoupai[ID_shoupai]

	add_funcptr(_sha_cixiong_qipai_go, {card, c_pos, ID_s, ID_mubiao})
	_sha_go(ID_shoupai, card_shoupai_sha, ID_s, ID_mubiao, true)
end
function _sha_cixiong_qipai_go(va_list)
	local card, c_pos, ID_s, ID_mubiao
	card = va_list[1]; c_pos = va_list[2]; ID_s = va_list[3]; ID_mubiao = va_list[4]

	card_add_qipai(card)
	card_remove({char_current_i, c_pos})
	_nanman_send_msg({char_juese[ID_s].name, "弃掉了'", card[2], card[3], "的", card[1], "'"})
end
function _sha_cixiong_zhudong_fangqi(va_list)	--  杀：(雌雄双股剑) 己方让对方摸一张牌
	local ID_shoupai, ID_s, ID_mubiao
	ID_shoupai = va_list[1]; ID_s = va_list[2]; ID_mubiao = va_list[3]

	local card = char_juese[ID_s].shoupai[ID_shoupai]

	add_funcptr(card_fenfa, {ID_s, 1, true})
	_sha_go(ID_shoupai, card, ID_s, ID_mubiao, true)
end
function _sha_hanbing_ai_judge(va_list)		--  杀：判断寒冰剑发动条件，如不发动直接结束结算
	local card_shoupai, ID_s, ID_mubiao, iscur
	card_shoupai = va_list[1]; ID_s = va_list[2]; ID_mubiao = va_list[3]; iscur = va_list[4]

	timer.stop()
	funcptr_queue = {}

	if ai_judge_hanbing(ID_mubiao) and char_juese[ID_s].wuqi[1] == "寒冰剑" then
		_sha_hanbing_ai(ID_s, ID_mubiao)
	else
		_sha_tili_deduct(card_shoupai, ID_s, ID_mubiao, iscur)
	end

	consent_func_queue(0.6)
end
function _sha_hanbing_ai(ID_s, ID_mubiao)	--  杀：AI使用寒冰剑
	add_funcptr(_nanman_send_msg, {char_juese[ID_s].name, "发动了'寒冰剑'效果"})

	add_funcptr(_sha_hanbing_qipai_go, ID_mubiao)
	add_funcptr(_sha_hanbing_qipai_go, ID_mubiao)

	add_funcptr(_sha_sub2, nil)
end
function _sha_hanbing_qipai_go(ID_mubiao)	--  杀：AI寒冰剑弃牌 (临时AI)
	local c_pos = math.random(#char_juese[ID_mubiao].shoupai)
	local card = char_juese[ID_mubiao].shoupai[c_pos]

	card_add_qipai(card)
	card_remove({ID_mubiao, c_pos})
	_nanman_send_msg({char_juese[ID_s].name, "弃掉了'", card[2], card[3], "的", card[1], "'"})
end
function _sha_qinglong_ai_judge(va_list)	--  杀：判断青龙刀发动条件，如不发动直接结束结算
	local ID_s, ID_mubiao, iscur
	ID_s = va_list[1]; ID_mubiao = va_list[2]; iscur = va_list[3]

	timer.stop()
	funcptr_queue = {}
	funcptr_i = 0

	if char_juese[ID_s].wuqi[1] == "青龙刀" and ai_judge_qinglong(ID_s) then    --  青龙刀，可再出杀追杀
		_sha_qinglong_ai(ID_s, ID_mubiao, iscur)
	else
		add_funcptr(_sha_sub2, nil)
	end

	timer.start(0.6)
end
function _sha_qinglong_ai(ID_s, ID_mubiao, iscur)	--  杀：AI青龙刀追杀
	local c_pos = ai_chazhao_sha(ID_s, char_juese[ID_s].shoupai)
	local card = char_juese[ID_s].shoupai[c_pos]

	add_funcptr(_nanman_send_msg, {char_juese[ID_s].name, "发动了'青龙刀'效果"})
	_sha_go(c_pos, card, ID_s, ID_mubiao, iscur)
end
function _sha_guanshi_ai_judge(va_list)		--  杀：判断贯石斧发动条件，如不发动直接结束结算
	local card_shoupai, ID_s, ID_mubiao, iscur
	card_shoupai = va_list[1]; ID_s = va_list[2]; ID_mubiao = va_list[3]; iscur = va_list[4]

	timer.stop()
	funcptr_queue = {}
	funcptr_i = 0

	if char_juese[ID_s].wuqi[1] == "贯石斧" and ai_judge_guanshi(ID_s) then
		_sha_guanshi_ai(card_shoupai, ID_s, ID_mubiao, iscur)
	else
		add_funcptr(_sha_sub2, nil)
	end

	timer.start(0.6)
end
function _sha_guanshi_ai(card_shoupai, ID_s, ID_mubiao, iscur)	--  杀：AI使用贯石斧
	add_funcptr(_nanman_send_msg, {char_juese[ID_s].name, "发动了'贯石斧'效果"})

	add_funcptr(_sha_guanshi_qipai_go, ID_s)
	add_funcptr(_sha_guanshi_qipai_go, ID_s)

	_sha_tili_deduct(card_shoupai, ID_s, ID_mubiao, iscur)
end
function _sha_guanshi_qipai_go(ID_s)	--  杀：AI贯石斧弃牌 (临时AI)
	local c_pos = math.random(#char_juese[ID_s].shoupai)
	local card = char_juese[ID_s].shoupai[c_pos]

	card_add_qipai(card)
	card_remove({ID_s, c_pos})
	_nanman_send_msg({char_juese[ID_s].name, "弃掉了'", card[2], card[3], "的", card[1], "'"})
end
function _sha_qilin_ai(va_list)	--  杀：AI使用麒麟弓 (临时AI)
	local ID_s, ID_mubiao
	ID_s = va_list[1]; ID_mubiao = va_list[2]

	if #char_juese[ID_mubiao].gongma ~= 0 or #char_juese[ID_mubiao].fangma ~= 0 then
		add_funcptr(_nanman_send_msg, {char_juese[ID_s].name, "发动了'麒麟弓'效果"})
		add_funcptr(_sha_qilin_qipai_go, va_list)
	end
end
function _sha_qilin_qipai_go(va_list)
	local card
	local ID_s, ID_mubiao
	ID_s = va_list[1]; ID_mubiao = va_list[2]
	
	if #char_juese[ID_mubiao].gongma ~= 0 then
		card = char_juese[ID_mubiao].gongma
		char_juese[ID_mubiao].gongma = {}
	elseif #char_juese[ID_mubiao].fangma ~= 0 then
		card = char_juese[ID_mubiao].fangma
		char_juese[ID_mubiao].fangma = {}
	end
	card_add_qipai(card)

	_nanman_send_msg({char_juese[ID_s].name, "弃掉了'", card[2], card[3], "的", card[1], "'"})
end
function _sha_exe_1(card_shoupai, ID_s, ID_mubiao, iscur, wushuang_flag)    --  杀：AI响应
    local c_pos, card, hint_1, jineng
	jineng = false
	
	hint_1 = _sha_get_leixing(card_shoupai)
	--  青釭剑，设置无视防具标志  --
	if #char_juese[ID_s].wuqi ~= 0 then
	    if char_juese[ID_s].wuqi[1] == "青钢剑" then
	        char_wushi = true
	    end
		if char_juese[ID_s].wuqi[1] == "朱雀扇" then
		    hint_1 = "火杀"
		end
	end
	
    --  若装备防具，进行判断  --
	card = table.copy(char_juese[ID_mubiao].fangju)

	--  卧龙诸葛若未装备防具，视为装备八卦阵  --
	if char_juese[ID_mubiao].skill["八阵"] == "available" and #card == 0 then
		card[1] = "八卦阵"
	end

	if #card ~= 0 then
		if not char_wushi then
			if _sha_judge_fangju_ying(card, card_shoupai, hint_1, ID_s, ID_mubiao) then
				add_funcptr(_sha_sub2, nil)
			    return
			end
		else
			add_funcptr(_nanman_send_msg, {char_juese[ID_s].name, "发动了'青钢剑'效果"})
		end
	end

	--  如果发动烈弓，则杀不可被闪避  --
	if char_liegong == true then
		if ID_s == char_current_i then
			--  杀的来源是己方  --
			_sha_fangqi(card_shoupai, ID_s, ID_mubiao, iscur)
		else
			--  杀的来源是AI  --
			_sha_zhudong_fangqi({card_shoupai, ID_s, ID_mubiao, iscur}, false)
		end
		return
	end

	if #card ~= 0 then
	    if not char_wushi then
		    if card[1] == "八卦阵" then
				if char_juese[ID_mubiao].skill["八阵"] == "available" then
					add_funcptr(skills_bazhen, ID_mubiao)
				end
				card_arm_bagua(ID_mubiao)
		    end
		end
	end
	
	add_funcptr(_sha_ai_xiangying, {card_shoupai, ID_s, ID_mubiao, iscur, wushuang_flag, card})
end
function _sha_ai_xiangying(va_list)
	local card_shoupai, ID_s, ID_mubiao, iscur, wushuang_flag, fangju_card
	card_shoupai = va_list[1]; ID_s = va_list[2]; ID_mubiao = va_list[3]; iscur = va_list[4]; wushuang_flag = va_list[5]; fangju_card = va_list[6]

	local yanshi = false

	timer.stop()
	funcptr_queue = {}
	funcptr_i = 0

	if #fangju_card ~= 0 then
	    if not char_wushi then
		    if fangju_card[1] == "八卦阵" then
				if _bagua_jiesuan(ID_mubiao) then
					--  张角雷击  --
					if char_juese[ID_mubiao].skill["雷击"] == "available" then
						add_funcptr(skills_leiji, {ID_mubiao, ID_s})
					end

					if wushuang_flag == true then
						_sha_exe_1(card_shoupai, ID_s, ID_mubiao, iscur, false)
					else
						if ID_s == char_current_i then
							--  杀的来源是己方  --
							_sha_shan_post(ID_s, card_shoupai, iscur)
						else
							--  杀的来源是AI  --
							_sha_shan_post_ai(card_shoupai, ID_s, ID_mubiao, iscur)
						end
					end

					timer.start(0.6)
					return
				else
					yanshi = true
				end
			end
		end
	end

	--  AI出闪  --
	local shoupai = char_juese[ID_mubiao].shoupai
	c_pos = ai_chazhao_shan(ID_mubiao, shoupai)
	if c_pos > -1 then
		if yanshi == false then
			_sha_shan({ID_mubiao, c_pos})
		else
			add_funcptr(_sha_shan, {ID_mubiao, c_pos})
		end
			
		--  张角雷击  --
		if char_juese[ID_mubiao].skill["雷击"] == "available" then
			add_funcptr(skills_leiji, {ID_mubiao, ID_s})
		end
			
		if wushuang_flag == false then
			if ID_s == char_current_i then
				--  杀的来源是己方  --
				_sha_shan_post(ID_s, card_shoupai, iscur)
			else
				--  杀的来源是AI  --
				_sha_shan_post_ai(card_shoupai, ID_s, ID_mubiao, iscur)
			end
		else
			_sha_exe_1(card_shoupai, ID_s, ID_mubiao, iscur, false)
		end
	else
		if ID_s == char_current_i then
			--  杀的来源是己方  --
			_sha_fangqi(card_shoupai, ID_s, ID_mubiao, iscur)
		else
			--  杀的来源是AI  --
			_sha_zhudong_fangqi({card_shoupai, ID_s, ID_mubiao, iscur}, false)
		end
	end

	timer.start(0.6)
end
function _sha_shan_post(ID_s, card_shoupai, iscur)		--  杀：杀的来源是己方时，出闪后处理
	if iscur and #char_juese[ID_s].wuqi ~= 0 and type(card_shoupai[1]) ~= "table" then
		if char_juese[ID_s].wuqi[1] == "青龙刀" then    --  青龙刀，可再出杀追杀
			add_funcptr(_sha_qinglong, nil)
		elseif char_juese[ID_s].wuqi[1] == "贯石斧" then
			add_funcptr(_sha_guanshi, nil)
			guankan_s = card_shoupai
		else
			add_funcptr(_sha_sub2, nil)
		end
	else
		add_funcptr(_sha_sub2, nil)
	end
end
function _sha_fangqi(card_shoupai, ID_s, ID_mubiao, iscur)		--  杀：杀的来源是己方时，放弃后处理
	add_funcptr(_nanman_send_msg, {char_juese[ID_mubiao].name, "放弃"})
	if #char_juese[ID_s].wuqi ~= 0 and type(card_shoupai[1]) ~= "table" and iscur then
		--  若对方没有任何牌，不能使用寒冰剑  --
		local p
		local flag = true
		p = char_juese[ID_mubiao]
		if #p.shoupai < 1 and #p.fangju == 0 and #p.wuqi == 0 and #p.gongma == 0 and #p.fangma == 0 and #p.panding == 0 then
			flag = false
		end
			
		if flag and char_juese[ID_s].wuqi[1] == "寒冰剑" then
			guankan_s = card_shoupai
			sha_va = {card_shoupai, ID_s, ID_mubiao, true}
			add_funcptr(_sha_hanbing)
		else
			_sha_tili_deduct(card_shoupai, ID_s, ID_mubiao, iscur)
		end
	else
		_sha_tili_deduct(card_shoupai, ID_s, ID_mubiao, iscur)
	end
end
function _sha_card_chazhao(tb, name)
    local i, v
	
	for i, v in ipairs(tb) do
	    if v[1] == name then
		    return i
		end
	end
	
	return -1
end
function _sha_chazhao_redblack(tb, red)
    local i, v
	
	for i, v in ipairs(tb) do
		if red == false then
			if v[2] == "黑桃" or v[2] == "草花" then
				return i
			end
		else
			if v[2] == "红桃" or v[2] == "方块" then
				return i
			end
		end
	end
	
	return -1
end
function _sha_exe_2(ID_s, ID_mubiao, c_pos)    --  杀：青龙刀追杀
	local card_shoupai

    gamerun_status = "手牌生效中"
	jiaohu_text = ""
	
	card_shoupai = char_juese[ID_s].shoupai[c_pos]
	add_funcptr(_sha_sub1, {c_pos, ID_s, ID_mubiao})
	_sha_exe_1(card_shoupai, ID_s, ID_mubiao, true)
end
function _sha_exe_2_g()    --  杀：放弃使用装备效果
	_sha_sub2()
end
function _sha_exe_3(ID_s, ID_mubiao, card_shoupai)    --  杀：贯石斧强制命中
    gamerun_status = "手牌生效中"
	jiaohu_text = ""
	
	add_funcptr(_nanman_send_msg, {char_juese[ID_s].name, "发动了'贯石斧'效果"})
	_sha_tili_deduct(card_shoupai, ID_s, ID_mubiao, true)
end
function _sha_exe_4(va_list)    --  杀：麒麟弓效果初始化
    local i
	local ID_s, ID_d
	ID_s = va_list[1]; ID_d = va_list[2]
	
	gamerun_status = "观看手牌-杀"
	gamerun_guankan_type = {}
	
	--  往观看牌堆添加牌  --
	if #char_juese[ID_d].fangma > 0 then
	    table.insert(gamerun_guankan_type, {"防御马", 0})
	end
	if #char_juese[ID_d].gongma > 0 then
	    table.insert(gamerun_guankan_type, {"攻击马", 0})
	end
	
	--  设置状态信息  --
	gamerun_guankan_selected = 1
	guankan_s = ID_s
	guankan_d = ID_d
	
	txt_messages:setVisible(false)
	platform.window:invalidate()
end
function _sha_exe_5(va_list)    --  杀：寒冰剑效果初始化
	local first = va_list[4]

	_chai_sub1(va_list)
	if first then
		gamerun_status = "观看手牌-寒"
	else
		gamerun_status = "观看手牌-寒2"
	end
end
function _sha_tili_deduct(card_shoupai, ID_s, ID_mubiao, iscur)    --  杀：扣减体力结算
    local shuxing, deduct, hint_1
	
	if type(card_shoupai[1]) ~= "table" then
		if card_shoupai[1] == "杀" or card_shoupai[1] == "火杀" or card_shoupai[1] == "雷杀" then
			hint_1 = card_shoupai[1]
		else
			hint_1 = "杀"
		end
	else
		hint_1 = "杀"
	end
	if #char_juese[ID_s].wuqi ~= 0 then
	    if char_juese[ID_s].wuqi[1] == "朱雀扇" then
		    hint_1 = "火杀"
		end
	end
	
	if hint_1 == "杀" then
		shuxing = "普通"
	elseif hint_1 == "火杀" then
		shuxing = "火"
	elseif hint_1 == "雷杀" then
		shuxing = "雷"
	end
		
	deduct = 1
	if char_hejiu and iscur then    --  喝酒，伤害+1
		deduct = deduct + 1
	end
	if char_luoyi and iscur then    --  裸衣，伤害+1
		deduct = deduct + 1
	end
	if #char_juese[ID_s].wuqi ~= 0 then    --  对方无牌时，古锭刀伤害+1
	    if char_juese[ID_s].wuqi[1] == "古锭刀" and #char_juese[ID_mubiao].shoupai == 0 then
	        deduct = deduct + 1
			add_funcptr(_nanman_send_msg, {char_juese[ID_s].name, "装备古锭刀，伤害+1"})
	    end
	end
	
	local victory, tili
	local p
	
	if iscur then
		--  造成伤害后，麒麟弓可将马弃置  -- 
		p = function(ID_s, ID_mubiao)
			if #char_juese[ID_s].wuqi ~= 0 then
				if char_juese[ID_s].wuqi[1] == "麒麟弓" and (#char_juese[ID_mubiao].gongma > 0 or #char_juese[ID_mubiao].fangma > 0) then
					if ID_s == char_current_i then
						add_funcptr(_sha_qilin, ID_mubiao)
					else
						_sha_qilin_ai({ID_s, ID_mubiao})
					end
					return
				end
			end
		end
	end
	
	--  结算伤害  --
	char_tili_deduct({deduct, ID_mubiao, ID_s, shuxing, ID_mubiao, p})
	
	--if lianhuan_va == nil and game_victory == false and iscur then
	if game_victory == false then
		add_funcptr(_sha_sub2, nil)
	end
end
function _sha_shan(va_list)    --  杀：AI出闪
    local ID_mubiao, c_pos, msg, card
	ID_mubiao = va_list[1]; c_pos = va_list[2]
	
	card = char_juese[ID_mubiao].shoupai[c_pos]
	card_add_qipai(card)
	card_remove({ID_mubiao, c_pos})
	--card_shanchu({ID_mubiao, c_pos})
	
	if card[1] ~= "闪" then
		if char_juese[ID_mubiao].skill["倾国"] == "available" then
			push_message(char_juese[ID_mubiao].name.."发动了武将技能 '倾国'")
		end
		
		if char_juese[ID_mubiao].skill["龙胆"] == "available" then
			push_message(char_juese[ID_mubiao].name.."发动了武将技能 '龙胆'")
		end
	end	
	
	msg = {char_juese[ID_mubiao].name, "出'闪' (", card[2], card[3], "的", card[1], ")"}
	push_message(table.concat(msg))
	msg = nil; collectgarbage()
end
function _sha_qinglong()    --  杀：青龙刀追杀状态设置
    gamerun_status = "主动出牌-青龙"
	jiaohu_text = "您可再出杀"
	platform.window:invalidate()
end
function _sha_guanshi()    --  杀：贯石斧状态设置
    gamerun_status = "主动出牌-贯石"
	jiaohu_text = "您可弃2张牌强制命中"
	platform.window:invalidate()
end
function _sha_zhuque()    --  杀：朱雀羽扇状态设置
    gamerun_status = "确认操作"
	jiaohu_text = "可按'确定'发动朱雀羽扇"
	gamerun_OK = false
	gamerun_OK_ptr = function()    -- 如果确认发动，执行的函数
		local card = char_juese[char_current_i].shoupai[card_highlighted]
	    gamerun_status = ""; set_hints("")
		funcptr_queue = {}
	    add_funcptr(_nanman_send_msg, {char_juese[char_current_i].name, "发动了'朱雀羽扇'效果"})
	    add_funcptr(_sha_sub1, {card_highlighted, char_current_i, gamerun_target_selected})
		--  孙策使用红色杀，摸一张牌  --
		if char_juese[char_current_i].name == "孙策" and (card[2] == "红桃" or card[2] == "方块") then
			skills_jiang(char_current_i)
		end
		
	    _sha_exe_1(guankan_s, char_current_i, gamerun_target_selected, true)
		consent_func_queue(0.6)
	end
	platform.window:invalidate()
end
function _sha_qilin(ID)		--  杀：麒麟弓状态设置
	if #char_juese[ID].gongma > 0 or #char_juese[ID].fangma > 0 then
		zhudong_queue = table.copy(funcptr_queue)
		zhudong_queue_i = funcptr_i + 1

		timer.stop()
		funcptr_queue = {}
		funcptr_i = 0

		add_funcptr(_sha_qilin_enter, ID)
		timer.start(0.6)
	end
end
function _sha_qilin_enter(ID)    --  杀：麒麟弓进入选牌界面
    gamerun_status = "确认操作"
	jiaohu_text = "可按'确定'发动麒麟弓"
	gamerun_OK = false
	gamerun_OK_ptr = function()    -- 如果确认发动，执行的函数
	    gamerun_status = ""; set_hints("")
		if gamerun_OK then
	        funcptr_queue = {}
			add_funcptr(_nanman_send_msg, {char_juese[char_current_i].name, "发动了'麒麟弓'效果"})
	        add_funcptr(_sha_exe_4, {char_current_i, gamerun_target_selected})
		    consent_func_queue(0.6)
	    else
		    _sha_qilin_huifu()
		end
	end
	platform.window:invalidate()
end
function _sha_qilin_huifu()	--  杀：(麒麟弓) 恢复己方中断前函数队列
	funcptr_queue = zhudong_queue
	funcptr_i = zhudong_queue_i
	timer.start(0.6)
end
function _sha_cixiong()    --  杀：雌雄双股剑状态设置
    gamerun_status = "确认操作"
	jiaohu_text = "可按'确定'发动雌雄剑"
	gamerun_OK = false
	gamerun_OK_ptr = function()    -- 如果确认发动，执行的函数
		local card = char_juese[char_current_i].shoupai[card_highlighted]
	    gamerun_status = ""; set_hints("")
		funcptr_queue = {}
	    add_funcptr(_nanman_send_msg, {char_juese[char_current_i].name, "发动了'雌雄双股剑'效果"})
		add_funcptr(card_fenfa, {char_current_i, 1, true})
	    add_funcptr(_sha_sub1, {card_highlighted, char_current_i, gamerun_target_selected})
		--  孙策使用红色杀，摸一张牌  --
		if char_juese[char_current_i].name == "孙策" and (card[2] == "红桃" or card[2] == "方块") then
			skills_jiang(char_current_i)
		end
		
	    _sha_exe_1(guankan_s, char_current_i, gamerun_target_selected, true)
		consent_func_queue(0.6)
	end
	platform.window:invalidate()
end
function _sha_hanbing(ID)    --  杀：寒冰剑状态设置
    gamerun_status = "确认操作"
	jiaohu_text = "可按'确定'防止伤害并弃牌"
	gamerun_OK = false
	gamerun_OK_ptr = function()    -- 如果确认发动，执行的函数
	    gamerun_status = ""; set_hints("")
		if gamerun_OK then
	        funcptr_queue = {}
			add_funcptr(_nanman_send_msg, {char_juese[char_current_i].name, "发动了'寒冰剑'效果"})
	        add_funcptr(_sha_exe_5, {true, char_current_i, gamerun_target_selected, true})
		    consent_func_queue(0.6)
	    else
			funcptr_queue = {}
			_sha_tili_deduct(sha_va[1], sha_va[2], sha_va[3], true)
			consent_func_queue(0.6)
		end
	end
	platform.window:invalidate()
end
function _sha_sub1(va_list)
    local msg, card, hint_1, jineng
	local ID_s, ID_shoupai, ID_mubiao
	ID_shoupai = va_list[1]; ID_s = va_list[2]; ID_mubiao = va_list[3]
	jineng = false
	
	--  恢复状态  --
	--on.tabKey()
	card_selected = {}
	card_highlighted = 1
	platform.window:invalidate()
	
	if type(ID_shoupai) ~= "table" then
		card = char_juese[ID_s].shoupai[ID_shoupai]
		if card[1] == "杀" or card[1] == "火杀" or card[1] == "雷杀" then
			hint_1 = card[1]
		else
			hint_1 = "杀"
		end
	else
		card = {char_juese[ID_s].shoupai[ID_shoupai[1]], char_juese[ID_s].shoupai[ID_shoupai[2]]}
		hint_1 = "杀"
	end
	if gamerun_OK then
	    if #char_juese[ID_s].wuqi ~= 0 then
		    if char_juese[ID_s].wuqi[1] == "朱雀扇" then
		        hint_1 = "火杀"
			end
		end
	end
	
	if type(ID_shoupai) ~= "table" then
	
		msg = {char_juese[ID_s].name, "'", hint_1, "'", char_juese[ID_mubiao].name, " (", card[2], card[3], "的", card[1], ")"}
		push_message(table.concat(msg))
		msg = nil; collectgarbage()
	
		card_shanchu({ID_s, ID_shoupai})
	else    --  丈八蛇矛
		msg = {char_juese[ID_s].name, "'", hint_1, "'", char_juese[ID_mubiao].name, " (", card[1][2], card[1][3], "的", card[1][1], ", ", card[2][2], card[2][3], "的", card[2][1], ")"}
		push_message(table.concat(msg))
		msg = nil; collectgarbage()
	
		card_shanchu({ID_s, ID_shoupai[1]})
		
		local a = 0
		if ID_shoupai[1] < ID_shoupai[2] then
			a = 1
		end
		card_shanchu({ID_s, ID_shoupai[2] - a})
	end
end
function _sha_sub2()
    char_yisha = true
	char_sha_time = char_sha_time - 1
	char_hejiu = false
	char_wushi = false
	char_liegong = false
	gamerun_OK = false
	lianhuan_va = nil
	sha_va = nil
	txt_messages:setVisible(true)
    gamerun_status = ""
	guankan_s = 0
	jiaohu_text = "请您出牌"
    platform.window:invalidate()
end
function _sha_sub3()    --  杀：寒冰剑第二轮状态设置
	local p
	local flag = true
	gamerun_status = ""
	p = char_juese[guankan_d]
	if #p.shoupai < 1 and #p.fangju == 0 and #p.wuqi == 0 and #p.gongma == 0 and #p.fangma == 0 and #p.panding == 0 then
		_sha_sub2()
		return
	end
	
	funcptr_queue = {}
	add_funcptr(_sha_sub4)
	add_funcptr(_sha_exe_5, {true, char_current_i, gamerun_target_selected, false})
	consent_func_queue(0.6)
end
function _sha_sub4()    --  杀：用于延时

end

--  使用借刀杀人  --
function card_jiedao(ID_shoupai, ID_req, ID_s, ID_d)
	local msg, c_pos
	
	--  目标B在目标A攻击范围内时才能借刀  --
	if ID_s == ID_d then
		return false
	end
	if #char_juese[ID_s].wuqi ~= 0 then
	    if char_calc_distance(ID_s, ID_d) > card_wuqi_r[char_juese[ID_s].wuqi[1]] then
	        return false
	    end
	else
	    if char_calc_distance(ID_s, ID_d) > 1 then
	        return false
	    end
	end
	
	if ID_req == char_current_i then
		gamerun_status = "手牌生效中"
		jiaohu_text = ""
	
		card_highlighted = 1
		card_selected = {}
	end
	add_funcptr(_jiedao_sub1, {ID_shoupai, ID_req, ID_s, ID_d})
	
	if ID_s ~= char_current_i then
		--  有杀则自动出杀  --
		c_pos = card_chazhao(ID_s, "杀")
		if c_pos < 0 then
			c_pos = card_chazhao(ID_s, "雷杀")
		end
		if c_pos < 0 then
			c_pos = card_chazhao(ID_s, "火杀")
		end
		if c_pos > -1 then
	    	card_sha(c_pos, ID_s, ID_d, false)
		else	
	    	add_funcptr(_nanman_send_msg, {char_juese[ID_s].name, "放弃"})
			add_funcptr(_jiedao_swap, {ID_req, ID_s})
		end
	
		add_funcptr(_jiedao_sub2)
	else
		add_funcptr(_jiedao_beidong_xiangying_enter, {ID_shoupai, ID_req, ID_s, ID_d})
	end

	return true
end
function _jiedao_beidong_xiangying_enter(va_list)	--  借刀杀人：进入己方被动响应状态
	wuxie_va = va_list
	gamerun_status = "主动出牌-借刀"
	set_hints("请您出杀或'取消'放弃")
	platform.window:invalidate()
end
function _jiedao_beidong_chu(c_pos, va_list)	--  借刀杀人：己方出杀
	local ID_s, ID_d
	ID_s = va_list[3]; ID_d = va_list[4]

	gamerun_status = "手牌生效中"
	jiaohu_text = ""
	
	card_highlighted = 1
	card_selected = {}

	card_sha(c_pos, ID_s, ID_d, false)
	add_funcptr(_jiedao_sub2)
end
function _jiedao_beidong_fangqi(va_list)	--  借刀杀人：己方放弃
	local ID_s, ID_d
	ID_req = va_list[2]; ID_s = va_list[3]

	gamerun_status = "手牌生效中"
	jiaohu_text = ""
	
	card_highlighted = 1
	card_selected = {}

	add_funcptr(_nanman_send_msg, {char_juese[ID_s].name, "放弃"})
	add_funcptr(_jiedao_swap, {ID_req, ID_s})
	add_funcptr(_jiedao_sub2)
end
function _jiedao_swap(va_list)    --  借刀杀人：将目标A的武器交给借刀者
	local ID_req, ID_s
	local card, msg
	ID_req = va_list[1]; ID_s = va_list[2]
	card = char_juese[ID_s].wuqi
	
	table.insert(char_juese[ID_req].shoupai, char_juese[ID_s].wuqi)
	char_juese[ID_s].wuqi = {}
	
	msg = {char_juese[ID_req].name, "获得", char_juese[ID_s].name, "的武器'", card[2], card[3], "的", card[1], "'"}
	push_message(table.concat(msg))
end
function _jiedao_sub1(va_list)
	local ID_shoupai, ID_req, ID_s, ID_d
	ID_shoupai = va_list[1]; ID_req = va_list[2]; ID_s = va_list[3]; ID_d = va_list[4]

	msg = {char_juese[ID_req].name, "借", char_juese[ID_s].name, "的刀杀", char_juese[ID_d].name}
	push_message(table.concat(msg))
	card_shanchu({ID_req, ID_shoupai})
end
function _jiedao_sub2()
	char_wushi = false
	gamerun_OK = false
    gamerun_status = ""
	guankan_s = 0
	jiaohu_text = "请您出牌"
    platform.window:invalidate()
end