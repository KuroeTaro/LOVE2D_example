function love.load()
    -- 加载 sprite
    sprite = love.graphics.newImage("spriteBatchExample.png")

    -- 创建 SpriteBatch
    batch = love.graphics.newSpriteBatch(sprite, 100)  -- 初始容量为 100
end

function love.update(dt)
    -- 清空 SpriteBatch
    batch:clear()

	batch:add(10, 50)
	batch:add(20, 50)
	batch:add(30, 50)
	batch:add(40, 50)


    -- 结束添加
    batch:flush()
end

function love.draw()
    -- 绘制 SpriteBatch
    love.graphics.draw(batch)
end