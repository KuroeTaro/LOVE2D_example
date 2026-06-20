function love.load()
    sprite = love.graphics.newImage("0.png")

    -- 创建轮廓版精灵（黑色阴影）
    local shadowCanvas = love.graphics.newCanvas(sprite:getWidth(), sprite:getHeight())
    love.graphics.setCanvas(shadowCanvas)
    love.graphics.clear()
    love.graphics.setColor(0, 0, 0, 1) -- 纯黑
    love.graphics.draw(sprite)
    love.graphics.setCanvas()

    shadow = shadowCanvas

    -- 加载径向模糊着色器
    radialBlurShader = love.graphics.newShader("radial_blur.glsl")
    radialBlurShader:send("samples", 32)        -- 模糊采样次数
    radialBlurShader:send("strength", 0.2)      -- 模糊强度

    spriteX, spriteY = 400, 300
end

function love.draw()
    love.graphics.clear(1,1,1,1)
    -- 计算中心点（以贴图坐标）
    local centerX = 0.5
    local centerY = 0.5
    radialBlurShader:send("center", {centerX, centerY})

    -- 应用模糊阴影
    love.graphics.setShader(radialBlurShader)
    love.graphics.setColor(1, 1, 1, 0.5)
    love.graphics.draw(shadow, spriteX, spriteY + 10, 0, 1, 1, shadow:getWidth()/2, shadow:getHeight()/2)
    love.graphics.setShader()

    -- 绘制原始精灵
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.draw(sprite, spriteX, spriteY, 0, 1, 1, sprite:getWidth()/2, sprite:getHeight()/2)
end
