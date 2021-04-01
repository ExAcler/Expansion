
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
card_jiesuan = {{}, "", 0}		--  正在结算的牌 (参数1为牌，参数2为实际的牌名，参数3为手牌来源ID)
wugucards = {}		--  五谷丰登/弃牌阶段牌堆

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
		if ID_juese == char_acting_i and gamerun_huihe == "弃牌" then
			table.insert(wugucards, char_juese[ID_juese].shoupai[ID_shoupai])
		else
			card_add_qipai(char_juese[ID_juese].shoupai[ID_shoupai])
		end
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
end

--  在弃牌堆添加手牌  --
function card_add_qipai(card)
	if card ~= nil then
		--  去除卡牌的锦囊标志 (技能发动)  --
		if card[4] ~= nil then
			card[4] = nil
		end
		table.insert(card_qipai, card)
	end
end

--  游戏开始时，向所有角色分发4张手牌  --
function card_fenfa_init()
    local i

	for i = 1, 5 do
        card_fenfa({i, 4, false})
	end
end

--  当前顺位玩家摸牌  --
function card_mopai()
    local msg
	
	gamerun_huihe_set("摸牌")
	
    if game_skip_mopai == true then
	    msg = {char_juese[char_acting_i].name, "不能摸牌"}
		push_message(table.concat(msg))
		msg = nil
		return
	end
	
	local draw_number = 2
	
	if char_yongsi ~= nil then
		draw_number = draw_number + char_yongsi
		char_yongsi = nil
	end
	
	if char_yingzi == true then
		draw_number = draw_number + 1
		char_yingzi = false
	end
	
	if char_haoshi == true then
		draw_number = draw_number + 2
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
		char_tuxi = false
	end
	
	if draw_number > 0 then
		card_fenfa({char_acting_i, draw_number, true})
	end
end

--  统计玩家的实际手牌数 (剔除技能虚拟的无色无点牌)  --
function card_shoupai_stat(ID)
	local minus = 0
	for i = 1, #char_juese[ID].shoupai do
		if char_juese[ID].shoupai[i][2] == "" then
			minus = minus + 1
		end
	end

	return #char_juese[ID].shoupai - minus
end

--  手牌效果执行前进入结算区  --
function card_into_jiesuan(ID, ID_shoupai, actual_name, ID_laiyuan)
	card_jiesuan[1] = {}
	card_jiesuan[2] = actual_name
	card_jiesuan[3] = ID_laiyuan

	for i = #ID_shoupai, 1, -1 do
		local card = char_juese[ID].shoupai[ID_shoupai[i]]
		card_remove({ID, ID_shoupai[i]})

		--  如果是技能虚拟的无色无点牌则直接删除不进结算区  --
		if card[2] ~= "" then
			table.insert(card_jiesuan[1], card)
		end
	end
end

--  手牌结算完毕后从结算区移入弃牌堆  --
function card_out_jiesuan()
	local card_gone = false

	--  如果牌没被曹操拿走，或者不是虚拟牌  --
	if #card_jiesuan[1] > 0 then
		--  祝融巨象拿走南蛮入侵  --
		if card_jiesuan[2] == "南蛮入侵" then
			for i = 1, 5 do
				if char_juese[i].skill["巨象"] == "available" and i ~= card_jiesuan[3] then
					skills_juxiang(i)

					for j = 1, #card_jiesuan[1] do
						table.insert(char_juese[i].shoupai, card_jiesuan[1][j])
					end

					card_gone = true
					break
				end
			end
		end

		if card_gone == false then
			for i = 1, #card_jiesuan[1] do
				card_add_qipai(card_jiesuan[1][i])
			end
		end
	end

	card_jiesuan[1] = {}
	card_jiesuan[2] = ""
	card_jiesuan[3] = 0
end

--  弃牌阶段结算结束后将牌从弃牌阶段牌堆移入弃牌堆  --
function card_huihe_cards_into_qipai()
	for i = 1, #wugucards do
		card_add_qipai(wugucards[i])
	end

	wugucards = {}
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
		msg = {char_juese[char_acting_i].name, "丢弃'", char_juese[char_acting_i].shoupai[ID][2], char_juese[char_acting_i].shoupai[ID][3], "的", char_juese[char_acting_i].shoupai[ID][1], "'"}
		push_message(table.concat(msg))
		msg = nil; --collectgarbage()
	end
	card_shanchu({char_acting_i, ID})
end

--  角色死亡，弃置所有手牌  --
function card_qipai_all(ID, panding)
    local i, v, j, max_select
	
	max_select = #char_juese[ID].shoupai
	j = 0
	
	if max_select > 0 then
		for i = 1, max_select do
			if char_juese[ID].shoupai[i] ~= nil then
				add_funcptr(_qipai_sub2, {ID, i - j})
				j = j + 1
			end
		end
	end
	
	if panding and #char_juese[ID].panding ~= 0 then
		j = 0
		for i = 1, #char_juese[ID].panding do
			if char_juese[ID].panding[i] ~= nil then
				add_funcptr(_qipai_sub3, {ID, i - j})
				j = j + 1
			end
		end
	end
	
	if #char_juese[ID].wuqi ~= 0 then
		add_funcptr(_qipai_sub4, ID)
	end
	
	if #char_juese[ID].fangju ~= 0 then
		add_funcptr(_qipai_sub5, ID)
	end
	
	if #char_juese[ID].gongma ~= 0 then
		add_funcptr(_qipai_sub6, ID)
	end
	
	if #char_juese[ID].fangma ~= 0 then
		add_funcptr(_qipai_sub7, ID)
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
	msg = nil; --collectgarbage()
	
	if ID == char_acting_i and gamerun_huihe == "弃牌" then
		table.insert(wugucards, char_juese[ID].shoupai[cardID])
	else
		card_add_qipai(char_juese[ID].shoupai[cardID])
	end

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
	msg = nil; --collectgarbage()
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
		msg = nil; --collectgarbage()
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
		msg = nil; --collectgarbage()
	end

	if char_juese[ID].siwang == false then
		--  失去白银狮子，回复一点体力  --
		if char_juese[ID].fangju[1] == "白银狮" and char_juese[ID].tili < char_juese[ID].tili_max then
			push_message(table.concat({char_juese[ID].name, "失去白银狮子，回复1点体力"}))
			char_juese[ID].tili = char_juese[ID].tili + 1
			platform.window:invalidate()
		end
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
		msg = nil; --collectgarbage()
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
		msg = nil; --collectgarbage()
	end
	card_add_qipai(char_juese[ID].fangma)
    char_juese[ID].fangma = {}
end

function _napai_sub2(va_list)    --  获得手牌
    local msg
	local cardID, ID, ID_get, is_passive
	ID = va_list[1]; ID_get = va_list[2]; cardID = va_list[3]; is_passive = va_list[4]
	
	if char_juese[ID].shoupai[cardID] == nil then return end
	
	msg = {char_juese[ID_get].name, "获得了", char_juese[ID].name, "的一张手牌"}
	push_message(table.concat(msg))
	msg = nil; --collectgarbage()
	card = char_juese[ID].shoupai[cardID]
	table.insert(char_juese[ID_get].shoupai,card)
    table.remove(char_juese[ID].shoupai, cardID)
end
function _napai_sub3(va_list)    --  获得判定区
    local msg
	local cardID, ID, ID_get, is_passive
	ID = va_list[1]; ID_get = va_list[2]; cardID = va_list[3]; is_passive = va_list[4]
	
	if char_juese[ID].panding[cardID] == nil then return end
	
	msg = {char_juese[ID_get].name, "获得了", char_juese[ID].name, "判定区的'", char_juese[ID].panding[cardID][2], char_juese[ID].panding[cardID][3], "的", char_juese[ID].panding[cardID][1], "'"}
	push_message(table.concat(msg))
	msg = nil; --collectgarbage()
	card = char_juese[ID].panding[cardID]
	table.insert(char_juese[ID_get].shoupai,card)
    table.remove(char_juese[ID].panding, cardID)
end
function _napai_sub4(ID, ID_get, hide_msg, is_passive)    --  获得武器
    local msg
	
	if hide_msg ~= true then
		msg = {char_juese[ID_get].name, "获得了", char_juese[ID].name, "的武器'", char_juese[ID].wuqi[2], char_juese[ID].wuqi[3], "的", char_juese[ID].wuqi[1], "'"}
		push_message(table.concat(msg))
		msg = nil; --collectgarbage()
	end
	card = char_juese[ID].wuqi
	table.insert(char_juese[ID_get].shoupai,card)
    char_juese[ID].wuqi = {}
end
function _napai_sub5(ID, ID_get, hide_msg, is_passive)    --  获得防具
    local msg
	
	if hide_msg ~= true then
		msg = {char_juese[ID_get].name, "获得了", char_juese[ID].name, "的防具'", char_juese[ID].fangju[2], char_juese[ID].fangju[3], "的", char_juese[ID].fangju[1], "'"}
		push_message(table.concat(msg))
		msg = nil; --collectgarbage()
	end
	card = char_juese[ID].fangju
	--  失去白银狮子，回复一点体力  --
	if card[1] == "白银狮" and char_juese[ID].tili < char_juese[ID].tili_max then
		push_message(table.concat({char_juese[ID].name, "失去白银狮子，回复1点体力"}))
		char_juese[ID].tili = char_juese[ID].tili + 1
		platform.window:invalidate()
	end
	table.insert(char_juese[ID_get].shoupai,card)
    char_juese[ID].fangju = {}
end
function _napai_sub6(ID, ID_get, hide_msg, is_passive)    --  获得-1马
    local msg
	
	if hide_msg ~= true then
		msg = {char_juese[ID_get].name, "获得了", char_juese[ID].name, "的-1马'", char_juese[ID].gongma[2], char_juese[ID].gongma[3], "的", char_juese[ID].gongma[1], "'"}
		push_message(table.concat(msg))
		msg = nil; --collectgarbage()
	end
	card = char_juese[ID].gongma
	table.insert(char_juese[ID_get].shoupai,card)
    char_juese[ID].gongma = {}
end
function _napai_sub7(ID, ID_get, hide_msg, is_passive)    --  获得+1马
    local msg
	
	if hide_msg ~= true then
		msg = {char_juese[ID_get].name, "获得了", char_juese[ID].name, "的+1马'", char_juese[ID].fangma[2], char_juese[ID].fangma[3], "的", char_juese[ID].fangma[1], "'"}
		push_message(table.concat(msg))
		msg = nil; --collectgarbage()
	end
	card = char_juese[ID].fangma
	table.insert(char_juese[ID_get].shoupai,card)
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
function card_pindian(va_list)
	local ID_s, ID_mubiao, win_fp, keep_card, chosen_pindian_card_id

	ID_s = va_list[1]; ID_mubiao = va_list[2]; win_fp = va_list[3]; keep_card = va_list[4]; chosen_pindian_card_id = va_list[5]

	push_zhudong_queue(table.copy(funcptr_queue), funcptr_i)
	timer.stop()
	funcptr_queue = {}
	funcptr_i = 0

	pindianing = {}
	if ID_s == char_current_i or ID_mubiao == char_current_i then
		skills_enter("请选择拼点的牌", "", "进行拼点", "技能选择-拼点")
		gamerun_OK_pindian_ptr = function()
			set_hints("")
			gamerun_status = "手牌生效中"

			if ID_s == char_current_i then
				add_funcptr(card_into_pindian, {ID_s, card_highlighted})
				skills_losecard(ID_s, 1, true)
				add_funcptr(card_into_pindian, {ID_mubiao, ai_pindian_judge(ID_mubiao, ai_judge_same_identity(ID_mubiao, ID_s, false) ~= 1)})
				skills_losecard(ID_mubiao, 1, true)
			elseif ID_mubiao == char_current_i then
				if chosen_pindian_card_id == nil then
					add_funcptr(card_into_pindian, {ID_s, ai_pindian_judge(ID_s, true)})
				else
					add_funcptr(card_into_pindian, {ID_s, chosen_pindian_card_id})
				end
				skills_losecard(ID_s, 1, true)
				add_funcptr(card_into_pindian, {ID_mubiao, card_highlighted})
				skills_losecard(ID_mubiao, 1, true)
			end

			card_selected = {}
			card_highlighted = 1

			add_funcptr(card_pindian_judge, {ID_s, ID_mubiao, win_fp, keep_card})
			add_funcptr(_pindian_huifu)
			timer.start(0.6)
		end
	else
		if chosen_pindian_card_id == nil then
			add_funcptr(card_into_pindian, {ID_s, ai_pindian_judge(ID_s, true)})
		else
			add_funcptr(card_into_pindian, {ID_s, chosen_pindian_card_id})
		end
		skills_losecard(ID_s, 1, true)
		add_funcptr(card_into_pindian, {ID_mubiao, ai_pindian_judge(ID_mubiao, ai_judge_same_identity(ID_mubiao, ID_s, false) ~= 1)})
		skills_losecard(ID_mubiao, 1, true)
		
		add_funcptr(card_pindian_judge, {ID_s, ID_mubiao, win_fp, keep_card})
		add_funcptr(_pindian_huifu)
		timer.start(0.6)
	end
end
function _pindian_huifu()
	funcptr_queue, funcptr_i = pop_zhudong_queue()
end

--  手牌进入拼点区  --
function card_into_pindian(va_list)
	local ID, ID_card
	ID = va_list[1]; ID_card = va_list[2]

	local card = char_juese[ID].shoupai[ID_card]

	table.insert(pindianing, {char_juese[ID].shoupai[ID_card][1], char_juese[ID].shoupai[ID_card][2], char_juese[ID].shoupai[ID_card][3]})
	table.remove(char_juese[ID].shoupai, ID_card)
	push_message(table.concat({char_juese[ID].name, "的拼点牌是'", card[2], card[3], "的", card[1], "'"}))
end

--  拼点结算  --
function card_pindian_judge(va_list)
	local ID_s, ID_mubiao, win_fp, keep_card
	ID_s = va_list[1]; ID_mubiao = va_list[2]; win_fp = va_list[3]; keep_card = va_list[4]

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
	
	if not keep_card then
		card_add_qipai(pindianing[1])
		card_add_qipai(pindianing[2])
		pindianing = {}
	end

	if i > j then
		push_message(char_juese[ID_s].name .. "拼点获胜")
		win_fp(true, false)
	elseif i < j then
		push_message(char_juese[ID_mubiao].name .. "拼点获胜")
		win_fp(false, true)
	else
		push_message(char_juese[ID_s].name .. "与" .. char_juese[ID_mubiao].name .. "拼点均没赢")
		win_fp(false, false)
	end
end

--  判断卡牌类型  --
function card_get_leixing(name)
    if name == "杀" or name == "火杀" or name == "雷杀" or name == "闪" or name == "桃" or name == "酒" then
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

--  判断指定的牌是否是酒  --
function card_judge_if_jiu(ID, card_i)
	local card = char_juese[ID].shoupai[card_i]

	if card[1] == "酒" then
		return true
	end

	local yanse, huase, dianshu = ai_judge_cardinfo(ID, {card})
	if char_juese[ID].skill["酒池"] == "available" then
		if huase == "黑桃" then
			return true
		end
	end
end

--  判断指定的牌是否是杀  --
function card_judge_if_sha(ID, card_i)
	local card = char_juese[ID].shoupai[card_i]

	if card[1] == "杀" or card[1] == "火杀" or card[1] == "雷杀" then
		return true
	end

	local yanse, huase, dianshu = ai_judge_cardinfo(ID, {card})
	if char_juese[ID].skill["武圣"] == "available" then
		if huase == "红桃" or huase == "方块" then
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

	local yanse, huase, dianshu = ai_judge_cardinfo(ID, {card})
	if char_juese[ID].skill["倾国"] == "available" then
		if huase == "草花" or huase == "黑桃" then
			return true
		end
	end

	if char_juese[ID].skill["龙胆"] == "available" then
		if card[1] == "杀" or card[1] == "火杀" or card[1] == "雷杀" then
			return true
		end
	end
end

--  计算卡牌/技能使用限制  --
function card_if_d_limit(card, ID_s, ID_d)
    local v, p

	--  技能可以对自己使用，且需要指定目标数为1的情况  --
	if ID_s < 0 then
		if card == "青囊" then
			if char_juese[ID_d].tili == char_juese[ID_d].tili_max then
				return false
			end
		end

		return true
	end
	
    if card_get_leixing(card) == "延时类锦囊" then
		if card == "乐不思蜀" then
			return card_judge_le(ID_d)
		end

		if card == "兵粮寸断" then
			return card_judge_bingliang(ID_s, ID_d)
		end

		if card == "闪电" then
			return card_judge_shandian(ID_s)
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

	--  大乔流离  --
	if card == "流离" then
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

	--  鲁肃好施  --
	if card == "好施" then
		if skills_judge_haoshi(ID_d) == false then
			return false
		end
	end

	--  选择主公技  --
	if card == "主公技" then
		local lordskills = skills_judge_lordskill(ID_s, ID_d)
		if #lordskills == 0 then
			return false
		end
	end

	return true
end

--  出牌  --
function card_chupai(ID)
    local card, wuqi
	local ID_shoupai = {}

    if card_highlighted <= 0 then
		return false
	end
	
	card = char_juese[char_current_i].shoupai[card_highlighted][1]
	funcptr_queue = {}
	ID_shoupai = {card_highlighted}
	
    --  武器牌  --
	if card_get_leixing(card) == "武器" or card_get_leixing(card) == "防具" or card_get_leixing(card) == "+1马" or card_get_leixing(card) == "-1马" then
		card_arm({ID_shoupai[1], char_current_i})
		return true
    end
		
	--  乐不思蜀  --
	if card == "乐不思蜀" then
		return card_le({ID_shoupai[1], char_current_i, gamerun_target_selected})
    end
	
	--  兵粮寸断  --
	if card == "兵粮寸断" then
		return card_bingliang({ID_shoupai[1], char_current_i, gamerun_target_selected})
    end
	
	--  闪电  --
	if card == "闪电" then
		return card_shandian({ID_shoupai[1], char_current_i})
    end
	
	--  桃  --
	if card == "桃" then
	    if card_tao(ID_shoupai[1], char_current_i, char_current_i) then
		    consent_func_queue(0.6)
		end
		return false
	end
	
	--  无中生有  --
	if card == "无中生有" then
	    card_wuzhong(ID_shoupai, char_current_i)
		consent_func_queue(0.6)
		return false
	end
	
	--  桃园结义  --
	if card == "桃园结义" then
	    card_taoyuan(ID_shoupai, char_current_i)
		consent_func_queue(0.6)
		return false
	end
	
	--  过河拆桥  --
	if card == "过河拆桥" then
		if card_chai(ID_shoupai, char_current_i, gamerun_target_selected) then
		    consent_func_queue(0.6)
		end
		return false
    end
	
	--  顺手牵羊  --
	if card == "顺手牵羊" then
		if card_shun(ID_shoupai, char_current_i, gamerun_target_selected) then
		    consent_func_queue(0.6)
		end
		return false
    end
	
	--  南蛮入侵  --
	if card == "南蛮入侵" then
		card_nanman(ID_shoupai, char_current_i)
		consent_func_queue(0.6)
		return false
    end
	
	--  万箭齐发  --
	if card == "万箭齐发" then
		card_wanjian(ID_shoupai, char_current_i)
		consent_func_queue(0.6)
		return false
    end
	
	--  五谷丰登  --
	if card == "五谷丰登" then
		card_wugu(ID_shoupai, char_current_i)
		consent_func_queue(0.6)
		return false
    end
	
	--  决斗  --
	if card == "决斗" then
		card_juedou(ID_shoupai, char_current_i, gamerun_target_selected)
		consent_func_queue(0.6)
		return false
    end

	--  火攻  --
	if card == "火攻" then
		if card_huogong(ID_shoupai, char_current_i, gamerun_target_selected) then
		    consent_func_queue(0.6)
		end
		return false
    end
	
	--  酒  --
	if card == "酒" then
		return card_jiu({ID_shoupai[1], char_current_i})
    end
	
	--  杀  --
	if card == "杀" or card == "火杀" or card == "雷杀" then
		if card_sha(ID_shoupai, char_current_i, {gamerun_target_selected}, true) then
		    consent_func_queue(0.6)
		end
		return false
    end
	
	--  借刀杀人  --
	if card == "借刀杀人" then
		if card_jiedao(ID_shoupai[1], char_current_i, guankan_s, gamerun_target_selected) then
			consent_func_queue(0.6)
		end
		return false
	end
	
	--  铁索连环 (连环效果)  --
	if card == "铁锁连环" then
		if card_lian_lianhuan(ID_shoupai, char_current_i, guankan_s, gamerun_target_selected, ID) then
			consent_func_queue(0.6)
		end
		return false
	end
end

--  AI回合内出牌 (执行)  --
--  返回值：出牌是否成功  --
function card_chupai_ai(ID_shoupai, ID_s, ID_mubiao, ID_req, actual_name)
    local card, wuqi
    card = actual_name
	
    --  武器牌  --
	if card_get_leixing(card) == "武器" or card_get_leixing(card) == "防具" or card_get_leixing(card) == "+1马" or card_get_leixing(card) == "-1马" then
		add_funcptr(card_arm, {ID_shoupai[1], ID_s})
		return true
    end
		
	--  乐不思蜀  --
	if card == "乐不思蜀" then
		if card_judge_le(ID_mubiao) == true then
			add_funcptr(card_le, {ID_shoupai[1], ID_s, ID_mubiao})
			return true
		else
			return false
		end
    end
	
	--  兵粮寸断  --
	if card == "兵粮寸断" then
		if card_judge_bingliang(ID_s, ID_mubiao) == true then
			add_funcptr(card_bingliang, {ID_shoupai[1], ID_s, ID_mubiao})
			return true
		else
			return false
		end
    end
	
	--  闪电  --
	if card == "闪电" then
		if card_judge_shandian(ID_s) == true then
			add_funcptr(card_shandian, {ID_shoupai[1], ID_s})
			return true
		else
			return false
		end
    end
	
	--  桃  --
	if card == "桃" then
		return card_tao(ID_shoupai[1], ID_s, ID_s)
	end
	
	--  无中生有  --
	if card == "无中生有" then
	    card_wuzhong(ID_shoupai, ID_s)
		return true
	end
	
	--  桃园结义  --
	if card == "桃园结义" then
	    card_taoyuan(ID_shoupai, ID_s)
		return true
	end
	
	--  过河拆桥  --
	if card == "过河拆桥" then
		return card_chai(ID_shoupai, ID_s, ID_mubiao)
    end
	
	--  顺手牵羊  --
	if card == "顺手牵羊" then
		return card_shun(ID_shoupai, ID_s, ID_mubiao)
    end
	
	--  南蛮入侵  --
	if card == "南蛮入侵" then
		card_nanman(ID_shoupai, ID_s)
		return true
    end
	
	--  万箭齐发  --
	if card == "万箭齐发" then
		card_wanjian(ID_shoupai, ID_s)
		return true
    end
	
	--  五谷丰登  --
	if card == "五谷丰登" then
		card_wugu(ID_shoupai, ID_s)
		return true
    end
	
	--  决斗  --
	if card == "决斗" then
		card_juedou(ID_shoupai, ID_s, ID_mubiao)
		return true
    end

	--  火攻  --
	if card == "火攻" then
		return card_huogong(ID_shoupai, ID_s, ID_mubiao)
    end
	
	--  酒  --
	if card == "酒" then
		if char_jiu_time >= 1 then
			add_funcptr(card_jiu, {ID_shoupai[1], ID_s})
			return true
		else
			return false
		end
    end
	
	--  杀  --
	if card == "杀" or card == "火杀" or card == "雷杀" then
		return card_sha(ID_shoupai, ID_s, {ID_mubiao}, true)
    end
	
	--  借刀杀人  --
	if card == "借刀杀人" then
		return card_jiedao(ID_shoupai[1], ID_req, ID_s, ID_mubiao)
	end
	
	--  铁索连环 (连环效果)  --
	if card == "铁锁连环-连环" then
		return card_lian_lianhuan(ID_shoupai, ID_req, ID_s, ID_mubiao, ID_mubiao ~= nil)
	end

	--  铁索连环 (重铸效果)  --
	if card == "铁锁连环-重铸" then
		add_funcptr(card_lian_chongzhu, {ID_shoupai[1], ID_s})
		return true
	end

	return false
end

--  方天画戟出杀  --
function card_fangtian(n_mubiao, cancel_clicked)
	local ID_mubiao = {}
	funcptr_queue = {}

	if cancel_clicked == false then
		if n_mubiao >= 2 then
			table.insert(ID_mubiao, guankan_s)
		end
		if n_mubiao >= 3 then
			table.insert(ID_mubiao, selected_target_b)
		end
		if n_mubiao >= 4 then
			table.insert(ID_mubiao, selected_target_c)
		end
		table.insert(ID_mubiao, gamerun_target_selected)
	else
		if n_mubiao >= 2 then
			table.insert(ID_mubiao, selected_target_b)
		end
		if n_mubiao >= 3 then
			table.insert(ID_mubiao, selected_target_c)
		end
		table.insert(ID_mubiao, guankan_s)
	end

	if card_sha({card_highlighted}, char_current_i, ID_mubiao, true) then
		if gamerun_judge_fangtian() == true then
			push_message(char_juese[char_current_i].name .. "发动了 '方天画戟' 效果")
		end

		consent_func_queue(0.6)
		return true
	else
		return false
	end
end

--  丈八蛇矛出杀  --
function card_zhangba(n_mubiao, cancel_clicked)
	local wuqi
	if #char_juese[char_current_i].wuqi ~= 0 then
		wuqi = char_juese[char_current_i].wuqi[1]
	else
		wuqi = ""
	end

	local ID_shoupai = skills_get_selected_shoupai()
	local ID_mubiao = {}

	if cancel_clicked == false then
		if n_mubiao == 2 then
			table.insert(ID_mubiao, guankan_s)
		end
		table.insert(ID_mubiao, gamerun_target_selected)
	else
		table.insert(ID_mubiao, guankan_s)
	end
	
	funcptr_queue = {}
	if card_sha(ID_shoupai, char_current_i, ID_mubiao, true) then
		if wuqi == "丈八矛" then
			push_message(char_juese[char_current_i].name .. "发动了 '丈八蛇矛' 效果")
		end

		skills_cs()
		consent_func_queue(0.6)
	end
end

--  丈八蛇矛选牌  --
function card_zhangba_enter()
	if #char_juese[char_current_i].wuqi == 0 then
		return false
	end

	if char_juese[char_current_i].wuqi[1] ~= "丈八矛" then
		return false
	end

	gamerun_armskill_selected = true
	gamerun_OK = false
	skills_enter("请选择两张牌", "杀", "杀", "技能选择-多牌")
	
	gamerun_OK_ptr = function()
		if gamerun_status == "技能选择-目标" and gamerun_OK == true then
			if card_if_d_limit("杀", char_current_i, gamerun_target_selected) then
				if char_sha_add_target_able == true then
					guankan_s = gamerun_target_selected
					set_hints("请选择目标B或'取消'出杀")
					gamerun_status = "技能选择-目标B"
					gamerun_select_target("init")
					platform.window:invalidate()
				else
					card_zhangba(1, false)
				end
			end

			return
		end
		
		if gamerun_status == "技能选择-目标B" then
			if gamerun_OK == true then
				card_zhangba(2, false)
			else
				card_zhangba(1, false)
			end
		end
	end
	
	gamerun_tab_ptr = function()
		if table.getn2(card_selected) == 2 then
			skills_enter_target()

			if char_sha_add_target_able == true then
				set_hints("请选择目标A")
			end
		end
	end

	return true
end

--  装备武器  --
function card_arm(va_list)
	local ID_shoupai, ID
	ID_shoupai = va_list[1]; ID = va_list[2]

	gamerun_status = "手牌生效中"
	set_hints("")

    local card, msg
    card = char_juese[ID].shoupai[ID_shoupai]
	
	--  删除手牌  --
	card_remove({ID, ID_shoupai})
	
	if card_get_leixing(card[1]) == "武器" then
	    --  如果已有装备，丢弃之  --
		if #char_juese[ID].wuqi ~= 0 then
		    table.insert(card_qipai, char_juese[ID].wuqi)
			char_juese[ID].last_n_arm = char_juese[ID].last_n_arm + 1	--  触发枭姬
		end
        char_juese[ID].wuqi = card
	elseif card_get_leixing(card[1]) == "防具" then
	    if #char_juese[ID].fangju ~= 0 then
		    --  失去白银狮子，回复一点体力  --
			if char_juese[ID].fangju[1] == "白银狮" and char_juese[ID].tili < char_juese[ID].tili_max then
			    push_message(table.concat({char_juese[ID].name, "失去白银狮子，回复1点体力"}))
				char_juese[ID].tili = char_juese[ID].tili + 1
				platform.window:invalidate()
			end
		    table.insert(card_qipai, char_juese[ID].fangju)
			char_juese[ID].last_n_arm = char_juese[ID].last_n_arm + 1	--  触发枭姬
		end
	    char_juese[ID].fangju = card
	elseif card_get_leixing(card[1]) == "+1马" then
	    if #char_juese[ID].fangma ~= 0 then
		    table.insert(card_qipai, char_juese[ID].fangma)
			char_juese[ID].last_n_arm = char_juese[ID].last_n_arm + 1	--  触发枭姬
		end
	    char_juese[ID].fangma = card
	elseif card_get_leixing(card[1]) == "-1马" then
	    if #char_juese[ID].gongma ~= 0 then
		    table.insert(card_qipai, char_juese[ID].gongma)
			char_juese[ID].last_n_arm = char_juese[ID].last_n_arm + 1	--  触发枭姬
		end
		char_juese[ID].gongma = card
	end
	
	msg = {char_juese[ID].name, "装备'", card[2], card[3], "的", card[1], "'"}
	push_message(table.concat(msg))
	
	timer.stop()
	funcptr_queue = {}
	funcptr_i = 0

	skills_losecard(ID, 0, true)
	add_funcptr(_arm_sub1)

	timer.start(0.2)
end
function _arm_sub1()
	if char_acting_i == char_current_i then
		gamerun_status = ""
		jiaohu_text = "请您出牌"
		platform.window:invalidate()
	else
		ai_card_use(char_acting_i)

		gamerun_status = "AI出牌"
		jiaohu_text = ""
	end
end

--  八卦阵效果  --
function card_arm_bagua(ID, ID_attack)
    add_funcptr(push_message, table.concat({char_juese[ID].name, "发动了'八卦阵'效果"}))
	add_funcptr(_bagua_fan_panding, ID)

	--  如场上有司马懿或张角，询问其改判技能  --
	skills_guicai_guidao_ask(ID, ID_attack, ID, "八卦阵")
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

	local yanse, huase, dianshu = ai_judge_cardinfo(ID, {card_panding_card})

	--  曹丕颂威  --
	skills_judge_songwei(ID)

	if huase == "红桃" or huase == "方块" then
	    --  判定成功  --
		push_message(table.concat({char_juese[ID].name, "的'八卦阵'判定成功"}))
		success = true
	else
		push_message(table.concat({char_juese[ID].name, "的'八卦阵'判定失败"}))
		success = false
	end
	
	skills_card_qi_panding(ID)
	return success
end

--  使用乐不思蜀  --
function card_judge_le(ID_mubiao)
	--  对方判定区内已有乐不思蜀则不可使用  --
	for i = 1, #char_juese[ID_mubiao].panding do
	    if _panding_get_leixing(ID_mubiao, i) == "乐不思蜀" then return false end
	end

	return true
end
function card_le(va_list)
	local ID_shoupai, ID_s, ID_mubiao
	ID_shoupai = va_list[1]; ID_s = va_list[2]; ID_mubiao = va_list[3]

    local msg, card, v

	if card_judge_le(ID_mubiao) == false then
		return false
	end
	
	card = char_juese[ID_s].shoupai[ID_shoupai]
	--  大乔国色  --
	if card[1] ~= "乐不思蜀" then
		card[4] = "乐不思蜀"
		push_message(char_juese[ID_s].name.."发动了武将技能 '国色'")
	end

	gamerun_status = "手牌生效中"
	set_hints("")
	
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

	if card[1] == "乐不思蜀" then
		msg = {char_juese[ID_s].name, "给", char_juese[ID_mubiao].name, "安装了'", card[2], card[3], "的", card[1], "'"}
	else
		msg = {char_juese[ID_s].name, "给", char_juese[ID_mubiao].name, "安装了乐不思蜀 {", card[2], card[3], "的", card[1], ")"}
	end
	push_message(table.concat(msg))
	
	funcptr_queue = {}
	funcptr_i = 0

	skills_losecard(ID_s, 0, true)
	
	add_funcptr(_le_sub1)
	timer.start(0.2)

	return true
end
function _le_sub1()
	if char_acting_i == char_current_i then
		gamerun_status = ""
		jiaohu_text = "请您出牌"
		platform.window:invalidate()
	else
		ai_card_use(char_acting_i)

		gamerun_status = "AI出牌"
		jiaohu_text = ""
	end
end

--  使用兵粮寸断  --
function card_judge_bingliang(ID_s, ID_mubiao)
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

	for i = 1, #char_juese[ID_mubiao].panding do
	    if _panding_get_leixing(ID_mubiao, i) == "兵粮寸断" then return false end
	end

	return true
end
function card_bingliang(va_list)
	local ID_shoupai, ID_s, ID_mubiao
	ID_shoupai = va_list[1]; ID_s = va_list[2]; ID_mubiao = va_list[3]

    local msg, card, v
	
	if card_judge_bingliang(ID_s, ID_mubiao) == false then
		return false
	end

	gamerun_status = "手牌生效中"
	set_hints("")
	
    card = char_juese[ID_s].shoupai[ID_shoupai]
	--  徐晃断粮  --
	if card[1] ~= "兵粮寸断" then
		card[4] = "兵粮寸断"
		push_message(char_juese[ID_s].name.."发动了武将技能 '断粮'")
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
	
	if card[1] == "兵粮寸断" then
		msg = {char_juese[ID_s].name, "给", char_juese[ID_mubiao].name, "安装了'", card[2], card[3], "的", card[1], "'"}
	else
		msg = {char_juese[ID_s].name, "给", char_juese[ID_mubiao].name, "安装了兵粮寸断 {", card[2], card[3], "的", card[1], ")"}
	end
	push_message(table.concat(msg))
	
	funcptr_queue = {}
	funcptr_i = 0

	skills_losecard(ID_s, 0, true)

	add_funcptr(_bingliang_sub1)
	timer.start(0.2)

	return true
end
function _bingliang_sub1()
	if char_acting_i == char_current_i then
		gamerun_status = ""
		jiaohu_text = "请您出牌"
		platform.window:invalidate()
	else
		ai_card_use(char_acting_i)

		gamerun_status = "AI出牌"
		jiaohu_text = ""
	end
end

--  使用闪电  --
function card_judge_shandian(ID_s)
	--  己方判定区内已有闪电则不可使用  --
	for _, v in ipairs(char_juese[ID_s].panding) do
	    if v[1] == "闪电" then return false end
	end

	return true
end
function card_shandian(va_list)
	local ID_shoupai, ID_s
	ID_shoupai = va_list[1]; ID_s = va_list[2]

    local msg, card, v
	
	if card_judge_shandian(ID_s) == false then
		return false
	end
	
	gamerun_status = "手牌生效中"
	set_hints("")

    card = char_juese[ID_s].shoupai[ID_shoupai]
    table.insert(char_juese[ID_s].panding, 1, card)
	card_remove({ID_s, ID_shoupai})
	
	msg = {char_juese[ID_s].name, "安装了'", card[2], card[3], "的", card[1], "'"}
	push_message(table.concat(msg))
	
	funcptr_queue = {}
	funcptr_i = 0

	skills_losecard(ID_s, 0, true)
	
	add_funcptr(_shandian_sub1)
	timer.start(0.2)

	return true
end
function _shandian_sub1()
	if char_acting_i == char_current_i then
		gamerun_status = ""
		jiaohu_text = "请您出牌"
		platform.window:invalidate()
	else
		ai_card_use(char_acting_i)

		gamerun_status = "AI出牌"
		jiaohu_text = ""
	end
end

--  锦囊通用子过程 (显示 "xx 使用 xx")
function _card_sub1(va_list)
    local msg, card
	local ID_s, ID_shoupai, ID_mubiao, actual_name
	ID_shoupai = va_list[1]; ID_s = va_list[2]; ID_mubiao = va_list[3]; actual_name = va_list[4]
	
	--  恢复状态  --
	if char_acting_i == char_current_i then
		card_selected = {}
		card_highlighted = 1
		platform.window:invalidate()
	end
	
	if ID_mubiao ~= nil then
	    msg = table.concat({char_juese[ID_s].name, "对", char_juese[ID_mubiao].name, "使用", actual_name})
    else
		msg = table.concat({char_juese[ID_s].name, "使用", actual_name})
	end

	--  如果不是技能虚拟的无色无点牌，则显示牌面信息  --
	if char_juese[ID_s].shoupai[ID_shoupai[1]][2] ~= "" then
		msg = msg .. " ("
		for i = 1, #ID_shoupai do
			local card = char_juese[ID_s].shoupai[ID_shoupai[i]]
			msg = msg .. table.concat({card[2], card[3], "的", card[1]})
			if i ~= #ID_shoupai then
				msg = msg .. "，"
			end
		end
		msg = msg .. ")"
	end
	push_message(msg)
	
	card_into_jiesuan(ID_s, ID_shoupai, actual_name, ID_s)
end

--  使用无懈可击  --
function card_wuxie(actual_name, ID_s, ID_mubiao)
	add_funcptr(_wuxie_prepare, nil, nil, "无懈轮询开始")
	card_wuxie_query(actual_name, ID_s, ID_mubiao)
end
function _wuxie_prepare()
	timer.start(0.2)

	push_message("等待其他玩家响应")
	wuxie_in_effect = false
	wuxie_queue_jinnang = table.copy(funcptr_queue)
end
function _wuxie_prepare_2()
	timer.start(0.2)

	push_message("等待其他玩家响应")
end
function card_wuxie_query(actual_name, ID_s, ID_mubiao)	--  无懈可击：从锦囊作用目标开始，轮询确定各方是否出无懈可击
	local id = ID_mubiao
	for i = 1, 5 do
		if char_juese[id].siwang == false then
			if id == char_current_i then
				--  轮到己方出无懈可击，插入主动响应  --
				add_funcptr(card_wuxie_zhudong, {actual_name, ID_s, ID_mubiao})
			else
				add_funcptr(card_wuxie_ai, {id, actual_name, ID_s, ID_mubiao})
			end
		end

		id = id + 1
		if id > 5 then id = 1 end
	end

	--  此时已经没有其他人再出无懈，进行原有锦囊的结算  --
	add_funcptr(_wuxie_exe)
end
function card_wuxie_ai(va_list)  --  无懈可击：他方无懈可击出牌判断
	local id, actual_name, ID_s, ID_mubiao
	local msg
	id = va_list[1]; actual_name = va_list[2]; ID_s = va_list[3]; ID_mubiao = va_list[4]

	if char_juese[id].siwang == true then
		return
	end

	n = card_chazhao(id, "无懈可击")
	if n < 0 then
		if char_juese[id].skill["看破"] == "available" then
			n = _sha_chazhao_redblack(id, char_juese[id].shoupai, false)
		end
	end

	local should_use_wuxie = false
	if id == ID_mubiao then
		local name = actual_name
		if name == "决斗" or name == "过河拆桥" or name == "顺手牵羊" or name == "万箭齐发" or name == "南蛮入侵" or name == "借刀杀人" or name == "无懈可击" or name == "火攻" or name == "铁锁连环" then
			should_use_wuxie = true
		end
	else
		should_use_wuxie = ai_judge_wuxie(id, ID_s, ID_mubiao, actual_name)
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

		skills_losecard(id, 0, true)
		if char_juese[id].skill["集智"] == "available" or (char_juese[id].skill["极略"] == "available" and mark_ren[id] > 0) then
			add_funcptr(skills_jizhi, id)
		end

		--  延时至0.6秒  --
		add_funcptr(_wuxie_yanshi)
		add_funcptr(_wuxie_yanshi)

		add_funcptr(_wuxie_prepare_2)
		card_wuxie_query("无懈可击", id, ID_s)
		funcptr_i = 0
		timer.start(0.2)
	else
		msg = {char_juese[id].name, "放弃无懈"}
		push_message(table.concat(msg))
	end
end
function _wuxie_yanshi()

end
function card_wuxie_zhudong(va_list)	--  无懈可击：轮到己方出无懈可击时，状态转换至主动出牌
	local actual_name, ID_s, ID_mubiao
	local msg
	actual_name = va_list[1]; ID_s = va_list[2]; ID_mubiao = va_list[3]

	wuxie_queue_xiangying = table.copy(funcptr_queue)
	wuxie_queue_xiangying_i = funcptr_i + 1
	wuxie_va = {ID_s, ID_mubiao}
	timer.stop()
	funcptr_queue = {}

	gamerun_status = "主动出牌-无懈可击"
	
	msg = {actual_name, "是否无懈"}
	set_hints(table.concat(msg))
end
function _wuxie_zhudong_chu(card, i, va_list)	--  无懈可击：己方选择出无懈可击
	local ID_s, ID_mubiao
	ID_s = va_list[1]; ID_mubiao = va_list[2]
	
	gamerun_status = "手牌生效中"
	msg = {char_juese[char_current_i].name, "使用了'", card[2], card[3], "的", card[1], "'"}
	push_message(table.concat(msg))
	card_remove({char_current_i, i})
	card_add_qipai(card)
	wuxie_in_effect = not wuxie_in_effect

	--  出无懈可击后，原有轮询已失效；从原锦囊的发出对象（无懈可击的作用对象）本身开始重新轮询  --
	timer.stop()
	funcptr_queue = {}

	skills_losecard(char_current_i, 0, true)
	if char_juese[char_current_i].skill["集智"] == "available" or (char_juese[char_current_i].skill["极略"] == "available" and mark_ren[char_current_i] > 0) then
		add_funcptr(skills_jizhi, char_current_i)
	end	

	add_funcptr(_wuxie_prepare_2)
	card_wuxie_query("无懈可击", char_current_i, ID_s)
	funcptr_i = 0
	timer.start(0.2)
end
function _wuxie_zhudong_fangqi()	--  无懈可击：己方放弃出无懈可击
	gamerun_status = "手牌生效中"
	jiaohu_text = ""
	msg = {char_juese[char_current_i].name, "放弃无懈"}
	push_message(table.concat(msg))

	--  恢复原有的函数队列，继续原有轮询  --
	funcptr_queue = wuxie_queue_xiangying
	funcptr_i = wuxie_queue_xiangying_i
	timer.start(0.2)

	msg = nil; --collectgarbage()
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

		if wuxie_queue_jinnang[i].tag == "无懈执行完毕" or wuxie_queue_jinnang[i].tag == "下一次出牌" or wuxie_queue_jinnang[i].tag == "无懈执行前" and current_query == false then
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
--  ID_shoupai为单  --
function card_tao(ID_shoupai, ID_s, ID_mubiao)
	if char_juese[ID_mubiao].tili == char_juese[ID_mubiao].tili_max then
	    return false
	end
	
	gamerun_status = "手牌生效中"
	set_hints("")
	local card = char_juese[ID_s].shoupai[ID_shoupai]
	
	if card[1] ~= "桃" then
		add_funcptr(push_message, char_juese[ID_s].name .. "发动了武将技能 '青囊'")
	end

	add_funcptr(_tao_show, {ID_shoupai, ID_s, nil})
	skills_losecard(ID_s, 1, true)
	add_funcptr(_tao_sub, {ID_mubiao, false})

	return true
end
function _tao_sub(va_list)
	local ID_mubiao, binsi
    local msg
	
	ID_mubiao = va_list[1]; binsi = va_list[2]
	char_juese[ID_mubiao].tili = char_juese[ID_mubiao].tili + 1
	msg = {char_juese[ID_mubiao].name, "回复1点体力"}
	push_message(table.concat(msg))
	msg = nil; --collectgarbage()
	
	if char_acting_i == char_current_i then
		gamerun_status = ""
		set_hints("请您出牌")
	else
		gamerun_status = "AI出牌"
		set_hints("")

		ai_card_use(char_acting_i)
	end
end
function _tao_show(va_list)
    local msg
	local ID_s, ID_shoupai, ID_mubiao
	ID_shoupai = va_list[1]; ID_s = va_list[2]; ID_mubiao = va_list[3]

	if char_acting_i == char_current_i then
		card_selected = {}
		card_highlighted = 1
		platform.window:invalidate()
	end
	
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
	msg = nil; --collectgarbage()
	
	card_shanchu({ID_s, ID_shoupai})
end

--  使用无中生有  --
--  ID_shoupai为多  --
function card_wuzhong(ID_shoupai, ID_s)
	gamerun_status = "手牌生效中"
	set_hints("")
	
	add_funcptr(_card_sub1, {ID_shoupai, ID_s, nil, "无中生有"})

	skills_losecard(ID_s, #ID_shoupai, true)
	if char_juese[ID_s].skill["集智"] == "available" or (char_juese[ID_s].skill["极略"] == "available" and mark_ren[ID_s] > 0) then
		add_funcptr(skills_jizhi, ID_s)
	end

	card_wuxie("无中生有", ID_s, ID_s)

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
	card_out_jiesuan()

	if char_acting_i == char_current_i then
		gamerun_status = ""
    	set_hints("请您出牌")
	else
		gamerun_status = "AI出牌"
		jiaohu_text = ""
	end
end

--  使用铁索连环 (重铸效果)  --
--  ID_shoupai为单  --
function card_lian_chongzhu(va_list)
	local ID_shoupai, ID_s
	ID_shoupai = va_list[1]; ID_s = va_list[2]

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
	
	skills_losecard(ID_s, 0, false)
	
	if char_acting_i == char_current_i then
		set_hints("请您出牌")
		gamerun_status = ""
	else
		gamerun_status = "AI出牌"
		jiaohu_text = ""
	end
end

--  使用铁索连环 (连环效果)  --
--  ID_shoupai为多  --
function card_lian_lianhuan(ID_shoupai, ID_s, ID_first, ID_second, doubl)
	gamerun_status = "手牌生效中"
	set_hints("")
	
	add_funcptr(_card_sub1, {ID_shoupai, ID_s, nil, "铁锁连环"})

	skills_losecard(ID_s, #ID_shoupai, true)
	if char_juese[ID_s].skill["集智"] == "available" or (char_juese[ID_s].skill["极略"] == "available" and mark_ren[ID_s] > 0) then
		add_funcptr(skills_jizhi, ID_s)
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
			_lian_sub1(ID_s, ID_second)
			_lian_sub1(ID_s, ID_first)
		else
			_lian_sub1(ID_s, ID_first)
			_lian_sub1(ID_s, ID_second)
		end
	end
	
	funcptr_add_tag = "无懈执行完毕"
	add_funcptr(_lian_sub3)
	funcptr_add_tag = nil

	return true
end
function _lian_sub1(ID_s, ID_mubiao)
	funcptr_add_tag = "无懈执行前"
	add_funcptr(_nanman_send_msg,{char_juese[ID_s].name, "对", char_juese[ID_mubiao].name, "使用了铁锁连环"})
	funcptr_add_tag = nil
	card_wuxie("铁锁连环", ID_s, ID_mubiao)
	
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
	card_out_jiesuan()

	if char_acting_i == char_current_i then
    	gamerun_status = ""
		set_hints("请您出牌")
	else
		gamerun_status = "AI出牌"
		jiaohu_text = ""

		ai_card_use(char_acting_i)
	end
end

--  使用桃园结义  --
--  ID_shoupai为多  --
function card_taoyuan(ID_shoupai, ID_s)
    local i, id
	
    gamerun_status = "手牌生效中"
	set_hints("")

	add_funcptr(_card_sub1, {ID_shoupai, ID_s, nil, "桃园结义"})
	skills_losecard(ID_s, #ID_shoupai, true)
	if char_juese[ID_s].skill["集智"] == "available" or (char_juese[ID_s].skill["极略"] == "available" and mark_ren[ID_s] > 0) then
		add_funcptr(skills_jizhi, ID_s)
	end
	
	id = ID_s
	for i = 1, 5 do
		if char_juese[id].siwang == false then
			if char_juese[id].tili < char_juese[id].tili_max then
				funcptr_add_tag = "无懈执行前"
    			add_funcptr(_nanman_send_msg, {char_juese[ID_s].name, "对", char_juese[id].name, "使用了桃园结义"})
				funcptr_add_tag = nil

				card_wuxie("桃园结义", ID_s, id)

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
end
function _taoyuan_sub2()
	card_out_jiesuan()

	if char_acting_i == char_current_i then
    	gamerun_status = ""
		set_hints("请您出牌")
	else
		gamerun_status = "AI出牌"
		jiaohu_text = ""
	end
end

--  使用过河拆桥  --
--  ID_shoupai为多  --
function card_chai(ID_shoupai, ID_s, ID_mubiao)
    --  只能对有牌角色使用  --
	local p
	p = char_juese[ID_mubiao]
	
	if p.skill["谦逊"] == "available" then
		return false
	end
	
	if #p.shoupai < 1 and #p.fangju == 0 and #p.wuqi == 0 and #p.gongma == 0 and #p.fangma == 0 and #p.panding == 0 then
	    return false
	end

    gamerun_status = "手牌生效中"
	set_hints("")
	
	--  甘宁奇袭  --
	if char_juese[ID_s].shoupai[ID_shoupai[1]][1] ~= "过河拆桥" then
		add_funcptr(push_message, char_juese[ID_s].name .. "发动了武将技能 '奇袭'")

		add_funcptr(_card_sub1, {ID_shoupai, ID_s, ID_mubiao, "过河拆桥"})
		skills_losecard(ID_s, #ID_shoupai, true)

		add_funcptr(gamerun_wuqi_out_hand, char_current_i)
	else
		add_funcptr(_card_sub1, {ID_shoupai, ID_s, ID_mubiao, "过河拆桥"})
		skills_losecard(ID_s, #ID_shoupai, true)
	end
	if char_juese[ID_s].skill["集智"] == "available" or (char_juese[ID_s].skill["极略"] == "available" and mark_ren[ID_s] > 0) then
		add_funcptr(skills_jizhi, ID_s)
	end
	
	card_wuxie("过河拆桥", ID_s, ID_mubiao)

	funcptr_add_tag = "无懈无效结算"
	if ID_s == char_current_i then
		add_funcptr(_chai_sub1, {true, ID_s, ID_mubiao})
	else
		add_funcptr(_chai_ai, {ID_s, ID_mubiao})
		skills_losecard(ID_mubiao, 9999, true)
		add_funcptr(_chai_sub2)
	end
	funcptr_add_tag = "无懈有效结算"
	add_funcptr(_chai_sub2)
	funcptr_add_tag = nil
	
	return true
end
function _chai_ai(va_list)		--  过河拆桥：AI拆牌
	local ID_s, ID_d, is_owned
	ID_s = va_list[1]; ID_d = va_list[2]; is_owned = va_list[3]

	if is_owned then
		ai_judge_withdraw_other(ID_d,ID_s,true,false,false,false)
	else
		ai_judge_withdraw_other(ID_d,ID_s,true,true,false,false)
	end
end
function _chai_sub1(va_list)    --  过河拆桥/顺手牵羊初始化 (寒冰剑效果共用)
    local i
	local leixing, ID_s, ID_d, is_owned
	leixing = va_list[1]; ID_s = va_list[2]; ID_d = va_list[3]; is_owned = va_list[4]
	
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
	if is_owned ~= true then
		for i = 1, #char_juese[ID_d].panding do
			table.insert(gamerun_guankan_type, {"判定牌", i})
		end
	end
	--  设置状态信息  --
	gamerun_guankan_selected = 1
	guankan_s = ID_s
	guankan_d = ID_d
	
	txt_messages:setVisible(false)
	platform.window:invalidate()
end
function _chai_sub2()
	card_out_jiesuan()

	if char_acting_i == char_current_i then
    	txt_messages:setVisible(true)
    	gamerun_status = ""
    	set_hints("请您出牌")
	else
		gamerun_status = "AI出牌"
		jiaohu_text = ""

		ai_card_use(char_acting_i)
	end
end

--  使用顺手牵羊  --
--  ID_shoupai为多  --
function card_shun(ID_shoupai, ID_s, ID_mubiao)
    --  只能对距离 1 以内、有牌角色使用  --
	local p
	p = char_juese[ID_mubiao]
	
	if p.skill["谦逊"] == "available" then
		return false
	end
	
	if (char_juese[ID_s].skill["奇才"] ~= "available" and char_calc_distance(ID_s, ID_mubiao) > 1) or #p.shoupai < 1 and #p.fangju == 0 and #p.wuqi == 0 and #p.gongma == 0 and #p.fangma == 0 and #p.panding == 0 then
	    return false
	end

    gamerun_status = "手牌生效中"
	set_hints("")

    add_funcptr(_card_sub1, {ID_shoupai, ID_s, ID_mubiao, "顺手牵羊"})
	skills_losecard(ID_s, #ID_shoupai, true)
	if char_juese[ID_s].skill["集智"] == "available" or (char_juese[ID_s].skill["极略"] == "available" and mark_ren[ID_s] > 0) then
		add_funcptr(skills_jizhi, ID_s)
	end

	card_wuxie("顺手牵羊", ID_s, ID_mubiao)

	funcptr_add_tag = "无懈无效结算"
	if ID_s == char_current_i then
		add_funcptr(_chai_sub1, {false, ID_s, ID_mubiao})
	else
		add_funcptr(_shun_ai, {ID_s, ID_mubiao})
		skills_losecard(ID_mubiao, 9999, true)
		add_funcptr(_chai_sub2)
	end
	funcptr_add_tag = "无懈有效结算"
	add_funcptr(_chai_sub2)
	funcptr_add_tag = nil

	return true
end
function _shun_ai(va_list)		--  顺手牵羊：AI顺牌
	local ID_s, ID_d, is_owned
	ID_s = va_list[1]; ID_d = va_list[2]; is_owned = va_list[3]

	if is_owned then
		ai_judge_withdraw_other(ID_d,ID_s,true,false,true,false)
	else
		ai_judge_withdraw_other(ID_d,ID_s,true,true,true,false)
	end
end
function _shun_sub2()
	card_out_jiesuan()

	if char_acting_i == char_current_i then
    	txt_messages:setVisible(true)
    	gamerun_status = ""
		set_hints("请您出牌")
	else
		gamerun_status = "AI出牌"
		jiaohu_text = ""
	end
end

--  执行过河拆桥/顺手牵羊动作  --
function card_chai_shun_exe(va_list)
	local leixing, ID_selected, ID_s, ID_d
	leixing = va_list[1]; ID_selected = va_list[2]; ID_s = va_list[3]; ID_d = va_list[4]

    local id, msg, card
	gamerun_status = "手牌生效中"
	set_hints("")

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
			msg = nil; card = nil; --collectgarbage()
		else    -- 顺
		    table.insert(char_juese[ID_s].shoupai, char_juese[ID_d].shoupai[id])
			card_remove({ID_d, id})
			
			msg = {char_juese[ID_s].name, "获得", char_juese[ID_d].name, "的一张牌"}
			push_message(table.concat(msg))
			msg = nil; --collectgarbage()
		end
	end
	if gamerun_guankan_type[ID_selected][1] == "防御马" then
	    if leixing then    -- 拆
		    card = char_juese[ID_d].fangma
		    card_add_qipai(card)
	        char_juese[ID_d].fangma = {}
			
			msg = {char_juese[ID_s].name, "弃掉", char_juese[ID_d].name, "的马'", card[2], card[3], "的", card[1], "'"}
			push_message(table.concat(msg))
			msg = nil; card = nil; --collectgarbage()
		else    -- 顺
		    card = char_juese[ID_d].fangma
		    table.insert(char_juese[ID_s].shoupai, card)
			char_juese[ID_d].fangma = {}
			
			msg = {char_juese[ID_s].name, "获得", char_juese[ID_d].name, "的马'", card[2], card[3], "的", card[1], "'"}
			push_message(table.concat(msg))
			msg = nil; card = nil; --collectgarbage()
		end
	end
	if gamerun_guankan_type[ID_selected][1] == "攻击马" then
	    if leixing then    -- 拆
		    card = char_juese[ID_d].gongma
		    card_add_qipai(card)
	        char_juese[ID_d].gongma = {}
			
			msg = {char_juese[ID_s].name, "弃掉", char_juese[ID_d].name, "的马'", card[2], card[3], "的", card[1], "'"}
			push_message(table.concat(msg))
			msg = nil; card = nil; --collectgarbage()
		else    -- 顺
		    card = char_juese[ID_d].gongma
		    table.insert(char_juese[ID_s].shoupai, card)
			char_juese[ID_d].gongma = {}
			
			msg = {char_juese[ID_s].name, "获得", char_juese[ID_d].name, "的马'", card[2], card[3], "的", card[1], "'"}
			push_message(table.concat(msg))
			msg = nil; card = nil; --collectgarbage()
		end
	end
	if gamerun_guankan_type[ID_selected][1] == "武器" then
	    if leixing then    -- 拆
		    card = char_juese[ID_d].wuqi
		    card_add_qipai(card)
	        char_juese[ID_d].wuqi = {}
			
			msg = {char_juese[ID_s].name, "弃掉", char_juese[ID_d].name, "的武器'", card[2], card[3], "的", card[1], "'"}
			push_message(table.concat(msg))
			msg = nil; card = nil; --collectgarbage()
		else    -- 顺
		    card = char_juese[ID_d].wuqi
		    table.insert(char_juese[ID_s].shoupai, card)
			char_juese[ID_d].wuqi = {}
			
			msg = {char_juese[ID_s].name, "获得", char_juese[ID_d].name, "的武器'", card[2], card[3], "的", card[1], "'"}
			push_message(table.concat(msg))
			msg = nil; card = nil; --collectgarbage()
		end
	end
	if gamerun_guankan_type[ID_selected][1] == "防具" then
	    if leixing then    -- 拆
		    card = char_juese[ID_d].fangju
			
		    card_add_qipai(card)
	        char_juese[ID_d].fangju = {}
			
			msg = {char_juese[ID_s].name, "弃掉", char_juese[ID_d].name, "的防具'", card[2], card[3], "的", card[1], "'"}
			push_message(table.concat(msg))
			msg = nil; --collectgarbage()
		else    -- 顺
		    card = char_juese[ID_d].fangju
		    table.insert(char_juese[ID_s].shoupai, card)
			char_juese[ID_d].fangju = {}
			
			msg = {char_juese[ID_s].name, "获得", char_juese[ID_d].name, "的防具'", card[2], card[3], "的", card[1], "'"}
			push_message(table.concat(msg))
			msg = nil; --collectgarbage()
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
			msg = nil; card = nil; --collectgarbage()
		else    -- 顺
		    card = char_juese[ID_d].panding[gamerun_guankan_type[ID_selected][2]]
		    table.insert(char_juese[ID_s].shoupai, card)
			table.remove(char_juese[ID_d].panding, gamerun_guankan_type[ID_selected][2])
			
			msg = {char_juese[ID_s].name, "获得", char_juese[ID_d].name, "的判定牌'", card[2], card[3], "的", card[1], "'"}
			push_message(table.concat(msg))
			msg = nil; card = nil; --collectgarbage()
		end
	end

	txt_messages:setVisible(true)
	platform.window:invalidate()
end

--  使用南蛮入侵  --
--  ID_shoupai为多  --
function card_nanman(ID_shoupai, _ID_s)
    local i, id, ID_s
	local source_card = char_juese[_ID_s].shoupai[ID_shoupai]
	
	ID_s = _ID_s
    gamerun_status = "手牌生效中"
	jiaohu_text = ""

	add_funcptr(_card_sub1, {ID_shoupai, ID_s, nil, "南蛮入侵"})
	skills_losecard(ID_s, #ID_shoupai, true)
	if char_juese[ID_s].skill["集智"] == "available" or (char_juese[ID_s].skill["极略"] == "available" and mark_ren[ID_s] > 0) then
		add_funcptr(skills_jizhi, ID_s)
	end

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
		if char_juese[id].siwang == false and char_juese[id].skill["祸首"] ~= "available" and char_juese[id].skill["巨象"] ~= "available" and id ~= _ID_s then
			funcptr_add_tag = "无懈执行前"
    		add_funcptr(_nanman_send_msg, {char_juese[ID_s].name, "对", char_juese[id].name, "使用了南蛮入侵"})
			funcptr_add_tag = nil

			card_wuxie("南蛮入侵", ID_s, id)

			if id ~= char_current_i then
				_nanman_AI(ID_s, id)
			else
				_nanman_zhudong(ID_s)
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
function _nanman_AI(ID_s, ID_mubiao)    --  南蛮入侵：响应AI (临时)
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
		skills_losecard(ID_mubiao, 1, true)
	else
	    add_funcptr(_nanman_send_msg, {char_juese[ID_mubiao].name, "放弃"})
		char_tili_deduct({1, ID_mubiao, ID_s, "普通", ID_mubiao, nil, true})
	end

	funcptr_add_tag = nil
end
function _nanman_zhudong(ID_s)		--  南蛮入侵：己方主动出牌
	funcptr_add_tag = "无懈无效结算"
	
	if _nanman_judge_mian(char_current_i) == true then
		funcptr_add_tag = nil
		return
	end

	add_funcptr(_nanman_zhudong_enter, ID_s)
	funcptr_add_tag = nil
end
function _nanman_zhudong_enter(ID_s)	--  南蛮入侵：进入己方主动出牌状态
	push_zhudong_queue(table.copy(funcptr_queue), funcptr_i)
	wuxie_va = ID_s
	timer.stop()
	funcptr_queue = {}
	funcptr_i = 0

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
	skills_losecard(char_current_i, 1, true)

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
	funcptr_queue, funcptr_i = pop_zhudong_queue()
end
function _nanman_send_msg(msg)    --  南蛮入侵：发送游戏状态信息
	push_message(table.concat(msg))
end
function _nanman_sha(va_list)    --  南蛮入侵：实际出杀
    local ID_mubiao, c_pos, msg, card
	ID_mubiao = va_list[1]; c_pos = va_list[2]
	
	card = table.copy(char_juese[ID_mubiao].shoupai[c_pos])
	card_add_qipai(card)
	card_remove({ID_mubiao, c_pos})

	if ID_mubiao == char_current_i then
		card_selected = {}
		card_highlighted = 1
	end
	
	msg = {char_juese[ID_mubiao].name, "使用'", card[2], card[3], "的", card[1], "'"}
	push_message(table.concat(msg))
end
function _nanman_sub1()
	card_out_jiesuan()

	if char_acting_i == char_current_i then
    	gamerun_status = ""
		jiaohu_text = "请您出牌"
		platform.window:invalidate()
	else
		gamerun_status = "AI出牌"
		jiaohu_text = ""

		ai_card_use(char_acting_i)
	end
end

--  使用万箭齐发  --
--  ID_shoupai为多  --
function card_wanjian(ID_shoupai, ID_s)
    local i, id, msg
	
    gamerun_status = "手牌生效中"
	jiaohu_text = ""
	
	if #ID_shoupai > 1 then
		msg = table.concat({char_juese[ID_s].name, "发动了武将技能 '乱击'"})
		add_funcptr(push_message, msg)
	end

	add_funcptr(_card_sub1, {ID_shoupai, ID_s, nil, "万箭齐发"})
	skills_losecard(ID_s, #ID_shoupai, true)
	if char_juese[ID_s].skill["集智"] == "available" or (char_juese[ID_s].skill["极略"] == "available" and mark_ren[ID_s] > 0) then
		add_funcptr(skills_jizhi, ID_s)
	end

	id = ID_s + 1
	if id > 5 then id = 1 end
	for i = 1, 4 do
	    if char_juese[id].siwang == false then
			funcptr_add_tag = "无懈执行前"
    		add_funcptr(_nanman_send_msg, {char_juese[ID_s].name, "对", char_juese[id].name, "使用了万箭齐发"})
			funcptr_add_tag = nil

			card_wuxie("万箭齐发", ID_s, id)

			funcptr_add_tag = "无懈无效结算"
			add_funcptr(_wanjian_exe, {ID_s, id})
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
	local ID_s, ID_mubiao
	ID_s = va_list[1]; ID_mubiao = va_list[2]

	if _wanjian_judge_mian(ID_mubiao) == true then
		return
	end

	push_zhudong_queue(table.copy(funcptr_queue), funcptr_i)
	timer.stop()
	funcptr_queue = {}
	funcptr_i = 0

	--  曹操护驾  --
	if char_juese[ID_mubiao].skill["护驾"] == "available" then
		add_funcptr(skills_hujia_req_side, {ID_mubiao, "万箭齐发", {ID_s, ID_mubiao}})
	end

	local card = table.copy(char_juese[ID_mubiao].fangju)
	if char_juese[ID_mubiao].skill["八阵"] == "available" and #card == 0 then
		card[1] = "八卦阵"
	end

	if #card ~= 0 then
		if card[1] == "八卦阵" then
			if char_juese[ID_mubiao].skill["八阵"] == "available" then
				add_funcptr(push_message, table.concat({char_juese[ID_mubiao].name, "触发了武将技能 '八阵'"}))
			end
			card_arm_bagua(ID_mubiao, ID_s)
		end
	end
	
	add_funcptr(_wanjian_jiesuan, {ID_s, ID_mubiao, card})
	timer.start(0.6)
end
function _wanjian_shan_replaced(ID_s, ID_mubiao)
	--  张角雷击  --
	if char_juese[ID_mubiao].skill["雷击"] == "available" then
		add_funcptr(skills_leiji, {ID_mubiao, ID_s})
	end

	add_funcptr(_wanjian_huifu)
end
function _wanjian_jiesuan(va_list)
	local ID_s, ID_mubiao, fangju_card
	ID_s = va_list[1]; ID_mubiao = va_list[2]; fangju_card = va_list[3]

	timer.stop()
	funcptr_queue = {}
	funcptr_i = 0

	local yanshi = false

	if #fangju_card ~= 0 then
		if fangju_card[1] == "八卦阵" then
			if _bagua_jiesuan(ID_mubiao) then
				_wanjian_shan_replaced(ID_s, ID_mubiao)
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

			--  张角雷击  --
			if char_juese[ID_mubiao].skill["雷击"] == "available" then
				add_funcptr(skills_leiji, {ID_mubiao, ID_s})
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
--  ID_shoupai为多  --
function card_wugu(ID_shoupai, ID_s)
	local card = char_juese[ID_s].shoupai[ID_shoupai]
    gamerun_status = "手牌生效中"
	jiaohu_text = ""

	add_funcptr(_card_sub1, {ID_shoupai, ID_s, nil, "五谷丰登"})
	skills_losecard(ID_s, #ID_shoupai, true)
	if char_juese[ID_s].skill["集智"] == "available" or (char_juese[ID_s].skill["极略"] == "available" and mark_ren[ID_s] > 0) then
		add_funcptr(skills_jizhi, ID_s)
	end

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

	_wugu_get_card_exe(ID_s)
end
function _wugu_zhudong_enter()		--  五谷丰登：进入己方选择模式
	push_zhudong_queue(table.copy(funcptr_queue), funcptr_i)
	funcptr_queue = {}
	funcptr_i = 0
	timer.stop()

	gamerun_status = "牌堆选择-五谷"
	jiaohu_text = "五谷丰登"

	gamerun_guankan_selected = 1
	txt_messages:setVisible(false)
	platform.window:invalidate()
end
function _wugu_huifu()	--  无懈可击：己方执行完毕恢复原有函数队列
	funcptr_queue, funcptr_i = pop_zhudong_queue()
	funcptr_i = funcptr_i + 1
	timer.start(0.6)
end
function _wugu_mopai()	--  五谷丰登：从主牌堆摸一张牌到五谷丰登牌堆
	if #card_yixi == 0 then
		card_xipai(true)
	end
	table.insert(wugucards, card_yixi[1])
	table.remove(card_yixi, 1)
end
function _wugu_get_card_exe(ID_s)		--  五谷丰登：执行获得五谷丰登手牌动作
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

			card_wuxie("五谷丰登", ID_s, ID_mubiao)

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
	wugucards = nil; --collectgarbage()
end

--  使用决斗  --
--  ID_shoupai为多  --
function card_juedou(ID_shoupai, ID_s, ID_mubiao)
	gamerun_status = "手牌生效中"
	jiaohu_text = ""

	add_funcptr(_card_sub1, {ID_shoupai, ID_s, ID_mubiao, "决斗"})
	skills_losecard(ID_s, #ID_shoupai, true)
	if char_juese[ID_s].skill["集智"] == "available" or (char_juese[ID_s].skill["极略"] == "available" and mark_ren[ID_s] > 0) then
		add_funcptr(skills_jizhi, ID_s)
	end
	
	if #ID_shoupai == 1 then
		local card = char_juese[ID_s].shoupai[ID_shoupai[1]]

		local yanse, huase, dianshu = ai_judge_cardinfo(ID_s, {card})
		--  孙策使用红色决斗，摸一张牌  --
		if char_juese[ID_s].skill["激昂"] == "available" and yanse == "红色" then
			add_funcptr(skills_jiang, ID_s)
		end

		yanse, huase, dianshu = ai_judge_cardinfo(ID_mubiao, {card})
		--  孙策被红色决斗，摸一张牌  --
		if char_juese[ID_mubiao].skill["激昂"] == "available" and yanse == "红色" then
			add_funcptr(skills_jiang, ID_mubiao)
		end
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
	
	--  非技能模拟的决斗才可被无懈  --
	if char_juese[ID_s].shoupai[ID_shoupai[1]][2] ~= "" then
		card_wuxie("决斗", ID_s, ID_mubiao)
	end
	
	funcptr_add_tag = "无懈无效结算"
	if ID_mubiao ~= char_current_i then
		if ID_s == char_current_i then
			--  AI与己方互杀，己方挑起决斗  --
			_juedou_exe(ID_s, ID_mubiao, false)
		else
			--  AI之间互杀  --
			emulated_shoupai_s = table.copy(char_juese[ID_s].shoupai)
			for i = #ID_shoupai, 1, -1 do
				table.remove(emulated_shoupai_s, ID_shoupai[i])
			end
			emulated_shoupai_mubiao = table.copy(char_juese[ID_mubiao].shoupai)

			_juedou_exe(ID_s, ID_mubiao, true, emulated_shoupai_s, emulated_shoupai_mubiao)
		end
	else
		--  AI与己方互杀，AI挑起决斗  --
		_juedou_xiangying(ID_s, ID_mubiao)
	end
	funcptr_add_tag = nil

	if char_juese[ID_s].shoupai[ID_shoupai[1]][2] ~= "" then
		funcptr_add_tag = "无懈有效结算"
		add_funcptr(_chai_sub2)
		funcptr_add_tag = nil
	end
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
		add_funcptr(push_message, char_juese[ID_s].name .. "触发了武将技能 '无双'")
	end
	
	--  自动出杀  --
	while true do
		c_pos = ai_chazhao_sha(ID_mubiao, shoupai_copy)
		if c_pos > -1 then
			add_funcptr(_juedou_sha, {ID_mubiao, ID_s, c_pos})
			skills_losecard(ID_mubiao, 9999, true)

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
			add_funcptr(_juedou_sub1, nil)
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
	wuxie_va = {ID_mubiao, ID_s}

	add_funcptr(_juedou_sha, {ID_mubiao, ID_s, c_pos})
	skills_losecard(ID_mubiao, 1, true)
	
	if char_xiangying_2 == false then
		_juedou_exe(ID_mubiao, ID_s, false)
	else
		char_xiangying_2 = false
		add_funcptr(_juedou_xiangying_enter, {ID_s, ID_mubiao})
	end
end
function _juedou_exe_fangqi(ID_s, ID_mubiao)    --  决斗：己方放弃
    gamerun_status = "手牌生效中"
	jiaohu_text = ""
	
	add_funcptr(_nanman_send_msg, {char_juese[ID_mubiao].name, "放弃"})
	
	char_tili_deduct({1, ID_mubiao, ID_s, "普通", ID_mubiao})
	add_funcptr(_juedou_sub1, nil)
end
function _juedou_xiangying(ID_s, ID_mubiao)
	if char_juese[ID_s].skill["无双"] == "available" then
		add_funcptr(push_message, char_juese[ID_s].name .. "触发了武将技能 '无双'")
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
	
	card = table.copy(char_juese[ID_s].shoupai[c_pos])
	card_add_qipai(card)
	card_remove({ID_s, c_pos})
	
	msg = {char_juese[ID_s].name, "'杀'", char_juese[ID_mubiao].name, " (", card[2], card[3], "的", card[1], ")"}
	push_message(table.concat(msg))
end
function _juedou_sub1()
	card_out_jiesuan()

	if char_acting_i == char_current_i then
    	gamerun_status = ""
		jiaohu_text = "请您出牌"
    	platform.window:invalidate()
	else
		gamerun_status = "AI出牌"
		jiaohu_text = ""

		ai_card_use(char_acting_i)
	end
end

--  使用火攻  --
--  ID_shoupai为多  --
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
	if #ID_shoupai > 1 then
		add_funcptr(push_message,char_juese[ID_s].name.. "发动了武将技能 '火计'")
	end

	add_funcptr(_card_sub1, {ID_shoupai, ID_s, ID_mubiao, "火攻"})
	skills_losecard(ID_s, #ID_shoupai, true)
	if char_juese[ID_s].skill["集智"] == "available" or (char_juese[ID_s].skill["极略"] == "available" and mark_ren[ID_s] > 0) then
		add_funcptr(skills_jizhi, ID_s)
	end

	local emulated_source_shoupai = table.copy(char_juese[ID_s].shoupai)
	for i = #ID_shoupai, 1, -1 do
		table.remove(emulated_source_shoupai, ID_shoupai[i])
	end

	card_wuxie("火攻", ID_s, ID_mubiao)
	
	funcptr_add_tag = "无懈无效结算"
	if ID_mubiao ~= char_current_i then
		if ID_s == char_current_i then
			--  己方火攻AI  --
			_huogong_exe_1(ID_s, ID_mubiao, emulated_source_shoupai, false)
		else
			--  AI互相火攻  --
			_huogong_exe_1(ID_s, ID_mubiao, emulated_source_shoupai, true)
		end
	else
		--  AI火攻己方  --
		_huogong_beidong_exe_1(ID_s, ID_mubiao)
	end
	funcptr_add_tag = "无懈有效结算"
	add_funcptr(_chai_sub2)
	funcptr_add_tag = nil
	
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
function _huogong_beidong_exe_2(ID_s, ID_mubiao, emulated_source_shoupai, c_pos)		--  火攻 (己方被动) 执行二：攻方出牌并造成伤害
	gamerun_status = "手牌生效中"
	jiaohu_text = ""
	
	if ID_mubiao == char_current_i then
		card_selected = {}
		card_highlighted = 1
		platform.window:invalidate()
	end

	local card_source = table.copy(char_juese[ID_mubiao].shoupai[c_pos])
	add_funcptr(_nanman_send_msg, {char_juese[ID_mubiao].name, "展示了'", card_source[2], card_source[3], "的", card_source[1], "'"})
	
	if ID_s ~= ID_mubiao then
		local yanse, huase, dianshu = ai_judge_cardinfo(ID_mubiao, {card_source})
		card_t_pos = ai_card_search(ID_s, huase, 1, emulated_source_shoupai)
	else
		card_t_pos = {c_pos}
	end
	if #card_t_pos == 0 then
		add_funcptr(_nanman_send_msg, {char_juese[ID_s].name, "放弃"})
    	add_funcptr(_huogong_sub1, nil)
	else
		add_funcptr(_huogong_qipai, {ID_s, ID_mubiao, card_t_pos[1]})
		skills_losecard(ID_s, 1, true)

		char_tili_deduct({1, ID_mubiao, ID_s, "火", ID_mubiao})
		add_funcptr(_huogong_sub1, nil)
	end
end
function _huogong_exe_1(ID_s, ID_mubiao, emulated_source_shoupai, between_ai)    --  火攻执行一：被攻方展示手牌 (临时AI)
    local card, card_chosen, i
	
	card = char_juese[ID_mubiao].shoupai
	i = math.random(#card)
	if between_ai then
		card_chosen = i
	else
		local yanse, huase, dianshu = ai_judge_cardinfo(ID_mubiao, {card[i]})
   		guankan_s = huase
	end

	if between_ai then
		_huogong_beidong_exe_2(ID_s, ID_mubiao, emulated_source_shoupai, card_chosen)
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
	add_funcptr(_huogong_sub1, nil)
end
function _huogong_qipai(va_list)    --  火攻：攻方出牌
    local ID_s, ID_mubiao, c_pos
	ID_s = va_list[1]; ID_mubiao = va_list[2]; c_pos = va_list[3]
	local card
	
	card = table.copy(char_juese[ID_s].shoupai[c_pos])
	card_add_qipai(card)
	card_remove({ID_s, c_pos})

	_nanman_send_msg({char_juese[ID_s].name, "弃掉了'", card[2], card[3], "的", card[1], "'"})
end
function _huogong_exe_3(ID_s)    --  火攻执行三：己方放弃
    add_funcptr(_nanman_send_msg, {char_juese[ID_s].name, "放弃"})
    add_funcptr(_huogong_sub1, nil)
end
function _huogong_sub1()
	card_out_jiesuan()
    guankan_s = 0
	
	if char_acting_i == char_current_i then
    	gamerun_status = ""
		jiaohu_text = "请您出牌"
    	platform.window:invalidate()
	else
		gamerun_status = "AI出牌"
		jiaohu_text = ""

		ai_card_use(char_acting_i)
	end
end

--  使用酒  --
--  ID_shoupai为单  --
function card_jiu(va_list)
	local ID_shoupai, ID_s
	ID_shoupai = va_list[1]; ID_s = va_list[2]

    local card
	if char_jiu_time <= 0 then return false end
	
	card = char_juese[ID_s].shoupai[ID_shoupai]
	char_jiu_time = char_jiu_time - 1
	char_hejiu = true
	_jiu_sub1({ID_s, ID_shoupai, card})
	
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
	skills_losecard(ID_s, 0, false)
end

--  使用杀  --
--  ID_shoupai为多  --
function card_sha(ID_shoupai, ID_s, ID_mubiao, iscur)
    local card_shoupai, arm_zhuge, xingbie_diff
	card_shoupai = {}

	char_liegong = {}
	char_sha_mubiao = ID_mubiao
	char_sha_mubiao_i = 1
	for i = 1, #ID_mubiao do
		char_liegong[ID_mubiao[i]] = false
	end
	
	--  空城状态的诸葛亮不能杀  --
	for i = 1, #ID_mubiao do
		if char_juese[ID_mubiao[i]].skill["空城"] == "available" and #char_juese[ID_mubiao[i]].shoupai == 0 then
			return false
		end
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

		for i = 1, #ID_mubiao do
	    	if char_calc_distance(ID_s, ID_mubiao[i]) > card_wuqi_r[char_juese[ID_s].wuqi[1]] and char_distance_infinity == false then
	        	return false
	    	end
		end
	else
		arm_zhuge = false
		--  张飞出杀不受限制  --
		if char_juese[ID_s].skill["咆哮"] == "available" then
			arm_zhuge = true
		end
	
	    if (char_sha_time <= 0 and not arm_zhuge) or char_sha_able == false then return false end

		for i = 1, #ID_mubiao do
	    	if char_calc_distance(ID_s, ID_mubiao[i]) > 1 and char_distance_infinity == false then
	        	return false
	    	end
		end
	end

	gamerun_status = "手牌生效中"
	jiaohu_text = ""
	
	--[[
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
	]]

	for i = 1, #ID_shoupai do
		table.insert(card_shoupai, char_juese[ID_s].shoupai[ID_shoupai[i]])
	end
	char_sha_params = {ID_shoupai, card_shoupai, ID_s, ID_mubiao, iscur}

	if #card_shoupai == 1 then
		if card_shoupai[1][1] ~= "杀" and card_shoupai[1][1] ~= "火杀" and card_shoupai[1][1] ~= "雷杀" then
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
	
	--  大乔流离  --
	for i = 1, #ID_mubiao do
		if char_juese[ID_mubiao[i]].skill["流离"] == "available" then
			add_funcptr(skills_liuli, {card_shoupai, ID_s, ID_mubiao[i], i})
		end
	end

	--  马超铁骑  --
	if char_juese[ID_s].skill["铁骑"] == "available" and iscur then
		for i = 1, #ID_mubiao do
			add_funcptr(skills_tieqi, {card_shoupai, ID_shoupai, ID_s, ID_mubiao[i], i})
		end
	end

	--  黄忠烈弓  --
	if char_juese[ID_s].skill["烈弓"] == "available" and iscur then
		for i = 1, #ID_mubiao do
			if skills_judge_liegong(ID_s, ID_mubiao[i]) then
				add_funcptr(skills_liegong, {ID_s, ID_mubiao[i], i})
			end
		end
	end
	--  杀第一个目标  --
	_sha_judge_and_go(ID_shoupai, card_shoupai, ID_s, ID_mubiao[1], iscur)
	return true
end
function _sha_judge_zhuque_cixiong(ID_shoupai, card_shoupai, ID_s, ID_mubiao)		--  杀：判断是否符合朱雀羽扇、雌雄双股剑发动条件
	local xingbie_diff = (char_juese_jineng[char_juese[ID_s].name][5] ~= char_juese_jineng[char_juese[ID_mubiao].name][5])

	if ID_s == char_current_i then
		--  己方杀AI  --
		if char_juese[ID_s].wuqi[1] == "朱雀扇" then
			guankan_s = card_shoupai
			_sha_zhuque()
			return true
		elseif xingbie_diff and char_juese[ID_s].wuqi[1] == "雌雄剑" then
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
function _sha_judge_and_go(ID_shoupai, card_shoupai, ID_s, ID_mubiao, iscur)
	if #char_juese[ID_s].wuqi ~= 0 then
		if _sha_judge_zhuque_cixiong(ID_shoupai, card_shoupai, ID_s, ID_mubiao) == false then
			_sha_go(ID_shoupai, card_shoupai, ID_s, ID_mubiao, iscur)
		end
	else
		_sha_go(ID_shoupai, card_shoupai, ID_s, ID_mubiao, iscur)
	end
end
function _sha_go(ID_shoupai, card_shoupai, ID_s, ID_mubiao, iscur)		--  杀：出杀
	if char_sha_mubiao_i == 1 then
		add_funcptr(_sha_sub1, {ID_shoupai, ID_s, ID_mubiao})
		skills_losecard(ID_s, #ID_shoupai, true)

		local yanse, huase, dianshu = ai_judge_cardinfo(ID_s, card_shoupai)
		--  孙策使用红色杀，摸一张牌  --
		if char_juese[ID_s].skill["激昂"] == "available" and yanse == "红色" then
			add_funcptr(skills_jiang, ID_s)
		end
	end

	local yanse, huase, dianshu = ai_judge_cardinfo(ID_mubiao, card_shoupai)
	--  孙策被红色杀，摸一张牌  --
	if char_juese[ID_mubiao].skill["激昂"] == "available" and yanse == "红色" then
		add_funcptr(skills_jiang, ID_mubiao)
	end

	--  吕布无双、董卓肉林  --
	local wushuang_flag = _sha_judge_if_xiangying_2(ID_s, ID_mubiao, true)

	if ID_mubiao == char_current_i then
		--  杀的目标是己方  --
		add_funcptr(_sha_exe_ai_1_queued, {card_shoupai, ID_s, ID_mubiao, iscur, wushuang_flag})
	else
		--  杀的目标是AI  --
		add_funcptr(_sha_exe_1_queued, {card_shoupai, ID_s, ID_mubiao, iscur, wushuang_flag})
	end
end
function _sha_judge_if_xiangying_2(ID_s, ID_mubiao, tishi)		--  杀：判断是否需要使用两张闪抵消
	--  吕布无双、董卓肉林  --
	if char_juese[ID_s].skill["无双"] == "available" then
		if tishi then
			add_funcptr(push_message, char_juese[ID_s].name .. "触发了武将技能 '无双'")
		end
		return true
	end
	if char_juese[ID_s].skill["肉林"] == "available" and char_juese_jineng[char_juese[ID_s].name][5] ~= char_juese_jineng[char_juese[ID_mubiao].name][5] then
		if tishi then
			add_funcptr(push_message, char_juese[ID_s].name .. "触发了武将技能 '肉林'")
		end
		return true
	end
	if char_juese[ID_mubiao].skill["肉林"] == "available" and char_juese_jineng[char_juese[ID_s].name][5] ~= char_juese_jineng[char_juese[ID_mubiao].name][5] then
		if tishi then
			add_funcptr(push_message, char_juese[ID_mubiao].name .. "触发了武将技能 '肉林'")
		end
		return true
	end
	return false
end
function _sha_get_leixing(card_shoupai)		--  杀：根据牌面返回杀的类型
	if #card_shoupai == 1 then
		if card_shoupai[1][1] == "杀" or card_shoupai[1][1] == "火杀" or card_shoupai[1][1] == "雷杀" then
			hint_1 = card_shoupai[1][1]
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
		add_funcptr(_nanman_send_msg, {char_juese[ID_mubiao].name, "装备藤甲，此杀无效"})
		return true
	end

	local yanse, huase, dianshu = ai_judge_cardinfo(ID_s, card_shoupai)
	if card_zhuangbei[1] == "仁王盾" and yanse == "黑色" then
		add_funcptr(_nanman_send_msg, {char_juese[ID_mubiao].name, "装备仁王盾，此杀无效"})
		return true
	end
	return false
end
function _sha_exe_ai_1_queued(va_list)
	local card_shoupai, ID_s, ID_mubiao, iscur, wushuang_flag
	card_shoupai = va_list[1]; ID_s = va_list[2]; ID_mubiao = va_list[3]; iscur = va_list[4]; wushuang_flag = va_list[5]

	_sha_exe_ai_1(card_shoupai, ID_s, ID_mubiao, iscur, wushuang_flag)
end
function _sha_exe_ai_1(card_shoupai, ID_s, ID_mubiao, iscur, wushuang_flag)	--  杀：己方响应
	local card, hint_1

	--  如果大乔流离了此杀  --
	if char_sha_mubiao[char_sha_mubiao_i] ~= ID_mubiao then
		ID_mubiao = char_sha_mubiao[char_sha_mubiao_i]
	end

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

	if (_sha_judge_if_xiangying_2(ID_s, ID_mubiao, false) == true and wushuang_flag == true) or _sha_judge_if_xiangying_2(ID_s, ID_mubiao, false) == false then
		push_message(table.concat({char_juese[ID_s].name, "'", hint_1, "'", char_juese[ID_mubiao].name}))

		--  刘禅享乐  --
		if char_juese[ID_mubiao].skill["享乐"] == "available" then
			add_funcptr(skills_xiangle, {ID_mubiao, ID_s})
		end
	end

	--  若装备防具，进行判断  --
	card = table.copy(char_juese[ID_mubiao].fangju)

	--  卧龙诸葛若未装备防具，视为装备八卦阵  --
	if char_juese[ID_mubiao].skill["八阵"] == "available" and #card == 0 then
		card[1] = "八卦阵"
	end

	if #card ~= 0 or (char_juese[ID_mubiao].skill["毅重"] == "available" and #card == 0) then
		local yanse, huase, dianshu = ai_judge_cardinfo(ID_s, card_shoupai)
		if char_juese[ID_mubiao].skill["毅重"] == "available" and #card == 0 and yanse == "黑色" then
			add_funcptr(_nanman_send_msg, {char_juese[ID_mubiao].name, "触发了武将技能 '毅重'，此杀无效"})
			add_funcptr(_sha_sub2, nil)
			return
		elseif not char_wushi then
			if _sha_judge_fangju_ying(card, card_shoupai, hint_1, ID_s, ID_mubiao) then
				add_funcptr(_sha_sub2, nil)
			    return
			end
		else
			add_funcptr(_nanman_send_msg, {char_juese[ID_s].name, "触发了'青钢剑'效果"})
		end
	end

	--  如果发动烈弓，则杀不可被闪避  --
	if char_liegong[ID_mubiao] == true then
		_sha_zhudong_fangqi({card_shoupai, ID_s, ID_mubiao, iscur}, false)
		return
	end

	--  曹操护驾  --
	if char_juese[ID_mubiao].skill["护驾"] == "available" then
		add_funcptr(skills_hujia_req_side, {ID_mubiao, "杀", {card_shoupai, ID_s, ID_mubiao, iscur, wushuang_flag}})
	end

	if ID_mubiao == char_current_i then
		_sha_exe_ai_1_fangyu(card_shoupai, ID_s, ID_mubiao, iscur, wushuang_flag, card)
	else
		--  大乔流离此杀的情况  --
		_sha_exe_1_fangyu(card_shoupai, ID_s, ID_mubiao, iscur, wushuang_flag, card)
	end
end
function _sha_exe_ai_1_fangyu(card_shoupai, ID_s, ID_mubiao, iscur, wushuang_flag, card)
	if #card ~= 0 then
		if not char_wushi then        
		    if card[1] == "八卦阵" then
				if char_juese[ID_mubiao].skill["八阵"] == "available" then
					add_funcptr(skills_bazhen, ID_mubiao)
				end
				card_arm_bagua(ID_mubiao, ID_s)
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
					_sha_shan_replaced(card_shoupai, ID_s, ID_mubiao, iscur, wushuang_flag)
					timer.start(0.6)
					return
				end
			end
		end
	end

	char_xiangying_2 = wushuang_flag

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
	skills_losecard(char_current_i, 1, true)

	--  张角雷击  --
	if char_juese[ID_mubiao].skill["雷击"] == "available" then
		add_funcptr(skills_leiji, {ID_mubiao, ID_s})
	end

	if char_xiangying_2 == false then
		--  庞德猛进  --
		if char_juese[ID_s].skill["猛进"] == "available" then
			add_funcptr(skills_mengjin, {ID_s, ID_mubiao})
		end

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
	if #char_juese[ID_s].wuqi ~= 0 and #card_shoupai == 1 and iscur then
		if char_juese[ID_s].wuqi[1] == "寒冰剑" then
			add_funcptr(_sha_hanbing_ai_judge, {card_shoupai, ID_s, ID_mubiao, iscur})
		else
			_sha_tili_deduct(card_shoupai, ID_s, ID_mubiao, iscur)
		end
	else
		_sha_tili_deduct(card_shoupai, ID_s, ID_mubiao, iscur)
	end
end
function _sha_shan_post_ai(card_shoupai, ID_s, ID_mubiao, iscur)	--  杀：杀的来源是AI时，出闪后处理
	if iscur and #char_juese[ID_s].wuqi ~= 0 and #card_shoupai == 1 then
		if char_juese[ID_s].wuqi[1] == "青龙刀" and ai_judge_qinglong(ID_s, ID_mubiao) then    --  青龙刀，可再出杀追杀
			add_funcptr(_sha_qinglong_ai_judge, {ID_s, ID_mubiao, iscur})
		elseif char_juese[ID_s].wuqi[1] == "贯石斧" and ai_judge_guanshi(ID_s, ID_mubiao) then
			add_funcptr(_sha_guanshi_ai_judge, {card_shoupai, ID_s, ID_mubiao, iscur})
		else
			add_funcptr(_sha_sub2, nil)
		end
	else
		add_funcptr(_sha_sub2, nil)
	end
end
function _sha_zhuque_ai(ID_shoupai, ID_s, ID_mubiao)	--  杀：AI使用朱雀羽扇效果
	local card = {char_juese[ID_s].shoupai[ID_shoupai[1]]}
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
	
	local card = {char_juese[ID_s].shoupai[ID_shoupai[1]]}
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
	local card_shoupai_sha = {char_juese[ID_s].shoupai[ID_shoupai[1]]}

	add_funcptr(_sha_cixiong_qipai_go, {card, c_pos, ID_s, ID_mubiao})
	skills_losecard(ID_s, 1, true)

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

	local card = {char_juese[ID_s].shoupai[ID_shoupai[1]]}

	add_funcptr(card_fenfa, {ID_s, 1, true})
	_sha_go(ID_shoupai, card, ID_s, ID_mubiao, true)
end
function _sha_hanbing_ai_judge(va_list)		--  杀：判断寒冰剑发动条件，如不发动直接结束结算
	local card_shoupai, ID_s, ID_mubiao, iscur
	card_shoupai = va_list[1]; ID_s = va_list[2]; ID_mubiao = va_list[3]; iscur = va_list[4]

	timer.stop()
	funcptr_queue = {}
	funcptr_i = 0

	if ai_judge_hanbing(ID_s, ID_mubiao) and char_juese[ID_s].wuqi[1] == "寒冰剑" then
		_sha_hanbing_ai(ID_s, ID_mubiao)
	else
		_sha_tili_deduct(card_shoupai, ID_s, ID_mubiao, iscur)
	end

	timer.start(0.6)
end
function _sha_hanbing_ai(ID_s, ID_mubiao)	--  杀：AI使用寒冰剑
	add_funcptr(_nanman_send_msg, {char_juese[ID_s].name, "发动了'寒冰剑'效果"})

	for i = 1, 2 do
		add_funcptr(_sha_hanbing_qipai_go, ID_mubiao)
		skills_losecard(ID_mubiao, 9999, true)
	end

	add_funcptr(_sha_sub2, nil)
end
function _sha_hanbing_qipai_go(ID_mubiao)	--  杀：AI寒冰剑弃牌 (临时AI)
	local c_pos = math.random(#char_juese[ID_mubiao].shoupai)
	local card = table.copy(char_juese[ID_mubiao].shoupai[c_pos])

	card_add_qipai(card)
	_nanman_send_msg({char_juese[ID_mubiao].name, "的'", card[2], card[3], "的", card[1], "'", "被弃置"})
	card_remove({ID_mubiao, c_pos})
end
function _sha_qinglong_ai_judge(va_list)	--  杀：判断青龙刀发动条件，如不发动直接结束结算
	local ID_s, ID_mubiao, iscur
	ID_s = va_list[1]; ID_mubiao = va_list[2]; iscur = va_list[3]

	timer.stop()
	funcptr_queue = {}
	funcptr_i = 0
	char_hejiu = false
	if char_juese[ID_s].wuqi[1] == "青龙刀" and ai_judge_qinglong(ID_s, ID_mubiao) then    --  青龙刀，可再出杀追杀
		_sha_qinglong_ai(ID_s, ID_mubiao, iscur)
	else
		add_funcptr(_sha_sub2, nil)
	end

	timer.start(0.6)
end
function _sha_qinglong_ai(ID_s, ID_mubiao, iscur)	--  杀：AI青龙刀追杀
	--  上一张杀进弃牌堆  --
	card_out_jiesuan()

	local c_pos = ai_chazhao_sha(ID_s, char_juese[ID_s].shoupai)
	local card = {char_juese[ID_s].shoupai[c_pos]}

	add_funcptr(_nanman_send_msg, {char_juese[ID_s].name, "发动了'青龙刀'效果"})
	_sha_go({c_pos}, card, ID_s, ID_mubiao, iscur)
end
function _sha_guanshi_ai_judge(va_list)		--  杀：判断贯石斧发动条件，如不发动直接结束结算
	local card_shoupai, ID_s, ID_mubiao, iscur
	card_shoupai = va_list[1]; ID_s = va_list[2]; ID_mubiao = va_list[3]; iscur = va_list[4]

	timer.stop()
	funcptr_queue = {}
	funcptr_i = 0

	if char_juese[ID_s].wuqi[1] == "贯石斧" and ai_judge_guanshi(ID_s, ID_mubiao) then
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
	skills_losecard(ID_s, 2, true)

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
function _sha_exe_1_queued(va_list)
	local card_shoupai, ID_s, ID_mubiao, iscur, wushuang_flag
	card_shoupai = va_list[1]; ID_s = va_list[2]; ID_mubiao = va_list[3]; iscur = va_list[4]; wushuang_flag = va_list[5]

	_sha_exe_1(card_shoupai, ID_s, ID_mubiao, iscur, wushuang_flag)
end
function _sha_exe_1(card_shoupai, ID_s, ID_mubiao, iscur, wushuang_flag)    --  杀：AI响应
    local c_pos, card, hint_1

	--  如果大乔流离了此杀  --
	if char_sha_mubiao[char_sha_mubiao_i] ~= ID_mubiao then
		ID_mubiao = char_sha_mubiao[char_sha_mubiao_i]
	end
	
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
	
	if (_sha_judge_if_xiangying_2(ID_s, ID_mubiao, false) == true and wushuang_flag == true) or _sha_judge_if_xiangying_2(ID_s, ID_mubiao, false) == false then
		push_message(table.concat({char_juese[ID_s].name, "'", hint_1, "'", char_juese[ID_mubiao].name}))

		--  刘禅享乐  --
		if char_juese[ID_mubiao].skill["享乐"] == "available" then
			add_funcptr(skills_xiangle, {ID_mubiao, ID_s})
		end
	end

    --  若装备防具，进行判断  --
	card = table.copy(char_juese[ID_mubiao].fangju)

	--  卧龙诸葛若未装备防具，视为装备八卦阵  --
	if char_juese[ID_mubiao].skill["八阵"] == "available" and #card == 0 then
		card[1] = "八卦阵"
	end

	if #card ~= 0 or (char_juese[ID_mubiao].skill["毅重"] == "available" and #card == 0) then
		local yanse, huase, dianshu = ai_judge_cardinfo(ID_s, card_shoupai)
		if char_juese[ID_mubiao].skill["毅重"] == "available" and #card == 0 and yanse == "黑色" then
			add_funcptr(_nanman_send_msg, {char_juese[ID_mubiao].name, "触发了武将技能 '毅重'，此杀无效"})
			add_funcptr(_sha_sub2, nil)
			return
		elseif not char_wushi then
			if _sha_judge_fangju_ying(card, card_shoupai, hint_1, ID_s, ID_mubiao) then
				add_funcptr(_sha_sub2, nil)
			    return
			end
		else
			add_funcptr(_nanman_send_msg, {char_juese[ID_s].name, "触发了'青钢剑'效果"})
		end
	end

	--  如果发动烈弓，则杀不可被闪避  --
	if char_liegong[ID_mubiao] == true then
		if ID_s == char_current_i then
			--  杀的来源是己方  --
			_sha_fangqi(card_shoupai, ID_s, ID_mubiao, iscur)
		else
			--  杀的来源是AI  --
			_sha_zhudong_fangqi({card_shoupai, ID_s, ID_mubiao, iscur}, false)
		end
		return
	end

	--  曹操护驾  --
	if char_juese[ID_mubiao].skill["护驾"] == "available" then
		add_funcptr(skills_hujia_req_side, {ID_mubiao, "杀", {card_shoupai, ID_s, ID_mubiao, iscur, wushuang_flag}})
	end

	if ID_mubiao == char_current_i then
		--  大乔流离此杀的情况  --
		_sha_exe_ai_1_fangyu(card_shoupai, ID_s, ID_mubiao, iscur, wushuang_flag, card)
	else
		_sha_exe_1_fangyu(card_shoupai, ID_s, ID_mubiao, iscur, wushuang_flag, card)
	end
end
function _sha_exe_1_fangyu(card_shoupai, ID_s, ID_mubiao, iscur, wushuang_flag, card)
	if #card ~= 0 then
	    if not char_wushi then
		    if card[1] == "八卦阵" then
				if char_juese[ID_mubiao].skill["八阵"] == "available" then
					add_funcptr(skills_bazhen, ID_mubiao)
				end
				card_arm_bagua(ID_mubiao, ID_s)
		    end
		end
	end
	
	add_funcptr(_sha_ai_xiangying, {card_shoupai, ID_s, ID_mubiao, iscur, wushuang_flag, card})
end
function _sha_shan_replaced(card_shoupai, ID_s, ID_mubiao, iscur, wushuang_flag)	--  杀：闪被代替后处理 (八卦阵、护驾其他角色出闪)
	--  张角雷击  --
	if char_juese[ID_mubiao].skill["雷击"] == "available" then
		add_funcptr(skills_leiji, {ID_mubiao, ID_s})
	end

	if wushuang_flag == true then
		if ID_mubiao == char_current_i then
			_sha_exe_ai_1(card_shoupai, ID_s, ID_mubiao, iscur, false)
		else
			_sha_exe_1(card_shoupai, ID_s, ID_mubiao, iscur, false)
		end
	else
		--  庞德猛进  --
		if char_juese[ID_s].skill["猛进"] == "available" then
			add_funcptr(skills_mengjin, {ID_s, ID_mubiao})
		end

		if ID_s == char_current_i then
			--  杀的来源是己方  --
			_sha_shan_post(ID_s, card_shoupai, iscur)
		else
			--  杀的来源是AI  --
			_sha_shan_post_ai(card_shoupai, ID_s, ID_mubiao, iscur)
		end
	end
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
					_sha_shan_replaced(card_shoupai, ID_s, ID_mubiao, iscur, wushuang_flag)
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
		skills_losecard(ID_mubiao, 1, true)
			
		--  张角雷击  --
		if char_juese[ID_mubiao].skill["雷击"] == "available" then
			add_funcptr(skills_leiji, {ID_mubiao, ID_s})
		end
			
		if wushuang_flag == false then
			--  庞德猛进  --
			if char_juese[ID_s].skill["猛进"] == "available" then
				add_funcptr(skills_mengjin, {ID_s, ID_mubiao})
			end

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
	if iscur and #char_juese[ID_s].wuqi ~= 0 and #card_shoupai == 1 then
		if char_juese[ID_s].wuqi[1] == "青龙刀" then    --  青龙刀，可再出杀追杀
			add_funcptr(_sha_qinglong, nil)
		elseif char_juese[ID_s].wuqi[1] == "贯石斧" then
			add_funcptr(_sha_guanshi, card_shoupai)
		else
			add_funcptr(_sha_sub2, nil)
		end
	else
		add_funcptr(_sha_sub2, nil)
	end
end
function _sha_fangqi(card_shoupai, ID_s, ID_mubiao, iscur)		--  杀：杀的来源是己方时，放弃后处理
	add_funcptr(_nanman_send_msg, {char_juese[ID_mubiao].name, "放弃"})
	if #char_juese[ID_s].wuqi ~= 0 and #card_shoupai == 1 and iscur then
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
function _sha_chazhao_redblack(id, tb, red)
    local i, v
	
	for i, v in ipairs(tb) do
		local yanse, huase, dianshu = ai_judge_cardinfo(id, {v})

		if red == false then
			if yanse == "黑色" then
				return i
			end
		else
			if yanse == "红色" then
				return i
			end
		end
	end
	
	return -1
end
function _sha_exe_2(ID_s, ID_mubiao, c_pos)    --  杀：青龙刀追杀
	local card_shoupai

	--  上一张杀进弃牌堆  --
	card_out_jiesuan()

    gamerun_status = "手牌生效中"
	jiaohu_text = ""
	
	card_shoupai = {char_juese[ID_s].shoupai[c_pos]}
	add_funcptr(_sha_sub1, {{c_pos}, ID_s, ID_mubiao})

	local wushuang_flag = _sha_judge_if_xiangying_2(ID_s, ID_mubiao, true)
	add_funcptr(_sha_exe_1_queued, {card_shoupai, ID_s, ID_mubiao, true, wushuang_flag})
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

	_chai_sub1({va_list[1], va_list[2], va_list[3], true})
	if first then
		gamerun_status = "观看手牌-寒"
	else
		gamerun_status = "观看手牌-寒2"
	end
end
function _sha_tili_deduct(card_shoupai, ID_s, ID_mubiao, iscur)    --  杀：扣减体力结算
    local shuxing, deduct, hint_1
	
	if #card_shoupai == 1 then
		if card_shoupai[1][1] == "杀" or card_shoupai[1][1] == "火杀" or card_shoupai[1][1] == "雷杀" then
			hint_1 = card_shoupai[1][1]
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
	add_funcptr(_sha_sub2, nil)
end
function _sha_shan(va_list)    --  杀：AI出闪
    local ID_mubiao, c_pos, msg, card
	ID_mubiao = va_list[1]; c_pos = va_list[2]
	
	card = char_juese[ID_mubiao].shoupai[c_pos]
	card_add_qipai(card)
	card_remove({ID_mubiao, c_pos})
	
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
	msg = nil; --collectgarbage()
end
function _sha_qinglong()    --  杀：青龙刀追杀状态设置
    gamerun_status = "主动出牌-青龙"
	jiaohu_text = "您可再出杀"
	platform.window:invalidate()
end
function _sha_guanshi(card_shoupai)    --  杀：贯石斧状态设置
    gamerun_status = "主动出牌-贯石"
	jiaohu_text = "您可弃2张牌强制命中"
	guankan_s = card_shoupai

	platform.window:invalidate()
end
function _sha_zhuque()    --  杀：朱雀羽扇状态设置
    gamerun_status = "确认操作"
	jiaohu_text = "是否发动'朱雀羽扇'效果?"
	gamerun_OK = false
	gamerun_OK_ptr = function()    -- 如果确认发动，执行的函数
		local card = char_juese[char_current_i].shoupai[card_highlighted]
	    gamerun_status = ""; set_hints("")
		funcptr_queue = {}
	    add_funcptr(_nanman_send_msg, {char_juese[char_current_i].name, "发动了'朱雀羽扇'效果"})
	    add_funcptr(_sha_sub1, {{card_highlighted}, char_current_i, gamerun_target_selected})

		local yanse, huase, dianshu = ai_judge_cardinfo(char_current_i, {char_juese[char_current_i].shoupai[card_highlighted]})
		--  孙策使用红色杀，摸一张牌  --
		if char_juese[char_current_i].skill["激昂"] == "available" and yanse == "红色" then
			add_funcptr(skills_jiang, char_current_i)
		end
		
		local wushuang_flag = _sha_judge_if_xiangying_2(char_current_i, gamerun_target_selected, true)

	    add_funcptr(_sha_exe_1_queued, {guankan_s, char_current_i, gamerun_target_selected, true, wushuang_flag})
		consent_func_queue(0.6)
	end
	platform.window:invalidate()
end
function _sha_qilin(ID)		--  杀：麒麟弓状态设置
	if #char_juese[ID].gongma > 0 or #char_juese[ID].fangma > 0 then
		push_zhudong_queue(table.copy(funcptr_queue), funcptr_i)
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
			funcptr_i = funcptr_i + 1
			timer.start(0.6)
		end
	end
	platform.window:invalidate()
end
function _sha_qilin_huifu()	--  杀：(麒麟弓) 恢复己方中断前函数队列
	funcptr_queue, funcptr_i = pop_zhudong_queue()
end
function _sha_cixiong()    --  杀：雌雄双股剑状态设置
    gamerun_status = "确认操作"
	jiaohu_text = "是否发动'雌雄剑'效果?"
	gamerun_OK = false
	gamerun_OK_ptr = function()    -- 如果确认发动，执行的函数
		local card = char_juese[char_current_i].shoupai[card_highlighted]
	    gamerun_status = ""; set_hints("")
		funcptr_queue = {}
	    add_funcptr(_nanman_send_msg, {char_juese[char_current_i].name, "发动了'雌雄双股剑'效果"})
		add_funcptr(card_fenfa, {char_current_i, 1, true})
	    add_funcptr(_sha_sub1, {{card_highlighted}, char_current_i, gamerun_target_selected})

		local yanse, huase, dianshu = ai_judge_cardinfo(char_current_i, {char_juese[char_current_i].shoupai[card_highlighted]})
		--  孙策使用红色杀，摸一张牌  --
		if char_juese[char_current_i].skill["激昂"] == "available" and yanse == "红色" then
			add_funcptr(skills_jiang, char_current_i)
		end
		
		local wushuang_flag = _sha_judge_if_xiangying_2(char_current_i, gamerun_target_selected, true)

		add_funcptr(_sha_exe_1_queued, {guankan_s, char_current_i, gamerun_target_selected, true, wushuang_flag})
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
    local msg, card, hint_1
	local ID_s, ID_shoupai, ID_mubiao
	ID_shoupai = va_list[1]; ID_s = va_list[2]; ID_mubiao = va_list[3]
	
	--  恢复状态  --
	if ID_s == char_current_i or ID_mubiao == char_current_i then
		card_selected = {}
		card_highlighted = 1
		platform.window:invalidate()
	end
	
	if #ID_shoupai == 1 then
		card = char_juese[ID_s].shoupai[ID_shoupai[1]]
		if card[1] == "杀" or card[1] == "火杀" or card[1] == "雷杀" then
			hint_1 = card[1]
		else
			hint_1 = "杀"
		end
	else
		hint_1 = "杀"
	end
	if gamerun_OK then
	    if #char_juese[ID_s].wuqi ~= 0 then
		    if char_juese[ID_s].wuqi[1] == "朱雀扇" then
		        hint_1 = "火杀"
			end
		end
	end

	--msg = table.concat({char_juese[ID_s].name, "'", hint_1, "'", char_juese[ID_mubiao].name})
	msg = table.concat({char_juese[ID_s].name, "使用'", hint_1, "'"})

	--  如果不是技能虚拟的无色无点牌，则显示牌面信息  --
	if char_juese[ID_s].shoupai[ID_shoupai[1]][2] ~= "" then
		msg = msg .. " ("
		for i = 1, #ID_shoupai do
			local card = char_juese[ID_s].shoupai[ID_shoupai[i]]
			msg = msg .. table.concat({card[2], card[3], "的", card[1]})
			if i ~= #ID_shoupai then
				msg = msg .. "，"
			end
		end
		msg = msg .. ")"
	end
	push_message(msg)
	
	card_into_jiesuan(ID_s, ID_shoupai, hint_1, ID_s)
	gamerun_wuqi_out_hand(ID_s)
end
function _sha_sub2()
	--  如果杀还有剩余目标，则继续下一个目标  --
	if char_sha_mubiao_i < #char_sha_mubiao then
		_sha_next_mubiao()
		return
	end

	card_out_jiesuan()
	gamerun_wuqi_out_hand(char_acting_i)

	--  如果是夏侯渊发动神速，恢复被中断的函数队列  --
	if gamerun_shensu == true then
		gamerun_shensu = false
		char_distance_infinity = false
		_shensu_huifu()
		return
	end

	char_sha_params = nil
	char_sha_mubiao = nil
	char_sha_mubiao_i = nil
    char_yisha = true
	char_sha_time = char_sha_time - 1
	char_hejiu = false
	char_wushi = false
	char_liegong = nil
	gamerun_OK = false
	sha_va = nil
	txt_messages:setVisible(true)
	guankan_s = 0

	if char_acting_i == char_current_i then
		gamerun_status = ""
		jiaohu_text = "请您出牌"
	else
		gamerun_status = "AI出牌"
		jiaohu_text = ""

		ai_next_card(char_acting_i)
	end
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
	
	_sha_exe_5({true, char_current_i, gamerun_target_selected, false})
end
function _sha_sub4()    --  杀：用于延时

end
function _sha_next_mubiao()		--  杀：杀下一个目标
	local card_shoupai, ID_shoupai, ID_s, ID_mubiao, iscur
	ID_shoupai = char_sha_params[1]; card_shoupai = char_sha_params[2]; ID_s = char_sha_params[3]; ID_mubiao = char_sha_params[4]; iscur = char_sha_params[5]

	funcptr_queue = {}
	funcptr_i = 0

	char_sha_mubiao_i = char_sha_mubiao_i + 1
	while char_juese[char_sha_mubiao[char_sha_mubiao_i]].siwang == true do
		if char_sha_mubiao_i >= #char_sha_mubiao then
			_sha_sub2()
			return
		end

		char_sha_mubiao_i = char_sha_mubiao_i + 1
	end
	
	ID_mubiao = char_sha_mubiao[char_sha_mubiao_i]	

	_sha_judge_and_go(ID_shoupai, card_shoupai, ID_s, ID_mubiao, iscur)
	timer.start(0.6)
end

--  使用借刀杀人  --
--  ID_shoupai为单  --
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
	    return false
	end
	
	gamerun_status = "手牌生效中"
	jiaohu_text = ""
	
	if char_acting_i == char_current_i then
		card_highlighted = 1
		card_selected = {}
	end

	add_funcptr(_jiedao_sub1, {ID_shoupai, ID_req, ID_s, ID_d})
	skills_losecard(ID_s, 1, true)
	if char_juese[ID_s].skill["集智"] == "available" or (char_juese[ID_s].skill["极略"] == "available" and mark_ren[ID_s] > 0) then
		add_funcptr(skills_jizhi, ID_s)
	end
	
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
	    	card_sha({c_pos}, ID_s, {ID_d}, false)
		else	
	    	add_funcptr(_nanman_send_msg, {char_juese[ID_s].name, "放弃"})
			add_funcptr(_jiedao_swap, {ID_req, ID_s})
			add_funcptr(_jiedao_sub2)
		end
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

	card_sha({c_pos}, ID_s, {ID_d}, false)
	--add_funcptr(_jiedao_sub2)
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
	guankan_s = 0

	if char_acting_i == char_current_i then
    	gamerun_status = ""
		jiaohu_text = "请您出牌"
	else
		gamerun_status = "AI出牌"
		jiaohu_text = ""

		ai_card_use(char_acting_i)
	end
	platform.window:invalidate()
end

function debug_getcard(ID,huase,dianshu,name)
	table.insert(char_juese[ID].shoupai,{name,huase,dianshu})
	platform.window:invalidate()
end