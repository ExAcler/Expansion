

--  他方区域  --
function draw_opponent(gc)
    local elems = {{224, 72}, {224, 5}, {5, 5}, {5, 72}}
    local id = 2
	local i, j
	local x1, y1
	local msg
	
	id = char_current_i + 1
	if id > 5 then id = 1 end
	
	for j = 1, 4 do
	    x1 = elems[j][1]
		y1 = elems[j][2]
	
        --  玩家信息框架  --
		
		-- 信息区域填色
		if char_juese[id].siwang == false then
			if char_juese[id].fanmian == true then
				gc:setColorRGB(114, 97, 73)
			else
				gc:setColorRGB(229, 195, 147)
			end
		else
			gc:setColorRGB(153, 153, 153)
	    end
		gc:fillRect(x1, y1, 88, 57)    -- (5, 5, 88, 57)
		
		-- 体力显示区域填色
	    if char_juese[id].shili == "蜀" then
			gc:setColorRGB(255, 140, 0)
		elseif char_juese[id].shili == "魏" then
			gc:setColorRGB(65, 105, 225)
		elseif char_juese[id].shili == "吴" then
			gc:setColorRGB(50, 205, 50)
		elseif char_juese[id].shili == "群" then
			gc:setColorRGB(211, 211, 211)
		elseif char_juese[id].shili == "晋" then
			gc:setColorRGB(238, 130, 238)
		elseif char_juese[id].shili == "神" then
			gc:setColorRGB(255, 215, 0)
		else
			gc:setColorRGB(153, 153, 153)
	    end
		gc:fillRect(x1 + 76, y1 + 1, 12, 56)    -- (81, 6, 12, 56)
		
		if char_juese[id].siwang == false then
			gc:setColorRGB(0, 0, 0)
        else
			gc:setColorRGB(192, 192, 192)
		end
		gc:drawRect(x1, y1, 88, 57)    -- 信息区域 (5, 5, 88, 57)
	    gc:drawRect(x1 + 76, y1, 12, 57)    -- 体力显示区域 (5 + 76, 5, 12, 57)
	    gc:drawLine(x1, y1 + 19, x1 + 75, y1 + 19)    -- 框架线 (5, 5 + 19, 80, 5 + 19)
	    gc:drawLine(x1, y1 + 19 + 19, x1 + 75, y1 + 19 + 19)    -- (5, 24 + 19, 80, 24 + 19)
	    gc:drawLine(x1 + 56, y1 + 19, x1 + 56, y1 + 57)    -- 纵向框架线 (+1 / -1 马) (61, 5 + 19, 61, 5 + 57)
	    gc:drawRect(x1 + 76, y1 + 45, 12, 12)    -- 卡牌数 (81, 50, 12, 12)
	
		-- 锦囊状态 --
		-- (x1 + 57, y1 + 39, x1 + 75, y1 + 56)
	
	    -- 卡牌数显示 --
	    gc:setFont("sansserif", "r", 7)
	    gc:drawString(#char_juese[id].shoupai, x1 + 80, y1 + 48 + 9)  -- (85, 53 + 9)
	    gc:setFont("sansserif", "r", 11)
	
	    -- 体力数 --
		if char_juese[id].tili_max < 5 then
	        for i = 1, char_juese[id].tili_max do
	            if i <= char_juese[id].tili then
	                gc:drawImage(hongxin_on_img, x1 + 77, y1 + 1 + 11 * (i - 1))  -- (82, 6 + 11 * (i - 1))
		        else
		            gc:drawImage(hongxin_off_img, x1 + 77, y1 + 1 + 11 * (i - 1))
		        end
	        end
		else
			if char_juese[id].siwang == false then
				gc:drawImage(hongxin_on_img, x1 + 77, y1 + 1)
				gc:setColorRGB(255, 0, 0)
			else
				gc:drawImage(hongxin_off_img, x1 + 77, y1 + 1)
				gc:setColorRGB(192, 192, 192)
			end
			gc:setFont("sansserif", "r", 7)
			gc:drawString(tostring(char_juese[id].tili), x1 + 81, y1 + 10 + 11)
			gc:drawString("/", x1 + 81, y1 + 10 + 11 + 8)
			gc:drawString(tostring(char_juese[id].tili_max), x1 + 81, y1 + 10 + 11 + 8 * 2)
			gc:setFont("sansserif", "r", 11)
			if char_juese[id].siwang == false then
				gc:setColorRGB(0, 0, 0)
			else
				gc:setColorRGB(192, 192, 192)
			end
		end
	
	    -- 名称及身份 --
		if char_juese[id].shenfen == "主公" then
		    gc:drawImage(identity_img["主公"], x1 + 65, y1 + 3)
		else
			if gamerun_huihe == "游戏结束" then
				gc:drawImage(identity_img[char_juese[id].shenfen], x1 + 65, y1 + 3)
			else
				if char_juese[id].siwang == false or fenxin_pending == id then
					gc:drawImage(identity_img["未知"], x1 + 65, y1 + 3)  -- (5 + 65, 5 + 3)
				else
					gc:drawImage(identity_img[char_juese[id].shenfen], x1 + 65, y1 + 3)
				end
			end
	    end
		gc:drawString(char_juese[id].name, x1 + 3, y1 + 20)  -- (8, 25)
		
		-- 装备 --
		if #char_juese[id].wuqi ~= 0 then
		    gc:drawString(char_juese[id].wuqi[1], x1 + 2, y1 + 20 + 19)  -- (7, 25 + 19)
	    end
		if #char_juese[id].fangju ~= 0 then
		    gc:drawString(char_juese[id].fangju[1], x1 + 2, y1 + 20 + 19 + 19)  -- (7, 44 + 19)
	    end
		if #char_juese[id].gongma ~= 0 and #char_juese[id].fangma ~= 0 then
	        gc:drawString("±1", x1 + 58, y1 + 20 + 19)  -- (63, 25 + 19)
	    else
	        if #char_juese[id].gongma ~= 0 then
		        gc:drawString("-1", x1 + 58, y1 + 20 + 19)
		    end
		    if #char_juese[id].fangma ~= 0 then
		        gc:drawString("+1", x1 + 58, y1 + 20 + 19)
		    end
	    end
		
		-- 锦囊状态 --
		local i, v, cnt, sel
		v = table.copy(char_juese[id].panding)
		if char_juese[id].hengzhi == true then
			table.insert(v, {"铁锁连环"})
		end
		
		for i = 1, #v do
			if v[i][1] ~= "乐不思蜀" and v[i][1] ~= "兵粮寸断" and v[i][1] ~= "闪电" and v[i][1] ~= "铁锁连环" then
				sel = 4
			else
				sel = 1
			end
			if v[i][sel] == "乐不思蜀" then
				gc:setColorRGB(255, 128, 128)
			end
			if v[i][sel] == "兵粮寸断" then
				gc:setColorRGB(242, 242, 0)
			end
			if v[i][sel] == "闪电" then
				gc:setColorRGB(0, 128, 255)
			end
			if v[i][sel] == "铁锁连环" then
				gc:setColorRGB(233, 233, 216)
			end
			
			if #v == 1 then
				gc:fillRect(x1 + 57, y1 + 39, 19, 18)
			end
			
			if #v == 2 then
				if i == 1 then
					gc:fillRect(x1 + 57, y1 + 39, 10, 18)
				end
				if i == 2 then
					gc:fillRect(x1 + 67, y1 + 39, 9, 18)
				end
			end
			
			if #v == 3 then
				if i == 1 then
					gc:fillRect(x1 + 57, y1 + 39, 10, 9)
				end
				if i == 2 then
					gc:fillRect(x1 + 67, y1 + 39, 9, 9)
				end
				if i == 3 then
					gc:fillRect(x1 + 57, y1 + 48, 19, 9)
				end
			end
			
			if #v == 4 then
				if i == 1 then
					gc:fillRect(x1 + 57, y1 + 39, 10, 9)
				end
				if i == 2 then
					gc:fillRect(x1 + 67, y1 + 39, 9, 9)
				end
				if i == 3 then
					gc:fillRect(x1 + 57, y1 + 48, 10, 9)
				end
				if i == 4 then
					gc:fillRect(x1 + 67, y1 + 48, 9, 9)
				end
			end
		end
		
		gc:setColorRGB(0, 0, 0)
		if char_acting_i == id then
			gc:setColorRGB(0, 255, 0)
			gc:setPen("medium")
			gc:drawRect(x1, y1, 88, 57)
			gc:setPen("thin")
			gc:setColorRGB(0, 0, 0)
		end
		--  选择卡牌使用目标状态  --
		if string.find(gamerun_status, "选择目标") or gamerun_status == "技能选择-目标" or gamerun_status == "技能选择-目标B" then
			local card
			
			if gamerun_status == "技能选择-目标" or gamerun_status == "技能选择-目标B" then
				card = imp_card
			else
				card = char_juese[char_current_i].shoupai[card_highlighted][1]
			end
		
		    --  显示距离  --
			if char_juese[id].siwang == false then
				gc:setColorRGB(0, 0, 0)
				gc:fillRect(x1, y1 + 19, 76, 38)
				gc:setColorRGB(255, 255, 255)
				if char_juese[char_current_i].skill["烈弓"]=="available" and (card == "杀" or card == "火杀" or card == "雷杀") then
					--  黄忠：显示 "可烈弓" 状态  --
					if skills_judge_liegong(char_current_i, id) then
						msg = {"距离 ", char_calc_distance(char_current_i, id)}
						gc:drawString(table.concat(msg), x1 + 12, y1 + 29 + 9)
						gc:drawString("可烈弓", x1 + 12, y1 + 49 + 9)
					else
						msg = {"距离 ", char_calc_distance(char_current_i, id)}
						gc:drawString(table.concat(msg), x1 + 12, y1 + 37 + 9)
					end
				else
					msg = {"距离 ", char_calc_distance(char_current_i, id)}
					gc:drawString(table.concat(msg), x1 + 12, y1 + 37 + 9)
				end
			
				if id == gamerun_target_selected then
					--  显示焦点  --
					local fun, wuqi
			
					if #char_juese[char_current_i].wuqi ~= 0 then
						wuqi = char_juese[char_current_i].wuqi[1]
					else
						wuqi = ""
					end
			
					if gamerun_status == "选择目标-B" or ((card == "驱虎2" or card == "节命" or card == "好施" or card == "遗计") and gamerun_status == "技能选择-目标B") then
						fun = function(card) return card_if_d_limit(card, guankan_s, gamerun_target_selected) end
					elseif wuqi == "丈八矛" then
						card = {}
						fun = function(card) return card_if_d_limit(card, char_current_i, id) end
					else
						fun = function(card) return card_if_d_limit(card, char_current_i, id) end
					end
					
					if char_acting_i == id and fun(card) then
						gc:setColorRGB(195, 195, 0)
					elseif char_acting_i == id then
						gc:setColorRGB(17, 69, 20)
					elseif fun(card) then
						--  选择的角色可作为目标  --
						gc:setColorRGB(255, 0, 0)
					else
						gc:setColorRGB(216, 216, 216)
					end
			
					gc:setPen("medium")
					gc:drawRect(x1, y1, 88, 57)
					gc:setPen("thin")
					gc:setColorRGB(0, 0, 0)
				end
			end
		end
		
		id = id + 1
		if id > 5 then id = 1 end
	end
end

--  本方区域  --
function draw_self(gc)
    local i, img_width, j, base_y
	
    -- 玩家信息框架	--
	if char_juese[char_current_i].siwang == false then
		if char_juese[char_current_i].fanmian == true then
			gc:setColorRGB(114, 97, 73)
		else
			gc:setColorRGB(229, 195, 147)
		end
	else
		gc:setColorRGB(153, 153, 153)
	end    -- 信息区域填色
	gc:fillRect(224, 151, 88, 57)
	if char_juese[char_current_i].shili == "蜀" then
		gc:setColorRGB(255, 140, 0)
	elseif char_juese[char_current_i].shili == "魏" then
		gc:setColorRGB(65, 105, 225)
	elseif char_juese[char_current_i].shili == "吴" then
		gc:setColorRGB(50, 205, 50)
	elseif char_juese[char_current_i].shili == "群" then
		gc:setColorRGB(211, 211, 211)
	elseif char_juese[char_current_i].shili == "晋" then
		gc:setColorRGB(238, 130, 238)
	elseif char_juese[char_current_i].shili == "神" then
		gc:setColorRGB(255, 215, 0)
	else
		gc:setColorRGB(153, 153, 153)
	end    -- 体力显示区域填色
	gc:fillRect(224 + 76, 152, 12, 56)
	if char_juese[char_current_i].siwang == false then
		gc:setColorRGB(0, 0, 0)
    else
		gc:setColorRGB(192, 192, 192)
	end
	gc:drawRect(224, 151, 88, 57)    -- 信息区域
	gc:drawRect(224 + 76, 151, 12, 57)    -- 体力显示区域
	gc:drawLine(224, 151 + 19, 224 + 75, 151 + 19)    -- 框架线
	gc:drawLine(224, 170 + 19, 224 + 75, 170 + 19)
	gc:drawLine(224 + 38, 151 + 19, 224 + 38, 151 + 57)    -- 纵向框架线
	
	-- 绘制卡牌 --
    -- img_width = 28 = (167 - 81) / (n - 1)
	if #char_juese[char_current_i].shoupai > 0 then
		if #char_juese[char_current_i].shoupai > 3 then
			img_width = (167 - 81) / (#char_juese[char_current_i].shoupai - 1)
		else
			img_width = 29
		end
		for i = 1, #char_juese[char_current_i].shoupai do
			if i ~= card_highlighted or (i == card_highlighted and card_selected[card_highlighted] ~= nil) then
				if card_selected[i] == nil then
					base_y = 151
				else
					base_y = 146
				end
				gc:drawImage(cards_img[char_juese[char_current_i].shoupai[i][1]], 81 + img_width * (i - 1), base_y)
				gc:drawImage(color_img[char_juese[char_current_i].shoupai[i][2]], 82 + img_width * (i - 1), base_y + 2)
				gc:setFont("sansserif", "r", 7)
				gc:drawString(char_juese[char_current_i].shoupai[i][3], 85 + img_width * (i - 1), base_y + 22)
				gc:setFont("sansserif", "r", 11)
			end
		end
		if card_selected[card_highlighted] == nil and card_highlighted ~= nil then
			if #char_juese[char_current_i].shoupai > 0 and card_highlighted > 0 then
				if card_highlighted > #char_juese[char_current_i].shoupai then
					card_highlighted = 1
				end

				gc:drawImage(cards_img[char_juese[char_current_i].shoupai[card_highlighted][1]], 81 + img_width * (card_highlighted - 1), 151)
				gc:drawImage(color_img[char_juese[char_current_i].shoupai[card_highlighted][2]], 82 + img_width * (card_highlighted - 1), 153)
				gc:setFont("sansserif", "r", 7)
				gc:drawString(char_juese[char_current_i].shoupai[card_highlighted][3], 85 + img_width * (card_highlighted - 1), 173)
				gc:setFont("sansserif", "r", 11)
			end
		end
	end
	
	if char_juese[char_current_i].name == "" then return end
	--  选取的技能高亮显示  --
	local s = gamerun_skill_selected
	if s ~= nil then
		gc:setColorRGB(153, 217, 234)
		if s - 2 * skill_disrow == 1 then
			gc:fillRect(225, 151 + 20, 37, 18)
		end
		if s - 2 * skill_disrow == 2 then
			gc:fillRect(225 + 38, 151 + 20, 37, 18)
		end
		if s - 2 * skill_disrow == 3 then
			gc:fillRect(225, 170 + 20, 37, 18)
		end
		if s - 2 * skill_disrow == 4 then
			gc:fillRect(225 + 38, 170 + 20, 37, 18)
		end
	end
	gc:setColorRGB(0, 0, 0)
	
	-- 角色信息 & 技能 --
	gc:drawString(char_juese[char_current_i].name, 224 + 3, 151 + 20)
	for i = 1, math.min(#char_juese[char_current_i].skillname - 2 * skill_disrow,4) do
	    if i < 3 then
	        gc:drawString(char_juese[char_current_i].skillname[i + 2 * skill_disrow], 227 + 38 * (i - 1), 171 + 19)
		else
	        gc:drawString(char_juese[char_current_i].skillname[i + 2 * skill_disrow], 227 + 38 * (i - 3), 171 + 38)
		end
	end
	
	-- 体力 --
	if char_juese[char_current_i].tili_max < 5 then
	    for i = 1, char_juese[char_current_i].tili_max do
	        if i <= char_juese[char_current_i].tili then
		        gc:drawImage(hongxin_on_img, 224 + 77, 151 + 15 + 11 * (i - 1))
		    else
		        gc:drawImage(hongxin_off_img, 224 + 77, 151 + 15 + 11 * (i - 1))
		    end
	    end
	else
	    gc:drawImage(hongxin_on_img, 224 + 77, 151 + 15)
		gc:setFont("sansserif", "r", 7)
		gc:setColorRGB(255, 0, 0)
		gc:drawString(tostring(char_juese[char_current_i].tili), 224 + 81, 151 + 24 + 11)
		gc:drawString("/", 224 + 81, 151 + 24 + 11 + 8)
		gc:drawString(tostring(char_juese[char_current_i].tili_max), 224 + 81, 151 + 24 + 11 + 8 * 2)
		gc:setFont("sansserif", "r", 11)
		gc:setColorRGB(0, 0, 0)
	end
	
	-- 身份 --
	gc:drawImage(identity_img[char_juese[char_current_i].shenfen], 224 + 77, 151 + 1)
	
	-- 装备信息 --
	if card_selected[-1] ~= nil then
		gc:setColorRGB(0, 255, 0)
		gc:fillRect(5,131+20,gc:getStringWidth(char_juese[char_current_i].wuqi[1]),20)
		gc:setColorRGB(0, 0, 0)
	end
	if card_selected[-2] ~= nil then
		gc:setColorRGB(0, 255, 0)
		gc:fillRect(5,151+19,gc:getStringWidth(char_juese[char_current_i].fangju[1]),20)
		gc:setColorRGB(0, 0, 0)
	end
	if card_selected[-3] ~= nil then
		gc:setColorRGB(0, 255, 0)
		gc:fillRect(5,170+19,30,20)
		gc:setColorRGB(0, 0, 0)
	end
	if card_selected[-4] ~= nil then
		gc:setColorRGB(0, 255, 0)
		gc:fillRect(40,170+19,30,20)
		gc:setColorRGB(0, 0, 0)
	end
	if #char_juese[char_current_i].wuqi ~= 0 then
	    gc:drawString(char_juese[char_current_i].wuqi[1], 5, 151 + 20)
	end
	if #char_juese[char_current_i].fangju ~= 0 then
	    gc:drawString(char_juese[char_current_i].fangju[1], 5, 171 + 19)
	end
	if #char_juese[char_current_i].gongma ~= 0 and #char_juese[char_current_i].fangma ~= 0 then
	    gc:drawString("+1 / -1", 5, 190 + 19)
	else
	    if #char_juese[char_current_i].gongma ~= 0 then
		    gc:drawString("-1", 40, 190 + 19)
		end
		if #char_juese[char_current_i].fangma ~= 0 then
		    gc:drawString("+1", 5, 190 + 19)
		end
	end

	-- 锦囊状态 --
	local i, v, cnt, sel
	v = table.copy(char_juese[char_current_i].panding)
	if char_juese[char_current_i].hengzhi == true then
		table.insert(v, {"铁锁连环"})
	end
	
	for i = 1, #v do
		if v[i][1] ~= "乐不思蜀" and v[i][1] ~= "兵粮寸断" and v[i][1] ~= "闪电" and v[i][1] ~= "铁锁连环" then
			sel = 4
		else
			sel = 1
		end
		if v[i][sel] == "乐不思蜀" then
			gc:setColorRGB(255, 128, 128)
		end
		if v[i][sel] == "兵粮寸断" then
			gc:setColorRGB(242, 242, 0)
		end
		if v[i][sel] == "闪电" then
			gc:setColorRGB(0, 128, 255)
		end
		if v[i][sel] == "铁锁连环" then
			gc:setColorRGB(233, 233, 216)
		end
		
		if i == 1 then
			gc:fillRect(5, 132, 5, 18)
		end
		if i == 2 then
			gc:fillRect(10, 132, 5, 18)
		end
		if i == 3 then
			gc:fillRect(15, 132, 5, 18)
		end
		if i == 4 then
			gc:fillRect(20, 132, 5, 18)
		end
	end
	
	if char_acting_i == char_current_i then
		gc:setColorRGB(0, 255, 0)
		gc:setPen("medium")
		gc:drawRect(224, 151, 88, 57)
		gc:setPen("thin")
		gc:setColorRGB(0, 0, 0)
	end

	--  被选择目标 (借刀杀人第二阶段)
	if (gamerun_status == "选择目标-B" or ((imp_card == "驱虎2" or imp_card == "节命" or imp_card == "好施") and gamerun_status == "技能选择-目标B")) and char_current_i == gamerun_target_selected then
		if card_highlighted ~= nil or gamerun_status ~= "选择目标-B" then
			--  显示焦点  --
			local card
			if gamerun_status == "选择目标-B" then
				card = char_juese[char_current_i].shoupai[card_highlighted][1]
			else
				card = imp_card
			end

			if char_acting_i == char_current_i and card_if_d_limit(card, guankan_s, gamerun_target_selected) then
				gc:setColorRGB(195, 195, 0)
			elseif char_acting_i == char_current_i then
				gc:setColorRGB(17, 69, 20)
			elseif card_if_d_limit(card, guankan_s, gamerun_target_selected) then
				--  选择的角色可作为目标  --
				gc:setColorRGB(255, 0, 0)
			else
				gc:setColorRGB(216, 216, 216)
			end
			
			gc:setPen("medium")
			gc:drawRect(224, 151, 88, 57)
			gc:setPen("thin")
			gc:setColorRGB(0, 0, 0)
		end
	end
end

--  界面信息  --
function draw_messages(gc)
	-- 牌堆剩余卡牌数 --
	gc:setColorRGB(255, 0, 0)
	gc:setFont("sansserif", "b", 9)
	gc:drawString(#card_yixi, 292, 150) 
	gc:setColorRGB(0, 255, 0)
	local card_stat = #card_yixi + #card_qipai
	for i = 1, 5 do
		card_stat = card_stat + #char_juese[i].panding + #char_juese[i].shoupai
		if #char_juese[i].wuqi ~= 0 then
			card_stat = card_stat + 1
		end
		if #char_juese[i].fangju ~= 0 then
			card_stat = card_stat + 1
		end
		if #char_juese[i].gongma ~= 0 then
			card_stat = card_stat + 1
		end
		if #char_juese[i].fangma ~= 0 then
			card_stat = card_stat + 1
		end
	end
	if wugucards ~= nil then
		card_stat = card_stat + #wugucards
	end
	gc:drawString(card_stat, 252, 150)
	gc:setColorRGB(0, 0, 0)
	gc:setFont("sansserif", "r", 11)
	
	-- 交互提示区信息 --
	local width = gc:getStringWidth(jiaohu_text)
	gc:drawString(jiaohu_text, 160 - width / 2, 148)
	--gc:drawString(jiaohu_text, 105, 148)
end

--  其他元素  --
function draw_others(gc)
    local msg = {}
	local i, v

	--  手牌展示区  --
    if string.find(gamerun_status, "观看手牌") then
	    gc:setColorRGB(255, 255, 255)
		gc:fillRect(50, 15, 220, 190)
        gc:setColorRGB(0, 0, 0)
        gc:drawRect(50, 15, 220, 190)
		
		msg = {"手牌(", #char_juese[guankan_d].shoupai, ")"}
		gc:drawString(table.concat(msg), 60, 60)
		msg = nil; --collectgarbage()
		
		gc:drawString("马", 160, 60)
		gc:drawString("武器", 60, 117)
		gc:drawString("防具", 178, 117)
		gc:drawString("判定区", 60, 174)
		
		for i, v in ipairs(gamerun_guankan_type) do
		    if v[1] == "手牌" then
			    gc:drawImage(cards_img["牌框"], 65 + 18 * 3, 60 - 10 - 27)
				if i == gamerun_guankan_selected then
			        gc:setPen("medium")
				    gc:setColorRGB(255, 0, 0)
				    gc:drawRect(65 + 18 * 3, 60 - 10 - 27, 41, 57)
			    end
			end
			if v[1] == "防御马" then
			    gc:drawImage(cards_img[char_juese[guankan_d].fangma[1]], 165 + 18, 60 - 10 - 27)
				if i == gamerun_guankan_selected then
			        gc:setPen("medium")
				    gc:setColorRGB(255, 0, 0)
				    gc:drawRect(165 + 18, 60 - 10 - 27, 41, 57)
			    end
			end
			if v[1] == "攻击马" then
			    gc:drawImage(cards_img[char_juese[guankan_d].gongma[1]], 165 + 18 + 44, 60 - 10 - 27) 
				if i == gamerun_guankan_selected then
			        gc:setPen("medium")
				    gc:setColorRGB(255, 0, 0)
				    gc:drawRect(165 + 18 + 44, 60 - 10 - 27, 41, 57)
			    end
			end
		    if v[1] == "武器" then
			    gc:drawImage(cards_img[char_juese[guankan_d].wuqi[1]], 65 + 18 * 2, 117 - 10 - 27) 
				if i == gamerun_guankan_selected then
			        gc:setPen("medium")
				    gc:setColorRGB(255, 0, 0)
				    gc:drawRect(65 + 18 * 2, 117 - 10 - 27, 41, 57)
			    end
			end
			if v[1] == "防具" then
			    gc:drawImage(cards_img[char_juese[guankan_d].fangju[1]], 183 + 18 * 2, 117 - 10 - 27) 
				if i == gamerun_guankan_selected then
			        gc:setPen("medium")
				    gc:setColorRGB(255, 0, 0)
				    gc:drawRect(183 + 18 * 2, 117 - 10 - 27, 41, 57)
			    end
			end
			if v[1] == "判定牌" then
			    gc:drawImage(cards_img[char_juese[guankan_d].panding[v[2]][1]], 65 + 18 * 3 + 46 * (v[2] - 1), 174 - 10 - 27) 
				if i == gamerun_guankan_selected then
			        gc:setPen("medium")
				    gc:setColorRGB(255, 0, 0)
				    gc:drawRect(65 + 18 * 3 + 44 * (v[2] - 1), 174 - 10 - 27, 41, 57)
			    end
			end
		end
	elseif string.find(gamerun_status, "牌堆选择") then
		gc:setColorRGB(255, 255, 255)
		gc:fillRect(50, 15, 220, 190)
        gc:setColorRGB(0, 0, 0)
        gc:drawRect(50, 15, 220, 190)
		gc:drawString("五谷丰登", 130, 45)
		for i = 1,#wugucards do
			gc:drawImage(cards_img[wugucards[i][1]], 83 + 18 * i, 117 - 10 - 27)
			gc:drawImage(color_img[wugucards[i][2]], 84 + 18 * i, 119 - 10 - 27)
		    gc:setFont("sansserif", "r", 7)
	        gc:drawString(wugucards[i][3], 87 + 18 * i, 139 - 10 - 27)
	        gc:setFont("sansserif", "r", 11)
		end
		gc:drawImage(cards_img[wugucards[gamerun_guankan_selected][1]], 83 + 18 * gamerun_guankan_selected, 117 - 10 - 27)
		gc:drawImage(color_img[wugucards[gamerun_guankan_selected][2]], 84 + 18 * gamerun_guankan_selected, 119 - 10 - 27)
		gc:setFont("sansserif", "r", 7)
	    gc:drawString(wugucards[gamerun_guankan_selected][3], 87 + 18 * gamerun_guankan_selected, 139 - 10 - 27)
	    gc:setFont("sansserif", "r", 11)
		gc:setPen("medium")
	    gc:setColorRGB(255, 0, 0)
	    gc:drawRect(83 + 18 * gamerun_guankan_selected, 117 - 10 - 27, 41, 57)
	elseif string.find(gamerun_status, "牌堆操作") then
		
	elseif string.find(gamerun_status, "选项选择") then
		gc:setColorRGB(255, 255, 255)
		gc:fillRect(20, 15, 280, 190)
        gc:setColorRGB(0, 0, 0)
        gc:drawRect(20, 15, 280, 190)
		
		gc:drawString(choose_name, 159 - 1/2*gc:getStringWidth(choose_name), 45)
		gc:drawString(jiaohu_text, 159 - 1/2*gc:getStringWidth(jiaohu_text), 65)
		for i = 1,math.min(#choose_option - item_disrow,3) do
	        gc:drawString((i + item_disrow).."."..choose_option[(i + item_disrow)], 87 , 139 - 10 - 27 + 30 * (i - 1))
		end
		gc:setPen("medium")
	    gc:setColorRGB(255, 0, 0)
	    gc:drawRect(87, 137 - 10 - 47 + 30 * (gamerun_guankan_selected - 1), gc:getStringWidth((gamerun_guankan_selected + item_disrow).."."..choose_option[gamerun_guankan_selected + item_disrow])+4, gc:getStringHeight((gamerun_guankan_selected + item_disrow).."."..choose_option[gamerun_guankan_selected + item_disrow])+4)
	end
end

function on.paint(gc)
	draw_opponent(gc)
	draw_self(gc)
	draw_messages(gc)
	draw_others(gc)
end