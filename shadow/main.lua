function love.load()
    -- 定义一个多边形（矩形为例）
    lines = 
    {
        {-52.00, -226.00,
            -194.00, -78.00}
        ,
        {-194.00, -78.00,
            -62.00, 64.00}
        ,
        {-62.00, 64.00,
            132.00, -72.00}
        ,
        {132.00, -72.00,
            -52.00, -226.00}
    
    }
    
    
    
    -- 光源位置
    light = {x = 150, y = 150}
end

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
				print(gap)
			end

			-- local updateEndTime = love.timer.getTime()
			-- print(updateStartTime-updateEndTime)

            FRST = math.fmod(FRST, 1/60)
        end
		collectgarbage()
		if love.timer then love.timer.sleep(0.001) end
	end
	
end

function love.update(dt)
    -- 更新光源位置为鼠标位置
    light.x, light.y = love.mouse.getPosition()
end

function love.draw()
    love.graphics.clear()
    -- -- 绘制多边形
    -- love.graphics.setColor(1, 1, 1)
    -- love.graphics.line(line)
    for i = 1, #lines do
        -- 计算阴影
        local line = lines[i]
        local shadowPolygon = calculateShadow(line, light, 800 ,450)

        -- 绘制阴影
        love.graphics.setColor(0.5, 0.5, 0.5, 1) -- 半透明黑色
        love.graphics.polygon("fill", shadowPolygon)

        -- 绘制光源
        love.graphics.setColor(1, 1, 0)
        love.graphics.circle("fill", light.x, light.y, 5)
    end

    -- 获取统计信息
    local stats = love.graphics.getStats()
    FPS = love.timer.getFPS()
    love.graphics.print( "GRAPHICIAL_FPS", 0, 255)
    love.graphics.print( FPS, 110, 255)

    -- 显示统计信息
    love.graphics.print("Draw Calls: " .. stats.drawcalls, 10, 10)
    love.graphics.print("Canvas Switches: " .. stats.canvasswitches, 10, 30)
    love.graphics.print("Texture Memory: " .. stats.texturememory / 1024 / 1024 .. " MB", 10, 50)
    love.graphics.print("Images Loaded: " .. stats.images, 10, 70)

end

function calculateShadow(line, light, loc_x, loc_y)
    local shadow = {}

    local x1 = line[1] + loc_x
    local dx = x1 - light.x
    local extendedX = x1 + dx * 50
    local y1 = line[2] + loc_y
    local dy = y1 - light.y
    local extendedY = y1 + dy * 50

    table.insert(shadow, x1)
    table.insert(shadow, y1)
    table.insert(shadow, extendedX)
    table.insert(shadow, extendedY)

    local x2 = line[3] + loc_x
    dx = x2 - light.x
    extendedX = x2 + dx * 1000
    local y2 = line[4] + loc_y
    dy = y2 - light.y
    extendedY = y2 + dy * 1000

    table.insert(shadow, extendedX)
    table.insert(shadow, extendedY)
    table.insert(shadow, x2)
    table.insert(shadow, y2)

    return shadow
end