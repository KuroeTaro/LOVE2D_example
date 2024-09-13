function create_thread()
    local thread = love.thread.newThread("thread.lua")
    thread:start()
end 

function love.run()
	if love.load then love.load(love.arg.parseGameArguments(arg), arg) end

	-- We don't want the first frame's dt to include time taken by love.load.
	if love.timer then love.timer.step() end

	local dt = 0
    local FRST = 1/60 --frame rate stabilization timer

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
		if love.timer then dt = love.timer.step() end

        if FRST >= 1/60 then
            if love.update then love.update(dt) end -- will pass 0 if love.timer is disabled

            if love.graphics and love.graphics.isActive() then
                if love.draw then love.draw() end
                love.graphics.present()
            end
            FRST = math.fmod(FRST, 1/60)
        end
        FRST = FRST + dt
		-- Call update and draw

		if love.timer then love.timer.sleep(0.001) end
	end
end

function love.load()
    create_thread()
    image = {}
    loaded = false 
end

function love.update(dt)

    timer = timer and timer + dt or 0
    if imageData == nil then 
        imageData = love.thread.getChannel( 'image' ):pop()
    end
    if imageData and loaded == false then
        image[1] = love.graphics.newImage(imageData[2])
        loaded = true
        print("C")
    end
    collectgarbage("collect")
end 

function love.draw()
    love.graphics.clear(7/255,19/255,31/255,1)
    if loaded then
        love.graphics.draw( image[1], 10, 10 )
    end
    love.graphics.circle( 'line', 100 + math.sin( timer * 20 ) * 20, 100 + math.cos( timer * 20 ) * 20, 20 )
    love.graphics.print(tostring(love.timer.getFPS( )),0,0)
end