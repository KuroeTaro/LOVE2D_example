local entities = {}
local spriteBatch, protagonist

function love.load()
	local image = love.graphics.newImage("spriteBatchExample.png")
	spriteBatch = love.graphics.newSpriteBatch(image)

	local quadPlayer   = love.graphics.newQuad(0,  0,  32, 32, image:getDimensions())
	local quadTree     = love.graphics.newQuad(32, 0,  32, 32, image:getDimensions())
	local quadSign     = love.graphics.newQuad(0,  32, 32, 32, image:getDimensions())
	local quadDogHouse = love.graphics.newQuad(32, 32, 32, 32, image:getDimensions())

	local windowWidth, windowHeight = love.graphics.getDimensions()

	love.graphics.setBackgroundColor(.05, .15, .05)

	-- Spawn lots of random things on an uneven grid.
	for baseY = 0, windowHeight, 30 do
		for baseX = 0, windowWidth, 40 do
			local quad = (
				love.math.random() < .10 and quadSign     or
				love.math.random() < .03 and quadDogHouse or
				quadTree
			)
			table.insert(entities, {
				quad   = quad,
				x      = baseX + math.random(-12, 12),
				y      = baseY + math.random(-8,  8 ),
				serial = #entities,
			})
		end
	end

	-- Spawn protagonist.
	protagonist = {quad=quadPlayer, x=0, y=0, serial=#entities} -- We set the position in love.update().
	table.insert(entities, protagonist)
end

function love.update(dt)
	local windowWidth, windowHeight = love.graphics.getDimensions()

	-- Make the protagonist move around in a circle.
	local angle   = .4 * love.timer.getTime()
	protagonist.x = windowWidth/2  + .3*windowWidth  * math.cos(angle)
	protagonist.y = windowHeight/2 + .3*windowHeight * math.sin(angle)
end

function love.draw()
	-- Sort entities by their Y position.
	table.sort(entities, function(entity1, entity2)
		if entity1.y ~= entity2.y then
			return entity1.y < entity2.y
		end
		return entity1.serial < entity2.serial -- If Y is the same, use the serial number as fallback.
	end)

	-- Add entities to sprite batch for drawing.
	spriteBatch:clear()
	for _, entity in ipairs(entities) do
		spriteBatch:add(entity.quad, math.floor(entity.x), math.floor(entity.y))
	end

	-- Finally, draw the sprite batch to the screen.
	love.graphics.draw(spriteBatch)

    -- 获取统计信息
	local stats = love.graphics.getStats()
	-- 显示统计信息
	love.graphics.print("Draw Calls: " .. stats.drawcalls, 250, 150)
	love.graphics.print("Canvas Switches: " .. stats.canvasswitches, 250, 30)
	love.graphics.print("Texture Memory: " .. stats.texturememory / 1024 / 1024 .. " MB", 250, 50)
	love.graphics.print("Images Loaded: " .. stats.images, 250, 70)
    
end