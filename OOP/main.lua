function love.run()
	if love.load then love.load(love.arg.parseGameArguments(arg), arg) end

	-- We don't want the first frame's dt to include time taken by love.load.
	if love.timer then love.timer.step() end

	local dt = 0
    local FRST = 1/60 --frame rate stabilization timer
	-- global_counter = 0

	-- Main loop time.
	return function()
		-- Process events.
		if love.event then
			love.event.pump()
			for name, a,b,c,d,e,f in love.event.poll() do
				if name == "quit" then
					if not love.quit or not love.quit() then
						return a or 0
					end
				end
				love.handlers[name](a,b,c,d,e,f)
			end
		end

		-- Update dt, as we'll be passing it to update
		if love.timer then FRST = FRST + love.timer.step() end
        -- Call update and draw
        if FRST >= 1/60 then
			
			-- local updateStartTime = love.timer.getTime()
			-- local cpu_heavy_task = function()
			-- 	-- 模拟繁重的 CPU 运算，消耗时间
			-- 	for i = 1, 100000 do
			-- 		-- 频繁读写全局变量 100w次
			-- 		global_counter = global_counter + 10
			-- 		global_counter = global_counter - 10
			-- 	end
			-- end
			-- cpu_heavy_task()
			local s = love.timer.getTime()
            if love.update then love.update() end -- will pass 0 if love.timer is disabled

            if love.draw then love.draw() end
            love.graphics.present()
			local gap = love.timer.getTime() - s 
			if gap > 1/60 then
				-- print(gap)
			end

			-- local updateEndTime = love.timer.getTime()
			-- print(updateStartTime-updateEndTime)

            FRST = math.fmod(FRST, 1/60)
        end
		collectgarbage()
		if love.timer then love.timer.sleep(0.001) end
	end
	
end

function average_RNG()
    CURRENT_INSERT_CHANCE = CURRENT_INSERT_CHANCE + 1/60
    if CURRENT_INSERT_CHANCE > math.random() then
        CURRENT_INSERT_CHANCE = 0
        LAST_TIME_INSERT = 0
        return true
    end
    return false
end
function random_inserter()
    if obj_list[#obj_list][1] ~= 0 
    and LAST_TIME_INSERT >= 60
    and average_RNG()
    then
        local new_obj = {
            0, -- 当前位置 1
            0, -- 可视化映射位置 2
            "up", -- 标签绘制方向 3
            250, -- 最大速度 4
            0, -- 当前速度 5
            12.5, -- 最快加速度 6
            12.5, -- 最快减速度 7
            0, -- 当前加速度 8
            (250/12.5)*125, -- 最小安全前车距离 9
            'stop' -- 当前状态 停止 加速 满速 减速 10
        }
        table.insert(obj_list, new_obj)
    end
end

function love.load()
    MAX_DISTANCE = 1600000 -- 总行程距离
    LAST_TIME_INSERT = 0
    CURRENT_INSERT_CHANCE = 0
    obj_list = {}
    speed_random_factor = 12.5/100 * 50

    local new_obj = {
        0, -- 当前位置 1
        0, -- 可视化映射位置 2
        "up", -- 标签绘制方向 3
        250, -- 最大速度 4
        0, -- 当前速度 5
        12.5, -- 最快加速度 6
        12.5, -- 最快减速度 7
        0, -- 当前加速度 8
        (250/12.5)*125, -- 最小安全前车距离 9
        'stop' -- 当前状态 停止 加速 满速 减速 10
    }
    table.insert(obj_list, new_obj)

end    
function love.update()
    LAST_TIME_INSERT = LAST_TIME_INSERT + 1
    random_inserter()
    for i = #obj_list, 1, -1 do -- 反向遍历，便于删除元素
        local obj = obj_list[i]
        if i == 1 then
            first_obj_update(obj,obj_list)
        else
            state_machine(obj,obj_list[i-1])
        end
        if obj[1] > MAX_DISTANCE then
            table.remove(obj_list, i)
        end
    end
end
function love.draw()
	draw_obj_list()
    
end

function first_obj_update(obj,obj_list)
    if obj[10] ~= "max_speed" or obj[5]<obj[4] then
        obj[5] = obj[5] + obj[6]
        if obj[5]>=obj[4] then
            obj[5]=obj[4]
            obj[10] = "max_speed"
        else
            obj[10] = "accelerate"
        end
    end

    obj[5] = obj[5] - ((math.random()-0.5)*speed_random_factor)
    obj[5] = math.max(obj[5],0)
    obj[5] = math.min(obj[5],obj[4])
    obj[1] = obj[1] + obj[5]
    obj[2] = obj[1]/MAX_DISTANCE*1600

end

function state_machine(obj,front_obj)
    local local_switch = {
        ["stop"] = function()
            if front_obj[1] - obj[1] > obj[9] then
                obj[5] = obj[5] + obj[6]
                obj[10] = "accelerate"
            end
        end,
        ["accelerate"] = function()
            if front_obj[1] - obj[1] <= obj[9] then
                obj[5] = obj[5] - obj[7]
                obj[10] = "decelerate"
            else
                obj[5] = obj[5] + obj[6]
                obj[5] = math.min(obj[5],obj[4])
                if obj[5] == obj[4] then
                    obj[10] = "max_speed"
                end
            end
        end,
        ["decelerate"] = function()
            if front_obj[1] - obj[1] > obj[9] then
                obj[5] = obj[5] + obj[6]
                obj[10] = "accelerate"
            else
                obj[5] = obj[5] - obj[7]
                obj[5] = math.max(obj[5],0)
                if obj[5] == 0 then
                    obj[10] = "stop"
                end
            end
        end,
        ["max_speed"] = function()
            if front_obj[1] - obj[1] < obj[9] then
                obj[5] = obj[5] - obj[7]
                obj[10] = "decelerate"
            end
        end,
    }
    local this_function = local_switch[obj[10]]
    if this_function then this_function() end

    obj[5] = obj[5] - ((math.random()-0.5)*speed_random_factor)
    obj[5] = math.max(obj[5],0)
    obj[5] = math.min(obj[5],obj[4])
    obj[1] = obj[1] + obj[5]
    obj[2] = obj[1]/MAX_DISTANCE*1600

end

function draw_obj_list()
    love.graphics.clear()
    local y_shift = -300
    for i = #obj_list, 1, -1 do -- 反向遍历，便于删除元素
        love.graphics.rectangle("line", obj_list[i][2]-5, 450-5+y_shift, 10, 10)
        love.graphics.print("speed:",obj_list[i][2]-5, 450+i*15+y_shift)
        love.graphics.print(math.floor(obj_list[i][5]),obj_list[i][2]+40, 450+i*15+y_shift)
        love.graphics.print("x:",obj_list[i][2]+70, 450+i*15+y_shift)
        love.graphics.print(math.floor(obj_list[i][1]),obj_list[i][2]+85, 450+i*15+y_shift)
    end
    love.graphics.line(0, 450+y_shift, 1600, 450+y_shift)
end





