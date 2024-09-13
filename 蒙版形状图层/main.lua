-- main.lua
function love.load()
    -- 加载图片
    image = love.graphics.newImage("image.png")
    mask = love.graphics.newImage("alpha.png")

    -- 加载着色器
    shader = love.graphics.newShader("feather.glsl")

    -- 传递alpha图层和亮度参数给着色器
    shader:send("mask", mask)
    shader:send("brightness", 2.5)  -- 初始亮度设为1.0，即无变化
end

function love.update(dt)
    -- 在这里可以添加代码来动态调整亮度
    -- 比如通过按键来增加或减少亮度
    if love.keyboard.isDown("up") then
        local currentBrightness = shader:send("brightness")
        shader:send("brightness", currentBrightness + dt)
    elseif love.keyboard.isDown("down") then
        local currentBrightness = shader:send("brightness")
        shader:send("brightness", currentBrightness - dt)
    end
end

function love.draw()
    -- 使用着色器绘制原图
    love.graphics.setShader(shader)
    love.graphics.draw(image, 0, 0)
    love.graphics.setShader()
end
